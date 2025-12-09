import 'package:dio/dio.dart';
import 'package:store_web/core/error/failures.dart';

class NetworkHandler {
  static Failure handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure(
          message: 'Request timed out. Please try again.',
          statusCode: 408,
        );

      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        final int statusCode = e.response?.statusCode ?? 500;
        final String message =
            _extractErrorMessage(e.response?.data) ??
            'Server error occurred. Please try again.';
        return ServerFailure(message: message, statusCode: statusCode);

      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
        return const NetworkFailure();

      case DioExceptionType.unknown:
        return const UnknownFailure();
    }
  }

  static String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      // Try different possible error message keys
      final errorKeys = ['message', 'error', 'msg', 'description', 'detail'];
      for (final key in errorKeys) {
        if (data.containsKey(key) && data[key] is String) {
          return data[key] as String;
        }
      }

      // If errors array exists
      if (data.containsKey('errors') && data['errors'] is List) {
        final errors = data['errors'] as List;
        if (errors.isNotEmpty && errors.first is String) {
          return errors.first as String;
        }
      }
    }

    return data.toString();
  }
}
