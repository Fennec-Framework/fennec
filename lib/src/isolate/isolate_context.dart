part of fennec;

class IsolateContext {
  final Stream _receiveStream;

  final SendPort _supervisorPort;

  final Map<String, dynamic> _data;

  Map<String, dynamic> get data => Map.unmodifiable(_data);

  IsolateContext(this._receiveStream, this._supervisorPort, this._data);

  StreamSubscription<T> receive<T>(IsolateMessageHandler<T> handler) {
    return _receiveStream
        .where((event) => event is T)
        .map<T>((event) => event as T)
        .listen((event) {
      handler(event);
    });
  }

  void send(dynamic message) {
    _supervisorPort.send(message);
  }
}
