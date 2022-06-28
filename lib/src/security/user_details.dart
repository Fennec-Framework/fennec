part of fennec;

/// [UserDetails] is a abstract class that contains the user details.
abstract class UserDetails {
  /// [id] contains the id of the user.
  final dynamic id;

  /// [username] contains the username of the user.
  final String username;

  /// [password] contains the password of the user.
  final String email;

  /// [roles] contains the roles of the user.
  final String password;

  /// [authorities] is a [Iterable] of [Object] that contains the authorities of the user.
  final Iterable<Object> authorities;

  /// [isEnabled] is a method that checks if the user is enabled.
  ///
  /// returns true if the user is enabled, false otherwise.
  bool isEnabled();

  /// [isCredentialsNonExpired] is a method that checks if the user is credentials non expired.
  ///
  /// returns true if the user is credentials non expired, false otherwise.
  bool isCredentialsNonExpired();

  /// [isAccountNonLocked] is a method that checks if the user is account non locked.
  ///
  /// returns true if the user is account non locked, false otherwise.
  bool isAccountNonLocked();

  /// [isAccountNonExpired] is a method that checks if the user is account non expired.
  ///
  /// returns true if the user is account non expired, false otherwise.
  bool isAccountNonExpired();

  /// [fromJson] is a method that returns a new [UserDetails] object from a json object.
  UserDetails fromJson(Map<String, dynamic> map);

  /// [UserDetails] is a constructor that creates a new [UserDetails] object.
  const UserDetails(
    this.id,
    this.username,
    this.email,
    this.password,
    this.authorities,
  );
}
