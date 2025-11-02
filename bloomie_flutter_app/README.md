# Bloomie Flutter App

## 🎯 Tổng quan

Ứng dụng mobile cho hệ thống bán hoa Bloomie, được xây dựng bằng Flutter và kết nối với .NET API backend.

## ✅ Tính năng

- ✅ Đăng nhập / Đăng ký
- ✅ Xem danh sách sản phẩm
- ✅ Xem chi tiết sản phẩm
- ✅ Giỏ hàng
- ✅ Đặt hàng
- ✅ Xem đơn hàng
- ✅ Hồ sơ người dùng
- ✅ Tìm kiếm sản phẩm
- ✅ Yêu thích sản phẩm

## 📁 Cấu trúc dự án

```
lib/
├── config/          # Cấu hình API, constants, theme
├── models/          # Data models
├── services/        # API services
├── providers/       # State management (Provider)
├── screens/         # UI screens
├── widgets/         # Reusable widgets
├── utils/           # Utilities
└── main.dart        # Entry point
```

## 🚀 Cài đặt

### 1. Cài đặt Flutter

Tải và cài đặt Flutter từ: https://flutter.dev/docs/get-started/install

### 2. Clone project

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/bloomie_flutter_app
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Cấu hình API

Cập nhật base URL trong `lib/config/api_config.dart`:

```dart
// Với Android Emulator
static const String baseUrl = 'http://10.0.2.2:5187/api/v1';

// Với iOS Simulator
static const String baseUrl = 'http://localhost:5187/api/v1';

// Với Real Device (thay IP_CUA_MAY_TINH bằng IP thật)
static const String baseUrl = 'http://IP_CUA_MAY_TINH:5187/api/v1';
```

### 5. Chạy backend API

```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet run
```

Backend sẽ chạy tại: http://localhost:5187

### 6. Chạy Flutter app

```bash
flutter run
```

## 🔐 Tài khoản test

```
Email: admin@bloomie.com
Password: Admin@123
```

## 📱 Cấu hình Android

File: `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.INTERNET" />
<application android:usesCleartextTraffic="true">
```

## 🍎 Cấu hình iOS

File: `ios/Runner/Info.plist`

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## 🛠️ Build

### Android APK

```bash
flutter build apk --release
```

APK sẽ được tạo tại: `build/app/outputs/flutter-apk/app-release.apk`

### iOS

```bash
flutter build ios --release
```

## 📦 Dependencies chính

- **dio**: HTTP client
- **provider**: State management
- **flutter_secure_storage**: Lưu JWT token
- **shared_preferences**: Local storage
- **cached_network_image**: Cache images
- **intl**: Formatting (date, currency)

## 🐛 Troubleshooting

### Không kết nối được API

1. Kiểm tra backend đang chạy:
   ```bash
   curl http://localhost:5187/api/v1/products
   ```

2. Kiểm tra base URL trong `api_config.dart`

3. Với Android Emulator, dùng `10.0.2.2` thay vì `localhost`

4. Với real device, dùng IP máy tính:
   ```bash
   # macOS/Linux
   ifconfig | grep "inet "

   # Windows
   ipconfig
   ```

### CORS Error

Backend đã được cấu hình CORS. Nếu vẫn gặp lỗi, check [Program.cs](../Program.cs)

### Build Error

```bash
flutter clean
flutter pub get
flutter run
```

## 📚 Tài liệu

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dio Package](https://pub.dev/packages/dio)
- [Provider Package](https://pub.dev/packages/provider)
- [API Documentation](../Api/README.md)

## 👥 Team

Bloomie Development Team

## 📄 License

Private Project
