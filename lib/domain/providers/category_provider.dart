import 'package:get/get.dart';

import '../../data/models/category_model.dart';

class CategoryProvider {
  static final RxList<CategoryCategoriesModel> categories =
      <CategoryCategoriesModel>[].obs;

  static void setCategories(List<CategoryCategoriesModel> list) {
    categories.assignAll(list);
  }

  static List<String> get categoryNames {
    return categories
        .map((e) => e.nameEn)
        .where((e) => e.trim().isNotEmpty)
        .toSet()
        .toList();
  }

  static Map<String, String> get categoryIconMap {
    return {
      for (final c in categories)
        if (c.nameEn.trim().isNotEmpty) c.nameEn: c.svg,
    };
  }

  static String? categoryIdByName(String name) {
    for (final c in categories) {
      if (c.nameEn == name) {
        return c.Id;
      }
    }
    return null;
  }
}
