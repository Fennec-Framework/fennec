part of fennec;

class RequestMethod {
  final String requestMethod;
  const RequestMethod(this.requestMethod);
  const RequestMethod.post() : this('POST');
  const RequestMethod.put() : this('PUT');
  const RequestMethod.delete() : this('DELETE');
  const RequestMethod.patch() : this('PATCH');
  const RequestMethod.options() : this('OPTIONS');
  const RequestMethod.get() : this('GET');
}
