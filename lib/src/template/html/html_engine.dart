part of fennec;

class HtmlEngine {
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
