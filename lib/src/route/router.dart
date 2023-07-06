part of fennec;

abstract class ARouter {
  String routerPath = '';
}

class Router extends ARouter {
  Router({String routerPath = ''}) {
    this.routerPath = routerPath;
  }

  List<MiddlewareHandler> middlewareHandlers = [];
  RouterInitState? _initState;

  Router useMiddleware(MiddlewareHandler middlewareHandler) {
    middlewareHandlers.add(middlewareHandler);
    return this;
  }

  Router useMiddlewares(List<MiddlewareHandler> middlewareHandlers) {
    this.middlewareHandlers.addAll(middlewareHandlers);
    return this;
  }

  final List<ARoute> _routes = [];

  List<ARoute> get routes => _routes;

  Router routerInitState({required RouterInitState routerInitState}) {
    _initState = routerInitState;
    return this;
  }

  Router post(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    _routes.add(Route(
        requestMethods: [RequestMethod.post()],
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Router get(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    _routes.add(Route(
        requestMethods: [RequestMethod.get()],
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Router delete(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    _routes.add(Route(
        requestMethods: [RequestMethod.delete()],
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Router put(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    _routes.add(Route(
        requestMethods: [RequestMethod.put()],
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Router options(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    _routes.add(Route(
        requestMethods: [RequestMethod.options()],
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Router patch(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    _routes.add(Route(
        requestMethods: [RequestMethod.patch()],
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Router any({
    required String path,
    required RequestHandler requestHandler,
    List<MiddlewareHandler> middlewares = const [],
    List<RequestMethod> requestMethods = const [RequestMethod.all()],
  }) {
    _routes.add(Route(
        requestMethods: requestMethods,
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  Router ws(
      {required String path,
      required WebsocketHandler websocketHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    _routes.add(WebsocketRoute(
        requestMethods: [RequestMethod.get()],
        path: path,
        webSocketHandler: websocketHandler,
        middlewares: middlewares));
    return this;
  }

  Router socketIO(
      {required SocketIOHandler socketIOHandler,
      List<MiddlewareHandler> middlewares = const [],
      String path = '/socket.io/'}) {
    _routes.add(WebsocketRoute(
        requestMethods: [RequestMethod.get()],
        path: path,
        webSocketHandler: socketIOHandler,
        middlewares: middlewares));
    return this;
  }
}
