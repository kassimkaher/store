import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final String? code;
  final int? statusCode;

  const Failure({required this.message, this.code, this.statusCode});

  @override
  List<Object?> get props => [message, code, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code, super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
    super.code,
    super.statusCode = 404,
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
    super.statusCode,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.code,
    super.statusCode = 404,
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required super.message,
    super.code,
    super.statusCode = 401,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred. Please try again.',
    super.code,
    super.statusCode = 500,
  });
}
