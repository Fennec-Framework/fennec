part of fennec;

class Utils {
  /// [isValidURl] a static method to check validity of requested uri
  static bool isValidURl(String url) {
    if (Uri.tryParse(url) == null || !Uri.tryParse(url)!.hasAbsolutePath) {
      return false;
    }
    List<String> splitedUri = url.split('://');
    if (splitedUri.length < 2) {
      return false;
    } else if (splitedUri[1].contains('//')) {
      return false;
    }
    return true;
  }
}
