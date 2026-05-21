// ignore_for_file: non_constant_identifier_names

import 'package:jsafe/jsafe.dart';

class SubCategoryModel {
  final int statusCode;
  final bool isSuccess;
  final String message;
  final List<SubCategoryDataModel> data;

  SubCategoryModel({
    required this.statusCode,
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  SubCategoryModel copyWith({
    int? statusCode,
    bool? isSuccess,
    String? message,
    List<SubCategoryDataModel>? data,
  }) {
    return SubCategoryModel(
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      statusCode: JSafe.integer(json['statusCode']),
      isSuccess: JSafe.boolean(json['isSuccess']),
      message: JSafe.string(json['message']),
      data: JSafe.mapList<SubCategoryDataModel>(
        json['data'],
        (e) => SubCategoryDataModel.fromJson(JSafe.map(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'isSuccess': isSuccess,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class SubCategoryDataModel {
  final String Id;
  final String nameEn;
  final String nameAr;
  final String svg;
  final String parentCategory;
  final int level;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SubCategoryChildrenModel> children;

  SubCategoryDataModel({
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
    required this.children,
  });

  SubCategoryDataModel copyWith({
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
    List<SubCategoryChildrenModel>? children,
  }) {
    return SubCategoryDataModel(
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
      children: children ?? this.children,
    );
  }

  factory SubCategoryDataModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryDataModel(
      Id: JSafe.string(json['_id']),
      nameEn: JSafe.string(json['nameEn']),
      nameAr: JSafe.string(json['nameAr']),
      svg: JSafe.string(json['svg']),
      parentCategory: JSafe.string(json['parentCategory']),
      level: JSafe.integer(json['level']),
      isActive: JSafe.boolean(json['isActive']),
      isDeleted: JSafe.boolean(json['isDeleted']),
      createdAt: JSafe.dateTime(json['createdAt']),
      updatedAt: JSafe.dateTime(json['updatedAt']),
      children: JSafe.mapList<SubCategoryChildrenModel>(
        json['children'],
        (e) => SubCategoryChildrenModel.fromJson(JSafe.map(e)),
      ),
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
    'children': children.map((e) => e.toJson()).toList(),
  };
}

class SubCategoryChildrenModel {
  final String Id;
  final String nameEn;
  final String nameAr;
  final String svg;
  final String parentCategory;
  final int level;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> children;

  SubCategoryChildrenModel({
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
    required this.children,
  });

  SubCategoryChildrenModel copyWith({
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
    List<dynamic>? children,
  }) {
    return SubCategoryChildrenModel(
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
      children: children ?? this.children,
    );
  }

  factory SubCategoryChildrenModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryChildrenModel(
      Id: JSafe.string(json['_id']),
      nameEn: JSafe.string(json['nameEn']),
      nameAr: JSafe.string(json['nameAr']),
      svg: JSafe.string(json['svg']),
      parentCategory: JSafe.string(json['parentCategory']),
      level: JSafe.integer(json['level']),
      isActive: JSafe.boolean(json['isActive']),
      isDeleted: JSafe.boolean(json['isDeleted']),
      createdAt: JSafe.dateTime(json['createdAt']),
      updatedAt: JSafe.dateTime(json['updatedAt']),
      children: JSafe.list(json['children']),
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
    'children': children.map((e) => e.toJson()).toList(),
  };
}
