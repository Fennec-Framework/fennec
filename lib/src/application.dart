part of fennec;

/// [Application] is a class that contains the application.
class Application {
  late final ApplicationConfiguration applicationConfiguration;

  /// [cache] is a [Map] that contains the cached data of the application.
  late Map<String, dynamic> cache;

  /// [_engines] is a [Map] that contains the engines of the application.
  final Map<String, Engine> _engines = {};

  /// instance of [Application] that contains the application.
  static final Application _instance = Application._internal();

  /// [Application] is a constructor that creates a new [Application] object.
  factory Application(ApplicationConfiguration applicationConfiguration) {
    _instance.applicationConfiguration = applicationConfiguration;
    return _instance;
  }
  Application._internal();

  /// [render] is a method that renders a view.
  void render(
    String fileName,
    Map<String, dynamic>? locals,
    Function(dynamic, String?) callback,
  ) {
    final view = _getViewFromFileName(fileName);
    view.render(locals, callback);
  }

  View _getViewFromFileName(String fileName) {
    View? view;
    if (_instance.applicationConfiguration.cache) {
      view = _instance.cache[fileName];
    }
    if (view == null) {
      view = View(fileName, _instance._engines,
          defaultEngine: _instance.applicationConfiguration.viewEngine,
          rootPath: _instance.applicationConfiguration.viewPath);

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
    if (_instance.applicationConfiguration.cache) {
      _instance.cache[fileName] = view;
    }
    return view;
  }
}
