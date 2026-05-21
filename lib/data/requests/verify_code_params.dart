class VerifyCodeParams {
  final String? email;
  final String? code;

  VerifyCodeParams({this.email, this.code});

  factory VerifyCodeParams.fromJson(Map<String, dynamic> json) {
    return VerifyCodeParams(
      email: json['email'] as String?,
      code: json['code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (email != null) data['email'] = email;
    if (code != null) data['code'] = code;

    return data;
  }

  VerifyCodeParams copyWith({String? email, String? code}) {
    return VerifyCodeParams(
      email: email ?? this.email,
      code: code ?? this.code,
    );
  }
}
