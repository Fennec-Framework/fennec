part of fennec;

/// [Server] is a class that contains information about the server.
class Server {
  /// [serverInput] is a [Application] that contains the application.
  late ServerInput serverInput;
  late TemplateRender templateRender;
  late ServerContext serverContext;

  /// [_httpServer] is a [HttpServer] that contains the http server.
  /// by default it's null.
  late HttpServer? _httpServer;

  /// [_listeningToServer] is a [bool] that indicates if the server is listening.
  /// by default it's false.
  bool _listeningToServer = false;

  /// [_instance] is a [Server] that contains the instance of the server.
  static final Server _instance = Server._internal();

  final StreamController streamController = StreamController();

  /// [Server] is a constructor that creates a new [Server] object.
  /// It's used to create a new [Server] object.
  factory Server(ServerInput serverInput, TemplateRender templateRender,
      ServerContext serverContext) {
    _instance.serverContext = serverContext;
    _instance.serverInput = serverInput;
    _instance.templateRender = templateRender;
    return _instance;
  }

  /// [Server] is a constructor that creates a new [Server] object.
  Server._internal();

  /// [requestTimeOut] is a [Duration] that contains the request timeout of the server.
  /// byd default it's null.
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

  Future<ServerInfo> startServer(int instance, bool shared) async {
    await _registerRoutes();
    RoutesHandler.checkRoutes(registeredRoutes);
    return isolateServer(instance, shared);
  }

  /// [isolateServer] is a method binds with the server.
  Future<ServerInfo> isolateServer(int instance, bool shared) async {
    if (serverInput.securityContext != null) {
      _instance._httpServer = await HttpServer.bindSecure(
          serverInput.host, serverInput.port, serverInput.securityContext!,
          shared: shared);
    } else {
      _instance._httpServer = await HttpServer.bind(
          serverInput.host, serverInput.port,
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
      await _handleRequest(event).timeout(
          _instance.requestTimeOut != null
              ? _instance.requestTimeOut!
              : Duration(seconds: 120), onTimeout: () {
        throw TimeoutException(
            'the requests takes more than the specified timeout');
      });
    }));
    _instance._listeningToServer = true;

    print(
        'Server is running on host: ${serverInput.host} port:  ${serverInput.port}   instance Nr: ${instance + 1}\n');
    return serverInfo;
  }

  Future<bool> _handleRequest(HttpRequest httpRequest) async {
    if (httpRequest.headers.value('Upgrade') == null) {
      return handleHttpRequest(httpRequest);
    } else if (httpRequest.headers.value("Upgrade") != null &&
        httpRequest.headers.value("Upgrade") == "websocket") {
      if (WebSocketTransformer.isUpgradeRequest(httpRequest)) {
        if (serverInput.useWebSocket) {
          return handleHttpRequest(httpRequest);
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
    Response response = Response(httpRequest.response, templateRender, method);

    if (serverInput.corsOptions != null) {
      var corsCallback = cors(serverInput.corsOptions!);
      final isOptionsMethod = await corsCallback(request, response);

      if (isOptionsMethod is Stop) {
        Response sentResponse = isOptionsMethod.response;
        if (!sentResponse.isClosed) {
          sentResponse.write();
        }
        return true;
      }
    }
    for (MiddlewareHandler middlewareHandler in serverInput.middlewares) {
      final isOptionsMethod =
          await middlewareHandler(serverContext, request, response);

      if (isOptionsMethod is Stop) {
        Response sentResponse = isOptionsMethod.response;

        if (!sentResponse.isClosed) {
          sentResponse.write();
        }

        return true;
      }
    }
    List<ARoute> matchedPaths =
        RoutesHandler.getMatchedRoutes(registeredRoutes, path);
    if (matchedPaths.isNotEmpty) {
      for (ARoute route in matchedPaths) {
        if (route.requestMethod.requestMethod == method) {
          Map<String, dynamic> pathParams = RoutesHandler.pathMatcher(
              routePath: route.path, matchesPath: path);
          request.pathParams = pathParams;
          List<MiddlewareHandler> middlewares = route.middlewares;
          for (MiddlewareHandler middlewareHandler in middlewares) {
            final Middleware middleWareResponse =
                await middlewareHandler(serverContext, request, response);

            if (middleWareResponse is Stop) {
              Response sentResponse = middleWareResponse.response;
              if (!sentResponse.isClosed) {
                sentResponse.write();
              }

              return true;
            }
          }

          if (route is WebsocketRoute &&
              route.path == path &&
              route.requestMethod.requestMethod ==
                  RequestMethod.get().requestMethod) {
            if (httpRequest.headers.value("Upgrade") != null &&
                httpRequest.headers.value("Upgrade") == "websocket") {
              if (WebSocketTransformer.isUpgradeRequest(httpRequest)) {
                await route.webSocketHandler(
                    serverContext, request.httpRequest);
              }
            }
          } else if (route is Route) {
            Response sentResponse =
                await route.requestHandler(serverContext, request, response);
            if (!sentResponse.isClosed) {
              sentResponse.write();
            }
          }

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

  final List<ARoute> registeredRoutes = [];

  Future _registerRoutes() async {
    registeredRoutes.addAll(serverInput.routes);
    for (Router router in serverInput.routers) {
      if (router._initState != null) {
        await router._initState!.call(serverContext);
      }
      for (ARoute route in router.routes) {
        String composedPath = router.routerPath + route.path;
        List<MiddlewareHandler> middlewareHandlers = [
          ...router.middlewareHandlers,
          ...route.middlewares
        ];
        if (route is Route) {
          registeredRoutes.add(Route(
              requestMethod: route.requestMethod,
              path: composedPath,
              requestHandler: route.requestHandler,
              middlewares: middlewareHandlers));
        } else if (route is WebsocketRoute) {
          registeredRoutes.add(WebsocketRoute(
              requestMethod: route.requestMethod,
              path: composedPath,
              webSocketHandler: route.webSocketHandler,
              middlewares: middlewareHandlers));
        }
      }
    }
  }

  Future<void> dispose() async {
    await httpServer.close();
  }

  void _unawaited(Future then) {}
}

class ServerConfig {
  final int port = 80;
  final String host = "0.0.0.0";
// ...
}
