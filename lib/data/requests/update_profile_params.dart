import 'dart:io';

class UpdateProfileParams {
  final String? name;
  final String? phone;
  final String? gender;
  final String? birthDate;
  final File? file;

  const UpdateProfileParams({
    this.name,
    this.phone,
    this.gender,
    this.birthDate,
    this.file,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (gender != null) {
      data['gender'] = gender;
    }
    if (birthDate != null) {
      data['birthDate'] = birthDate;
    }
    return data;
  }
}
