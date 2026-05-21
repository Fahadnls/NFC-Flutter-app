abstract class ApiEndpoints {
  static const String checkUser = 'auth/verifyUser';
  static const String authenticate = 'auth/authenticate';
  static const String tokenRefresh = 'auth/refresh-token';
  static const String deleteAccount = 'auth/deleteAccount';
  static const String guestAuth = 'auth/guest';
  static const String getCurrentUser = 'auth/current-user';
  static const String updateProfile = 'auth/updateProfile';
  static const String getAddresses = 'address/';
  static const String createAddress = 'address/create';
  static String updateAddress(String addressId) => 'address/$addressId';
  static String deleteAddress(String addressId) => 'address/$addressId';

  static const String getHome = 'home/';
  static const String getCampaign = 'campaign';
  static const String checkPromoCode = 'campaign/check-promo-code';
  static String getProductDetail(String id) => 'product/getProductDetail/$id';
  static const String toggleWishlist = 'wishlist/toggle';
  static const String getWishlist = 'wishlist/';
  static const String getBrands = 'brand/list';
  static const String getCategories = 'filter/categories';
  static String getChildCategories(String categoryId) =>
      'filter/child-categories/$categoryId';
  static const String getProductListingFilters =
      'product/productListingFilters';
  static String getProductFeedback(String productId) =>
      'feedback/product/$productId';
  static const String createCart = 'cart/create';
  static const String getCart = 'cart/get';
  static const String getShippingCharges = 'cart/shipping-charges';
  static const String updateCart = 'cart/update';
  static const String removeCart = 'cart/remove';
  static const String createOrder = 'order/create';
  static const String getOrderHistory = 'order/history';
  static String getOrderDetail(String orderId) => 'order/detail/$orderId';
  static const String createFeedback = 'feedback/create';
  static const String getReward = 'reward/get';
  static const String getSearchSuggestions = 'filter/search-list/';
  static const String addSearchSuggestion = 'filter/suggestion';
  static const String getSearchHistory = 'filter/history';
  static const String removeSearchSuggestion = 'filter/removeSearchSuggestion';
}
