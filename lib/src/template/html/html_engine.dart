part of fennec;

/// [HtmlEngine] is a class that contains the html engine.
/// It's used to get the html engine.
class HtmlEngine {
  /// [ext] is a [String] that contains the extension of the engine.
  /// It's set to [html].
  /// bydefault it's ".html".
  static String ext = '.html';

  /// Called when rendering an HTML file in the Response
  ///
  /// [locals] is ignored for HTML files
  static Future<String?> handler(
    String filePath,
    Map<String, dynamic>? locals,
    EngineHandlerCallback callback, [
    FileRepository fileRepository = const FileRepositoryImpl(),
  ]) async {
    try {
      var uri = Uri.file(filePath);
      final rendered = await fileRepository.readAsString(uri);

      callback(null, rendered);
      return rendered;
    } catch (e) {
      callback(e, null);
      return null;
    }
  }

  static Engine use() => Engine(HtmlEngine.ext, HtmlEngine.handler);
}
