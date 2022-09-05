part of fennec;

FutureOr<AMiddleWareResponse> Function(Request request, Response response) cors(
    CorsOptions corsOptions) {
  return (Request req, Response res) {
    res.headers.add('Access-Control-Allow-Origin', corsOptions.origin);
    res.headers.add('Access-Control-Allow-Headers', corsOptions.headers);
    res.headers.add('Access-Control-Expose-Headers', corsOptions.headers);
    res.headers.add('Access-Control-Allow-Methods', corsOptions.methods);
    res.headers.add('Access-Control-Max-Age', corsOptions.age);

    if (isPreflight(req)) {
      res.statusCode = 204;
      return Stop(res);
    }
    return Next();
  };
}

bool isPreflight(Request req) {
  return (req.httpRequest.method == 'OPTIONS' &&
      req.httpRequest.headers['origin'] != null &&
      req.httpRequest.headers['access-control-request-method'] != null);
}
