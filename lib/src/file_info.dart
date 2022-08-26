part of fennec;

/// [FileInfo] is a class that contains information about the file.
class FileInfo {
  /// [mimeType] is a [String] that contains the mime type of the file.
  String mimeType;

  /// [name] is a [String] that contains the name.
  String name;

  /// [filename] is a [String] that contains the file name.
  String filename;

  /// [data] is a [List] of [int] that contains the data.
  /// bydefault it's empty.
  List<int> data;

  /// [FileInfo] is a constructor that creates a new [FileInfo] object.
  FileInfo({
    required this.mimeType,
    required this.name,
    required this.filename,
    this.data = const [],
  });
}
