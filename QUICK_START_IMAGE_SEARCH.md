# 🚀 Quick Start - Image Search Feature

## 3 Bước để chạy Image Search

### Bước 1: Khởi động Flask API (Terminal 1)

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
./start_api.sh
```

**Đợi đến khi thấy:**
```
Server starting on http://0.0.0.0:8000
 * Running on http://0.0.0.0:8000
```

---

### Bước 2: Khởi động ASP.NET Core (Terminal 2)

```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet run
```

**Đợi đến khi thấy:**
```
Now listening on: http://localhost:5187
```

---

### Bước 3: Test hệ thống (Terminal 3)

```bash
cd /Users/lequangminh/Documents/DACN_Base-3
./test-image-search.sh
```

**Nếu tất cả đều ✓ (green checkmark), bạn đã sẵn sàng!**

---

## Cách sử dụng trên Website

### Option 1: Upload ảnh có sẵn

1. Mở http://localhost:5187
2. Click vào ô **tìm kiếm** ở header
3. Click icon **📷 camera**
4. Click **"Chọn ảnh"** hoặc **"Upload"**
5. Chọn ảnh hoa từ máy tính
6. Đợi 3-5 giây → Tự động chuyển đến kết quả

### Option 2: Chụp ảnh từ camera

1. Mở http://localhost:5187
2. Click vào ô **tìm kiếm** ở header
3. Click icon **📷 camera**
4. Click **"Mở camera"**
5. Cho phép truy cập camera
6. Chụp ảnh hoa
7. Click **"Gửi"**
8. Đợi 3-5 giây → Tự động chuyển đến kết quả

---

## ❌ Troubleshooting nhanh

### Lỗi: Flask API không kết nối

```bash
# Check xem Flask có chạy không
curl http://localhost:8000/health

# Nếu không, restart Flask
cd project_flowers
./start_api.sh
```

### Lỗi: "Không thể phân tích ảnh"

**Nguyên nhân:** Flask API chưa chạy hoặc bị crash

**Giải pháp:**
1. Check Terminal 1 xem có lỗi không
2. Restart Flask API
3. Thử lại

### Lỗi: Camera không hoạt động

**Nguyên nhân:** Browser chặn truy cập camera

**Giải pháp:**
1. Cho phép camera trong browser settings
2. Dùng Chrome hoặc Edge (recommended)
3. Hoặc dùng option Upload thay vì Camera

### Lỗi: File quá lớn

**Giải pháp:** Chọn ảnh nhỏ hơn 5MB

---

## 📊 Kiểm tra logs

### Flask API logs:
- Xem Terminal 1 (đang chạy Flask)
- Mỗi request sẽ hiển thị prediction result

### ASP.NET Core logs:
- Xem Terminal 2 (đang chạy dotnet run)
- Có thể thấy HTTP requests

### Browser logs:
- Press **F12** → Tab **Console**
- Xem JavaScript errors nếu có

---

## ✅ Checklist đảm bảo mọi thứ hoạt động

- [ ] Flask API chạy (port 8000)
- [ ] ASP.NET Core chạy (port 5187)
- [ ] test-image-search.sh tất cả đều ✓
- [ ] Có thể mở website http://localhost:5187
- [ ] Thấy icon 📷 trong search bar
- [ ] Click vào icon → modal mở ra
- [ ] Upload ảnh → tự động redirect đến kết quả

---

## 🎯 Kết quả mong đợi

Sau khi upload/chụp ảnh hoa:

1. **Modal phân tích** hiện lên 2-3 giây
2. **Tự động redirect** đến `/Product/Index?colors=...&presentations=...`
3. **Hiển thị sản phẩm** với màu sắc phù hợp
4. **Top 3 predictions** được log ra console (F12)

---

## 📚 Tài liệu chi tiết

- [SETUP_IMAGE_SEARCH.md](SETUP_IMAGE_SEARCH.md) - Hướng dẫn đầy đủ
- [project_flowers/README.md](project_flowers/README.md) - Tài liệu Flask API
- [IMAGE_SEARCH_SETUP.md](IMAGE_SEARCH_SETUP.md) - Kiến trúc hệ thống

---

## 🆘 Cần trợ giúp?

1. Chạy test script: `./test-image-search.sh`
2. Check logs của cả 3 terminals
3. Xem Browser Console (F12)
4. Đọc phần Troubleshooting trong SETUP_IMAGE_SEARCH.md
