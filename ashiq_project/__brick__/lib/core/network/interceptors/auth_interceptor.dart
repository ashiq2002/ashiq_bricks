import 'package:dio/dio.dart';

import '../api_cancel_manager.dart';

class AppAuthInterceptor extends Interceptor {
  final Future<String?> Function() getToken;
  final Function() onLogout;

  bool _handling401 = false;

  AppAuthInterceptor({
    required this.getToken,
    required this.onLogout,
  });

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Token $token';
    }

    /// attach global cancel token
    options.cancelToken = ApiCancelManager.token;

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    if (err.response?.statusCode == 401) {
      _handle401();
    }

    handler.next(err);
  }

  void _handle401() {
    if (_handling401) return;
    _handling401 = true;

    /// cancel all APIs
    ApiCancelManager.cancelAll('Unauthorized (401)');

    /// logout user
    onLogout();
  }

  /// call after successful login
  void reset() {
    _handling401 = false;
  }
}
