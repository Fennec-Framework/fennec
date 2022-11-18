part of fennec;

/// [ActorAction] is an abstract class to determine different Agent Actions.
abstract class ActorAction {}

class ActorInitState extends ActorAction {
  final Map<String, dynamic> data;

  ActorInitState(this.data);
}

class ActorGet extends ActorAction {
  final String action;

  final Map<String, dynamic> data;

  final SendPort feedbackPort;

  ActorGet(this.action, this.data, this.feedbackPort);
}

class ActorGetInstance extends ActorAction {
  final String action = "this";
  final Map<String, dynamic> data;
  final SendPort feedbackPort;

  ActorGetInstance(this.data, this.feedbackPort);
}

class ActorExecution extends ActorAction {
  final String action;

  final Map<String, dynamic> data;

  ActorExecution(this.action, this.data);
}
