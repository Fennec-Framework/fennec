part of fennec;

/// [ApplicationConfiguration] is a class that contains the configuration of the application.
class ApplicationConfiguration {
  ///[cache] is a boolean for enabling caching
  bool cache = false;

  ///[host] represents host of the server
  dynamic host = '0.0.0.0';

  ///[port] represents port of the server
  int port = 8000;

  ///[securityContext] represents if you bind your server secure
  SecurityContext? securityContext;

  ///[viewPath] represents the default path of views
  String viewPath = path.join(path.current, 'views');

  ///[viewEngine] represents the used viewEngine
  String viewEngine = 'html';

  /// [numberOfIsolates] is a [int] that contains the number of isolates of the application.
  int numberOfIsolates = 1;
  final List<Type> controllers = [];

  /// [addController] is a method that adds a new controller to the application.
  /// [controller] is a [Type] that contains the controller.
  ApplicationConfiguration addController(Type controller) {
    controllers.add(controller);
    return this;
  }

  /// [addControllers] is a method that adds a new controllers to the application.
  /// [controllers] is a [List] of [Type] that contains the controllers to add.
  ApplicationConfiguration addControllers(List<Type> controllers) {
    this.controllers.addAll(controllers);
    return this;
  }

  /// [setCache] is a method that enable caching of the application.
  /// bydefault it's set to false.
  ApplicationConfiguration setCache(bool cache) {
    this.cache = cache;
    return this;
  }

  /// [setHost] is a method that sets the host of server of the application.
  /// bydefault it's set to '0.0.0.0'.
  ApplicationConfiguration setHost(dynamic host) {
    this.host = host;
    return this;
  }

  /// [setPort] is a method that sets the port of server of the application.
  /// bydefault it's set to 8000.
  ApplicationConfiguration setPort(int port) {
    this.port = port;
    return this;
  }

  /// [setSecurityContext] is a method that sets the SecurityContext of server of the application.
  /// bydefault it's set to null.
  ApplicationConfiguration setSecurityContext(SecurityContext securityContext) {
    this.securityContext = securityContext;
    return this;
  }

  /// [setViewPath] is a method that sets the defaultpath of views of the application.
  ApplicationConfiguration setViewPath(String viewPath) {
    this.viewPath = viewPath;
    return this;
  }

  /// [setViewEngine] is a method that sets the defaultviewEngine of views of the application.
  ApplicationConfiguration setViewEngine(String viewEngine) {
    this.viewEngine = viewEngine;
    return this;
  }

  /// [setNumberOfIsolates] is a method that sets the number of isolates of the application.
  /// bydefault it's set to 1.
  ApplicationConfiguration setNumberOfIsolates(int numberOfIsolates) {
    this.numberOfIsolates = numberOfIsolates;
    return this;
  }
}
