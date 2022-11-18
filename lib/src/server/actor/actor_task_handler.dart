part of fennec;

class ActorTaskHandler extends IsolateTaskHandler {
  final Actor _actor;

  ActorTaskHandler(this._actor);

  @override
  Future<void> onStart(IsolateContext context) async {
    try {
      await _actor.initState();

      context.receive<ActorGet>(_handleActorGet);
      context.receive<ActorGetInstance>(_handleActorGetInstance);
      context.receive<ActorExecution>(_handleActorExecute);
    } catch (error, stackTrace) {
      context.send(IsolateError(error, stackTrace));
    }
  }

  void _handleActorGet(ActorGet action) async {
    var result = await _actor.get(action.action, data: action.data);
    action.feedbackPort.send(ActorGetResult(result));
  }

  void _handleActorGetInstance(ActorGetInstance action) {
    var result = _actor.getInstance(action.action, data: action.data);
    action.feedbackPort.send(ActorGetResult(result));
  }

  void _handleActorExecute(ActorExecution action) async {
    await _actor.execute(action.action, data: action.data);
  }

  @override
  Future<void> onDispose(IsolateContext context) async {
    await _actor.dispose();
  }
}
