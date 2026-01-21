import 'dart:io';
import 'package:dio/dio.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'interceptors/auth_interceptor.dart';

class ApiClient {
  late final Dio dio;
  late final AppAuthInterceptor authInterceptor;

  ApiClient({
    required String baseUrl,
    required Future<String?> Function() getToken,
    required void Function() onLogout,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
        contentType: 'application/json',
      ),
    );

    /// Auth Interceptor
    authInterceptor = AppAuthInterceptor(
      getToken: getToken,
      onLogout: onLogout,
    );

    /// Interceptors Order (VERY IMPORTANT)
    dio.interceptors.addAll([
      AppLogInterceptor(),
      AppRetryInterceptor(dio: dio),
      authInterceptor,
    ]);
  }

  // ----------------------------- GET ----------------------------
  Future<Response> get({
    required String api,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) => dio.get(
    api,
    queryParameters: params,
    options: Options(headers: headers),
    cancelToken: cancelToken,
  );

  // ----------------------------- POST ----------------------------
  Future<Response> post({
    required String api,
    required Map<String, dynamic> body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) => dio.post(
    api,
    data: body,
    queryParameters: params,
    options: Options(headers: headers),
    cancelToken: cancelToken,
  );

  // ----------------------------- PUT ----------------------------
  Future<Response> put({
    required String api,
    required Map<String, dynamic> body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) => dio.put(
    api,
    data: body,
    queryParameters: params,
    options: Options(headers: headers),
    cancelToken: cancelToken,
  );

  // ----------------------------- DELETE ----------------------------
  Future<Response> delete({
    required String api,
    required Map<String, dynamic> body,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) => dio.delete(
    api,
    data: body,
    queryParameters: params,
    options: Options(headers: headers),
    cancelToken: cancelToken,
  );

  // ------------------------- UPLOAD FILE -------------------------
  Future<Response> uploadFile({
    required String api,
    required File file,
    String field = "photo",
    Map<String, dynamic>? fields,
  }) async {
    final form = FormData.fromMap({
      ...?fields,
      field: await MultipartFile.fromFile(file.path),
    });

    return dio.post(api, data: form);
  }

  // ------------------------ DOWNLOAD FILE ------------------------
  Future<void> download({
    required String url,
    required String savePath,
    void Function(int, int)? onProgress,
  }) async {
    await dio.download(url, savePath, onReceiveProgress: onProgress);
  }
}
