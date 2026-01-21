import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppRetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration delay;

  AppRetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.delay = const Duration(seconds: 2),
  });

  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.error is SocketException ||
        (e.response?.statusCode ?? 0) >= 500;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    int retryCount =
        (err.requestOptions.extra["retry_count"] ?? 0) + 1;

    if (retryCount > maxRetries) {
      return handler.next(err);
    }

    debugPrint("🔄 Retry $retryCount / $maxRetries");

    await Future.delayed(delay * retryCount);

    final newReq = await dio.request(
      err.requestOptions.path,
      data: err.requestOptions.data,
      queryParameters: err.requestOptions.queryParameters,
      options: Options(
        method: err.requestOptions.method,
        headers: err.requestOptions.headers,
        extra: {"retry_count": retryCount},
      ),
    );

    return handler.resolve(newReq);
  }
}
