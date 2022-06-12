part of fennec;

class FileInfo {
  String mimeType;
  String name;
  String filename;
  List<int> data;

  FileInfo(
      {required this.mimeType,
      required this.name,
      required this.filename,
      this.data = const []});
}
