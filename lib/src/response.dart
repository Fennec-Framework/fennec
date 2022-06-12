part of fennec;

class Response {
  final HttpResponse _response;
  final Application _application;
  Response(this._response, this._application);
  void send(dynamic body) {
    headers.contentType ??= ContentType.text;
    write(body);
    close();
  }

  void render(String viewName, [Map<String, dynamic>? locals]) {
    _application.render(viewName, locals, (err, data) {
      if (err != null) {
        _response
          ..statusCode = HttpStatus.badRequest
          ..write(err)
          ..close();
        return;
      }

      html(data!);
    });
  }

  void html(String html) {
    headers.contentType = ContentType.html;
    send(html);
  }

  void json(Map body) {
    headers.contentType = ContentType.json;
    send(jsonEncode(body));
  }

  Response set(String headerName, dynamic headerContent) {
    headers.add(headerName, headerContent);

    return this;
  }

  Response status(int code) {
    statusCode = code;
    return this;
  }

  Response ok() {
    statusCode = HttpStatus.ok;
    return this;
  }

  Response badRequest() {
    statusCode = HttpStatus.badRequest;
    return this;
  }

  Response badGateway() {
    statusCode = HttpStatus.badGateway;
    return this;
  }

  Response accepted() {
    statusCode = HttpStatus.accepted;
    return this;
  }

  Response notFound() {
    statusCode = HttpStatus.notFound;
    return this;
  }

  Response notImplemented() {
    statusCode = HttpStatus.notImplemented;
    return this;
  }

  Response notAcceptable() {
    statusCode = HttpStatus.notAcceptable;
    return this;
  }

  Response forbidden() {
    statusCode = HttpStatus.forbidden;
    return this;
  }

  Response alreadyReported() {
    statusCode = HttpStatus.alreadyReported;
    return this;
  }

  Response clientClosedRequest() {
    statusCode = HttpStatus.clientClosedRequest;
    return this;
  }

  Response conflict() {
    statusCode = HttpStatus.conflict;
    return this;
  }

  Response connectionClosedWithoutResponse() {
    statusCode = HttpStatus.connectionClosedWithoutResponse;
    return this;
  }

  Response unauthorized() {
    statusCode = HttpStatus.unauthorized;
    return this;
  }

  Response continue_() {
    statusCode = HttpStatus.continue_;
    return this;
  }

  Response created() {
    statusCode = HttpStatus.created;
    return this;
  }

  Response expectationFailed() {
    statusCode = HttpStatus.expectationFailed;
    return this;
  }

  Response failedDependency() {
    statusCode = HttpStatus.failedDependency;
    return this;
  }

  Response found() {
    statusCode = HttpStatus.found;
    return this;
  }

  Response gatewayTimeout() {
    statusCode = HttpStatus.gatewayTimeout;
    return this;
  }

  Response requestTimeout() {
    statusCode = HttpStatus.requestTimeout;
    return this;
  }

  Response requestEntityTooLarge() {
    statusCode = HttpStatus.requestEntityTooLarge;
    return this;
  }

  Response gone() {
    statusCode = HttpStatus.gone;
    return this;
  }

  Response requestHeaderFieldsTooLarge() {
    statusCode = HttpStatus.requestHeaderFieldsTooLarge;
    return this;
  }

  Response requestUriTooLong() {
    statusCode = HttpStatus.requestUriTooLong;
    return this;
  }

  Response lengthRequired() {
    statusCode = HttpStatus.lengthRequired;
    return this;
  }

  Response httpVersionNotSupported() {
    statusCode = HttpStatus.httpVersionNotSupported;
    return this;
  }

  Response unsupportedMediaType() {
    statusCode = HttpStatus.unsupportedMediaType;
    return this;
  }

  Response internalServerError() {
    statusCode = HttpStatus.internalServerError;
    return this;
  }

  Response methodNotAllowed() {
    statusCode = HttpStatus.methodNotAllowed;
    return this;
  }

  Response tooManyRequests() {
    statusCode = HttpStatus.tooManyRequests;
    return this;
  }

  Response movedPermanently() {
    statusCode = HttpStatus.movedPermanently;
    return this;
  }

  Response movedTemporarily() {
    statusCode = HttpStatus.movedTemporarily;
    return this;
  }

  Response multiStatus() {
    statusCode = HttpStatus.multiStatus;
    return this;
  }

  Response unprocessableEntity() {
    statusCode = HttpStatus.unprocessableEntity;
    return this;
  }

  Response networkAuthenticationRequired() {
    statusCode = HttpStatus.networkAuthenticationRequired;
    return this;
  }

  Response networkConnectTimeoutError() {
    statusCode = HttpStatus.networkConnectTimeoutError;
    return this;
  }

  int get statusCode => _response.statusCode;
  set statusCode(int newCode) => _response.statusCode = newCode;

  Future close() => _response.close();

  HttpConnectionInfo? get connectionInfo => _response.connectionInfo;

  List<Cookie> get cookies => _response.cookies;

  Future<bool> get isDone async =>
      _response.done.then((d) => true).catchError((e) => false);

  Future flush() => _response.flush();

  HttpHeaders get headers => _response.headers;
  void write(Object obj) => _response.write(obj);
  void location(String path) => headers.add('Location', path);

  Future end() => close();
}
