part of fennec;

/// [AuthenticationProvider] is a abstract class that contains the authentication provider.
abstract class AuthenticationProvider {
  /// [authorities] is a [List] of [String] that contains the authorities.
  final List<String> authorities;

  /// [userRepository] is a [UserRepository] that contains the user repository.
  final UserRepository userRepository;

  /// [AuthenticationProvider] is a constructor that creates a new [AuthenticationProvider] object.
  const AuthenticationProvider(this.authorities, this.userRepository);
}
