import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/core/di/injection_container.dart';
import 'package:store_web/features/auth/cubit/auth_cubit.dart';

import '../../api/rest_client.dart';
import '../storage/storage_service.dart';
import '../utils/app_credentials.dart';
import 'dio_interceptor.dart';
import 'dio_log_interceptor.dart';

@lazySingleton
class DioClient {
  final StoreConfig config;
  final StorageService storageService;

  DioClient({required this.config, required this.storageService});

  RestClient instance([String? customBaseUrl]) {
    final dio = Dio();

    // Set base options
    dio.options.baseUrl = customBaseUrl ?? config.apiBaseUrl;
    dio.options.connectTimeout = Duration(
      seconds: config.requestTimeoutSeconds,
    );
    dio.options.receiveTimeout = Duration(
      seconds: config.requestTimeoutSeconds,
    );
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';

    // Add authorization if available
    _addAuthToken(dio);

    // Add API key if configured
    if (config.apiKey != null) {
      dio.options.headers['X-API-Key'] = config.apiKey!;
    }

    // Add interceptors
    dio.interceptors.add(DioInterceptor(dio, storageService, config));
    dio.interceptors.add(DioLogger());

    final restClient = RestClient(
      dio,
      baseUrl: customBaseUrl ?? config.apiBaseUrl,
    );

    return restClient;
  }

  void _addAuthToken(Dio dio) {
    try {
      dio.options.headers['Authorization'] = getIt<AuthCubit>().state.maybeWhen(
        authenticated: (data, v, b) => data.token,
        orElse: () => '',
      );
    } catch (e) {
      // Token not available
    }
  }

  Future<void> setAuthToken(String token) async {
    await storageService.setString('auth_token', token);
  }

  Future<void> setRefreshToken(String token) async {
    await storageService.setString('refresh_token', token);
  }

  Future<void> clearTokens() async {
    await storageService.remove('auth_token');
    await storageService.remove('refresh_token');
  }

  Future<String?> getAuthToken() async {
    return await storageService.getString('auth_token');
  }
}
