part of fennec;

class BodyParser {
  static Future<Request> parseBody(
      HttpRequest httpRequest, Map<String, dynamic>? pathParams) async {
    dynamic body;
    Map<String, dynamic> params = {};

    httpRequest.uri.queryParameters.forEach((key, value) {
      params.addAll({key: value});
    });

    List<FileInfo> files = [];
    ContentType? contentType = httpRequest.headers.contentType;
    if (contentType != null) {
      if (contentType.mimeType == 'multipart/form-data' &&
          contentType.parameters['boundary'] != null) {
        var boundary = contentType.parameters['boundary']!;
        final transformer = MimeMultipartTransformer(boundary);
        List<int> dataBytes = [];
        await for (var data in httpRequest) {
          dataBytes.addAll(data);
        }
        final bodyStream = Stream.fromIterable([dataBytes]);
        final parts = await transformer.bind(bodyStream).toList();
        for (var part in parts) {
          var content = await part.toList();
          var contenDisposition = part.headers['content-disposition'];
          if (contenDisposition != null) {
            List<String> values = contenDisposition.split(";");
            if (values.length < 3) {
              files.add(FileInfo(
                  mimeType: part.headers['content-type'] ?? "image/png",
                  name: "media",
                  filename: 'file',
                  data: content[0]));
            } else {
              files.add(FileInfo(
                  mimeType: part.headers['content-type'] ?? "image/png",
                  name: values.elementAt(1).split("=")[1],
                  filename: values.elementAt(2).split("=")[1],
                  data: content[0]));
            }
          } else {
            files.add(FileInfo(
                mimeType: part.headers['content-type'] ?? "image/png",
                name: "media",
                filename: 'file',
                data: content[0]));
          }
        }
      } else if (contentType.mimeType == 'application/json') {
        var content = await utf8.decoder.bind(httpRequest).join();
        body = content.isNotEmpty ? jsonDecode(content) : {};
      } else {
        var content = await utf8.decoder.bind(httpRequest).join();
        body = content;
      }
    }
    return Request(httpRequest, body, params, httpRequest.headers, files,
        pathParams: pathParams);
  }
}
