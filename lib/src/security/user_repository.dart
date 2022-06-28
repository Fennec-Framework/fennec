part of fennec;

/// [UserRepository] is a abstract class that contains the user repository.
abstract class UserRepository {
  const UserRepository();

  /// [loadUser] is a method that loads the user.
  FutureOr<UserDetails?> loadUser(dynamic id, {List<String>? authorities});
}
