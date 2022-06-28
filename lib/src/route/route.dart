part of fennec;

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
/// [middlwareHandler] is a [MiddlwareHandler] that contains the authentication middlware.
class AuthenticatedRoute extends ARoute {
  final MiddlwareHandler middlwareHandler;
  const AuthenticatedRoute(
      String path, RequestMethod method, this.middlwareHandler)
      : super(path, method);
}

/// [AuthorizatedRoute] is a class that is used to define a route that requires
/// authorization.
///
/// [middlwareHandler] is a [MiddlwareHandler] that contains the authorization middlware.
///
/// [roles] is a [List] of [String] that contains the roles.
///
/// [userProvider] is a [UserProvider] that contains the user provider.
///
class AuthorizatedRoute extends ARoute {
  final MiddlwareHandler middlwareHandler;
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
