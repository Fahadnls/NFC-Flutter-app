class UserModel {
  final String? accessToken;
  // final String? refreshToken;

  UserModel({
    this.accessToken,
    // this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // final userData = json['data'] ?? {};

    return UserModel(
      accessToken: json['token'] as String?,
      // refreshToken: json['refresh_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': accessToken,
      // 'refresh_token': refreshToken,
    };
  }

  UserModel copyWith({
    String? accessToken,
    // String? refreshToken,
  }) {
    return UserModel(
      accessToken: accessToken ?? this.accessToken,
      // refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
