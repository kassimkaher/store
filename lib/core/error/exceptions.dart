class AppException implements Exception {
  final String message;
  final String? code;

  AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message';
}

class ServerException extends AppException {
  ServerException({required super.message, super.code});
}

class CacheException extends AppException {
  CacheException({required super.message, super.code});
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.code});
}

class ValidationException extends AppException {
  ValidationException({required super.message, super.code});
}

class NotAuthorizedException extends AppException {
  NotAuthorizedException({required super.message, super.code});
}
