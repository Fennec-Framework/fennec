part of fennec;

/// [WebSocketHandler] is a class that contains the websocket handler.
class WebSocketHandler {
  /// [_server] is a [Server] that contains the server.
  Server? _server;

  /// getter that returns the server.
  Server? get server => _server;

  /// [clients] is a [List] of [UpgradedWebSocket] that contains the clients.
  final List<UpgradedWebSocket> clients = [];
  StreamController<UpgradedWebSocket> get clientsListener =>
      _instance._server == null
          ? throw Exception("you need to regsiter your websocket firstly")
          : _instance._server!.webSocketStream;
  Stream<UpgradedWebSocket> get clientsMultipleListener => _instance._server ==
          null
      ? throw Exception("you need to regsiter your websocket firstly")
      : _instance._server!.webSocketStreamBroadcast.stream.asBroadcastStream();

  /// [_instance] is a [WebSocketHandler] that contains the instance of the websocket handler.
  factory WebSocketHandler() {
    return _instance;
  }

  /// [registerWebSocketHandler] is a method that registers the websocket handler.
  void registerWebSocketHandler(Server server) {
    if (_instance._server != null) {
      throw Exception("the server is already registred");
    }
    _instance._server = server;
  }

  static final WebSocketHandler _instance = WebSocketHandler._internal();
  WebSocketHandler._internal();

  /// [addClient] is a method that adds a new client to the websocket handler.
  void addClient(UpgradedWebSocket webSocket) {
    clients.add(webSocket);
  }

  /// [removeClient] is a method that removes a client from the websocket handler.
  void removeClient(UpgradedWebSocket webSocket) {
    clients.remove(webSocket);
  }

  /// [sendToAllJson] is a method that sends a json to all clients.
  void sendToAllJson(Map<String, dynamic> map) {
    for (var client in clients) {
      client.webSocket.add(jsonEncode(map));
    }
  }

  /// [sendToAllText] is a method that sends a text to all clients.
  void sendToAllText(String text) {
    for (var client in clients) {
      client.webSocket.add(text);
    }
  }
}
