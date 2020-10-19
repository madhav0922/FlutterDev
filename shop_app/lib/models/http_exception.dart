class HttpException implements Exception {
  // implements means that this class has to use the functions of the class it implements.
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    // every class has a toString() method.
    return message;
    // return super.toString(); // Instance of HttpException
  }
}
