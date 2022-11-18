part of fennec;

/// [Response] is a class that contains the response of the server.
/// It's used to get the response of the server.
class Response {
  /// [_response] is a [HttpResponse] that contains the http response of the server.
  final HttpResponse _response;

  /// [templateRender] is a [Application] that contains the application of the server.
  final TemplateRender templateRender;
  Object? _body;
  bool isClosed = false;

  ///[method] defines which method has the request
  final String method;

  /// constructor that creates a new [Response] object.
  Response(this._response, this.templateRender, this.method);

  Response html() {
    headers.contentType = ContentType.html;
    return this;
  }

  Response json() {
    headers.contentType = ContentType.json;
    return this;
  }

  Response text() {
    headers.contentType = ContentType.text;

    return this;
  }

  Response binary() {
    headers.contentType = ContentType.binary;
    return this;
  }

  Response redirect(String path, {int status = HttpStatus.movedTemporarily}) {
    isClosed = true;
    _response.redirect(Uri.parse(path), status: status);
    return this;
  }

  /// [render] is a method that renders the response.
  /// It's used to render the response.
  /// [viewName] is a [String] that contains the name of the view.
  /// [locals] is a [Map] that contains the locals. by default it's null.
  Response render(String viewName,
      {Map<String, dynamic>? locals,
      Map<String, dynamic> parameters = const {}}) {
    isClosed = true;
    if (method.toUpperCase() != 'GET') {
      badRequestException(
          _response, 'Only GET method is allowed to render html templates');
    }
    templateRender.render(viewName, locals, (err, data) {
      if (err != null) {
        _response
          ..statusCode = HttpStatus.badRequest
          ..write(err)
          ..close();
        return;
      }
      _html(data);
    }, parameters: parameters);

    return this;
  }

  void _html(dynamic body) {
    headers.contentType = ContentType.html;
    _response.write(body);
    close();
  }

  Response renderHtmlAsString(String htmlInput,
      {Map<String, dynamic> parameters = const {}}) {
    if (method.toUpperCase() != 'GET') {
      badRequestException(
          _response, 'Only GET method is allowed to render html templates');
      return this;
    }
    var data =
        templateRender.renderHtmlAsString(htmlInput, parameters: parameters);
    _body = data;
    headers.contentType = ContentType.html;
    return this;
  }

  /*/// [html] is a method that sends the response as html.
  void html(String html) {
    headers.contentType = ContentType.html;
    send(html);
  }

  /// [json] is a method that sends the response as json.
  void json(Map body) {
    headers.contentType = ContentType.json;
    send(jsonEncode(body));
  }*/

  /// set the [headerName] and [headerContent]
  Response set(String headerName, dynamic headerContent) {
    headers.set(headerName, headerContent);
    return this;
  }

  /// [status] is a method that sets the [statusCode] code of the response.
  Response status(int code) {
    statusCode = code;
    return this;
  }

  /// [ok] is a method that sets the [statusCode] code of the response to [HttpStatus.ok].
  /// It's used to set the status code to [HttpStatus.ok].
  Response ok(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.ok;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [badRequest] is a method that sets the [statusCode] code of the response to [HttpStatus.badRequest].
  /// It's used to set the status code to [HttpStatus.badRequest].
  Response badRequest(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.badRequest;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [badGateway] is a method that sets the [statusCode] code of the response to [HttpStatus.badGateway].
  /// It's used to set the status code to [HttpStatus.badGateway].
  Response badGateway(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.badGateway;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [accepted] is a method that sets the [statusCode] code of the response to [HttpStatus.accepted].
  /// It's used to set the status code to [HttpStatus.accepted].

  Response accepted(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.accepted;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [notFound] is a method that sets the [statusCode] code of the response to [HttpStatus.notFound].
  /// It's used to set the status code to [HttpStatus.notFound].
  Response notFound(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.notFound;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [notImplemented] is a method that sets the [statusCode] code of the response to [HttpStatus.notImplemented].
  /// It's used to set the status code to [HttpStatus.notImplemented].
  Response notImplemented(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.notImplemented;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [notAcceptable] is a method that sets the [statusCode] code of the response to [HttpStatus.notAcceptable].
  /// It's used to set the status code to [HttpStatus.notAcceptable].
  Response notAcceptable(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.notAcceptable;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [forbidden] is a method that sets the [statusCode] code of the response to [HttpStatus.forbidden].
  /// It's used to set the status code to [HttpStatus.forbidden].
  Response forbidden(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.forbidden;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [alreadyReported] is a method that sets the [statusCode] code of the response to [HttpStatus.alreadyReported].
  /// It's used to set the status code to [HttpStatus.alreadyReported].
  Response alreadyReported(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.alreadyReported;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [clientClosedRequest] is a method that sets the [statusCode] code of the response to [HttpStatus.clientClosedRequest].
  /// It's used to set the status code to [HttpStatus.clientClosedRequest].
  Response clientClosedRequest(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.clientClosedRequest;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [conflict] is a method that sets the [statusCode] code of the response to [HttpStatus.conflict].
  /// It's used to set the status code to [HttpStatus.conflict].
  Response conflict(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.conflict;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [connectionClosedWithoutResponse] is a method that sets the [statusCode] code of the response to [HttpStatus.connectionClosedWithoutResponse].
  /// It's used to set the status code to [HttpStatus.connectionClosedWithoutResponse].
  Response connectionClosedWithoutResponse(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.connectionClosedWithoutResponse;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [unauthorized] is a method that sets the [statusCode] code of the response to [HttpStatus.unauthorized].
  /// It's used to set the status code to [HttpStatus.unauthorized].
  Response unauthorized(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.unauthorized;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [continue_] is a method that sets the [statusCode] code of the response to [HttpStatus.continue_].
  /// It's used to set the status code to [HttpStatus.continue_].
  Response continue_(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.continue_;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [created] is a method that sets the [statusCode] code of the response to [HttpStatus.created].
  /// It's used to set the status code to [HttpStatus.created].
  Response created(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.created;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [expectationFailed] is a method that sets the [statusCode] code of the response to [HttpStatus.expectationFailed].
  /// It's used to set the status code to [HttpStatus.expectationFailed].
  Response expectationFailed(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.expectationFailed;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [failedDependency] is a method that sets the [statusCode] code of the response to [HttpStatus.failedDependency].
  /// It's used to set the status code to [HttpStatus.failedDependency].
  Response failedDependency(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.failedDependency;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [found] is a method that sets the [statusCode] code of the response to [HttpStatus.found].
  /// It's used to set the status code to [HttpStatus.found].
  Response found(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.found;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [gatewayTimeout] is a method that sets the [statusCode] code of the response to [HttpStatus.gatewayTimeout].
  /// It's used to set the status code to [HttpStatus.gatewayTimeout].
  Response gatewayTimeout(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.gatewayTimeout;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [requestTimeout] is a method that sets the [statusCode] code of the response to [HttpStatus.requestTimeout].
  /// It's used to set the status code to [HttpStatus.requestTimeout].
  Response requestTimeout(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.requestTimeout;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [requestEntityTooLarge] is a method that sets the [statusCode] code of the response to [HttpStatus.requestEntityTooLarge].
  /// It's used to set the status code to [HttpStatus.requestEntityTooLarge].
  Response requestEntityTooLarge(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.requestEntityTooLarge;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [gone] is a method that sets the [statusCode] code of the response to [HttpStatus.gone].
  /// It's used to set the status code to [HttpStatus.gone].
  Response gone(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.gone;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [requestHeaderFieldsTooLarge] is a method that sets the [statusCode] code of the response to [HttpStatus.requestHeaderFieldsTooLarge].
  /// It's used to set the status code to [HttpStatus.requestHeaderFieldsTooLarge].
  Response requestHeaderFieldsTooLarge(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.requestHeaderFieldsTooLarge;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [requestUriTooLong] is a method that sets the [statusCode] code of the response to [HttpStatus.requestUriTooLong].
  /// It's used to set the status code to [HttpStatus.requestUriTooLong].
  Response requestUriTooLong(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.requestUriTooLong;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [lengthRequired] is a method that sets the [statusCode] code of the response to [HttpStatus.lengthRequired].
  /// It's used to set the status code to [HttpStatus.lengthRequired].
  Response lengthRequired(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.lengthRequired;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [httpVersionNotSupported] is a method that sets the [statusCode] code of the response to [HttpStatus.httpVersionNotSupported].
  /// It's used to set the status code to [HttpStatus.httpVersionNotSupported].
  Response httpVersionNotSupported(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.httpVersionNotSupported;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [unsupportedMediaType] is a method that sets the [statusCode] code of the response to [HttpStatus.unsupportedMediaType].
  /// It's used to set the status code to [HttpStatus.unsupportedMediaType].
  Response unsupportedMediaType(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.unsupportedMediaType;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [internalServerError] is a method that sets the [statusCode] code of the response to [HttpStatus.internalServerError].
  /// It's used to set the status code to [HttpStatus.internalServerError].
  Response internalServerError(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.internalServerError;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [methodNotAllowed] is a method that sets the [statusCode] code of the response to [HttpStatus.methodNotAllowed].
  /// It's used to set the status code to [HttpStatus.methodNotAllowed].
  Response methodNotAllowed(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.methodNotAllowed;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [tooManyRequests] is a method that sets the [statusCode] code of the response to [HttpStatus.tooManyRequests].
  /// It's used to set the status code to [HttpStatus.tooManyRequests].
  Response tooManyRequests(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.tooManyRequests;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [movedPermanently] is a method that sets the [statusCode] code of the response to [HttpStatus.movedPermanently].
  /// It's used to set the status code to [HttpStatus.movedPermanently].
  Response movedPermanently(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.movedPermanently;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [movedTemporarily] is a method that sets the [statusCode] code of the response to [HttpStatus.movedTemporarily].
  /// It's used to set the status code to [HttpStatus.movedTemporarily].
  Response movedTemporarily(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.movedTemporarily;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [multiStatus] is a method that sets the [statusCode] code of the response to [HttpStatus.multiStatus].
  /// It's used to set the status code to [HttpStatus.multiStatus].
  Response multiStatus(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.multiStatus;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [unprocessableEntity] is a method that sets the [statusCode] code of the response to [HttpStatus.unprocessableEntity].
  /// It's used to set the status code to [HttpStatus.unprocessableEntity].
  Response unprocessableEntity(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.unprocessableEntity;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [networkAuthenticationRequired] is a method that sets the [statusCode] code of the response to [HttpStatus.networkAuthenticationRequired].
  /// It's used to set the status code to [HttpStatus.networkAuthenticationRequired].
  Response networkAuthenticationRequired(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.networkAuthenticationRequired;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
    return this;
  }

  /// [networkConnectTimeoutError] is a method that sets the [statusCode] code of the response to [HttpStatus.networkConnectTimeoutError].
  Response networkConnectTimeoutError(
      {Object? body,
      Map<String, dynamic> headers = const {},
      ContentType? contentType}) {
    this.headers.contentType = contentType ?? ContentType.text;
    statusCode = HttpStatus.networkConnectTimeoutError;
    headers.forEach((key, value) {
      this.headers.set(key, value);
    });
    _body = body;
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

  HttpResponse get httpResponse => _response;

  /// [write] is a method that writes the [obj] to the response.
  void write() {
    if (_body != null) {
      if (headers.contentType != null &&
          headers.contentType!.mimeType == ContentType.json.mimeType) {
        _response.write(jsonEncode(_body));
      } else {
        _response.write(_body);
      }
    }
    close();
  }

  /// [location] is a method that adds the [headers] location.
  void location(String path) => headers.add('Location', path);

  /// [end] is a method that ends/close the response.
  /// It's used to end/close the response.
  Future end() => close();
}
