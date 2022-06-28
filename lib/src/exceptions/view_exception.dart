part of fennec;

/// [ViewException] is a class that is used to define a view exception.
/// it implements [Error].
/// [view] is a [View] that contains the view.
/// [directory] is a [String] that contains the directory.
class ViewException implements Error {
  final View view;
  final String directory;

  ViewException(this.view, this.directory);
  String get message =>
      'ViewException(Failed to find ${view.name}${view.ext} in $directory)';

  @override
  String toString() => message;

  @override
  StackTrace get stackTrace => StackTrace.fromString('ViewException');
}
