import 'package:dio/dio.dart';
import '../models/api_response.dart';
import '../models/cart.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class CartService {
  final _client = ApiClient();

  Future<ApiResponse<Cart>> getCart() async {
    try {
      final response = await _client.get(ApiConfig.cart);

      return ApiResponse<Cart>.fromJson(
        response.data,
        (json) => Cart.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<Cart>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }

  Future<ApiResponse<Cart>> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final response = await _client.post(
        ApiConfig.cartItems,
        data: {
          'productId': productId,
          'quantity': quantity,
        },
      );

      return ApiResponse<Cart>.fromJson(
        response.data,
        (json) => Cart.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<Cart>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }

  Future<ApiResponse<Cart>> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await _client.put(
        ApiConfig.cartItem(cartItemId),
        data: {
          'cartItemId': cartItemId,
          'quantity': quantity,
        },
      );

      return ApiResponse<Cart>.fromJson(
        response.data,
        (json) => Cart.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<Cart>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }

  Future<ApiResponse<Cart>> removeFromCart(int cartItemId) async {
    try {
      final response = await _client.delete(
        ApiConfig.cartItem(cartItemId),
      );

      return ApiResponse<Cart>.fromJson(
        response.data,
        (json) => Cart.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<Cart>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }

  Future<ApiResponse<void>> clearCart() async {
    try {
      await _client.delete(ApiConfig.cart);
      return ApiResponse<void>(success: true, message: 'Đã xóa giỏ hàng');
    } on DioException catch (e) {
      return ApiResponse<void>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }
}
