# 🌸 Bloomie - Image Search Quick Start

## 🚀 Khởi Động Nhanh (3 Bước)

### 1️⃣ Khởi động Python API
```bash
./START_IMAGE_SEARCH.sh
```

### 2️⃣ Khởi động ASP.NET (Terminal mới)
```bash
dotnet run
```

### 3️⃣ Truy cập website
Mở browser: **http://localhost:5187**

---

## 🎯 Cách Sử Dụng

1. Click icon **📤** (Upload) hoặc **📷** (Camera) trong thanh tìm kiếm
2. Chọn/chụp ảnh hoa
3. Hệ thống tự động nhận dạng và hiển thị sản phẩm

---

## ⚠️ Khắc Phục Lỗi Nhanh

### Lỗi "Failed to fetch"
```bash
# Kiểm tra Python API
curl http://localhost:8000/health

# Nếu không phản hồi:
cd project_flowers && python3 app.py
```

### Dừng hệ thống
```bash
./STOP_IMAGE_SEARCH.sh
```

---

## 📚 Tài Liệu Chi Tiết

Xem file: **[HUONG_DAN_TIM_KIEM_HINH_ANH.md](./HUONG_DAN_TIM_KIEM_HINH_ANH.md)**

---

## ✅ Checklist

- [x] Python API chạy trên port 8000
- [x] ASP.NET app chạy trên port 5187
- [x] Model `oxford102_m2_optimized.h5` tồn tại
- [x] Dependencies: flask, tensorflow, numpy, pillow

---

**Tạo bởi:** Claude Code | **Ngày:** 24/10/2025
