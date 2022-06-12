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
}

class AuthorizationRequired {
  const AuthorizationRequired();
}
