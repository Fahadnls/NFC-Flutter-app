class AddressParams {
  final String firstName;
  final String lastName;
  final String phone;
  final String city;
  final String area;
  final String addressType;
  final String otherAddressType;
  final bool isDefault;
  final String note;

  const AddressParams({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.city,
    required this.area,
    required this.addressType,
    required this.otherAddressType,
    required this.isDefault,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'city': city,
    'area': area,
    'addressType': addressType,
    'otherAddressType': otherAddressType,
    'isDefault': isDefault,
    'note': note,
  };
}
