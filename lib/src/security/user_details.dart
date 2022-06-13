part of fennec;

abstract class UserDetails {
  final dynamic id;
  final String username;
  final String email;
  final String password;
  final Iterable<Object> authorities;
  bool isEnabled();
  bool isCredentialsNonExpired();
  bool isAccountNonLocked();
  bool isAccountNonExpired();
  UserDetails fromJson(Map<String, dynamic> map);
  const UserDetails(
      this.id, this.username, this.email, this.password, this.authorities);
}
