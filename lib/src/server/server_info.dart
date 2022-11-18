part of fennec;

/// [ServerInfo] is a class that contains information about the server.
/// It's used to get information about the server.
class ServerInfo {
  /// [address] is the address of the server.
  late dynamic address;

  /// [port] is the port of the server.
  late int port;

  /// [autoCompress] is a [bool] that indicates if the server should compress the response.
  late bool autoCompress;

  /// [defaultResponseHeaders] is a type of [HttpHeaders] that contains the default response headers.
  late HttpHeaders defaultResponseHeaders;

  /// [idleTimeout] is a [Duration] that indicates the idle timeout of the server.
  Duration? idleTimeout;

  /// [serverHeader] is a [String] that contains the server header of the server.
  String? serverHeader;

  /// [ServerInfo] is a constructor that creates a new [ServerInfo] object.
  ServerInfo(
    this.address,
    this.port,
    this.autoCompress,
    this.defaultResponseHeaders,
    this.idleTimeout,
    this.serverHeader,
  );
}
