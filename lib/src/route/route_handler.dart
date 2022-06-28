part of fennec;

/// [RoutesHandler] is a class that is used to handle routes.
class RoutesHandler {
  /// [pathMatcher] is a method that is used to match a path.
  static Map<String, dynamic>? pathMatcher(
      {required String routePath, required String matchesPath}) {
    Map<String, dynamic>? params = {};
    if (routePath == matchesPath) return params;
    List<String> pathComponents = matchesPath.split("/");
    List<String> routeComponents = routePath.split("/");
    if (pathComponents.length == routeComponents.length) {
      for (int i = 0; i < pathComponents.length; i++) {
        String path = pathComponents[i];
        String route = routeComponents[i];
        if (path == route) continue;
        if (route.startsWith("@")) {
          params[route.substring(1)] = path;
        }
      }
    }
    return params;
  }

  /// [checkRoutes] is a static method that is used to check if a route is
  /// valid.
  /// [routes] is a [List] of [RestControllerRoutesMapping].
  static void checkRoutes(List<RestControllerRoutesMapping> routes) {
    List<String> exitingsRoutes = [];
    for (RestControllerRoutesMapping routesMapping in routes) {
      for (var element in routesMapping.routes.entries) {
        String composed = (routesMapping.controllerInstance.controllerPath +
                element.value.path +
                element.value.method.requestMethod)
            .toLowerCase();
        if (exitingsRoutes.contains(composed)) {
          throw Exception('you have multiples Routes with the same end point');
        } else {
          exitingsRoutes.add(composed);
        }
      }
    }
  }

  /// [getMatchedRoute1s] is a static method that is used to get the matched
  /// routes.
  /// [routes] is a [List] of [RestControllerRoutesMapping].
  /// [path] is a [String] that is the path to match.
  ///
  /// returns [List] of [RestControllerRoutesMapping].
  static List<RestControllerRoutesMapping> getMatchedRoute1s(
      List<RestControllerRoutesMapping> routes, String path) {
    List<RestControllerRoutesMapping> _routes = [];
    List<String> pathComponents = path.split("/");

    for (RestControllerRoutesMapping routesMapping in routes) {
      Map<Symbol, ARoute> _routesMap = {};
      for (var element in routesMapping.routes.entries) {
        List<String> routeComponents =
            (routesMapping.controllerInstance.controllerPath +
                    element.value.path)
                .split("/");
        bool checker = false;
        if (pathComponents.length == routeComponents.length) {
          for (int i = 0; i < pathComponents.length && !checker; i++) {
            String path = pathComponents[i];
            String route = routeComponents[i];

            if (path != route && !route.startsWith("@")) {
              checker = true;
            }
          }
        } else {
          checker = true;
        }
        if (!checker) {
          _routesMap.addAll({element.key: element.value});
        }
      }
      if (_routesMap.isNotEmpty) {
        _routes.add(RestControllerRoutesMapping(
            routesMapping.controllerInstance, _routesMap));
      }
    }
    return _routes;
  }
}
