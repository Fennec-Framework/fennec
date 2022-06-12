part of fennec;

abstract class UserRepository {
  const UserRepository();
  FutureOr<UserDetails?> loadUser(dynamic id, {List<String>? authorities});
}
