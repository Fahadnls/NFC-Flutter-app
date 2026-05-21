import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  void _devLog(String message, {String name = 'API'}) {
    if (kDebugMode) {
      developer.log(message, name: name, time: DateTime.now());
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer();

    buffer.writeln(
      "🌐 REQUEST ➜ ${options.method.toUpperCase()} ${options.uri}",
    );

    buffer.writeln("📦 Headers:");
    options.headers.forEach((k, v) => buffer.writeln('   $k: $v'));

    if (options.queryParameters.isNotEmpty) {
      buffer.writeln("🔎 Query Params:");
      options.queryParameters.forEach((k, v) => buffer.writeln('   $k: $v'));
    }

    if (options.data != null) {
      try {
        const encoder = JsonEncoder.withIndent('  ');
        final prettyBody = encoder.convert(options.data);
        buffer.writeln("📤 Body:\n$prettyBody");
      } catch (_) {
        buffer.writeln("📤 Raw Body:\n${options.data}");
      }
    }

    _devLog(buffer.toString(), name: "REQUEST");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final buffer = StringBuffer();

    buffer.writeln(
      "✅ RESPONSE ➜ ${response.statusCode} ${response.requestOptions.uri}",
    );

    try {
      const encoder = JsonEncoder.withIndent('  ');
      final prettyJson = encoder.convert(response.data);
      buffer.writeln("📨 Body:\n$prettyJson");
    } catch (_) {
      buffer.writeln("📨 Raw Body:\n${response.data}");
    }

    _devLog(buffer.toString(), name: "RESPONSE");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer();

    buffer.writeln(
      "❌ ERROR ➜ ${err.response?.statusCode ?? 'Unknown'} ${err.requestOptions.uri}",
    );

    if (err.response != null) {
      try {
        const encoder = JsonEncoder.withIndent('  ');
        final prettyError = encoder.convert(err.response!.data);
        buffer.writeln("❗ Error Body:\n$prettyError");
      } catch (_) {
        buffer.writeln("❗ Raw Error:\n${err.response!.data}");
      }
    } else {
      buffer.writeln("⚠️ No response received: ${err.message}");
    }

    _devLog(buffer.toString(), name: "ERROR");
    super.onError(err, handler);
  }
}
