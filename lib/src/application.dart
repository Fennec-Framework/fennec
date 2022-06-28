part of fennec;

/// [AppSettings] is a class that contains the settings of the application.
class AppSettings {
  /// [viewsPath] is a [String] that contains the path of the views.
  late String viewsPath;

  /// [cache] is a [bool] that indicates if the application should cache the views.
  /// bydefault it's true.
  late bool cache;

  /// [viewEngine] is a [String] that contains the view engine.
  /// bydefault it's set to "html".
  late String viewEngine;
  AppSettings({
    cache = true,
    String? viewPathParam,
    viewEngine = 'html',
  }) : viewsPath = viewPathParam ?? path.absolute('views');
}

/// [Application] is a class that contains the application.
class Application {
  /// [host] contains the host of the application.
  late dynamic host;

  /// [port] is [int] that contains the port of the application.
  late int port;

  /// [rootPath] is a [String] that contains the root path of the application.
  /// bydefault it's set to null.
  String? rootPath;

  /// [_settings] is a [AppSettings] that contains the settings of the application.
  late AppSettings _settings;

  /// [cache] is a [Map] that contains the cache of the application.
  late Map<String, dynamic> cache;

  /// [_engines] is a [Map] that contains the engines of the application.
  late Map<String, Engine> _engines;

  /// instance of [Application] that contains the application.
  static final Application _instance = Application._internal();

  /// [Application] is a constructor that creates a new [Application] object.
  factory Application(dynamic host, int port) {
    _instance._settings = AppSettings();
    _instance.cache = {};
    _instance._engines = {'html': HtmlEngine.use()};
    _instance.host = host;
    _instance.port = port;
    return _instance;
  }
  Application._internal();

  /// [setRootPath] is a method that sets the root path of the application.
  Application setRootPath(String rootPath) {
    _instance.rootPath = rootPath;
    return this;
  }

  final List<Type> _controllers = [];

  /// [numberOfIsolates] is a [int] that contains the number of isolates of the application.
  int numberOfIsolates = 1;

  /// [setNumberOfIsolates] is a method that sets the number of isolates of the application.
  /// bydefault it's set to 1.
  void setNumberOfIsolates(int num) {
    _instance.numberOfIsolates = num;
  }

  /// [addController] is a method that adds a new controller to the application.
  /// [controller] is a [Type] that contains the controller.
  void addController(Type controller) {
    _instance._controllers.add(controller);
  }

  /// [addControllers] is a method that adds a new controllers to the application.
  /// [controllers] is a [List] of [Type] that contains the controllers to add.
  void addControllers(List<Type> controllers) {
    _instance._controllers.addAll(controllers);
  }

  /// getter of [controllers] that returns the controllers of the application.
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

  /// [engine] is a method that adds a new engine to the application.
  Application engine(Engine engine) {
    if (_instance._engines[engine.ext] != null) {
      throw Error.safeToString(
        'A View engine for the ${engine.ext} extension has already been defined.',
      );
    }
    _instance._engines[engine.ext] = engine;
    return this;
  }

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
