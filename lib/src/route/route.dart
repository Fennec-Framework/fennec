part of fennec;

/// abstract class for all possible Route Annotations.
abstract class ARoute {
  final String path;
  final RequestMethod method;
  const ARoute(this.path, this.method);
}

class Route extends ARoute {
  const Route(String path, RequestMethod method) : super(path, method);
}

class AuthenticatedRoute extends ARoute {
  final MiddlwareHandler middlwareHandler;
  const AuthenticatedRoute(
      String path, RequestMethod method, this.middlwareHandler)
      : super(path, method);
}

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
