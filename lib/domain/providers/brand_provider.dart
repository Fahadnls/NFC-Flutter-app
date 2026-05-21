import 'package:get/get.dart';

import '../../data/models/brands_model.dart';

class BrandProvider {
  static final RxList<BrandsBrandsModel> brands = <BrandsBrandsModel>[].obs;

  static void setBrands(List<BrandsBrandsModel> list) {
    brands.assignAll(list);
  }

  static List<String> get brandNames {
    return brands
        .map((e) => e.nameEn)
        .where((e) => e.trim().isNotEmpty)
        .toSet()
        .toList();
  }

  static String? brandIdByName(String name) {
    for (final b in brands) {
      if (b.nameEn == name) {
        return b.Id;
      }
    }
    return null;
  }
}
