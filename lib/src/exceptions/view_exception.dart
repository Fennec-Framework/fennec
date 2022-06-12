part of fennec;

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
