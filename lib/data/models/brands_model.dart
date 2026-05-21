// ignore_for_file: non_constant_identifier_names

import 'package:jsafe/jsafe.dart';

class BrandsModel {
  final int statusCode;
  final bool isSuccess;
  final String message;
  final List<BrandsBrandsModel> brands;

  BrandsModel({
    required this.statusCode,
    required this.isSuccess,
    required this.message,
    required this.brands,
  });

  BrandsModel copyWith({
    int? statusCode,
    bool? isSuccess,
    String? message,
    List<BrandsBrandsModel>? brands,
  }) {
    return BrandsModel(
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      brands: brands ?? this.brands,
    );
  }

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      statusCode: JSafe.integer(json['statusCode']),
      isSuccess: JSafe.boolean(json['isSuccess']),
      message: JSafe.string(json['message']),
      brands: JSafe.mapList<BrandsBrandsModel>(
        json['brands'],
        (e) => BrandsBrandsModel.fromJson(JSafe.map(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'isSuccess': isSuccess,
    'message': message,
    'brands': brands.map((e) => e.toJson()).toList(),
  };
}

class BrandsBrandsModel {
  final String Id;
  final String nameEn;
  final String nameAr;
  final String logo;

  BrandsBrandsModel({
    required this.Id,
    required this.nameEn,
    required this.nameAr,
    required this.logo,
  });

  BrandsBrandsModel copyWith({
    String? Id,
    String? nameEn,
    String? nameAr,
    String? logo,
  }) {
    return BrandsBrandsModel(
      Id: Id ?? this.Id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      logo: logo ?? this.logo,
    );
  }

  factory BrandsBrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsBrandsModel(
      Id: JSafe.string(json['_id']),
      nameEn: JSafe.string(json['nameEn']),
      nameAr: JSafe.string(json['nameAr']),
      logo: JSafe.string(json['logo']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': Id,
    'nameEn': nameEn,
    'nameAr': nameAr,
    'logo': logo,
  };
}
