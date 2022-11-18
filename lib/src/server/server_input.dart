part of fennec;

class ServerInput {
  final int port;
  final String host;
  final List<ARoute> routes;
  final List<Router> routers;
  CorsOptions? corsOptions;
  bool useWebSocket;
  bool useSocketIO;
  SecurityContext? securityContext;
  final List<MiddlewareHandler> middlewares;

  ServerInput(this.port, this.host, this.routers, this.routes, this.middlewares,
      this.useWebSocket, this.useSocketIO,
      {this.corsOptions, this.securityContext});
}
