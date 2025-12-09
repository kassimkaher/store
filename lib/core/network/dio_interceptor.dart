import 'dart:developer';

import 'package:dio/dio.dart';

import '../storage/storage_service.dart';
import '../utils/app_credentials.dart';

class DioInterceptor extends InterceptorsWrapper {
  final Dio dio;
  final StorageService storageService;
  final StoreConfig config;

  DioInterceptor(this.dio, this.storageService, this.config);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log(options.data.toString());
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      if (err.response!.statusCode == 401) {
        // Get stored tokens
        final token = await storageService.getString('auth_token');
        final refreshToken = await storageService.getString('refresh_token');

        if (token != null && refreshToken != null) {
          // Try to refresh the token
          final newToken = await _refreshToken(refreshToken);
          if (newToken != null) {
            // Save new token
            await storageService.setString('auth_token', newToken);

            // Update the request with new access token
            final requestOptions = err.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newToken';

            try {
              // Retry the original request with new token
              final response = await dio.fetch(requestOptions);
              return handler.resolve(response);
            } catch (e) {
              // If retry fails, clear tokens and reject
              await _clearTokens();
              return handler.reject(err);
            }
          }
        }
        // If refresh fails or user is not authenticated, clear tokens
        await _clearTokens();
        return handler.reject(err);
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: config.apiBaseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      refreshDio.interceptors.clear();

      final result = await refreshDio.post(
        '/auth/refresh-token',
        data: {"refreshToken": refreshToken},
      );

      if (result.statusCode == 200 && result.data != null) {
        final data = result.data['token'];
        if (data != null) {
          return data as String;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _clearTokens() async {
    await storageService.remove('auth_token');
    await storageService.remove('refresh_token');
  }
}
