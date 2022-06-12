part of fennec;

class ServerInfo {
  late dynamic address;
  late int port;
  late bool autoCompress;
  late HttpHeaders defaultResponseHeaders;
  Duration? idleTimeout;
  String? serverHeader;

  ServerInfo(
    this.address,
    this.port,
    this.autoCompress,
    this.defaultResponseHeaders,
    this.idleTimeout,
    this.serverHeader,
  );
}
