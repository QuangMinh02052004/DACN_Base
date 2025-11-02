import 'package:dio/dio.dart';
import '../models/api_response.dart';
import '../models/order.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class OrderService {
  final _client = ApiClient();

  Future<ApiResponse<List<Order>>> getMyOrders({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _client.get(
        ApiConfig.orders,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
      );

      return ApiResponse<List<Order>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => Order.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<Order>>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }

  Future<ApiResponse<OrderDetail>> getOrderDetail(int orderId) async {
    try {
      final response = await _client.get(
        ApiConfig.orderDetail(orderId),
      );

      return ApiResponse<OrderDetail>.fromJson(
        response.data,
        (json) => OrderDetail.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<OrderDetail>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }

  Future<ApiResponse<void>> cancelOrder(int orderId) async {
    try {
      await _client.post(ApiConfig.orderCancel(orderId));
      return ApiResponse<void>(success: true, message: 'Đã hủy đơn hàng');
    } on DioException catch (e) {
      return ApiResponse<void>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }
}
