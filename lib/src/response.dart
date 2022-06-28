part of fennec;

/// [Response] is a class that contains the response of the server.
/// It's used to get the response of the server.
class Response {
  /// [_response] is a [HttpResponse] that contains the http response of the server.
  final HttpResponse _response;

  /// [_application] is a [Application] that contains the application of the server.
  final Application _application;

  /// constructor that creates a new [Response] object.
  Response(this._response, this._application);

  /// [send] is a method that sends the response.
  /// It's used to send the response.
  void send(dynamic body) {
    headers.contentType ??= ContentType.text;
    write(body);
    close();
  }

  /// [render] is a method that renders the response.
  /// It's used to render the response.
  /// [viewName] is a [String] that contains the name of the view.
  /// [locals] is a [Map] that contains the locals. by default it's null.
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

  /// [html] is a method that sends the response as html.

  void html(String html) {
    headers.contentType = ContentType.html;
    send(html);
  }

  /// [json] is a method that sends the response as json.
  void json(Map body) {
    headers.contentType = ContentType.json;
    send(jsonEncode(body));
  }

  /// set the [headerName] and [headerContent]
  Response set(String headerName, dynamic headerContent) {
    headers.add(headerName, headerContent);
    return this;
  }

  /// [status] is a method that sets the [statusCode] code of the response.
  Response status(int code) {
    statusCode = code;
    return this;
  }

  /// [ok] is a method that sets the [statusCode] code of the response to [HttpStatus.ok].
  /// It's used to set the status code to [HttpStatus.ok].
  Response ok() {
    statusCode = HttpStatus.ok;
    return this;
  }

  /// [badRequest] is a method that sets the [statusCode] code of the response to [HttpStatus.badRequest].
  /// It's used to set the status code to [HttpStatus.badRequest].
  Response badRequest() {
    statusCode = HttpStatus.badRequest;
    return this;
  }

  /// [badGateway] is a method that sets the [statusCode] code of the response to [HttpStatus.badGateway].
  /// It's used to set the status code to [HttpStatus.badGateway].

  Response badGateway() {
    statusCode = HttpStatus.badGateway;
    return this;
  }

  /// [accepted] is a method that sets the [statusCode] code of the response to [HttpStatus.accepted].
  /// It's used to set the status code to [HttpStatus.accepted].

  Response accepted() {
    statusCode = HttpStatus.accepted;
    return this;
  }

  /// [notFound] is a method that sets the [statusCode] code of the response to [HttpStatus.notFound].
  /// It's used to set the status code to [HttpStatus.notFound].
  Response notFound() {
    statusCode = HttpStatus.notFound;
    return this;
  }

  /// [notImplemented] is a method that sets the [statusCode] code of the response to [HttpStatus.notImplemented].
  /// It's used to set the status code to [HttpStatus.notImplemented].
  Response notImplemented() {
    statusCode = HttpStatus.notImplemented;
    return this;
  }

  /// [notAcceptable] is a method that sets the [statusCode] code of the response to [HttpStatus.notAcceptable].
  /// It's used to set the status code to [HttpStatus.notAcceptable].
  Response notAcceptable() {
    statusCode = HttpStatus.notAcceptable;
    return this;
  }

  /// [forbidden] is a method that sets the [statusCode] code of the response to [HttpStatus.forbidden].
  /// It's used to set the status code to [HttpStatus.forbidden].
  Response forbidden() {
    statusCode = HttpStatus.forbidden;
    return this;
  }

  /// [alreadyReported] is a method that sets the [statusCode] code of the response to [HttpStatus.alreadyReported].
  /// It's used to set the status code to [HttpStatus.alreadyReported].
  Response alreadyReported() {
    statusCode = HttpStatus.alreadyReported;
    return this;
  }

  /// [clientClosedRequest] is a method that sets the [statusCode] code of the response to [HttpStatus.clientClosedRequest].
  /// It's used to set the status code to [HttpStatus.clientClosedRequest].
  Response clientClosedRequest() {
    statusCode = HttpStatus.clientClosedRequest;
    return this;
  }

  /// [conflict] is a method that sets the [statusCode] code of the response to [HttpStatus.conflict].
  /// It's used to set the status code to [HttpStatus.conflict].
  Response conflict() {
    statusCode = HttpStatus.conflict;
    return this;
  }

  /// [connectionClosedWithoutResponse] is a method that sets the [statusCode] code of the response to [HttpStatus.connectionClosedWithoutResponse].
  /// It's used to set the status code to [HttpStatus.connectionClosedWithoutResponse].
  Response connectionClosedWithoutResponse() {
    statusCode = HttpStatus.connectionClosedWithoutResponse;
    return this;
  }

  /// [unauthorized] is a method that sets the [statusCode] code of the response to [HttpStatus.unauthorized].
  /// It's used to set the status code to [HttpStatus.unauthorized].
  Response unauthorized() {
    statusCode = HttpStatus.unauthorized;
    return this;
  }

  /// [continue_] is a method that sets the [statusCode] code of the response to [HttpStatus.continue_].
  /// It's used to set the status code to [HttpStatus.continue_].
  Response continue_() {
    statusCode = HttpStatus.continue_;
    return this;
  }

  /// [created] is a method that sets the [statusCode] code of the response to [HttpStatus.created].
  /// It's used to set the status code to [HttpStatus.created].
  Response created() {
    statusCode = HttpStatus.created;
    return this;
  }

  /// [expectationFailed] is a method that sets the [statusCode] code of the response to [HttpStatus.expectationFailed].
  /// It's used to set the status code to [HttpStatus.expectationFailed].
  Response expectationFailed() {
    statusCode = HttpStatus.expectationFailed;
    return this;
  }

  /// [failedDependency] is a method that sets the [statusCode] code of the response to [HttpStatus.failedDependency].
  /// It's used to set the status code to [HttpStatus.failedDependency].
  Response failedDependency() {
    statusCode = HttpStatus.failedDependency;
    return this;
  }

  /// [found] is a method that sets the [statusCode] code of the response to [HttpStatus.found].
  /// It's used to set the status code to [HttpStatus.found].
  Response found() {
    statusCode = HttpStatus.found;
    return this;
  }

  /// [gatewayTimeout] is a method that sets the [statusCode] code of the response to [HttpStatus.gatewayTimeout].
  /// It's used to set the status code to [HttpStatus.gatewayTimeout].
  Response gatewayTimeout() {
    statusCode = HttpStatus.gatewayTimeout;
    return this;
  }

  /// [requestTimeout] is a method that sets the [statusCode] code of the response to [HttpStatus.requestTimeout].
  /// It's used to set the status code to [HttpStatus.requestTimeout].
  Response requestTimeout() {
    statusCode = HttpStatus.requestTimeout;
    return this;
  }

  /// [requestEntityTooLarge] is a method that sets the [statusCode] code of the response to [HttpStatus.requestEntityTooLarge].
  /// It's used to set the status code to [HttpStatus.requestEntityTooLarge].
  Response requestEntityTooLarge() {
    statusCode = HttpStatus.requestEntityTooLarge;
    return this;
  }

  /// [gone] is a method that sets the [statusCode] code of the response to [HttpStatus.gone].
  /// It's used to set the status code to [HttpStatus.gone].
  Response gone() {
    statusCode = HttpStatus.gone;
    return this;
  }

  /// [requestHeaderFieldsTooLarge] is a method that sets the [statusCode] code of the response to [HttpStatus.requestHeaderFieldsTooLarge].
  /// It's used to set the status code to [HttpStatus.requestHeaderFieldsTooLarge].
  Response requestHeaderFieldsTooLarge() {
    statusCode = HttpStatus.requestHeaderFieldsTooLarge;
    return this;
  }

  /// [requestUriTooLong] is a method that sets the [statusCode] code of the response to [HttpStatus.requestUriTooLong].
  /// It's used to set the status code to [HttpStatus.requestUriTooLong].
  Response requestUriTooLong() {
    statusCode = HttpStatus.requestUriTooLong;
    return this;
  }

  /// [lengthRequired] is a method that sets the [statusCode] code of the response to [HttpStatus.lengthRequired].
  /// It's used to set the status code to [HttpStatus.lengthRequired].
  Response lengthRequired() {
    statusCode = HttpStatus.lengthRequired;
    return this;
  }

  /// [httpVersionNotSupported] is a method that sets the [statusCode] code of the response to [HttpStatus.httpVersionNotSupported].
  /// It's used to set the status code to [HttpStatus.httpVersionNotSupported].
  Response httpVersionNotSupported() {
    statusCode = HttpStatus.httpVersionNotSupported;
    return this;
  }

  /// [unsupportedMediaType] is a method that sets the [statusCode] code of the response to [HttpStatus.unsupportedMediaType].
  /// It's used to set the status code to [HttpStatus.unsupportedMediaType].
  Response unsupportedMediaType() {
    statusCode = HttpStatus.unsupportedMediaType;
    return this;
  }

  /// [internalServerError] is a method that sets the [statusCode] code of the response to [HttpStatus.internalServerError].
  /// It's used to set the status code to [HttpStatus.internalServerError].
  Response internalServerError() {
    statusCode = HttpStatus.internalServerError;
    return this;
  }

  /// [methodNotAllowed] is a method that sets the [statusCode] code of the response to [HttpStatus.methodNotAllowed].
  /// It's used to set the status code to [HttpStatus.methodNotAllowed].
  Response methodNotAllowed() {
    statusCode = HttpStatus.methodNotAllowed;
    return this;
  }

  /// [tooManyRequests] is a method that sets the [statusCode] code of the response to [HttpStatus.tooManyRequests].
  /// It's used to set the status code to [HttpStatus.tooManyRequests].
  Response tooManyRequests() {
    statusCode = HttpStatus.tooManyRequests;
    return this;
  }

  /// [movedPermanently] is a method that sets the [statusCode] code of the response to [HttpStatus.movedPermanently].
  /// It's used to set the status code to [HttpStatus.movedPermanently].
  Response movedPermanently() {
    statusCode = HttpStatus.movedPermanently;
    return this;
  }

  /// [movedTemporarily] is a method that sets the [statusCode] code of the response to [HttpStatus.movedTemporarily].
  /// It's used to set the status code to [HttpStatus.movedTemporarily].
  Response movedTemporarily() {
    statusCode = HttpStatus.movedTemporarily;
    return this;
  }

  /// [multiStatus] is a method that sets the [statusCode] code of the response to [HttpStatus.multiStatus].
  /// It's used to set the status code to [HttpStatus.multiStatus].
  Response multiStatus() {
    statusCode = HttpStatus.multiStatus;
    return this;
  }

  /// [unprocessableEntity] is a method that sets the [statusCode] code of the response to [HttpStatus.unprocessableEntity].
  /// It's used to set the status code to [HttpStatus.unprocessableEntity].
  Response unprocessableEntity() {
    statusCode = HttpStatus.unprocessableEntity;
    return this;
  }

  /// [newtworkAuthenticationRequired] is a method that sets the [statusCode] code of the response to [HttpStatus.networkAuthenticationRequired].
  /// It's used to set the status code to [HttpStatus.networkAuthenticationRequired].
  Response networkAuthenticationRequired() {
    statusCode = HttpStatus.networkAuthenticationRequired;
    return this;
  }

  /// [networkConnectTimeoutError] is a method that sets the [statusCode] code of the response to [HttpStatus.networkConnectTimeoutError].
  Response networkConnectTimeoutError() {
    statusCode = HttpStatus.networkConnectTimeoutError;
    return this;
  }

  /// getter for the [statusCode] of the response.
  int get statusCode => _response.statusCode;

  /// setter for the [statusCode] of the response.
  set statusCode(int newCode) => _response.statusCode = newCode;

  /// [close] is a method that closes the response.
  Future close() => _response.close();

  /// getter for the [connectionInfo] of the response.
  /// returns a [HttpConnectionInfo]
  HttpConnectionInfo? get connectionInfo => _response.connectionInfo;

  /// getter for the [cookies] of the response.
  /// returns a [List] of [Cookie]
  List<Cookie> get cookies => _response.cookies;

  /// getter for the [isDone]
  /// returns a [Future] of [bool]
  /// true if the response is done, false otherwise.
  Future<bool> get isDone async =>
      _response.done.then((d) => true).catchError((e) => false);

  /// [flush] is a method that flushes the response.
  /// It's used to flush the response.
  Future flush() => _response.flush();

  /// getter for the [headers] of the response.
  /// returns a [HttpHeaders].
  HttpHeaders get headers => _response.headers;

  /// [write] is a method that writes the [obj] to the response.
  void write(Object obj) => _response.write(obj);

  /// [location] is a method that adds the [headers] location.
  void location(String path) => headers.add('Location', path);

  /// [end] is a method that ends/close the response.
  /// It's used to end/close the response.
  Future end() => close();
}
