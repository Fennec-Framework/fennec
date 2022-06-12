part of fennec;

void routeNotFoundException(HttpResponse response, String path, String method) {
  response
    ..statusCode = HttpStatus.notFound
    ..headers.contentType = ContentType.html
    ..write(
        '<!DOCTYPE html> <html lang="en"> <head> <meta charset="utf-8"> <title>Error</title></head><body><pre>Cannot $method $path</pre></body></html>')
    ..close();
}

void methodNotAllowedException(
    HttpResponse response, String path, String method) {
  response
    ..statusCode = HttpStatus.methodNotAllowed
    ..headers.contentType = ContentType.html
    ..write(
        '<!DOCTYPE html> <html lang="en"> <head> <meta charset="utf-8"> <title>Error</title></head><body><pre>Cannot $method $path</pre></body></html>')
    ..close();
}
