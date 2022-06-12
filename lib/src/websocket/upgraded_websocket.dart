part of fennec;

class UpgradedWebSocket {
  WebSocket webSocket;
  HttpHeaders? headers;
  Uri uri;
  UpgradedWebSocket(this.webSocket, this.headers, this.uri);
}
