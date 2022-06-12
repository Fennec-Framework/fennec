import 'dart:mirrors';

class ControllerInstance {
  final String controllerPath;
  final InstanceMirror instanceMirror;
  const ControllerInstance(this.controllerPath, this.instanceMirror);
}
