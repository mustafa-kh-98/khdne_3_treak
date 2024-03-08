import 'dart:async';
import 'package:connectivity/connectivity.dart';

import '../generic/generic.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  static const String _BASE_URL =
      "https://taskflutter.futurecode-projects.com/api/";
  final token = '';
  late Dio _dio;

  static final instance = ApiProvider._();

  factory ApiProvider() => instance;

  ApiProvider._() {
    _dio = Dio(
      BaseOptions(
        headers: {
          "Authorization": "bearer $token",
        },
        followRedirects: false,
        validateStatus: (status) => true,
        baseUrl: _BASE_URL,
        receiveTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 100),
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
          responseBody: true,
          requestBody: true,
          responseHeader: true,
          requestHeader: true,
          request: true,
          error: true),
    );
  }

  _requestApi<T>(
      String url,
      final String method,
      String token,
      dynamic data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      Function()? beforeSend,
      Function(GenericResponse<T> data)? onSuccess,
      Function(dynamic error)? onError,
      Function(int progress)? onSendProgress,
      bool ignoreToken) async {
    if (beforeSend != null) beforeSend();
    (headers ?? {}).forEach((key, value) => _dio.options.headers[key] = value);
    _dio.options.headers["Authorization"] =
        token.isEmpty ? "" : "Bearer $token";
    try {
      Connectivity connectivity = Connectivity();
      ConnectivityResult connectivityResult =
          await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw NetworkException(
            ErrorCode.noInternetConnection,
            "AppStrings.NO_INTERNET_CONNECTION",
            (data is Map) ? data["code"] : null);
      }
      // final String culture = AppTranslation.isArabic ? "ar" : "en";
      Map<String, dynamic> params = {};
      params.addAll(queryParameters ?? {});
      late Response response;
      switch (method) {
        case "get":
          response = await _dio.get(url, queryParameters: params);
          break;
        case "post":
          response = await _dio.post(url, data: data, queryParameters: params,
              onSendProgress: (send, total) {
            if (onSendProgress != null) {
              final pr = (send / total) * 100;
              onSendProgress(pr.toInt());
            }
          });
          break;
        case "patch":
          response = await _dio.patch(url, data: data, queryParameters: params);
          break;
        case "put":
          response = await _dio.put(url, data: data, queryParameters: params);
          break;
      }
      if (handleRemoteError(response)) {
        if (onSuccess != null) {
          onSuccess(GenericResponse.fromJson<T>(response.data));
        }
      }
    } on DioException catch (e) {
      if (onError != null) {
        onError(NetworkException(ErrorCode.connection, e.toString(),
                (data is Map) ? data["code"] : null)
            .error);
      }
    } on NetworkException catch (e) {
      if (onError != null) onError(e.error);
    } catch (e) {
      if (onError != null) onError(e);
    }
  }

  Future post<T>(
    String url, {
    String token = '',
    dynamic data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Function()? beforeSend,
    Function(GenericResponse<T> data)? onSuccess,
    Function(dynamic error)? onError,
    Function(int progress)? onSendProgress,
    bool ignoreToken = false,
  }) =>
      _requestApi(url, 'post', token, data, header, queryParameters, beforeSend,
          onSuccess, onError, onSendProgress, ignoreToken);

  Future get<T>(
    String url, {
    String token = '',
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Function()? beforeSend,
    Function(GenericResponse<T> data)? onSuccess,
    Function(dynamic error)? onError,
    Function(int progress)? onSendProgress,
    bool ignoreToken = false,
  }) =>
      _requestApi(url, 'get', token, null, header, queryParameters, beforeSend,
          onSuccess, onError, onSendProgress, ignoreToken);

  Future patch<T>(
    String url, {
    String token = '',
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Function()? beforeSend,
    Function(GenericResponse<T> data)? onSuccess,
    Function(dynamic error)? onError,
    Function(int progress)? onSendProgress,
    bool ignoreToken = false,
  }) =>
      _requestApi(url, 'patch', token, data, header, queryParameters,
          beforeSend, onSuccess, onError, onSendProgress, ignoreToken);

  Future put<T>(
    String url, {
    String token = '',
    dynamic data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    Function()? beforeSend,
    Function(GenericResponse<T> data)? onSuccess,
    Function(dynamic error)? onError,
    Function(int progress)? onSendProgress,
    bool ignoreToken = false,
  }) =>
      _requestApi(url, 'put', token, data, header, queryParameters, beforeSend,
          onSuccess, onError, onSendProgress, ignoreToken);
}

class NetworkException implements Exception {
  final ErrorCode errorCode;
  final dynamic error;
  final String? code;

  NetworkException(this.errorCode, this.error, this.code);

  @override
  String toString() => error;
}

enum ErrorCode {
  serverError,
  badRequest,
  unauthenticated,
  timeOut,
  noInternetConnection,
  unProcessableEntity,
  wrongInput,
  forbidden,
  conflict,
  connection,
  notFound
}

bool handleRemoteError(Response response) {
  final statusCode = response.statusCode ?? 0;
  final data = response.data;
  String? errorCode;
  if (data is Map<String, dynamic>) {
    errorCode = data["statusCode"].toString();
  }
  if (statusCode == 200 || statusCode == 201) {
    return true;
  }
  if (statusCode == 401) {
    throw NetworkException(
        ErrorCode.unauthenticated, data["error"] ?? data['message'], errorCode);
  } else if (statusCode == 403) {
    throw NetworkException(
        ErrorCode.forbidden, data["error"] ?? data['message'], errorCode);
  } else if (statusCode == 409) {
    throw NetworkException(
        ErrorCode.conflict, data["error"] ?? data['message'], errorCode);
  } else if (statusCode == 400) {
    throw NetworkException(
        ErrorCode.badRequest, data["error"] ?? data['message'], errorCode);
  } else if (statusCode == 404) {
    throw NetworkException(
        ErrorCode.badRequest, data["error"] ?? data['message'], errorCode);
  } else if (statusCode == 422) {
    throw NetworkException(
        ErrorCode.badRequest, data["error"] ?? data['message'], errorCode);
  }
  throw NetworkException(ErrorCode.serverError, "SERVER_ERROR", errorCode);
}
