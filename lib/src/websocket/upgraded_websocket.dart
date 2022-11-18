part of fennec;

/// [UpgradedWebSocket] is a class that contains the upgraded websocket.
/// It's used to get the upgraded websocket.
class UpgradedWebSocket {
  /// [webSocket] is a [WebSocket] that contains the websocket.
  WebSocket webSocket;

  /// [headers] is a [HttpHeaders] that contains the headers of the websocket.
  /// by default it's null.
  HttpHeaders? headers;

  /// [uri] is a [Uri] that contains the uri of the websocket.
  Uri uri;

  /// [UpgradedWebSocket] is a constructor that creates a new [UpgradedWebSocket] object.
  UpgradedWebSocket(this.webSocket, this.headers, this.uri);
}
