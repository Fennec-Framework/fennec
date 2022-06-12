part of fennec;

abstract class FileRepository {
  const FileRepository();

  Future<String> readAsString(Uri uri);
}

class FileRepositoryImpl extends FileRepository {
  const FileRepositoryImpl();

  @override
  Future<String> readAsString(Uri uri) {
    return File.fromUri(uri).readAsString();
  }
}
