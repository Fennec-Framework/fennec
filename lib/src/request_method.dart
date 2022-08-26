part of fennec;

/// [RequestMethod] is a class that contains information about the request method.
class RequestMethod {
  /// [requestMethod] is a [String] that contains the request method.
  final String requestMethod;

  /// [RequestMethod] is a constructor that creates a new [RequestMethod] object.
  const RequestMethod(this.requestMethod);

  /// [post] is a constructor that creates a new [RequestMethod] object with the request method set to [POST].
  const RequestMethod.post() : this('POST');

  /// [put] is a constructor that creates a new [RequestMethod] object with the request method set to [PUT].
  const RequestMethod.put() : this('PUT');

  /// [delete] is a constructor that creates a new [RequestMethod] object with the request method set to [DELETE].
  const RequestMethod.delete() : this('DELETE');

  /// [patch] is a constructor that creates a new [RequestMethod] object with the request method set to [PATCH].
  const RequestMethod.patch() : this('PATCH');

  /// [options] is a constructor that creates a new [RequestMethod] object with the request method set to [OPTIONS].
  const RequestMethod.options() : this('OPTIONS');

  /// [get] is a constructor that creates a new [RequestMethod] object with the request method set to [GET].
  const RequestMethod.get() : this('GET');
}
