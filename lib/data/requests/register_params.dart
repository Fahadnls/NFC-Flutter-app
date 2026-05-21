class RegisterParams {
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? authProvider;
  final String? country;

  RegisterParams({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.authProvider,
    this.country,
  });

  factory RegisterParams.fromJson(Map<String, dynamic> json) {
    return RegisterParams(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      authProvider: json['authProvider'] as String?,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (phone != null) data['phone'] = phone;
    if (authProvider != null) data['authProvider'] = authProvider;
    if (country != null) data['country'] = country;

    return data;
  }

  RegisterParams copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? authProvider,
    String? country,
  }) {
    return RegisterParams(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      authProvider: authProvider ?? this.authProvider,
      country: country ?? this.country,
    );
  }
}
