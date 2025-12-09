import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioLogger extends InterceptorsWrapper {
  DioLogger();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      _logWarning('EndPoint', options.path);
      _logWarning('Method', options.method);
      _logWarning('Headers', options.headers.toString());
      _logWarning('Data', '${options.data}');
      _logWarning('Query Parameters', '${options.queryParameters}');
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (kDebugMode) {
      _logSuccess('Endpoint', response.requestOptions.path);
      _logSuccess('Status Code', response.statusCode.toString());
      _logSuccess(
        'Response Data ${response.requestOptions.path}',
        jsonEncode(response.data),
      );
    }

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      _logError('Endpoint', '${err.requestOptions.uri}');
      _logError('Method', err.requestOptions.method);
      _logError('Error Message', jsonEncode(err.response?.data));
    }

    handler.next(err);
  }

  void _logSuccess(String name, String msg) {
    log('\x1B[37m  $name: \x1B[32m  $msg');
  }

  void _logError(String name, String msg) {
    log('\x1B[37m  $name: \x1B[31m  $msg');
  }

  void _logWarning(String name, String msg) {
    log('\x1B[37m  $name: \x1B[33m  $msg');
  }
}
