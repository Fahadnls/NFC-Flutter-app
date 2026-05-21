import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart' hide Response;
import '../../domain/errors/failure.dart';
import '../../environment/environment.dart';
import '../../core/translations/strings_enum.dart';
import 'auth_interceptor.dart';
import 'logging_interceptor.dart';

class ApiClient {
  final Dio _dio;
  final AuthInterceptor _authInterceptor;

  ApiClient({required Dio dio, required AuthInterceptor authInterceptor})
    : _dio = dio,
      _authInterceptor = authInterceptor {
    _configureApiClient();
  }

  void _configureApiClient() {
    String baseUrl = BASE_URL;
    String apiVersion = URL_TYPE;

    _dio.options = BaseOptions(
      baseUrl: "$baseUrl/$apiVersion/",
      headers: _defaultHeaders,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      responseType: ResponseType.json,
    );

    _dio.interceptors.add(_authInterceptor);
    _dio.interceptors.add(LoggingInterceptor());
  }

  // Generic GET request with optional headers
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) converter,
    Map<String, dynamic>? headers, // Optional headers
  }) async {
    // log("APi Url = $path");

    // Merge user headers with default ones
    final options = Options(headers: _mergeHeaders(headers));

    return _handleRequest(
      requestExecutor: () => _dio.get(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      ),
      converter: converter,
    );
  }

  // Generic POST request with optional headers
  Future<Either<Failure, T>> post<T>(
    String path, {
    dynamic data,
    dynamic queryParameters,
    required T Function(dynamic) converter,
    Map<String, dynamic>? headers, // Optional headers
  }) async {
    final options = Options(headers: _mergeHeaders(headers));

    return _handleRequest(
      requestExecutor: () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      converter: converter,
    );
  }

  // Generic PUT request with optional headers
  Future<Either<Failure, T>> put<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) converter,
    Map<String, dynamic>? headers, // Optional headers
  }) async {
    final options = Options(headers: _mergeHeaders(headers));

    return _handleRequest(
      requestExecutor: () => _dio.put(path, data: data, options: options),
      converter: converter,
    );
  }

  // Generic PATCH request with optional headers
  Future<Either<Failure, T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) converter,
    Map<String, dynamic>? headers, // Optional headers
  }) async {
    final options = Options(headers: _mergeHeaders(headers));

    return _handleRequest(
      requestExecutor: () => _dio.patch(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
      ),
      converter: converter,
    );
  }

  // Generic DELETE request with optional headers
  Future<Either<Failure, T>> delete<T>(
    String path, {
    Map<String, dynamic>? data,
    required T Function(dynamic) converter,
    Map<String, dynamic>? headers, // Optional headers
  }) async {
    final options = Options(headers: _mergeHeaders(headers));

    return _handleRequest(
      requestExecutor: () => _dio.delete(path, data: data, options: options),
      converter: converter,
    );
  }

  /// Method to handle requests and errors
  Future<Either<Failure, T>> _handleRequest<T>({
    required Future<Response<dynamic>> Function() requestExecutor,
    required T Function(dynamic) converter,
  }) async {
    try {
      final response = await requestExecutor();

      // Check for successful status codes (200-299)
      if (response.statusCode == null ||
          response.statusCode! < 200 ||
          response.statusCode! >= 300) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Received invalid status code: ${response.statusCode}',
        );
      }

      // Ensure the response data is not null
      if (response.data == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'Response data is null',
        );
      }

      // Convert the response using the provided converter
      return Either.right(converter(response.data));
    } on DioException catch (e) {
      // Handle Dio-specific errors
      return Left(_mapErrorToFailure(e));
    } catch (e) {
      // Handle unexpected errors
      return Left(
        Failure.serverFailure(message: Strings.unexpected_error_try_again.tr),
      );
    }
  }

  /// Merges user-defined headers with the default ones
  Map<String, dynamic> _mergeHeaders(Map<String, dynamic>? customHeaders) {
    final defaultHeaders = _defaultHeaders;
    if (customHeaders != null && customHeaders.isNotEmpty) {
      return {...defaultHeaders, ...customHeaders};
    }
    return defaultHeaders;
  }

  Map<String, dynamic> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'lang': Get.locale?.languageCode ?? 'en',
  };

  Failure _mapErrorToFailure(DioException e) {
    // Timeouts
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Failure.serverFailure(
        message: Strings.request_timed_out_try_again.tr,
      );
    }

    if (_isConnectivityFailure(e)) {
      _openNoInternetPage();
      return Failure.serverFailure(
        message: Strings.noInternetConnection.tr,
        shouldShowMessage: false,
      );
    }

    final statusCode = e.response?.statusCode ?? 0;

    if (e.response != null) {
      // 1) Try to extract a meaningful message (JSON OR HTML OR String)
      final serverMessage = _extractErrorMessage(e.response!.data);

      // 2) If nothing, try a friendly fallback including method/path
      final message = (serverMessage != null && serverMessage.isNotEmpty)
          ? serverMessage
          : _friendlyFallback(statusCode, e.response);

      return Failure.serverFailure(message: message, statusCode: statusCode);
    }

    // No response at all
    return Failure.serverFailure(
      message: e.message ?? Strings.unexpected_error_try_again.tr,
    );
  }

  bool _isConnectivityFailure(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return true;
    }

    final error = e.error;
    if (error is SocketException) {
      return true;
    }

    final message = (e.message ?? '').toLowerCase();
    return message.contains('socketexception') ||
        message.contains('failed host lookup') ||
        message.contains('network is unreachable') ||
        message.contains('connection refused');
  }

  void _openNoInternetPage() {
    if (Get.isSnackbarOpen) {
      return;
    }
    Get.snackbar('Offline', Strings.noInternetConnection.tr);
  }

  /// Extracts error message from response data
  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is String) return data;

    if (data is Map<String, dynamic>) {
      const possibleMessageFields = [
        'message',
        'msg',
        'error',
        'errors',
        'detail',
        'description',
      ];

      for (final field in possibleMessageFields) {
        if (data.containsKey(field)) {
          final value = data[field];
          if (value is String) return value;
          if (value is List) return value.join(', ');
          if (value is Map<String, dynamic>) {
            return value['message'] as String? ??
                value['msg'] as String? ??
                value['error'] as String?;
          }
        }
      }

      return data.toString();
    }

    if (data is List) return data.join(', ');

    return null;
  }
}

String? _extractMessageFromHtmlOrString(dynamic data) {
  if (data == null) return null;

  if (data is String) {
    final preMatch = RegExp(
      r'<pre[^>]*>([\s\S]*?)<\/pre>',
      caseSensitive: false,
    ).firstMatch(data);
    if (preMatch != null) {
      return preMatch.group(1)?.trim();
    }
    final stripped = data.replaceAll(RegExp(r'<[^>]+>'), '').trim();
    return stripped.isNotEmpty ? stripped : null;
  }

  return null;
}

String? extractErrorMessage(dynamic data) {
  if (data == null) return null;

  if (data is String) {
    return _extractMessageFromHtmlOrString(data);
  }

  if (data is Map<String, dynamic>) {
    const candidates = [
      'message',
      'msg',
      'error',
      'detail',
      'description',

      'data',
    ];

    for (final key in candidates) {
      if (data.containsKey(key)) {
        final v = data[key];
        if (v is String && v.trim().isNotEmpty) return v.trim();
        if (v is List) {
          if (v.isNotEmpty) {
            if (v.first is String) return v.join(', ');
            if (v.first is Map) {
              final firstMap = (v.first as Map);
              for (final kk in ['message', 'msg', 'error', 'detail']) {
                if (firstMap[kk] is String) {
                  return (firstMap[kk] as String).trim();
                }
              }
              return firstMap.toString();
            }
          }
        }
        if (v is Map<String, dynamic>) {
          for (final kk in [
            'message',
            'msg',
            'error',
            'detail',
            'description',
          ]) {
            final inner = v[kk];
            if (inner is String && inner.trim().isNotEmpty) return inner.trim();
          }
          // as a last resort
          return v.toString();
        }
      }
    }

    for (final top in ['error', 'errors']) {
      final val = data[top];
      if (val is Map<String, dynamic>) {
        for (final kk in ['message', 'msg', 'detail', 'description']) {
          final inner = val[kk];
          if (inner is String && inner.trim().isNotEmpty) return inner.trim();
        }
      }
    }

    // last resort for maps
    return data.toString();
  }

  if (data is List) {
    return data.map((e) => e.toString()).join(', ');
  }

  return null;
}

String _friendlyFallback(int statusCode, Response? r) {
  final method = r?.requestOptions.method ?? '';
  final path = r?.requestOptions.path ?? '';
  switch (statusCode) {
    case 404:
      return 'Request not found ($method $path).';
    case 400:
      return 'Bad request.';
    case 401:
      return 'Unauthorized.';
    case 403:
      return 'Forbidden.';
    case 500:
      return 'Internal server error.';
    default:
      return 'Server error ($statusCode).';
  }
}
