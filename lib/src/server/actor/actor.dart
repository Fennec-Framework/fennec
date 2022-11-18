part of fennec;

/// [Actor] is an abstract superclass, where all their subclasses will be executed separately in each instance.
/// [Actor] is used to ensure sharing Data between multiples Isolates.
/// All subclasses of [Actor] will be accessible in each server Instance.
abstract class Actor {
  late final String name;
  final Map<String, dynamic> data;

  Actor(this.name, {this.data = const {}});

  String getName() {
    return name;
  }

  Map<String, dynamic> getData() {
    return data;
  }

  /// [initState] will be called to initialized Data.
  FutureOr<void> initState() {}

  /// [get] will be used to get Data from Agent depending from Action.
  FutureOr<dynamic> get(String action, {Map<String, dynamic> data = const {}});

  /// [execute] will be used to execute some operations in Agent instance.
  FutureOr<void> execute(String action, {Map<String, dynamic> data = const {}});

  /// [dispose] will be used to free all Objects and resources used by [Agent]
  FutureOr<void> dispose() {}

  ///[getInstance] will be used to have directly access to [Agent] instances Objects. it should just used to get method but  not to execute.
  Actor? getInstance(String action, {Map<String, dynamic> data = const {}}) {
    if (action == "this") return this;
    return null;
  }
}
