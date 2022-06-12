part of fennec;

/// class represents a Request Class
class Request {
  final HttpRequest httpRequest;
  final dynamic body;
  final Map<String, dynamic> params;
  final HttpHeaders httpHeaders;
  final List<FileInfo> files;
  final Map<String, dynamic>? pathParams;
  Map<String, dynamic>? additionalData;
  UserDetails? userDetails;

  Request(
      this.httpRequest, this.body, this.params, this.httpHeaders, this.files,
      {this.additionalData, this.pathParams, this.userDetails});

  Request copyWith(
      {HttpRequest? httpRequest,
      dynamic body,
      Map<String, dynamic>? params,
      HttpHeaders? httpHeaders,
      List<FileInfo>? files,
      Map<String, dynamic>? additionalData,
      Map<String, dynamic>? pathParams,
      UserDetails? userDetails}) {
    return Request(
        httpRequest ?? this.httpRequest,
        body ?? this.body,
        params ?? this.params,
        httpHeaders ?? this.httpHeaders,
        files ?? this.files,
        additionalData: additionalData ?? this.additionalData,
        pathParams: pathParams ?? this.pathParams,
        userDetails: userDetails ?? this.userDetails);
  }
}
