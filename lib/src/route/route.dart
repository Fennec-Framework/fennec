/*part of fennec;

/// [ARoute] is a abstract class that is used to create pre-defined types of route.
abstract class ARoute {
  /// [path] is the path of the route.
  final String path;

  /// [method] is the [RequestMethod] of the route.
  final RequestMethod method;

  /// constructor of [ARoute]
  const ARoute(this.path, this.method);
}

/// [Route] is a class that is used to define a normal route.
class Route extends ARoute {
  const Route(String path, RequestMethod method) : super(path, method);
}

/// [AuthenticatedRoute] is a class that is used to define a route that requires
/// authentication.
///
/// [middlwareHandler] is a [AMiddlwareHandler] that contains the authentication middlware.
class AuthenticatedRoute extends ARoute {
  final AMiddlwareHandler middlwareHandler;
  const AuthenticatedRoute(
      String path, RequestMethod method, this.middlwareHandler)
      : super(path, method);
}

/// [AuthorizatedRoute] is a class that is used to define a route that requires
/// authorization.
///
/// [middlwareHandler] is a [AMiddlwareHandler] that contains the authorization middlware.
///
/// [roles] is a [List] of [String] that contains the roles.
///
/// [userProvider] is a [UserProvider] that contains the user provider.
///
class AuthorizatedRoute extends ARoute {
  final AMiddlwareHandler middlwareHandler;
  final List<String> roles;
  final UserProvider userProvider;
  const AuthorizatedRoute(
    String path,
    RequestMethod method,
    this.middlwareHandler,
    this.roles,
    this.userProvider,
  ) : super(path, method);
}
*/
part of fennec;

class Route {
  final RequestMethod requestMethod;
  final String path;
  final RequestHandler requestHandler;
  final List<MiddlewareHandler> middlewares;

  Route(
      {required this.requestMethod,
      required this.path,
      required this.requestHandler,
      required this.middlewares});
}
