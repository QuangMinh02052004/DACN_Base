# Flutter Quick Start - Bloomie API

## Bước 1: Chạy Backend (5 phút)

```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet run
```

**Kiểm tra backend đang chạy:**
- Mở: http://localhost:5187/api/docs
- Hoặc test: `curl http://localhost:5187/api/v1/products`

---

## Bước 2: Tạo Flutter Project (2 phút)

```bash
flutter create bloomie_app
cd bloomie_app
```

---

## Bước 3: Cài Dependencies (3 phút)

**Thêm vào `pubspec.yaml`:**
```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0
  flutter_secure_storage: ^9.0.0
  provider: ^6.1.1
```

```bash
flutter pub get
```

---

## Bước 4: Cấu hình Permissions (2 phút)

### Android: `android/app/src/main/AndroidManifest.xml`
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />

    <application
        android:usesCleartextTraffic="true">
        ...
    </application>
</manifest>
```

### iOS: `ios/Runner/Info.plist`
```xml
<dict>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</dict>
```

---

## Bước 5: Copy Code (5 phút)

### 5.1. Tạo file `lib/config/api_config.dart`:
```dart
class ApiConfig {
  // Thay đổi theo môi trường của bạn:
  // - Android Emulator: 'http://10.0.2.2:5187/api/v1'
  // - iOS Simulator: 'http://localhost:5187/api/v1'
  // - Real Device: 'http://192.168.1.X:5187/api/v1' (thay X = IP máy tính)

  static const String baseUrl = 'http://10.0.2.2:5187/api/v1';  // Android

  static const Duration timeout = Duration(seconds: 30);
}
```

### 5.2. Tạo file `lib/services/api_client.dart`:
```dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio _dio;
  final _storage = const FlutterSecureStorage();

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.timeout,
      receiveTimeout: ApiConfig.timeout,
    ));

    // Auto-add JWT token to requests
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'jwt_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Dio get dio => _dio;

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'jwt_token');
  }
}
```

### 5.3. Tạo file `lib/services/auth_service.dart`:
```dart
import 'api_client.dart';

class AuthService {
  final _client = ApiClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _client.dio.post('/auth/login', data: {
        'userNameOrEmail': email,
        'password': password,
      });

      if (response.data['success'] == true) {
        final token = response.data['data']['token'];
        await _client.saveToken(token);
      }

      return response.data;
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<void> logout() async {
    await _client.clearToken();
  }
}
```

---

## Bước 6: Test Login (5 phút)

### Tạo file `lib/screens/login_screen.dart`:
```dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    final result = await _authService.login(
      _emailController.text,
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (result['success'] == true) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng nhập thành công!')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Đăng nhập thất bại')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
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
    );
  }
}
```

### Update `lib/main.dart`:
```dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloomie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
```

---

## Bước 7: Chạy App (1 phút)

```bash
# Android
flutter run

# Hoặc chọn device trong Android Studio
```

---

## Bước 8: Test Login

**Sử dụng admin account có sẵn:**
- **Email:** `admin@bloomie.com`
- **Password:** `Admin@123`

---

## ⚠️ Lưu ý quan trọng

### Base URL theo thiết bị:

| Thiết bị | Base URL |
|----------|----------|
| **Android Emulator** | `http://10.0.2.2:5187/api/v1` |
| **iOS Simulator** | `http://localhost:5187/api/v1` |
| **Real Device** | `http://192.168.1.X:5187/api/v1` |

**Lấy IP máy tính:**
```bash
# macOS/Linux
ifconfig | grep "inet "

# Windows
ipconfig
```

### Kiểm tra kết nối:

```dart
// Test trong main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Test connection
  final dio = Dio();
  try {
    final response = await dio.get('http://10.0.2.2:5187/api/v1/products');
    print('✅ Connected! Products: ${response.data}');
  } catch (e) {
    print('❌ Connection failed: $e');
  }

  runApp(const MyApp());
}
```

---

## 🐛 Troubleshooting nhanh

### Lỗi: SocketException
**Giải pháp:**
1. Kiểm tra backend đang chạy: `dotnet run`
2. Kiểm tra base URL đúng với thiết bị
3. Kiểm tra firewall cho phép port 5187

### Lỗi: CORS
**Giải pháp:**
Backend đã config CORS sẵn trong [Program.cs](Program.cs)

### Lỗi: 401 Unauthorized
**Giải pháp:**
Login lại để lấy token mới

---

## 📚 Tài liệu đầy đủ

Xem guide chi tiết tại: [FLUTTER_INTEGRATION_GUIDE.md](FLUTTER_INTEGRATION_GUIDE.md)

---

## 🎯 Tóm tắt

✅ **Backend:** `dotnet run` → http://localhost:5187

✅ **Flutter:** Tạo project → Add dependencies → Copy code → Run

✅ **Test:** Login với `admin@bloomie.com` / `Admin@123`

✅ **Next:** Xem [FLUTTER_INTEGRATION_GUIDE.md](FLUTTER_INTEGRATION_GUIDE.md) để implement thêm Products, Orders, Cart

**Thời gian tổng:** ~25 phút để có app login hoạt động! 🚀
