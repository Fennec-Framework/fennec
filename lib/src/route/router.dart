part of fennec;

abstract class ARouter {
  String routerPath = '';
}

class Router extends ARouter {
  Router({String routerPath = ''}) {
    this.routerPath = routerPath;
  }

  List<MiddlewareHandler> middlewareHandlers = [];
  Router useMiddleware(MiddlewareHandler middlewareHandler) {
    middlewareHandlers.add(middlewareHandler);
    return this;
  }

  Router useMiddlewares(List<MiddlewareHandler> middlewareHandlers) {
    this.middlewareHandlers.addAll(middlewareHandlers);
    return this;
  }

  final List<Route> _routes = [];
  List<Route> get routes => _routes;
  Router post(
      {required String path,
      required RequestHandler requestHandler,
      List<MiddlewareHandler> middlewares = const []}) {
    _routes.add(Route(
        requestMethod: RequestMethod.post(),
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
        requestMethod: RequestMethod.get(),
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
        requestMethod: RequestMethod.delete(),
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
        requestMethod: RequestMethod.put(),
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
        requestMethod: RequestMethod.options(),
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
        requestMethod: RequestMethod.patch(),
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }
}
