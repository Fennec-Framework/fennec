part of fennec;

/// [MiddleWareResponseEnum] is a [enum] that contains the different response types of the middleware.
enum MiddleWareResponseEnum { next, stop }

@Deprecated('not used more. you can use Next instead')

/// [MiddleWareResponse] is a class that contains the response of the middleware
class MiddleWareResponse {
  /// [value] is a [MiddleWareResponseEnum] that contains the response of the middleware.
  final MiddleWareResponseEnum value;

  /// constructor that creates a new [MiddleWareResponse] object.
  MiddleWareResponse(this.value);
}

/// [MiddleWare] is an abstract class that contains the response of the middleware
abstract class MiddleWare {}

class Next implements MiddleWare {
  Next();
}

class Stop implements MiddleWare {
  final Response response;
  Stop(this.response);
}
