part of fennec;

abstract class UserDetails {
  dynamic id;
  late String username;
  late String email;
  late String password;
  late Iterable<Object> authorities;
  bool isEnabled();
  bool isCredentialsNonExpired();
  bool isAccountNonLocked();
  bool isAccountNonExpired();
  UserDetails fromJson(Map<String, dynamic> map);
}

class UsersDetailsImpl implements UserDetails {
  @override
  Iterable<Object> authorities;

  @override
  String email;

  @override
  dynamic id;
  @override
  String password;

  @override
  String username;
  UsersDetailsImpl(
      this.authorities, this.email, this.id, this.password, this.username);

  @override
  bool isAccountNonExpired() {
    return true;
  }

  @override
  bool isAccountNonLocked() {
    // TODO: implement isAccountNonLocked
    throw UnimplementedError();
  }

  @override
  bool isCredentialsNonExpired() {
    // TODO: implement isCredentialsNonExpired
    throw UnimplementedError();
  }

  @override
  bool isEnabled() {
    // TODO: implement isEnabled
    throw UnimplementedError();
  }

  @override
  UserDetails fromJson(Map<String, dynamic> map) {
    return UsersDetailsImpl(map['authoroties'], map['email'], map['id'],
        map['password'], map['userName']);
  }
}
