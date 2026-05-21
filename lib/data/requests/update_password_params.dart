class UpdatePasswordParams {
  final String? oldPassword;
  final String? newPassword;

  UpdatePasswordParams({this.newPassword, this.oldPassword});

  factory UpdatePasswordParams.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordParams(
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (oldPassword != null) data['oldPassword'] = oldPassword;
    if (newPassword != null) data['newPassword'] = newPassword;

    return data;
  }

  UpdatePasswordParams copyWith({String? oldPassword, String? newPassword}) {
    return UpdatePasswordParams(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
