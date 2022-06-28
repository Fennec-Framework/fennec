part of fennec;

/// [UserNotFoundException] is a class that is used to define a user not found exception.
/// it implements [Exception].
/// [message] is a [String] that contains the message.
class UserNotFoundException implements Exception {
  String message;
  UserNotFoundException(this.message);
}
