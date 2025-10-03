import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

import '../services/hive_service.dart';
import '../utils/dev_log.dart';
import '../utils/show_snackbar.dart';
import '../utils/show_toast.dart';

typedef LogoutCallback = void Function();

class ApiClient {
  final Dio _dio;
  final LogoutCallback? onLogout;
  final isToast = false.obs;

  // Keeps track of CancelTokens mapped by a unique request key
  final Map<String, CancelToken> _cancelTokens = {};

  ApiClient._internal(this._dio, this.onLogout);

  factory ApiClient({
    required String baseUrl,
    LogoutCallback? onLogout,
  }) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));

    // Add request/response logging in debug mode
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ));
    }

    final client = ApiClient._internal(dio, onLogout);

    // Interceptor for token handling and error management
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await HiveService.to.getAccessToken();

          devLog(tag: "TOKENS", payload: {"access_token": "$token"});

          // You can add token here if needed:
          options.headers['Authorization'] = 'Bearer $token';
          options.headers["Accept"] = "application/json";
          return handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException error, handler) {
          client._handleError(error);
          return handler.next(error);
        },
      ),
    );

    return client;
  }

  /// Set the Authorization Bearer token
  void setAuthToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  /// Remove the Authorization token
  void clearAuthToken() {
    _dio.options.headers.remove("Authorization");
  }

  /// Cancel a request by its [requestKey]
  void cancelRequest(String requestKey) {
    if (_cancelTokens.containsKey(requestKey)) {
      _cancelTokens[requestKey]?.cancel("Request cancelled: $requestKey");
      _cancelTokens.remove(requestKey);
    }
  }

  /// Handles various Dio errors globally
  void _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      showSnackBar(message: "Request timeout", backgroundColor: Colors.red);
      debugPrint("⏰ Timeout error: ${error.message}");
    } else if (error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode ?? 0;
      final data = error.response?.data;
      final extractedMessage =
          data is Map<String, dynamic> ? _extractMessage(data) : null;

      debugPrint("❗️Server responded with $statusCode: ${data.toString()}");

      showToast(message: extractedMessage ?? "Bad request");

      if (statusCode == 401 && onLogout != null) {
        debugPrint("🚪 Unauthorized! Triggering logout...");
        onLogout!();
      }
    } else if (error.type == DioExceptionType.unknown &&
        error.error is SocketException) {
      debugPrint("📡 No Internet connection.");
    } else {
      debugPrint("⚠️ Dio error: ${error.message}");
    }
  }

  String? _extractMessage(Map<String, dynamic> map) {
    for (var key in map.keys) {
      final value = map[key];

      if (key == 'message' && value is String) {
        return value;
      }

      if (value is Map<String, dynamic>) {
        final nestedMessage = _extractMessage(value);
        if (nestedMessage != null) return nestedMessage;
      }
    }

    return null;
  }

  ///=================================api get call
  Future<Response> get({
    required String api,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String? requestKey,
  }) async {
    final cancelToken = _registerCancelToken(requestKey);
    try {
      return await _dio.get(
        api,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
    } finally {
      _cleanupCancelToken(requestKey);
    }
  }

  ///===================================api post call
  Future<Response> post({
    required String api,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String? requestKey,
  }) async {
    final cancelToken = _registerCancelToken(requestKey);
    try {
      return await _dio.post(
        api,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
    } finally {
      _cleanupCancelToken(requestKey);
    }
  }

  ///========================================api put call
  Future<Response> put({
    required String path,
    required Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String? requestKey,
  }) async {
    final cancelToken = _registerCancelToken(requestKey);
    try {
      return await _dio.put(
        path,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
    } finally {
      _cleanupCancelToken(requestKey);
    }
  }

  ///============================================api patch call
  Future<Response> patch({
    required String path,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String? requestKey,
  }) async {
    final cancelToken = _registerCancelToken(requestKey);
    try {
      return await _dio.patch(
        path,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
    } finally {
      _cleanupCancelToken(requestKey);
    }
  }

  ///=========================================api delete call
  Future<Response> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String? requestKey,
  }) async {
    final cancelToken = _registerCancelToken(requestKey);
    try {
      return await _dio.delete(
        path,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
    } finally {
      _cleanupCancelToken(requestKey);
    }
  }

  ///===========================================upload any file to cloud
  Future<Response> upload({
    required String path,
    required Map<String, dynamic> formFields,
    required List<File> files,
    String fileField = 'file',
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    String? requestKey,
  }) async {
    final formData = FormData();

    // Add form fields
    formFields.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    // Add each file
    for (var file in files) {
      final fileName = file.path.split('/').last;
      formData.files.add(MapEntry(
        fileField,
        await MultipartFile.fromFile(file.path, filename: fileName),
      ));
    }

    final cancelToken = _registerCancelToken(requestKey);

    try {
      return await _dio.post(
        path,
        data: formData,
        queryParameters: queryParams,
        options: Options(
          headers: {
            ...?headers,
            'Content-Type': 'multipart/form-data',
          },
        ),
        cancelToken: cancelToken,
      );
    } finally {
      _cleanupCancelToken(requestKey);
    }
  }

  ///=============================================download file from cloud
  Future<void> download({
    required String url,
    required String savePath,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    void Function(int received, int total)? onReceiveProgress,
    String? requestKey,
  }) async {
    final cancelToken = _registerCancelToken(requestKey);

    try {
      await _dio.download(
        url,
        savePath,
        queryParameters: queryParams,
        options: Options(headers: headers),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    } finally {
      _cleanupCancelToken(requestKey);
    }
  }

  /// Registers a CancelToken for a given [requestKey], if provided
  CancelToken? _registerCancelToken(String? requestKey) {
    if (requestKey == null) return null;
    final token = CancelToken();
    _cancelTokens[requestKey] = token;
    return token;
  }

  /// Cleans up CancelToken after request completes
  void _cleanupCancelToken(String? requestKey) {
    if (requestKey != null) {
      _cancelTokens.remove(requestKey);
    }
  }
}