part of fennec;

/// [FileRepository] is a abstract class that contains the file repository.
abstract class FileRepository {
  const FileRepository();

  /// [readAsString] is a method that reads the file as string.
  /// [uri] is a [Uri] that contains the uri of the file.
  Future<String> readAsString(Uri uri);
}

/// [FileRepositoryImpl] is a class that contains the file repository implementation.
class FileRepositoryImpl extends FileRepository {
  const FileRepositoryImpl();

  @override
  Future<String> readAsString(Uri uri) {
    return File.fromUri(uri).readAsString();
  }
}
