part of fennec;

class AppSettings {
  late String viewsPath;
  late bool cache;
  late String viewEngine;
  AppSettings({
    cache = true,
    String? viewPathParam,
    viewEngine = 'html',
  }) : viewsPath = viewPathParam ?? path.absolute('views');
}

class Application {
  late dynamic host;
  late int port;
  String? rootPath;
  late AppSettings _settings;
  late Map<String, dynamic> cache;
  late Map<String, Engine> _engines;
  static final Application _instance = Application._internal();
  factory Application(dynamic host, int port) {
    _instance._settings = AppSettings();
    _instance.cache = {};
    _instance._engines = {'html': HtmlEngine.use()};
    _instance.host = host;
    _instance.port = port;
    return _instance;
  }
  Application._internal();
  Application setRootPath(String rootPath) {
    _instance.rootPath = rootPath;
    return this;
  }

  final List<Type> _controllers = [];
  int numberOfProcessors = 1;
  void setNumberOfProcessors(int num) {
    _instance.numberOfProcessors = num;
  }

  void addController(Type controller) {
    _instance._controllers.add(controller);
  }

  void addControllers(List<Type> controllers) {
    _instance._controllers.addAll(controllers);
  }

  List<Type> get controllers => _instance._controllers;

  void set(String key, dynamic value) {
    switch (key.toLowerCase()) {
      case 'views engine':
      case 'view engine':
        _instance._settings.viewEngine = value;
        break;
      case 'views':
        _instance._settings.viewsPath = value;
        break;
      case 'cache':
        _instance._settings.cache = value;
        break;
      default:
        throw ArgumentError('Invalid key "$key" for settings.');
    }
  }

  Application engine(Engine engine) {
    if (_instance._engines[engine.ext] != null) {
      throw Error.safeToString(
        'A View engine for the ${engine.ext} extension has already been defined.',
      );
    }
    _instance._engines[engine.ext] = engine;
    return this;
  }

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
    if (_instance._settings.cache) {
      view = _instance.cache[fileName];
    }
    if (view == null) {
      view = View(fileName, _instance._engines,
          defaultEngine: _instance._settings.viewEngine,
          rootPath: _instance.rootPath ?? _instance._settings.viewsPath);

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
    if (_instance._settings.cache) {
      _instance.cache[fileName] = view;
    }
    return view;
  }
}
