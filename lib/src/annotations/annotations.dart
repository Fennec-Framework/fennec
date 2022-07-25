part of fennec;

/// @RestController is an annotation that is used to define a rest controller.
///
/// [path] is a [String] that contains the path.
class RestController {
  final String path;
  const RestController({required this.path});

  /// [getControllerPath] is used to define a controller path and can be overridden to create own RestController.
  String getControllerPath() {
    return path;
  }
}

/// @Middleware is an annotation that is used to define a middleware.
///
/// [priority] is a [int] that contains the priority.
///
/// by default the priority is 0.
class Middleware {
  final int priority;
  const Middleware({this.priority = 0});
}

/// [AMiddlwareHandler] of type [T] is a abstract class that is used to define a middlware handler.
abstract class AMiddlwareHandler<T> {
  const AMiddlwareHandler();
}

/// [UserProvider] is a abstract class that is used to define a user provider.
///
/// [loadUser] is a [Function] that contains the load user function.
///
///
abstract class UserProvider {
  const UserProvider();
  @AuthorizationRequired()
  Future<UserDetails?> loadUser(
    Request request,
    Response response,
    List<String> roules,
  );
}

/// @AuthorizationRequired is an annotation that is used to define a authorization required.
class AuthorizationRequired {
  const AuthorizationRequired();
}
