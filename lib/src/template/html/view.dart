part of fennec;

class View {
  dynamic rootPath;
  String? defaultEngine;
  String? filePath;
  String? ext;
  String name;
  Engine? engine;
  Map<String, Engine> engines;

  View(
    this.name,
    this.engines, {
    this.rootPath = "/",
    this.defaultEngine = "html",
  }) {
    ext = path.extension(name);

    if (ext == null && defaultEngine == null) {
      throw Error.safeToString('No default engine or extension are provided.');
    }
    var fileName = name;
    if (ext == null || ext!.isEmpty) {
      ext = defaultEngine![0] == '.' ? defaultEngine : '.$defaultEngine';

      fileName += ext!;
    }
    engine = engines[ext] ?? HtmlEngine.use();
    if (lookup(fileName) != null) {
      filePath = lookup(fileName);
    }
  }
  void render(Map<String, dynamic>? options,
      Function(dynamic e, String? rendered) callback) {
    if (filePath == null) {
      engine!.engineHandler(rootPath + name, options, callback);
    } else {
      engine!.engineHandler(filePath!, options, callback);
    }
  }

  String? lookup(String fileName) {
    String? finalPath;
    final List<String> roots = rootPath is List ? rootPath : [rootPath];
    for (var i = 0; i < roots.length && finalPath == null; i++) {
      final root = roots[i];
      final fullFilePath = path.join(root, fileName);
      final loc = path.isAbsolute(fullFilePath)
          ? fullFilePath
          : path.absolute(fullFilePath);
      finalPath = resolve(loc);
    }

    return finalPath;
  }

  String? resolve(filePath) {
    if (_exists(filePath) && _isFile(filePath)) {
      return filePath;
    } else {
      return null;
    }
  }

  bool _isFile(filePath) {
    try {
      return File.fromUri(Uri.file(filePath)).statSync().type ==
          FileSystemEntityType.file;
    } catch (e) {
      return false;
    }
  }

  bool _exists(filePath) {
    return File.fromUri(Uri.file(filePath)).existsSync();
  }
}
