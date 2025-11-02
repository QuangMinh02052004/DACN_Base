import 'dart:io';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'storage_service.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio _dio;
  final _storage = StorageService();

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      headers: ApiConfig.defaultHeaders,
    ));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add JWT token
          final token = await _storage.readSecure('jwt_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('📤 [${options.method}] ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('📥 [${response.statusCode}] ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (error, handler) async {
          print('❌ [${error.response?.statusCode}] ${error.requestOptions.path}');
          print('Error: ${error.message}');

          // Handle 401 Unauthorized
          if (error.response?.statusCode == 401) {
            await _storage.clearSecure();
            // Có thể trigger logout event ở đây
          }

          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(
    String path, {
    dynamic data,
  }) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> patch(
    String path, {
    dynamic data,
  }) async {
    return await _dio.patch(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
}
