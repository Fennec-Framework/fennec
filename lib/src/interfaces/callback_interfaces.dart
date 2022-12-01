part of fennec;

/// [RequestHandler] is a [typedef] that is used to define a callback for a request.
/// [req] is a [Request] that is the request.
/// [res] is a [Response] that is the response.
///
/// returns [FutureOr] of [void].
typedef RequestHandler = FutureOr<Response> Function(
    ServerContext serverContext, Request req, Response res);
typedef WebsocketHandler = FutureOr<void> Function(
    ServerContext serverContext, HttpRequest request);
typedef SocketIOHandler = FutureOr<void> Function(
    ServerContext serverContext, HttpRequest request);

typedef RouterInitState = FutureOr<dynamic> Function(
    ServerContext serverContext);

/// [MiddlewareHandler] is a [typedef].
/// [req] is a [Request] that is the request.
/// [res] is a [Response] that is the response.
/// returns [FutureOr] of [Next].
typedef MiddlewareHandler = FutureOr<Middleware> Function(
    ServerContext serverContext, Request req, Response res);

/// [RouteNotFoundException] is a [typedef].
/// [response] is a [Response] that is the response.
/// [path] is a [String] that is the path.
/// [method] is a [String] that is the method name.
typedef RouteNotFoundException = void Function(
    Response response, String path, String method);

/// [EngineHandlerCallback] is a [typedef] that is used to define a callback for Engine Handler.
typedef EngineHandlerCallback = Function(dynamic e, String? rendered);

/// [EngineHandler] is a [typedef] that is used to define a Engine Handler.
/// [filePath] is a [String] that is the file path.
/// [locals] is a [Map] that is the locals.
/// [cb] is a [EngineHandlerCallback] that is the callback.
typedef EngineHandler = Function(String filePath, Map<String, dynamic>? locals,
    EngineHandlerCallback cb, Map<String, dynamic>? parameters);

/// [MiddleWareRequestByLoadUser] is a [typedef] that is used to define a callback.
/// [req] is a [Request] that is the request.
/// [res] is a [Response] that is the response.
/// [authenticationProvider] is a [AuthenticationProvider] that is the authentication provider.
typedef MiddleWareRequestByLoadUser = FutureOr<UserDetails?> Function(
    Request req, Response res, AuthenticationProvider authenticationProvider);

typedef IsolateMessageHandler<T> = FutureOr<void> Function(T message);
