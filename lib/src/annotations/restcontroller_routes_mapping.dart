import 'package:fennec/fennec.dart';

import 'controller_instance.dart';

class RestControllerRoutesMapping {
  final ControllerInstance controllerInstance;
  final Map<Symbol, ARoute> routes;
  const RestControllerRoutesMapping(this.controllerInstance, this.routes);
}
