part of fennec;

enum MiddleWareResponseEnum { next, stop }

/// this class present a response for a middlware

class MiddleWareResponse {
  final MiddleWareResponseEnum value;
  MiddleWareResponse(this.value);
}
