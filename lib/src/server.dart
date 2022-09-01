part of fennec;

/// [Server] is a class that contains information about the server.
class Server {
  /// [application] is a [Application] that contains the application.
  late Application application;

  /// [_httpServer] is a [HttpServer] that contains the http server.
  /// bydefault it's null.
  late HttpServer? _httpServer;

  /// [_listeningToServer] is a [bool] that indicates if the server is listening.
  /// bydefault it's false.
  bool _listeningToServer = false;

  /// [_instance] is a [Server] that contains the instance of the server.
  static final Server _instance = Server._internal();

  /// [Server] is a constructor that creates a new [Server] object.
  /// It's used to create a new [Server] object.
  factory Server(Application application) {
    _instance.application = application;
    return _instance;
  }

  /// [Server] is a constructor that creates a new [Server] object.
  Server._internal();

  /// [requestTimeOut] is a [Duration] that contains the request timeout of the server.
  /// bydefault it's null.
  Duration? requestTimeOut;

  /// [setRequestTimeOut] is a method that sets the request timeout of the server.
  void setRequestTimeOut(Duration duration) {
    _instance.requestTimeOut = duration;
  }

  final StreamController<UpgradedWebSocket> _webSocketStream =
      StreamController();
  final StreamController<HttpRequest> httpServerStream = StreamController();

  StreamController<UpgradedWebSocket> get webSocketStream => _webSocketStream;
  final StreamController<UpgradedWebSocket> _webSocketStreamBroadcast =
      StreamController();

  StreamController<UpgradedWebSocket> get webSocketStreamBroadcast =>
      _webSocketStreamBroadcast;

  HttpServer get httpServer => _instance._httpServer == null
      ? throw Exception("you should start first")
      : _instance._httpServer!;

  /// [startServer] is a method that starts the server.
  /// It's used to start the server.

  Future<ServerInfo> startServer() async {
    _registerRoutes();
    RoutesHandler.checkRoutes(registredRoutes);

    if (_instance.application.numberOfIsolates == 1) {
      return isolateServer(false);
    }
    for (int i = 1; i < _instance.application.numberOfIsolates; i++) {
      Isolate.spawn(isolateServer, true);
    }
    return isolateServer(true);
  }

  /// [isolateServer] is a method binds with the server.
  Future<ServerInfo> isolateServer(bool shared) async {
    if (application.securityContext != null) {
      _instance._httpServer = await HttpServer.bindSecure(
          application.host, application.port, application.securityContext!,
          shared: shared);
    } else {
      _instance._httpServer = await HttpServer.bind(
          application.host, application.port,
          shared: shared);
    }
    final ServerInfo serverInfo = ServerInfo(
        _instance._httpServer!.address,
        _instance._httpServer!.port,
        _instance._httpServer!.autoCompress,
        _instance._httpServer!.defaultResponseHeaders,
        _instance._httpServer!.idleTimeout,
        _instance._httpServer!.serverHeader);
    if (_instance._listeningToServer) return serverInfo;
    _instance._httpServer!.listen(((event) async {
      await _parseRequest(event).timeout(
          _instance.requestTimeOut != null
              ? _instance.requestTimeOut!
              : Duration(seconds: 120), onTimeout: () {
        throw TimeoutException(
            'the requests takes more than the specified timeout');
      });
    }));
    _instance._listeningToServer = true;
    print('Server is running on port:  ${application.port}');
    return serverInfo;
  }

  Future<bool> _parseRequest(HttpRequest httpRequest) async {
    if (httpRequest.headers.value('Upgrade') == null) {
      return handleHttpRequest(httpRequest);
    } else if (httpRequest.headers.value("Upgrade") != null &&
        httpRequest.headers.value("Upgrade") == "websocket") {
      if (WebSocketTransformer.isUpgradeRequest(httpRequest)) {
        if (application.socketIOServer) {
          httpServerStream.sink.add(httpRequest);
        } else if (application.webSocket) {
          WebSocketTransformer.upgrade(httpRequest).then((WebSocket websocket) {
            UpgradedWebSocket upgradedWebSocket = UpgradedWebSocket(
                websocket, httpRequest.headers, httpRequest.uri);
            _webSocketStream.sink.add(upgradedWebSocket);
            _webSocketStreamBroadcast.sink.add(upgradedWebSocket);
          });
        }
      }
      return true;
    }
    return true;
  }

  Future<bool> handleHttpRequest(HttpRequest httpRequest) async {
    _unawaited(httpRequest.response.done.then((dynamic _) {
      return true;
    }));
    final String path = httpRequest.uri.path;
    final String method = httpRequest.method;
    if (!Utils.isValidURl(httpRequest.requestedUri.toString())) {
      badRequestException(httpRequest.response, 'Invalid URL');
      return true;
    }
    Request request = await BodyParser.parseBody(httpRequest, {});
    Response response = Response(httpRequest.response, application, method);
    if (application.cors != null) {
      var corsCallback = application.cors!;
      final isOptionsMethod = await corsCallback(request, response);
      if (isOptionsMethod == null) {
        return true;
      }
    } else if (application.corsOptions != null) {
      var corsCallback = cors(application.corsOptions!);
      final isOptionsMethod = await corsCallback(request, response);

      if (isOptionsMethod == null) {
        return true;
      }
    }
    List<Route> matchedPaths =
        RoutesHandler.getMatchedRoutes(registredRoutes, path);
    if (matchedPaths.isNotEmpty) {
      for (Route route in matchedPaths) {
        if (route.requestMethod.requestMethod == method) {
          Map<String, dynamic> pathParams = RoutesHandler.pathMatcher(
              routePath: route.path, matchesPath: path);
          request.pathParams = pathParams;
          List<MiddlewareHandler> middlewares = route.middlewares;
          for (MiddlewareHandler middlewareHandler in middlewares) {
            final Next? middleWareResponse =
                await middlewareHandler(request, response);
            if (middleWareResponse == null) {
              return true;
            }
          }
          await route.requestHandler(request, response);
          return true;
        }
      }
      methodNotAllowedException(httpRequest.response, path, method);
      return true;
    } else {
      routeNotFoundException(httpRequest.response, path, method);
      return true;
    }
  }

  // final List<RestControllerRoutesMapping> _registredRoutes = [];
  final List<Route> registredRoutes = [];

  void _registerRoutes() {
    registredRoutes.addAll(application.routes);
    for (Router router in application.routers) {
      for (Route route in router.routes) {
        String composedPath = router.routerPath + route.path;
        List<MiddlewareHandler> middlewareHandlers = [
          ...router.middlewareHandlers,
          ...route.middlewares
        ];
        registredRoutes.add(Route(
            requestMethod: route.requestMethod,
            path: composedPath,
            requestHandler: route.requestHandler,
            middlewares: middlewareHandlers));
      }
    }
  }

  void _unawaited(Future then) {}
}
