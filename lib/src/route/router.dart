part of fennec;

abstract class ARouter {
  String getRoutePath();
}

class Router extends ARouter {
  final List<Route> _routes = [];
  List<Route> get routes => _routes;
  Router post(
      {required String path,
      required RequestHandler requestHandler,
      required List<MiddlewareHandler> middlewares}) {
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
      required List<MiddlewareHandler> middlewares}) {
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
      required List<MiddlewareHandler> middlewares}) {
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
      required List<MiddlewareHandler> middlewares}) {
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
      required List<MiddlewareHandler> middlewares}) {
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
      required List<MiddlewareHandler> middlewares}) {
    _routes.add(Route(
        requestMethod: RequestMethod.patch(),
        path: path,
        requestHandler: requestHandler,
        middlewares: middlewares));
    return this;
  }

  @override
  String getRoutePath() {
    return '';
  }
}
