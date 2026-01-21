import 'package:dio/dio.dart';

class ApiCancelManager {
  ApiCancelManager._();

  static CancelToken _cancelToken = CancelToken();

  static CancelToken get token => _cancelToken;

  static bool get isCancelled => _cancelToken.isCancelled;

  /// Cancel all running API calls
  static void cancelAll([String reason = 'Cancelled']) {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel(reason);
    }
  }

  /// MUST be called after logout / before login
  static void reset() {
    _cancelToken = CancelToken();
  }
}
