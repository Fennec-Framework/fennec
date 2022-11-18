part of fennec;

/// [ActorContainer] used to send different events to connected Agents depending on Action using [SendPort]
class ActorContainer {
  final String name;

  final SendPort _agentPort;

  ActorContainer(this.name, SendPort agentPort) : _agentPort = agentPort;

  Future<T> get<T>(String action, {Map<String, dynamic>? data}) async {
    var receivePort = ReceivePort();

    _agentPort.send(ActorGet(action, data ?? {}, receivePort.sendPort));

    var callResult = await receivePort
        .firstWhere((element) => element is ActorGetResult) as ActorGetResult;

    receivePort.close();

    return callResult.result as T;
  }

  void execute(String action, {Map<String, dynamic>? data}) {
    _agentPort.send(ActorExecution(action, data ?? {}));
  }

  Future<T> getInstance<T>({Map<String, dynamic>? data}) async {
    var receivePort = ReceivePort();
    _agentPort.send(ActorGetInstance(data ?? {}, receivePort.sendPort));
    var callResult = await receivePort
        .firstWhere((element) => element is ActorGetResult) as ActorGetResult;

    receivePort.close();

    return callResult.result as T;
  }
}
