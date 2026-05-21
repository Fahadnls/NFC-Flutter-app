class ResetPasswordParams {
  final String? newPassword;
  final String? token;

  ResetPasswordParams({this.newPassword, this.token});

  factory ResetPasswordParams.fromJson(Map<String, dynamic> json) {
    return ResetPasswordParams(
      newPassword: json['newPassword'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (newPassword != null) data['newPassword'] = newPassword;
    if (token != null) data['token'] = token;

    return data;
  }

  ResetPasswordParams copyWith({String? newPassword, String? token}) {
    return ResetPasswordParams(
      newPassword: newPassword ?? this.newPassword,
      token: token ?? this.token,
    );
  }
}
