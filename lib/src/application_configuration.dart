part of fennec;

class ApplicationConfiguration {
  bool cache = false;
  dynamic host = '0.0.0.0';
  int port = 8000;
  SecurityContext? securityContext;
  String viewPath = path.join(path.current, 'views');
  String viewEngine = 'html';
  int numberOfIsolates = 1;
  final List<Type> controllers = [];
  ApplicationConfiguration addController(Type controller) {
    controllers.add(controller);
    return this;
  }

  ApplicationConfiguration addControllers(List<Type> controllers) {
    this.controllers.addAll(controllers);

    return this;
  }

  ApplicationConfiguration setCache(bool cache) {
    this.cache = cache;
    return this;
  }

  ApplicationConfiguration setHost(dynamic host) {
    this.host = host;
    return this;
  }

  ApplicationConfiguration setPort(int port) {
    this.port = port;
    return this;
  }

  ApplicationConfiguration setSecurityContext(SecurityContext securityContext) {
    this.securityContext = securityContext;
    return this;
  }

  ApplicationConfiguration setViewPath(String viewPath) {
    this.viewPath = viewPath;
    return this;
  }

  ApplicationConfiguration setViewEngine(String viewEngine) {
    this.viewEngine = viewEngine;
    return this;
  }

  ApplicationConfiguration setNumberOfIsolates(int numberOfIsolates) {
    this.numberOfIsolates = numberOfIsolates;
    return this;
  }
}
