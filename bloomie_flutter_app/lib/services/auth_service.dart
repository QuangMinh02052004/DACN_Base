import 'package:dio/dio.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../config/api_config.dart';
import 'api_client.dart';
import 'storage_service.dart';

class AuthService {
  final _client = ApiClient();
  final _storage = StorageService();

  Future<ApiResponse<AuthResponse>> login({
    required String userNameOrEmail,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        ApiConfig.authLogin,
        data: {
          'userNameOrEmail': userNameOrEmail,
          'password': password,
          'rememberMe': false,
        },
      );

      final apiResponse = ApiResponse<AuthResponse>.fromJson(
        response.data,
        (json) => AuthResponse.fromJson(json),
      );

      if (apiResponse.success && apiResponse.data?.token != null) {
        await _storage.saveSecure('jwt_token', apiResponse.data!.token!);
        if (apiResponse.data!.refreshToken != null) {
          await _storage.saveSecure('refresh_token', apiResponse.data!.refreshToken!);
        }
      }

      return apiResponse;
    } on DioException catch (e) {
      return ApiResponse<AuthResponse>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
        errors: [e.message ?? 'Unknown error'],
      );
    }
  }

  Future<ApiResponse<AuthResponse>> register({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    String? fullName,
    String? phoneNumber,
  }) async {
    try {
      final response = await _client.post(
        ApiConfig.authRegister,
        data: {
          'userName': userName,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
        },
      );

      final apiResponse = ApiResponse<AuthResponse>.fromJson(
        response.data,
        (json) => AuthResponse.fromJson(json),
      );

      if (apiResponse.success && apiResponse.data?.token != null) {
        await _storage.saveSecure('jwt_token', apiResponse.data!.token!);
      }

      return apiResponse;
    } on DioException catch (e) {
      return ApiResponse<AuthResponse>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
        errors: [e.message ?? 'Unknown error'],
      );
    }
  }

  Future<ApiResponse<User>> getCurrentUser() async {
    try {
      final response = await _client.get(ApiConfig.authMe);

      return ApiResponse<User>.fromJson(
        response.data,
        (json) => User.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<User>(
        success: false,
        message: e.response?.data['message'] ?? 'Đã xảy ra lỗi',
      );
    }
  }

  Future<void> logout() async {
    try {
      await _client.post(ApiConfig.authLogout);
    } finally {
      await _storage.clearSecure();
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.readSecure('jwt_token');
    return token != null && token.isNotEmpty;
  }

  Future<String?> getToken() async {
    return await _storage.readSecure('jwt_token');
  }
}
