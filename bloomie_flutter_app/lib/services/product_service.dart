import 'package:dio/dio.dart';
import '../models/api_response.dart';
import '../models/product.dart';
import '../config/api_config.dart';
import 'api_client.dart';

class ProductService {
  final _client = ApiClient();

  Future<ApiResponse<List<Product>>> getProducts({
    String? keyword,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (keyword != null && keyword.isNotEmpty) {
        queryParams['keyword'] = keyword;
      }
      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (minPrice != null) queryParams['minPrice'] = minPrice;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;

      final response = await _client.get(
        ApiConfig.products,
        queryParameters: queryParams,
      );

      return ApiResponse<List<Product>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => Product.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<Product>>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }

  Future<ApiResponse<Product>> getProductDetail(int productId) async {
    try {
      final response = await _client.get(
        ApiConfig.productDetail(productId),
      );

      return ApiResponse<Product>.fromJson(
        response.data,
        (json) => Product.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<Product>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }
}
