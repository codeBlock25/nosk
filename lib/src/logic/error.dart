class AppError implements Exception {
  final String message;
  final dynamic error;

  AppError({
    required this.message,
    this.error,
  });

  @override
  String toString() {
    String message = this.message;
    return "Exception: $message/n Error: $error";
  }
}
