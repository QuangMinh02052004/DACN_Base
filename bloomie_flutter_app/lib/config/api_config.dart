import 'dart:io';

class ApiConfig {
  // Base URLs
  static const String _baseUrlAndroid = 'http://10.0.2.2:5187/api/v1';
  static const String _baseUrlIOS = 'http://localhost:5187/api/v1';
  static const String _baseUrlProduction = 'https://your-production-api.com/api/v1';

  // Tự động chọn base URL dựa trên platform và environment
  static String get baseUrl {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return _baseUrlProduction;
    }
    return Platform.isAndroid ? _baseUrlAndroid : _baseUrlIOS;
  }

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Endpoints - Auth
  static String get authLogin => '/auth/login';
  static String get authRegister => '/auth/register';
  static String get authMe => '/auth/me';
  static String get authLogout => '/auth/logout';
  static String get authChangePassword => '/auth/change-password';
  static String get authForgotPassword => '/auth/forgot-password';

  // Endpoints - Products
  static String get products => '/products';
  static String productDetail(int id) => '/products/$id';
  static String productRating(int id) => '/products/$id/ratings';
  static String get productSearchByImage => '/products/search-by-image';

  // Endpoints - Categories
  static String get categories => '/categories';
  static String categoryDetail(int id) => '/categories/$id';

  // Endpoints - Cart
  static String get cart => '/cart';
  static String get cartItems => '/cart/items';
  static String cartItem(int itemId) => '/cart/items/$itemId';

  // Endpoints - Orders
  static String get orders => '/orders';
  static String get allOrders => '/orders/all';
  static String orderDetail(int id) => '/orders/$id';
  static String orderStatus(int id) => '/orders/$id/status';
  static String orderCancel(int id) => '/orders/$id/cancel';

  // Endpoints - User Profile
  static String get userProfile => '/user/profile';
  static String get userOrders => '/user/orders';
  static String get userFavorites => '/user/favorites';

  // Endpoints - Custom Arrangement
  static String get customArrangements => '/custom-arrangements';
  static String customArrangementDetail(int id) => '/custom-arrangements/$id';

  // Endpoints - Promotions
  static String get promotions => '/promotions';
  static String promotionDetail(int id) => '/promotions/$id';

  // Headers
  static Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  static Map<String, String> authHeader(String token) => {
        ...defaultHeaders,
        'Authorization': 'Bearer $token',
      };
}
