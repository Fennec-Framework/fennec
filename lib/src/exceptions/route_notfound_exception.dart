part of fennec;

/// [routeNotFoundException] is a public function that is used throw a route not found exception.
void routeNotFoundException(HttpResponse response, String path, String method) {
  response
    ..statusCode = HttpStatus.notFound
    ..headers.contentType = ContentType.html
    ..write(
        '<!DOCTYPE html> <html lang="en"> <head> <meta charset="utf-8"> <title>Error</title></head><body><pre>Cannot $method $path</pre></body></html>')
    ..close();
}

/// [methodNotAllowedException] is a public function that is used throw a method not allowed exception.
void methodNotAllowedException(
    HttpResponse response, String path, String method) {
  response
    ..statusCode = HttpStatus.methodNotAllowed
    ..headers.contentType = ContentType.html
    ..write(
        '<!DOCTYPE html> <html lang="en"> <head> <meta charset="utf-8"> <title>Error</title></head><body><pre>Cannot $method $path</pre></body></html>')
    ..close();
}
