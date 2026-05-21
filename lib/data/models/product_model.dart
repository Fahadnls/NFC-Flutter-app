// ignore_for_file: non_constant_identifier_names

import 'package:jsafe/jsafe.dart';

class ProductsHomeModel {
  final String Id;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String category;
  final String brand;
  final double rating;
  final List<String> labels;
  bool isFavourite;
  final bool isActive;
  final bool isArchived;
  final bool isDeleted;
  final String coverImage;
  final int V;
  final DateTime createdAt;
  final DateTime updatedAt;
  final VariantModel variant;

  ProductsHomeModel({
    required this.Id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.category,
    required this.brand,
    required this.rating,
    required this.labels,
    required this.isFavourite,
    required this.isActive,
    required this.isArchived,
    required this.isDeleted,
    required this.coverImage,
    required this.V,
    required this.createdAt,
    required this.updatedAt,
    required this.variant,
  });

  ProductsHomeModel copyWith({
    String? Id,
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? category,
    String? brand,
    double? rating,
    List<String>? labels,
    bool? isFavourite,
    bool? isActive,
    bool? isArchived,
    bool? isDeleted,
    String? coverImage,
    int? V,
    DateTime? createdAt,
    DateTime? updatedAt,
    VariantModel? variant,
  }) {
    return ProductsHomeModel(
      Id: Id ?? this.Id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      rating: rating ?? this.rating,
      labels: labels ?? this.labels,
      isFavourite: isFavourite ?? this.isFavourite,
      isActive: isActive ?? this.isActive,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      coverImage: coverImage ?? this.coverImage,
      V: V ?? this.V,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      variant: variant ?? this.variant,
    );
  }

  factory ProductsHomeModel.fromJson(Map<String, dynamic> json) {
    return ProductsHomeModel(
      Id: JSafe.string(json['_id']),
      nameEn: JSafe.string(json['nameEn']),
      nameAr: JSafe.string(json['nameAr']),
      descriptionEn: JSafe.string(json['descriptionEn']),
      descriptionAr: JSafe.string(json['descriptionAr']),
      category: JSafe.string(json['category']),
      brand: JSafe.string(json['brand']),
      rating: JSafe.double_(json['rating']),
      labels: JSafe.mapList<String>(json['labels'], (e) => JSafe.string(e)),
      isFavourite: JSafe.boolean(json['isFavourite']),
      isActive: JSafe.boolean(json['isActive']),
      isArchived: JSafe.boolean(json['isArchived']),
      isDeleted: JSafe.boolean(json['isDeleted']),
      coverImage: JSafe.string(json['coverImage']),
      V: JSafe.integer(json['__v']),
      createdAt: JSafe.dateTime(json['createdAt']),
      updatedAt: JSafe.dateTime(json['updatedAt']),
      variant: VariantModel.fromJson(JSafe.map(json['variant'])),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': Id,
    'nameEn': nameEn,
    'nameAr': nameAr,
    'descriptionEn': descriptionEn,
    'descriptionAr': descriptionAr,
    'category': category,
    'brand': brand,
    'rating': rating,
    'labels': labels,
    'isFavourite': isFavourite,
    'isActive': isActive,
    'isArchived': isArchived,
    'isDeleted': isDeleted,
    'coverImage': coverImage,
    '__v': V,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'variant': variant.toJson(),
  };
}

class VariantModel {
  final String Id;
  final String product;
  final String sku;
  final String name;
  final String color;
  final String size;
  final String unit;
  final int value;
  final double price;
  final double discountPrice;
  final int stock;
  final List<String> images;
  final bool isActive;
  final bool isDeleted;
  final int V;
  final int discountedPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  VariantModel({
    required this.Id,
    required this.product,
    required this.sku,
    required this.name,
    required this.color,
    required this.size,
    required this.unit,
    required this.value,
    required this.price,
    required this.discountPrice,
    required this.stock,
    required this.images,
    required this.isActive,
    required this.isDeleted,
    required this.V,
    required this.createdAt,
    required this.discountedPrice,
    required this.updatedAt,
  });

  VariantModel copyWith({
    String? Id,
    String? product,
    String? sku,
    String? name,
    String? color,
    String? size,
    String? unit,
    int? value,
    double? price,
    double? discountPrice,
    int? stock,
    List<String>? images,
    bool? isActive,
    bool? isDeleted,
    int? V,
    int? discountedPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VariantModel(
      Id: Id ?? this.Id,
      product: product ?? this.product,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      color: color ?? this.color,
      size: size ?? this.size,
      unit: unit ?? this.unit,
      value: value ?? this.value,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      stock: stock ?? this.stock,
      images: images ?? this.images,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      V: V ?? this.V,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    final priceValue = JSafe.double_(json['price']);
    final rawDiscountPrice = json['discountPrice'] ?? json['discountedPrice'];
    final discountPriceValue = rawDiscountPrice == null
        ? priceValue
        : JSafe.double_(rawDiscountPrice);
    final rawProduct = json['product'];
    final productId = rawProduct is Map<String, dynamic>
        ? JSafe.string(rawProduct['_id'])
        : JSafe.string(rawProduct);
    return VariantModel(
      Id: JSafe.string(json['_id']),
      product: productId,
      sku: JSafe.string(json['sku']),
      name: JSafe.string(json['name']),
      color: JSafe.string(json['color']),
      size: JSafe.string(json['size']),
      unit: JSafe.string(json['unit']),
      value: JSafe.integer(json['value']),
      price: priceValue,
      discountPrice: discountPriceValue,
      stock: JSafe.integer(json['stock']),
      images: JSafe.mapList<String>(json['images'], (e) => JSafe.string(e)),
      isActive: JSafe.boolean(json['isActive']),
      isDeleted: JSafe.boolean(json['isDeleted']),
      V: JSafe.integer(json['__v']),
      discountedPrice: JSafe.integer(json['discountedPrice']),
      createdAt: JSafe.dateTime(json['createdAt']),
      updatedAt: JSafe.dateTime(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': Id,
    'product': product,
    'sku': sku,
    'name': name,
    'color': color,
    'size': size,
    'unit': unit,
    'value': value,
    'price': price,
    'discountPrice': discountPrice,
    'discountedPrice': discountedPrice,
    'stock': stock,
    'images': images,
    'isActive': isActive,
    'isDeleted': isDeleted,
    '__v': V,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
