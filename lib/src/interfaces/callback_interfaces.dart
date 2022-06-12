part of fennec;

typedef CallBackRequest = FutureOr Function(Request req, Response res);
typedef MiddleWareRequest = FutureOr<MiddleWareResponse> Function(
    Request req, Response res);
typedef RouteNotFoundException = void Function(
    Response response, String path, String method);
typedef EngineHandlerCallback = Function(dynamic e, String? rendered);
typedef EngineHandler = Function(
    String filePath, Map<String, dynamic>? locals, EngineHandlerCallback cb);

typedef MiddleWareRequestByLoadUser = FutureOr<UserDetails?> Function(
    Request req, Response res, AuthenticationProvider authenticationProvider);
