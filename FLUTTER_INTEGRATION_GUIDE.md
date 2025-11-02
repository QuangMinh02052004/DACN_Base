# Hướng dẫn tích hợp với Flutter/Dart

## Tổng quan

Backend API (.NET) của bạn đã sẵn sàng để tích hợp với Flutter mobile app. Guide này sẽ hướng dẫn:
1. Cách chạy backend API
2. Cấu hình network cho Flutter
3. Tạo API client trong Flutter
4. Code examples đầy đủ

---

## Phần 1: Chạy Backend API

### 1.1. Khởi động .NET Backend

```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet run
```

Backend sẽ chạy tại:
- **HTTP:** http://localhost:5187
- **HTTPS:** https://localhost:7187
- **Swagger UI:** http://localhost:5187/api/docs

### 1.2. Test API hoạt động

Mở trình duyệt: http://localhost:5187/api/docs

Hoặc test bằng curl:
```bash
curl http://localhost:5187/api/v1/products
```

### 1.3. Cấu hình CORS cho Flutter

Backend đã được cấu hình CORS trong [Program.cs](Program.cs), nhưng cần thêm origin cho mobile:

**Cập nhật [Program.cs](Program.cs):**

```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins", policy =>
    {
        policy.WithOrigins(
            "http://localhost:3000",       // React
            "http://localhost:5173",       // Vite
            "http://localhost:4200",       // Angular
            "http://10.0.2.2:5187",       // Android Emulator
            "http://localhost:5187"        // iOS Simulator
        )
        .AllowAnyMethod()
        .AllowAnyHeader()
        .AllowCredentials();
    });

    // Cho development, có thể dùng AllowAll
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});
```

**Lưu ý về địa chỉ:**
- **Android Emulator:** Sử dụng `10.0.2.2` thay vì `localhost`
- **iOS Simulator:** Có thể dùng `localhost`
- **Real Device:** Dùng IP máy tính (VD: `192.168.1.100`)

---

## Phần 2: Setup Flutter Project

### 2.1. Tạo Flutter Project

```bash
# Tạo project mới
flutter create bloomie_app
cd bloomie_app

# Hoặc mở project hiện có trong Android Studio
```

### 2.2. Thêm Dependencies vào pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter

  # HTTP client
  http: ^1.1.0
  dio: ^5.4.0  # Khuyến nghị: powerful HTTP client

  # State management
  provider: ^6.1.1  # Hoặc riverpod, bloc, getx

  # JSON serialization
  json_annotation: ^4.8.1

  # Secure storage cho JWT token
  flutter_secure_storage: ^9.0.0

  # Shared preferences
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
```

```bash
flutter pub get
```

### 2.3. Cấu hình Network Permissions

#### Android: android/app/src/main/AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Thêm permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:label="bloomie_app"
        android:usesCleartextTraffic="true">  <!-- Cho phép HTTP trong dev -->
        ...
    </application>
</manifest>
```

#### iOS: ios/Runner/Info.plist
```xml
<dict>
    <!-- Thêm cho HTTP connections -->
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</dict>
```

---

## Phần 3: Tạo API Client trong Flutter

### 3.1. Cấu trúc thư mục

```
lib/
├── main.dart
├── config/
│   └── api_config.dart
├── models/
│   ├── api_response.dart
│   ├── user.dart
│   ├── product.dart
│   └── order.dart
├── services/
│   ├── api_client.dart
│   ├── auth_service.dart
│   ├── product_service.dart
│   └── order_service.dart
├── providers/
│   └── auth_provider.dart
└── screens/
    ├── login_screen.dart
    ├── products_screen.dart
    └── product_detail_screen.dart
```

### 3.2. API Configuration

**lib/config/api_config.dart**
```dart
class ApiConfig {
  // Thay đổi base URL dựa trên môi trường
  static const String _baseUrlAndroid = 'http://10.0.2.2:5187/api/v1';
  static const String _baseUrlIOS = 'http://localhost:5187/api/v1';
  static const String _baseUrlRealDevice = 'http://192.168.1.100:5187/api/v1';

  // Chọn base URL
  static String get baseUrl {
    // Tự động detect platform
    return _baseUrlAndroid; // Thay đổi theo môi trường
  }

  // Endpoints
  static String get authLogin => '$baseUrl/auth/login';
  static String get authRegister => '$baseUrl/auth/register';
  static String get authMe => '$baseUrl/auth/me';

  static String get products => '$baseUrl/products';
  static String productDetail(int id) => '$baseUrl/products/$id';

  static String get orders => '$baseUrl/orders';
  static String orderDetail(int id) => '$baseUrl/orders/$id';

  static String get cart => '$baseUrl/cart';
  static String cartItem(int itemId) => '$baseUrl/cart/items/$itemId';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
```

### 3.3. Models

**lib/models/api_response.dart**
```dart
class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final List<String>? errors;
  final Map<String, dynamic>? meta;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.errors,
    this.meta,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      errors: json['errors'] != null
          ? List<String>.from(json['errors'])
          : null,
      meta: json['meta'],
    );
  }
}
```

**lib/models/user.dart**
```dart
class User {
  final String userId;
  final String userName;
  final String email;
  final String? fullName;
  final String? phoneNumber;
  final List<String> roles;

  User({
    required this.userId,
    required this.userName,
    required this.email,
    this.fullName,
    this.phoneNumber,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'roles': roles,
    };
  }
}

class AuthResponse {
  final bool success;
  final String? message;
  final String? token;
  final String? refreshToken;
  final DateTime? expiresAt;
  final User? user;

  AuthResponse({
    required this.success,
    this.message,
    this.token,
    this.refreshToken,
    this.expiresAt,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
```

**lib/models/product.dart**
```dart
class Product {
  final int productId;
  final String productName;
  final String? description;
  final double price;
  final double? discountedPrice;
  final int stockQuantity;
  final bool isAvailable;
  final String? categoryName;
  final String? primaryImage;
  final double? averageRating;
  final int totalRatings;

  Product({
    required this.productId,
    required this.productName,
    this.description,
    required this.price,
    this.discountedPrice,
    required this.stockQuantity,
    required this.isAvailable,
    this.categoryName,
    this.primaryImage,
    this.averageRating,
    required this.totalRatings,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      discountedPrice: json['discountedPrice'] != null
          ? (json['discountedPrice'] as num).toDouble()
          : null,
      stockQuantity: json['stockQuantity'],
      isAvailable: json['isAvailable'],
      categoryName: json['categoryName'],
      primaryImage: json['primaryImage'],
      averageRating: json['averageRating'] != null
          ? (json['averageRating'] as num).toDouble()
          : null,
      totalRatings: json['totalRatings'] ?? 0,
    );
  }

  double get displayPrice => discountedPrice ?? price;
}
```

### 3.4. API Client

**lib/services/api_client.dart**
```dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';

class ApiClient {
  late Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Thêm token vào header
          final token = await _storage.read(key: 'jwt_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('📤 REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('📥 RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) async {
          print('❌ ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}');

          // Handle 401 Unauthorized
          if (error.response?.statusCode == 401) {
            // Token expired, redirect to login
            await _storage.delete(key: 'jwt_token');
            // Có thể emit event hoặc navigate to login
          }

          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
  }) async {
    return await _dio.put(path, data: data);
  }

  // DELETE request
  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }

  // Save token
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  // Get token
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Clear token
  Future<void> clearToken() async {
    await _storage.delete(key: 'jwt_token');
  }
}
```

### 3.5. Auth Service

**lib/services/auth_service.dart**
```dart
import 'dart:convert';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  // Login
  Future<ApiResponse<AuthResponse>> login({
    required String userNameOrEmail,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/login',
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

      // Save token if login successful
      if (apiResponse.success && apiResponse.data?.token != null) {
        await _apiClient.saveToken(apiResponse.data!.token!);
      }

      return apiResponse;
    } on DioException catch (e) {
      return ApiResponse<AuthResponse>(
        success: false,
        message: e.message ?? 'Đã xảy ra lỗi',
        errors: [e.toString()],
      );
    }
  }

  // Register
  Future<ApiResponse<AuthResponse>> register({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    String? fullName,
    String? phoneNumber,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/register',
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

      // Save token if register successful
      if (apiResponse.success && apiResponse.data?.token != null) {
        await _apiClient.saveToken(apiResponse.data!.token!);
      }

      return apiResponse;
    } on DioException catch (e) {
      return ApiResponse<AuthResponse>(
        success: false,
        message: e.message ?? 'Đã xảy ra lỗi',
        errors: [e.toString()],
      );
    }
  }

  // Get current user
  Future<ApiResponse<User>> getCurrentUser() async {
    try {
      final response = await _apiClient.get('/auth/me');

      return ApiResponse<User>.fromJson(
        response.data,
        (json) => User.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<User>(
        success: false,
        message: e.message ?? 'Đã xảy ra lỗi',
      );
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout');
    } finally {
      await _apiClient.clearToken();
    }
  }

  // Check if logged in
  Future<bool> isLoggedIn() async {
    final token = await _apiClient.getToken();
    return token != null && token.isNotEmpty;
  }
}
```

### 3.6. Product Service

**lib/services/product_service.dart**
```dart
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/api_response.dart';
import '../models/product.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient _apiClient = ApiClient();

  // Get all products
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

      if (keyword != null) queryParams['keyword'] = keyword;
      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (minPrice != null) queryParams['minPrice'] = minPrice;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;

      final response = await _apiClient.get(
        '/products',
        queryParameters: queryParams,
      );

      return ApiResponse<List<Product>>.fromJson(
        response.data,
        (json) => (json as List).map((item) => Product.fromJson(item)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse<List<Product>>(
        success: false,
        message: e.message ?? 'Đã xảy ra lỗi',
      );
    }
  }

  // Get product detail
  Future<ApiResponse<Product>> getProductDetail(int productId) async {
    try {
      final response = await _apiClient.get('/products/$productId');

      return ApiResponse<Product>.fromJson(
        response.data,
        (json) => Product.fromJson(json),
      );
    } on DioException catch (e) {
      return ApiResponse<Product>(
        success: false,
        message: e.message ?? 'Đã xảy ra lỗi',
      );
    }
  }
}
```

---

## Phần 4: UI Examples

### 4.1. Login Screen

**lib/screens/login_screen.dart**
```dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _authService.login(
        userNameOrEmail: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (response.success && response.data?.token != null) {
        // Login thành công
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng nhập thành công!')),
          );

          // Navigate to home
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        // Login thất bại
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? 'Đăng nhập thất bại')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email hoặc Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email hoặc username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Đăng nhập'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

### 4.2. Products List Screen

**lib/screens/products_screen.dart**
```dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _productService = ProductService();

  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _productService.getProducts();

      if (response.success && response.data != null) {
        setState(() {
          _products = response.data!;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? 'Không thể tải sản phẩm';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProducts,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (_products.isEmpty) {
      return const Center(child: Text('Không có sản phẩm'));
    }

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return ProductCard(product: product);
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: product.primaryImage != null
            ? Image.network(
                product.primaryImage!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 60);
                },
              )
            : const Icon(Icons.image, size: 60),
        title: Text(product.productName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${product.displayPrice.toStringAsFixed(0)} đ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            if (product.averageRating != null)
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(' ${product.averageRating!.toStringAsFixed(1)}'),
                  Text(' (${product.totalRatings})'),
                ],
              ),
          ],
        ),
        trailing: product.isAvailable
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.cancel, color: Colors.red),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/product-detail',
            arguments: product.productId,
          );
        },
      ),
    );
  }
}
```

---

## Phần 5: Testing

### 5.1. Test với Account có sẵn

```dart
// Test login với admin account
final authService = AuthService();
final response = await authService.login(
  userNameOrEmail: 'admin@bloomie.com',
  password: 'Admin@123',
);

print('Login success: ${response.success}');
print('Token: ${response.data?.token}');
```

### 5.2. Kiểm tra kết nối

**Test trong main.dart:**
```dart
import 'package:flutter/material.dart';
import 'services/api_client.dart';
import 'config/api_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Test API connection
  await testApiConnection();

  runApp(const MyApp());
}

Future<void> testApiConnection() async {
  try {
    final client = ApiClient();
    final response = await client.get('/products');
    print('✅ API Connection successful!');
    print('📦 Products loaded: ${response.data}');
  } catch (e) {
    print('❌ API Connection failed: $e');
    print('🔧 Check if backend is running at: ${ApiConfig.baseUrl}');
  }
}
```

---

## Phần 6: Troubleshooting

### 6.1. Không kết nối được API

**Lỗi:** `SocketException: Failed to connect`

**Giải pháp:**
1. Kiểm tra backend đang chạy:
   ```bash
   curl http://localhost:5187/api/v1/products
   ```

2. Kiểm tra địa chỉ đúng:
   - Android Emulator: `http://10.0.2.2:5187`
   - iOS Simulator: `http://localhost:5187`
   - Real Device: `http://<YOUR_COMPUTER_IP>:5187`

3. Check firewall:
   ```bash
   # macOS: Cho phép incoming connections
   # Windows: Allow port 5187 in firewall
   ```

### 6.2. CORS Error

**Lỗi:** `CORS policy blocked`

**Giải pháp:**
Kiểm tra CORS trong [Program.cs](Program.cs) đã bao gồm origin của mobile app

### 6.3. 401 Unauthorized

**Nguyên nhân:** Token expired hoặc invalid

**Giải pháp:**
```dart
// Check token
final token = await ApiClient().getToken();
print('Current token: $token');

// Re-login
await authService.logout();
// Navigate to login screen
```

---

## Phần 7: Next Steps

### 7.1. State Management

Implement Provider/Riverpod/Bloc cho state management tốt hơn:

```dart
// Example with Provider
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    final response = await _authService.login(
      userNameOrEmail: email,
      password: password,
    );

    if (response.success) {
      _currentUser = response.data?.user;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
```

### 7.2. Offline Support

Implement caching với `hive` hoặc `sqflite`

### 7.3. Push Notifications

Tích hợp Firebase Cloud Messaging

---

## Tóm tắt

✅ **Backend đã sẵn sàng** - Chạy với `dotnet run`

✅ **Flutter setup hoàn chỉnh** - Copy code examples và chạy

✅ **API Client đã có** - Sử dụng Dio với JWT authentication

✅ **Models & Services** - Đầy đủ cho Auth, Products, Orders

### Các bước tiếp theo:

1. ✅ Chạy backend: `dotnet run`
2. ✅ Tạo Flutter project
3. ✅ Copy code examples vào project
4. ✅ Update base URL trong `api_config.dart`
5. ✅ Test login với admin account
6. ✅ Build & run app

**Happy coding! 🚀**
