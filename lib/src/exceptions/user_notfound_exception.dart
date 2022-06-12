part of fennec;

class UserNotFoundException implements Exception {
  String message;
  UserNotFoundException(this.message);
}
