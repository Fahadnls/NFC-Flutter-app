// ignore_for_file: unused_field

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../environment/environment.dart';
import '../../domain/providers/storage_provider.dart';
import '../../domain/providers/user_provider.dart';
import '../../routes/app_pages.dart';
import 'api_endpoints.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AuthInterceptor extends Interceptor {
  final UserProvider _userProvider;
  final Dio _dio = Dio();
  Future<String?>? _refreshingTokenFuture;

  AuthInterceptor(this._userProvider);
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // log('AuthInterceptor: Request to ${options.uri}');
    // log('Headers before adding token: ${options.headers}');

    if (_isAuthEndpoint(options.path)) {
      return handler.next(options);
    }

    final user = await _userProvider.getUser();
    String? token = StorageProvider.getAccessToken() ?? user?.accessToken;

    if (token != null && token.isNotEmpty && _isTokenExpired(token)) {
      // log('AuthInterceptor: access token expired, refreshing...');
      token = await _refreshAccessTokenSerialized();
    }

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  bool _isTokenExpired(String token) {
    try {
      final payload = token.split('.')[1];
      final decoded =
          json.decode(ascii.decode(base64.decode(base64.normalize(payload))))
              as Map<String, dynamic>;
      final expiry = decoded['exp'];
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
      log("${DateTime.now().isAfter(expiryDate)}");
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      return true;
    }
  }

  Future<String?> _refreshAccessTokenSerialized() async {
    if (_refreshingTokenFuture != null) {
      return _refreshingTokenFuture;
    }
    _refreshingTokenFuture = _refreshAccessToken();
    final token = await _refreshingTokenFuture;
    _refreshingTokenFuture = null;
    return token;
  }

  Future<String?> _refreshAccessToken() async {
    final refreshToken = StorageProvider.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      // log('AuthInterceptor: refresh token is missing');
      return null;
    }

    try {
      _dio.options = BaseOptions(
        baseUrl: '$BASE_URL/$URL_TYPE/',
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final response = await _dio.post(
        ApiEndpoints.tokenRefresh,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode != 200 || response.data == null) {
        return null;
      }

      final data = response.data as Map<String, dynamic>;
      final newAccessToken = _extractAccessToken(data);
      final newRefreshToken = _extractRefreshToken(data) ?? refreshToken;

      if (newAccessToken == null || newAccessToken.isEmpty) {
        return null;
      }

      await StorageProvider.setTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );
      return newAccessToken;
    } catch (e) {
      // log('AuthInterceptor: refresh token request failed -> $e');
      return null;
    }
  }

  // @override
  // Future<void> onError(
  //   DioException err,
  //   ErrorInterceptorHandler handler,
  // ) async {
  //   if (err.response?.statusCode == 401) {
  //     log(
  //       'AuthInterceptor User Clear: User is cleared on First attempt after token expire.. no refresh token',
  //     );
  //     await MySharedPref.logoutUser();
  //     _navigateToLoginScreen();
  //   }
  //   return handler.next(err);
  // }
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final path = err.requestOptions.path;
      final serverMsg = _extractMessage(err.response?.data);

      final isAuthEndpoint = _isAuthEndpoint(path);
      final isTokenProblem = _looksLikeAuthTokenProblem(serverMsg);

      if (!isAuthEndpoint && isTokenProblem) {
        // Token/session truly bad -> logout
        // log('AuthInterceptor: token/authorization problem -> logout');
        await _userProvider.clearUser();
        _navigateToLoginScreen();
        // Optionally, you can short-circuit with a custom DioException if you want:
        // return handler.reject(err);
      } else {
        // 401 but expected during auth flows (e.g., invalid credentials)
        // or 401 with a non-token message -> let UI show the message (ApiClient will handle)
        log(
          'AuthInterceptor: 401 without token issue or on auth endpoint -> do NOT logout',
        );
      }
    }

    return handler.next(err);
  }

  void _navigateToLoginScreen() {
    Get.offAllNamed(Routes.WELCOME);
    // Navigator.of(navigatorKey.currentContext!).pushReplacementNamed('login');
  }
}

bool _looksLikeAuthTokenProblem(String? msg) {
  if (msg == null) return false;
  final m = msg.toLowerCase();

  return m.contains('token expired') ||
      m.contains('jwt expired') ||
      m.contains('expired token') ||
      m.contains('invalid token') ||
      m.contains('invalid or expired token') ||
      m.contains('no token provided') ||
      m.contains('no user token provided') ||
      m.contains('no user token') ||
      m.contains('missing token') ||
      m.contains('missing authorization') ||
      m.contains('authorization header missing') ||
      m.contains('authorization header required') ||
      m.contains('authorization required') ||
      m.contains('unauthorized') ||
      m.contains('unauthorized token') ||
      m.contains('unauthenticated') ||
      m.contains('not authenticated') ||
      m.contains('not authorized') ||
      m.contains('error reading token') ||
      m.contains('token malformed') ||
      m.contains('malformed jwt') ||
      m.contains('malformed token') ||
      m.contains('token invalid') ||
      m.contains('token not provided') ||
      m.contains('token not found') ||
      m.contains('jwt malformed') ||
      m.contains('jwt signature') ||
      m.contains('invalid signature') ||
      m.contains('invalid jwt') ||
      m.contains('token decode error') ||
      m.contains('error decoding token') ||
      m.contains('could not decode token') ||
      m.contains('token verification failed') ||
      m.contains('failed to verify token') ||
      m.contains('token verify failed') ||
      m.contains('token verification error') ||
      m.contains('token revoked') ||
      m.contains('revoked token') ||
      m.contains('blacklisted token') ||
      m.contains('forbidden: token') ||
      m.contains('expired or invalid') ||
      m.contains('auth token missing') ||
      m.contains('auth token expired') ||
      m.contains('auth token invalid') ||
      m.contains('access token expired') ||
      m.contains('access token invalid') ||
      m.contains('invalid access token') ||
      m.contains('refresh token expired') ||
      m.contains('refresh token invalid') ||
      m.contains('refresh token missing') ||
      m.contains('bearer token missing') ||
      m.contains('bearer token invalid') ||
      m.contains('bearer token expired') ||
      m.contains('token expired or invalid') ||
      m.contains('signature has expired') ||
      m.contains('signature verification failed') ||
      m.contains('invalid signature for token') ||
      m.contains('invalid bearer token');
}

String? _extractMessage(dynamic data) {
  if (data == null) return null;

  if (data is String) {
    final preMatch = RegExp(
      r'<pre[^>]*>([\s\S]*?)<\/pre>',
      caseSensitive: false,
    ).firstMatch(data);
    if (preMatch != null) return preMatch.group(1)?.trim();
    final stripped = data.replaceAll(RegExp(r'<[^>]+>'), '').trim();
    return stripped.isNotEmpty ? stripped : null;
  }

  if (data is Map<String, dynamic>) {
    for (final k in ['message', 'msg', 'error', 'detail', 'description']) {
      final v = data[k];
      if (v is String && v.trim().isNotEmpty) return v.trim();
    }
    if (data['error'] is Map) {
      final err = data['error'] as Map;
      for (final k in ['message', 'msg', 'detail', 'description']) {
        final v = err[k];
        if (v is String && v.trim().isNotEmpty) return v.trim();
      }
    }
    return data.toString();
  }

  if (data is List && data.isNotEmpty) {
    return data.map((e) => e.toString()).join(', ');
  }

  return null;
}

bool _isAuthEndpoint(String path) {
  final p = path.toLowerCase();
  return p.contains('/login') ||
      p.contains('/register') ||
      p.contains('/sign-in') ||
      p.contains('/sign-up') ||
      p.contains('/verify') ||
      p.contains('/authenticate') ||
      p.contains('/verifyuser') ||
      p.contains('/refresh-token') ||
      p.contains('/forgot') ||
      p.contains('/reset');
}

String? _extractAccessToken(Map<String, dynamic> data) {
  return data['accessToken'] as String? ??
      (data['tokens'] is Map<String, dynamic>
          ? (data['tokens'] as Map<String, dynamic>)['accessToken'] as String?
          : null) ??
      data['token'] as String?;
}

String? _extractRefreshToken(Map<String, dynamic> data) {
  return data['refreshToken'] as String? ??
      (data['tokens'] is Map<String, dynamic>
          ? (data['tokens'] as Map<String, dynamic>)['refreshToken'] as String?
          : null);
}
