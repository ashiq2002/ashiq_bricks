class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class PasswordRequiredException implements Exception {
  final String message;
  const PasswordRequiredException(this.message);
}
