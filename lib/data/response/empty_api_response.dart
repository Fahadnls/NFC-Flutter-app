import 'dart:convert';

class EmptyApiResponse {
  final int? statusCode;
  final bool? isSuccess;
  final String? message;
  final String? fileName;
  final String? token;
  final int? code;

  EmptyApiResponse({
    this.statusCode,
    this.isSuccess,
    this.message,
    this.fileName,
    this.token,
    this.code,
  });

  EmptyApiResponse copyWith({
    int? statusCode,
    bool? isSuccess,
    String? message,
    String? fileName,
    String? token,
    int? code,
  }) {
    return EmptyApiResponse(
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      fileName: fileName ?? this.fileName,
      token: token ?? this.token,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'message': message,
      'fileName': fileName,
      'token': token,
      'code': code,
    };
  }

  factory EmptyApiResponse.fromMap(Map<String, dynamic> map) {
    return EmptyApiResponse(
      statusCode: map['statusCode'] as int?,
      isSuccess: map['isSuccess'] as bool?,
      message: map['message'] as String?,
      fileName: map['fileName'] as String?,
      token: map['token'] as String?,
      code: map['code'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmptyApiResponse.fromJson(String source) =>
      EmptyApiResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
