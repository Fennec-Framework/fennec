part of fennec;

///[Actors] is used to initialize all Connected Actors.
class Actors {
  final List<Actor> _actors;

  final Map<String, IsolateSupervisor> _supervisors = {};

  final List<ActorContainer> _actorContainers = [];

  List<ActorContainer> get actorContainers =>
      List.unmodifiable(_actorContainers);

  Actors(List<Actor> actors) : _actors = actors;

  Future<void> initState() async {
    if (_actors.map((e) => e.name).toSet().length != _actors.length) {
      throw Exception('all actors names must be unique.');
    }

    for (var data in _actors) {
      _supervisors[data.name] = IsolateSupervisor();
    }

    await Future.wait(_supervisors.values.map((e) => e.initState()));

    for (var i = 0; i < _actors.length; i++) {
      var actor = _actors[i];

      IsolateError? error;

      var supervisor = _supervisors[actor.name]!;

      var subscription = supervisor.errors.listen((event) {
        error ??= event;
      });

      await supervisor.start(ActorTaskHandler(actor));

      subscription.cancel();

      if (error != null) {
        throw Exception(
            'an error occurred in the actor with name: ${actor.name}.\n\ Actor error:\n\n${error!.error}\n\n Actor stack trace:\n\n${error!.stackTrace}');
      }

      _actorContainers.add(ActorContainer(actor.name, supervisor.isolatePort!));
    }
  }

  Future<void> pause() async {
    await Future.wait(_supervisors.values.map((e) => e.pause()));
  }

  Future<void> resume() async {
    await Future.wait(_supervisors.values.map((e) => e.resume()));
  }

  Future<void> dispose() async {
    await Future.wait(_supervisors.values.map((e) => e.dispose()));
  }
}
