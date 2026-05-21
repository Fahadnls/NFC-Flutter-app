import 'package:jsafe/jsafe.dart';

class MetaModel {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final bool hasNext;
  final bool hasPrev;

  MetaModel({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.hasNext,
    required this.hasPrev,
  });

  MetaModel copyWith({
    int? totalItems,
    int? totalPages,
    int? currentPage,
    int? pageSize,
    bool? hasNext,
    bool? hasPrev,
  }) {
    return MetaModel(
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      hasNext: hasNext ?? this.hasNext,
      hasPrev: hasPrev ?? this.hasPrev,
    );
  }

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      totalItems: JSafe.integer(json['totalItems']),
      totalPages: JSafe.integer(json['totalPages']),
      currentPage: JSafe.integer(json['currentPage']),
      pageSize: JSafe.integer(json['pageSize']),
      hasNext: JSafe.boolean(json['hasNext']),
      hasPrev: JSafe.boolean(json['hasPrev']),
    );
  }

  Map<String, dynamic> toJson() => {
    'totalItems': totalItems,
    'totalPages': totalPages,
    'currentPage': currentPage,
    'pageSize': pageSize,
    'hasNext': hasNext,
    'hasPrev': hasPrev,
  };
}
