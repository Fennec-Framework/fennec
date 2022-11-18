part of fennec;

/// [Application] is a class that contains the application.
class Application {
  /// [cached] is a [Map] that contains the cached data of the application.
  late Map<String, dynamic> cached;

  /// [_engines] is a [Map] that contains the engines of the application.
  final Map<String, Engine> _engines = {};

  CorsOptions? corsOptions;
  final List<MiddlewareHandler> middlewares = [];

  /// instance of [Application] that contains the application.
  static final Application _instance = Application._internal();
  final List<IsolateSupervisor> _supervisors = [];
  final List<Actor> _actors = [];

  /// [Application] is a constructor that creates a new [Application] object.
  factory Application() {
    return _instance;
  }

  Application._internal();

  /// [render] is a method that renders a view.
  void render(String fileName, Map<String, dynamic>? locals,
      Function(dynamic, String?) callback,
      {Map<String, dynamic> parameters = const {}}) {
    final view = _getViewFromFileName(fileName);
    view.render(locals, parameters, callback);
  }

  /// [renderHtmlAsString] is a method that renders a html file by a String.
  String renderHtmlAsString(String html,
      {Map<String, dynamic> parameters = const {}}) {
    return HtmlEngine.renderHtmlAsString(html, parameters: parameters);
  }

  View _getViewFromFileName(String fileName) {
    View? view;
    if (_instance.cache) {
      view = _instance.cached[fileName];
    }
    if (view == null) {
      view = View(fileName, _instance._engines,
          defaultEngine: _instance.viewEngine, rootPath: _instance.viewPath);

      if (view.filePath == null) {
        late String dirs;
        if (view.rootPath is List) {
          dirs =
              'directories "${view.rootPath.join(', ')}" or "${view.rootPath[view.rootPath.length - 1]}"';
        } else {
          dirs = 'directory "${view.rootPath}"';
        }
        throw ViewException(view, dirs);
      }
    }
    if (_instance.cache) {
      _instance.cached[fileName] = view;
    }
    return view;
  }

  ///[cached] is a boolean for enabling caching
  bool cache = false;

  ///[host] represents host of the server
  dynamic host = '0.0.0.0';

  ///[port] represents port of the server
  int port = 8000;

  bool socketIOServer = false;
  bool webSocket = false;

  ///[securityContext] represents if you bind your server secure
  SecurityContext? securityContext;

  ///[viewPath] represents the default path of views
  String viewPath = path.join(path.current, 'views');

  ///[viewEngine] represents the used viewEngine
  String viewEngine = 'html';

  /// [numberOfIsolates] is a [int] that contains the number of isolates of the application.
  int numberOfIsolates = 1;

  final List<Router> routers = [];
  final List<ARoute> routes = [];

  /// [addRouter] is a method that adds a new Router to the application.
  /// [router] is a [Router] that contains the router.
  Application addRouter(Router router) {
    routers.add(router);
    return this;
  }

  /// [addRouters] is a method that adds a List Router to the application.
  /// [routers] is a List Router that contains the router.
  Application addRouters(List<Router> routers) {
    this.routers.addAll(routers);
    return this;
  }

  /// [addRoute] is a method that adds a new Route to the application.
  /// [route] is a [Route] that contains the route.
  Application addRoute(ARoute route) {
    routes.add(route);
    return this;
  }

  /// [addRoutes] is a method that adds a a List of Route to the application.
  Application addRoutes(List<ARoute> routes) {
    this.routes.addAll(routes);
    return this;
  }

  /// [setCache] is a method that enable caching of the application.
  /// by default it's set to false.
  Application setCache(bool cache) {
    this.cache = cache;
    return this;
  }

  /// [setHost] is a method that sets the host of server of the application.
  /// by default it's set to '0.0.0.0'.
  Application setHost(dynamic host) {
    this.host = host;
    return this;
  }

  Application addActor(Actor actor) {
    _actors.add(actor);
    return this;
  }

  Application addActors(List<Actor> actors) {
    _actors.addAll(actors);
    return this;
  }

  /// [setPort] is a method that sets the port of server of the application.
  /// by default it's set to 8000.
  Application setPort(int port) {
    this.port = port;
    return this;
  }

  /// [setSecurityContext] is a method that sets the SecurityContext of server of the application.
  /// by default it's set to null.
  Application setSecurityContext(SecurityContext securityContext) {
    this.securityContext = securityContext;
    return this;
  }

  /// [setViewPath] is a method that sets the default path of views of the application.
  Application setViewPath(String viewPath) {
    this.viewPath = viewPath;
    return this;
  }

  /// [setViewEngine] is a method that sets the default viewEngine of views of the application.
  Application setViewEngine(String viewEngine) {
    this.viewEngine = viewEngine;
    return this;
  }

  /// [setNumberOfIsolates] is a method that sets the number of isolates of the application.
  /// by default it's set to 1.
  Application setNumberOfIsolates(int numberOfIsolates) {
    this.numberOfIsolates = numberOfIsolates;
    return this;
  }

  Application useSocketIOServer(bool useSocketIOServer) {
    socketIOServer = useSocketIOServer;
    return this;
  }

  Application useWebSocket(bool useWebSocket) {
    webSocket = useWebSocket;
    return this;
  }

  ///[setCorsOptions] is used to add Cors to the response header
  Application setCorsOptions(CorsOptions corsOptions) {
    this.corsOptions = corsOptions;
    return this;
  }

  /// [useMiddleware] is used to defines middlewares, that will be executed after every request.
  Application useMiddleware(MiddlewareHandler middlewareHandler) {
    middlewares.add(middlewareHandler);
    return this;
  }

  Application post(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    addRoute(Route(
        requestMethod: RequestMethod.post(),
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Application get(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    addRoute(Route(
        requestMethod: RequestMethod.get(),
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Application delete(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    addRoute(Route(
        requestMethod: RequestMethod.delete(),
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Application put(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    addRoute(Route(
        requestMethod: RequestMethod.put(),
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Application options(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    addRoute(Route(
        requestMethod: RequestMethod.options(),
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Application patch(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    addRoute(Route(
        requestMethod: RequestMethod.patch(),
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Application ws(
      {required String path,
      required WebsocketHandler websocketHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    addRoute(WebsocketRoute(
        requestMethod: RequestMethod.get(),
        path: path,
        webSocketHandler: websocketHandler,
        middlewares: middlewares));
    return this;
  }

  Future<ServerInfo> runServer() async {
    Actors actors = Actors(_actors);

    await actors.initState();

    var actorContainers = ActorContainers(actors.actorContainers);
    _supervisors.addAll(
        List.generate(numberOfIsolates, (index) => IsolateSupervisor()));

    await Future.wait(List.generate(
        _supervisors.length, (index) => _supervisors[index].initState()));
    final TemplateRender templateRender = TemplateRender(_instance.cache);
    final ServerInput serverInput = ServerInput(
        _instance.port,
        _instance.host,
        _instance.routers,
        _instance.routes,
        _instance.middlewares,
        _instance.webSocket,
        _instance.socketIOServer,
        corsOptions: _instance.corsOptions,
        securityContext: _instance.securityContext);
    ServerContext serverContext = ServerContext(actorContainers);
    ServerInfo? serverInfo;

    for (var i = 0; i < _supervisors.length; i++) {
      IsolateError? error;

      var subscription = _supervisors[i].errors.listen((event) {
        error ??= event;
      });
      var subscriptionServerInfo = _supervisors[i].serverInfo.listen((event) {
        serverInfo ??= event.serverInfo;
      });

      templateRender.rootPath = _instance.viewPath;
      await _supervisors[i].start(ServerTaskHandler(
          i, true, templateRender, serverInput, serverContext));

      subscription.cancel();
      subscriptionServerInfo.cancel();

      if (error != null) {
        throw Exception(
            'an error occurred in the server instance: $i.\n\nInstance error:\n\n${error!.error}\n\nInstance stack trace:\n\n${error!.stackTrace}');
      }
    }
    return serverInfo!;
  }

  Future<void> pause() async {
    await Future.wait(_supervisors.map((e) => e.pause()));
  }

  Future<void> resume() async {
    await Future.wait(_supervisors.map((e) => e.resume()));
  }

  Future<void> dispose() async {
    await Future.wait(_supervisors.map((e) => e.dispose()));
  }
}
