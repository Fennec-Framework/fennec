part of fennec;

class RequestMethod {
  final String requestMethod;
  RequestMethod(this.requestMethod);
  RequestMethod.post() : this('POST');
  RequestMethod.put() : this('PUT');
  RequestMethod.delete() : this('DELETE');
  RequestMethod.patch() : this('PATCH');
  RequestMethod.options() : this('OPTIONS');
  RequestMethod.get() : this('GET');
}
