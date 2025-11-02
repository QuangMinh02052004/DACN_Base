# 🚀 Hướng dẫn chạy dự án Bloomie (Backend + Flutter App)

## 📋 Tổng quan

Dự án Bloomie gồm 2 phần:
1. **Backend API** - .NET 8.0 Web API
2. **Mobile App** - Flutter (Android/iOS)

---

## PHẦN 1: Chạy Backend API (.NET)

### Bước 1: Chạy Backend

```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet run
```

**Backend sẽ chạy tại:**
- HTTP: http://localhost:5187
- Swagger UI: http://localhost:5187/api/docs

### Tài khoản test:
```
Email: admin@bloomie.com
Password: Admin@123
```

---

## PHẦN 2: Chạy Flutter Mobile App

### Bước 1: Install dependencies

```bash
cd bloomie_flutter_app
flutter pub get
```

### Bước 2: Cấu hình base URL

Mở `lib/config/api_config.dart`:

- Android Emulator: `http://10.0.2.2:5187/api/v1`
- iOS Simulator: `http://localhost:5187/api/v1`
- Real Device: `http://YOUR_COMPUTER_IP:5187/api/v1`

### Bước 3: Chạy app

```bash
flutter run
```

---

## 🐛 Troubleshooting

### Backend không chạy
```bash
lsof -ti:5187 | xargs kill -9
dotnet run
```

### App không kết nối API
1. Check backend đang chạy
2. Với Android Emulator: DÙNG `10.0.2.2` không dùng `localhost`
3. Với real device: Cùng WiFi + dùng IP máy tính

---

## 📚 Tài liệu chi tiết

1. **API_SETUP_SUMMARY.md** - Backend API guide
2. **FLUTTER_INTEGRATION_GUIDE.md** - Flutter integration  
3. **FLUTTER_QUICK_START.md** - Quick start

**Chúc code vui vẻ! 🚀**
