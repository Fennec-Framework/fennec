part of fennec;

///[ActorContainers] contains all [ActorContainer] that are used to send Data to actors
class ActorContainers {
  final List<ActorContainer> _actorContainers;

  ActorContainers(this._actorContainers);

  ActorContainer? get(String name) {
    for (var connector in _actorContainers) {
      if (connector.name == name) {
        return connector;
      }
    }
    return null;
  }

  ActorContainer? operator [](String key) {
    return get(key);
  }
}
