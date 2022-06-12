part of fennec;

class WebSocketHandler {
  Server? _server;
  Server? get server => _server;
  final List<UpgradedWebSocket> clients = [];
  StreamController<UpgradedWebSocket> get clientsListener =>
      _instance._server == null
          ? throw Exception("you need to regsiter your websocket firstly")
          : _instance._server!.webSocketStream;
  Stream<UpgradedWebSocket> get clientsMultipleListener => _instance._server ==
          null
      ? throw Exception("you need to regsiter your websocket firstly")
      : _instance._server!.webSocketStreamBroadcast.stream.asBroadcastStream();
  factory WebSocketHandler() {
    return _instance;
  }
  void registerWebSocketHandler(Server server) {
    if (_instance._server != null) {
      throw Exception("the server is already registred");
    }
    _instance._server = server;
  }

  static final WebSocketHandler _instance = WebSocketHandler._internal();
  WebSocketHandler._internal();

  void addClient(UpgradedWebSocket webSocket) {
    clients.add(webSocket);
  }

  void removeClient(UpgradedWebSocket webSocket) {
    clients.remove(webSocket);
  }

  void sendToAllJson(Map<String, dynamic> map) {
    for (var client in clients) {
      client.webSocket.add(jsonEncode(map));
    }
  }

  void sendToAllText(String text) {
    for (var client in clients) {
      client.webSocket.add(text);
    }
  }
}
