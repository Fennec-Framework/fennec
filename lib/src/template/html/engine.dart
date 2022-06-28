part of fennec;

/// [Engine] is a class that contains the engine.
class Engine {
  /// [ext] is a [String] that contains the extension of the engine.
  final String ext;

  /// [engineHandler] is a [EngineHandler] that contains the engine handler.
  final EngineHandler engineHandler;

  /// [Engine] is a constructor that creates a new [Engine] object.
  const Engine(this.ext, this.engineHandler);
}
