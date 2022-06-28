part of fennec;

/// [MiddleWareResponseEnum] is a [enum] that contains the different response types of the middleware.
enum MiddleWareResponseEnum { next, stop }

/// [MiddleWareResponse] is a class that contains the response of the middleware.
class MiddleWareResponse {
  /// [value] is a [MiddleWareResponseEnum] that contains the response of the middleware.
  final MiddleWareResponseEnum value;

  /// constructor that creates a new [MiddleWareResponse] object.
  MiddleWareResponse(this.value);
}
