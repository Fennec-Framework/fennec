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
  static Future<String?> handler(String filePath, Map<String, dynamic>? locals,
      EngineHandlerCallback callback, Map<String, dynamic>? parameters) async {
    try {
      FileRepository fileRepository = const FileRepositoryImpl();
      var uri = Uri.file(filePath);
      String rendered = await fileRepository.readAsString(uri);
      if (parameters != null) {
        for (var element in parameters.entries) {
          if (rendered.contains(element.key)) {
            if (element.value is List) {
              String result = "[";
              for (int i = 0; i < element.value.length; i++) {
                result += '"${element.value[i].toString()}"';
                if (i < element.value.length - 1) {
                  result += ' ,';
                }
              }
              result += "]";
              rendered = rendered.replaceAll(element.key, result);
            } else {
              rendered =
                  rendered.replaceAll(element.key, element.value.toString());
            }
          }
        }
      }

      callback(null, rendered);
      return rendered;
    } catch (e) {
      callback(e, null);
      return null;
    }
  }

  static String renderHtmlAsString(String html,
      {Map<String, dynamic> parameters = const {}}) {
    for (var element in parameters.entries) {
      if (html.contains(element.key)) {
        if (element.value is List) {
          String result = "[";
          for (int i = 0; i < element.value.length; i++) {
            result += '"${element.value[i].toString()}"';
            if (i < element.value.length - 1) {
              result += ' ,';
            }
          }
          result += "]";
          html = html.replaceAll(element.key, result);
        } else {
          html = html.replaceAll(element.key, element.value.toString());
        }
      }
    }

    return html;
  }

  static Engine use() => Engine(HtmlEngine.ext, HtmlEngine.handler);
}
