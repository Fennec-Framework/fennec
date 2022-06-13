part of fennec;

class RestController {
  final String path;
  const RestController({required this.path});
}

class Middleware {
  final int priority;
  const Middleware({this.priority = 0});
}

abstract class MiddlwareHandler<T> {
  const MiddlwareHandler();
}

abstract class UserProvider {
  const UserProvider();
  @AuthorizationRequired()
  Future<UserDetails?> loadUser(
      Request request, Response response, List<String> roules);
}

class AuthorizationRequired {
  const AuthorizationRequired();
}
