// ignore_for_file: non_constant_identifier_names

import 'package:jsafe/jsafe.dart';

class CategoryModel {
  final int statusCode;
  final bool isSuccess;
  final String message;
  final List<CategoryCategoriesModel> categories;

  CategoryModel({
    required this.statusCode,
    required this.isSuccess,
    required this.message,
    required this.categories,
  });

  CategoryModel copyWith({
    int? statusCode,
    bool? isSuccess,
    String? message,
    List<CategoryCategoriesModel>? categories,
  }) {
    return CategoryModel(
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      categories: categories ?? this.categories,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      statusCode: JSafe.integer(json['statusCode']),
      isSuccess: JSafe.boolean(json['isSuccess']),
      message: JSafe.string(json['message']),
      categories: JSafe.mapList<CategoryCategoriesModel>(
        json['categories'],
        (e) => CategoryCategoriesModel.fromJson(JSafe.map(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'isSuccess': isSuccess,
    'message': message,
    'categories': categories.map((e) => e.toJson()).toList(),
  };
}

class CategoryCategoriesModel {
  final String Id;
  final String nameEn;
  final String nameAr;
  final String svg;
  final dynamic parentCategory;
  final int level;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryCategoriesModel({
    required this.Id,
    required this.nameEn,
    required this.nameAr,
    required this.svg,
    required this.parentCategory,
    required this.level,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  CategoryCategoriesModel copyWith({
    String? Id,
    String? nameEn,
    String? nameAr,
    String? svg,
    String? parentCategory,
    int? level,
    bool? isActive,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryCategoriesModel(
      Id: Id ?? this.Id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      svg: svg ?? this.svg,
      parentCategory: parentCategory ?? this.parentCategory,
      level: level ?? this.level,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CategoryCategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoryCategoriesModel(
      Id: JSafe.string(json['_id']),
      nameEn: JSafe.string(json['nameEn']),
      nameAr: JSafe.string(json['nameAr']),
      svg: JSafe.string(json['svg']),
      parentCategory: json['parentCategory'],
      level: JSafe.integer(json['level']),
      isActive: JSafe.boolean(json['isActive']),
      isDeleted: JSafe.boolean(json['isDeleted']),
      createdAt: JSafe.dateTime(json['createdAt']),
      updatedAt: JSafe.dateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': Id,
    'nameEn': nameEn,
    'nameAr': nameAr,
    'svg': svg,
    'parentCategory': parentCategory,
    'level': level,
    'isActive': isActive,
    'isDeleted': isDeleted,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
