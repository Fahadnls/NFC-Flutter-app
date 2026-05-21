import 'package:get/get.dart';

import '../../data/models/sub_category_model.dart';

class SubCategoryProvider {
  static final RxMap<String, List<SubCategoryDataModel>> subCategoryMap =
      <String, List<SubCategoryDataModel>>{}.obs;

  static List<SubCategoryDataModel> getByCategoryId(String categoryId) {
    return subCategoryMap[categoryId] ?? <SubCategoryDataModel>[];
  }

  static void setByCategoryId(
    String categoryId,
    List<SubCategoryDataModel> subCategories,
  ) {
    subCategoryMap[categoryId] = subCategories;
  }

  static void clear() {
    subCategoryMap.clear();
  }
}
