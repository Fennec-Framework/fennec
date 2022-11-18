part of fennec;

///[IsolateEvent] is an abstract class to define all Event of Isolate.
abstract class IsolateEvent {}

class IsolateInitialized extends IsolateEvent {
  final SendPort isolatePort;

  IsolateInitialized(this.isolatePort);
}

class IsolateStarted extends IsolateEvent {}

class IsolateStopped extends IsolateEvent {}

class IsolateResumed extends IsolateEvent {}

class IsolatePaused extends IsolateEvent {}

class IsolateDisposed extends IsolateEvent {}
