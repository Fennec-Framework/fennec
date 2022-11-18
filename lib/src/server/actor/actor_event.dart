part of fennec;

abstract class ActorEvent {}

class ActorInitialized extends ActorEvent {}

class ActorGetResult extends ActorEvent {
  final dynamic result;

  ActorGetResult(this.result);
}

class ActorDisposed extends ActorEvent {}
