import 'package:fennec/fennec.dart';

import 'controller_instance.dart';

/// [RestControllerRoutesMapping] is a class that is used to define a rest controller routes mapping.
class RestControllerRoutesMapping {
  /// [controllerInstance] is a [ControllerInstance] that contains the controller instance.
  final ControllerInstance controllerInstance;

  /// [routes] is a [Map] of [Symbol] and [ARoute] that contains the routes.
  final Map<Symbol, ARoute> routes;

  /// [RestControllerRoutesMapping] is a constructor that is used to define a rest controller routes mapping.
  const RestControllerRoutesMapping(this.controllerInstance, this.routes);
}
