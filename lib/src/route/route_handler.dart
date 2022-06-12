part of fennec;

class RoutesHandler {
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
