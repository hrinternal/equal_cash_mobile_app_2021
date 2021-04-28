class HttpException implements Exception {
  final String message;
  final int code;

  HttpException(this.message, this.code);

  @override
  String toString() {
    return message;
  }
}
