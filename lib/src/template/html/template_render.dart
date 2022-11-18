part of fennec;

///[TemplateRender]  is a class that will be used to rendering templates with html extensions and contains caching if it's enabled.
class TemplateRender {
  static final TemplateRender _instance = TemplateRender._internal();
  late bool cache;
  final Map<String, dynamic> cached = {};
  final Map<String, Engine> _engines = {};
  final String defaultEngine = "html";
  String rootPath = "/";

  factory TemplateRender(bool cache) {
    _instance.cache = cache;
    return _instance;
  }

  TemplateRender._internal();

  /// [render] is a method that renders a view.
  void render(String fileName, Map<String, dynamic>? locals,
      Function(dynamic, String?) callback,
      {Map<String, dynamic> parameters = const {}}) {
    final view = _getViewFromFileName(fileName);
    view.render(locals, parameters, callback);
  }

  /// [renderHtmlAsString] is a method that renders a html file by a String.
  String renderHtmlAsString(String html,
      {Map<String, dynamic> parameters = const {}}) {
    return HtmlEngine.renderHtmlAsString(html, parameters: parameters);
  }

  View _getViewFromFileName(String fileName) {
    View? view;
    if (_instance.cache) {
      view = _instance.cached[fileName];
    }
    if (view == null) {
      view = View(fileName, _instance._engines,
          defaultEngine: _instance.defaultEngine, rootPath: _instance.rootPath);

      if (view.filePath == null) {
        late String dirs;
        if (view.rootPath is List) {
          dirs =
              'directories "${view.rootPath.join(', ')}" or "${view.rootPath[view.rootPath.length - 1]}"';
        } else {
          dirs = 'directory "${view.rootPath}"';
        }
        throw ViewException(view, dirs);
      }
    }
    if (_instance.cache) {
      _instance.cached[fileName] = view;
    }
    return view;
  }
}
