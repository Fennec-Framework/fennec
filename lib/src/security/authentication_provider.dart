part of fennec;

abstract class AuthenticationProvider {
  final List<String> authorities;
  final UserRepository userRepository;
  const AuthenticationProvider(this.authorities, this.userRepository);
}
