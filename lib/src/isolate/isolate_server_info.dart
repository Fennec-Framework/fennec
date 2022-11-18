part of fennec;

///[IsolateServerIfo] a class that contains an instance of [ServerInfo] that will be shared between isolates.
class IsolateServerInfo {
  ServerInfo serverInfo;

  IsolateServerInfo(this.serverInfo);
}
