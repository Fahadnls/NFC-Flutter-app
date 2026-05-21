import 'package:get/get.dart';

import '../../data/models/product_model.dart';

class FavoriteProvider {
  static final RxMap<String, bool> _favoriteStates = <String, bool>{}.obs;
  static final RxMap<String, String> _productSelectedVariants =
      <String, String>{}.obs;

  static RxMap<String, bool> get favoriteStates => _favoriteStates;
  static RxMap<String, String> get productSelectedVariants =>
      _productSelectedVariants;

  static bool resolveLike(
    String variantId, {
    String? productId,
    required bool fallback,
  }) {
    if (_favoriteStates.containsKey(variantId)) {
      return _favoriteStates[variantId] ?? fallback;
    }
    if (productId != null &&
        productId.isNotEmpty &&
        _productSelectedVariants.containsKey(productId)) {
      final selectedVariantId = _productSelectedVariants[productId];
      if (selectedVariantId != null &&
          _favoriteStates.containsKey(selectedVariantId)) {
        return _favoriteStates[selectedVariantId] ?? fallback;
      }
    }
    return fallback;
  }

  static void setLike(String variantId, bool isLiked, {String? productId}) {
    _favoriteStates[variantId] = isLiked;
    if (productId != null && productId.isNotEmpty) {
      _productSelectedVariants[productId] = variantId;
    }
  }

  static void syncProducts(List<ProductsHomeModel> products) {
    for (final product in products) {
      _productSelectedVariants[product.Id] = product.variant.Id;
      final variantId = product.variant.Id;
      if (_favoriteStates.containsKey(variantId)) {
        product.isFavourite = _favoriteStates[variantId] ?? product.isFavourite;
      } else {
        _favoriteStates[variantId] = product.isFavourite;
      }
    }
  }

  static void syncProduct(ProductsHomeModel product) {
    syncProducts([product]);
  }

  static void setProductVariant(String productId, String variantId) {
    if (productId.isEmpty || variantId.isEmpty) {
      return;
    }
    _productSelectedVariants[productId] = variantId;
  }

  static String? selectedVariantForProduct(String productId) {
    if (productId.isEmpty) {
      return null;
    }
    return _productSelectedVariants[productId];
  }

  static void clear() {
    _favoriteStates.clear();
    _productSelectedVariants.clear();
  }
}
