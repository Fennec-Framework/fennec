import 'dart:mirrors';

/// [ControllerInstance] is a class that is used to define a controller instance.
class ControllerInstance {
  /// [controllerPath] is a [String] that contains the controller path.
  final String controllerPath;

  /// [instanceMirror] is a [InstanceMirror] that contains the instance mirror.
  final InstanceMirror instanceMirror;

  /// [ControllerInstance] is a constructor that is used to define a controller instance.
  const ControllerInstance(this.controllerPath, this.instanceMirror);
}
