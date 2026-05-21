class LoginParams {
  final String? email;
  final String? password;

  LoginParams({this.email, this.password});

  factory LoginParams.fromJson(Map<String, dynamic> json) {
    return LoginParams(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;

    return data;
  }

  LoginParams copyWith({String? email, String? password}) {
    return LoginParams(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
