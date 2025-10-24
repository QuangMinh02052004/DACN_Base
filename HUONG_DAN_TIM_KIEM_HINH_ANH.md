# 🌸 Hướng Dẫn Chức Năng Tìm Kiếm Hình Ảnh - Bloomie

## 📋 Tổng Quan

Hệ thống tìm kiếm hình ảnh cho phép người dùng upload hoặc chụp ảnh hoa để tìm kiếm sản phẩm tương tự.

### Kiến Trúc Hệ Thống

```
┌─────────────────┐        ┌──────────────────┐        ┌─────────────────┐
│   Web Browser   │◄──────►│   ASP.NET Core   │◄──────►│  Python API     │
│  (localhost:    │        │  (localhost:5187)│        │ (localhost:8000)│
│     5187)       │        │                  │        │                 │
└─────────────────┘        └──────────────────┘        └─────────────────┘
        ▲                           ▲                           ▲
        │                           │                           │
     Upload ảnh              ImageSearchService      Oxford Flowers Model
                                                      (TensorFlow/Keras)
```

## 🚀 Cách Khởi Động

### Phương Pháp 1: Sử Dụng Script (Đơn Giản Nhất)

```bash
# Khởi động Python API
./START_IMAGE_SEARCH.sh

# Mở terminal mới và khởi động ASP.NET
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet run
```

### Phương Pháp 2: Thủ Công

**Bước 1: Khởi động Python API Server**

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
python3 app.py
```

Server sẽ chạy trên: `http://localhost:8000`

**Bước 2: Khởi động ASP.NET Application**

```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet run
```

Website sẽ chạy trên: `http://localhost:5187`

## ✅ Kiểm Tra Hệ Thống

### 1. Kiểm tra Python API

```bash
# Health check
curl http://localhost:8000/health

# Kết quả mong đợi:
{
  "status": "healthy",
  "model": "Oxford102_m2_optimized"
}
```

### 2. Test phân tích ảnh

```bash
# Upload ảnh test
curl -X POST http://localhost:8000/predict \
  -F "image=@path/to/flower.jpg"

# Kết quả mong đợi:
{
  "success": true,
  "predictions": [
    {
      "className": "Hoa Hồng",
      "confidence": 0.85,
      "englishName": "rose"
    }
  ]
}
```

## 🌐 Sử Dụng Trên Website

### Upload Ảnh

1. Truy cập trang chủ: `http://localhost:5187`
2. Tìm thanh tìm kiếm ở header
3. Click icon **📤 Upload** (bên cạnh icon search)
4. Chọn ảnh hoa từ máy tính
5. Hệ thống sẽ tự động:
   - Phân tích ảnh
   - Nhận dạng loại hoa
   - Tìm sản phẩm phù hợp
   - Chuyển hướng đến trang kết quả

### Chụp Ảnh Bằng Camera

1. Click icon **📷 Camera** trong thanh tìm kiếm
2. Cho phép truy cập camera
3. Chụp ảnh hoa
4. Hệ thống sẽ phân tích và hiển thị kết quả

## 🔧 Xử Lý Lỗi Thường Gặp

### Lỗi: "Failed to fetch"

**Nguyên nhân:** Python API chưa chạy

**Giải pháp:**
```bash
# Kiểm tra Python API
curl http://localhost:8000/health

# Nếu không phản hồi, khởi động lại
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
python3 app.py
```

### Lỗi: "Address already in use"

**Nguyên nhân:** Port 8000 đang được sử dụng

**Giải pháp:**
```bash
# Dừng process cũ
./STOP_IMAGE_SEARCH.sh

# Hoặc thủ công
kill $(lsof -ti:8000)

# Khởi động lại
./START_IMAGE_SEARCH.sh
```

### Lỗi: Model không tải được

**Nguyên nhân:** Thiếu file model hoặc dependencies

**Giải pháp:**
```bash
# Kiểm tra file model
ls -lh project_flowers/oxford102_m2_optimized.h5

# Cài đặt dependencies
cd project_flowers
pip3 install flask flask-cors tensorflow numpy pillow
```

### Lỗi: CORS Policy

**Nguyên nhân:** Frontend và backend trên domain khác nhau

**Giải pháp:** Đã được xử lý trong code (flask-cors), không cần làm gì

## 📊 API Endpoints

### Python API (Port 8000)

| Endpoint | Method | Mô Tả | Body |
|----------|--------|-------|------|
| `/health` | GET | Kiểm tra trạng thái | - |
| `/predict` | POST | Phân tích hình ảnh | `image` (file) |
| `/search-by-image` | POST | Tìm kiếm bằng ảnh | `imageFile` (file) |

### C# API (Port 5187)

| Endpoint | Method | Mô Tả | Body |
|----------|--------|-------|------|
| `/Product/ImageSearch` | POST | Upload và phân tích | `imageFile` (IFormFile) |
| `/Product/ImageSearchResults` | GET | Hiển thị kết quả | `colors`, `presentations` |

## 🗂️ Cấu Trúc File

```
DACN_Base-3/
├── project_flowers/
│   ├── app.py                          # Python API server
│   ├── oxford102_m2_optimized.h5       # Model nhận dạng hoa
│   └── test_image_gui.py               # GUI test tool
├── Services/
│   ├── Interfaces/
│   │   └── IImageSearchService.cs
│   └── Implementations/
│       └── ImageSearchService.cs       # Service xử lý ảnh
├── Controllers/
│   └── ProductController.cs            # Controller xử lý request
├── Views/
│   ├── Shared/
│   │   └── _Layout.cshtml              # Header với search box
│   └── Product/
│       └── ImageSearchResults.cshtml   # Trang kết quả
├── appsettings.json                    # Cấu hình (Python API URL)
├── START_IMAGE_SEARCH.sh               # Script khởi động
├── STOP_IMAGE_SEARCH.sh                # Script dừng
└── HUONG_DAN_TIM_KIEM_HINH_ANH.md     # File này
```

## 🔍 Model Nhận Dạng

### Oxford Flowers 102 Dataset

- **Tên model:** `oxford102_m2_optimized.h5`
- **Framework:** TensorFlow/Keras
- **Số lượng loại hoa:** 102 loại
- **Input size:** 224x224 RGB
- **Output:** Top 3 predictions với confidence score

### Các Loại Hoa Được Hỗ Trợ

Một số loại hoa phổ biến:
- Hoa Hồng (Rose)
- Hoa Hướng Dương (Sunflower)
- Hoa Cẩm Chướng (Carnation)
- Hoa Tulip (Tulip)
- Hoa Lily (Lily)
- Hoa Lan (Orchid)
- Hoa Cúc (Daisy)
- ... và 95 loại khác

## 🛠️ Maintenance

### Xem Log Python API

```bash
# Realtime log
tail -f /tmp/bloomie_api.log

# Hoặc nếu chạy ở foreground
cd project_flowers
python3 app.py
```

### Dừng Hệ Thống

```bash
# Dừng Python API
./STOP_IMAGE_SEARCH.sh

# Dừng ASP.NET (Ctrl+C trong terminal đang chạy dotnet run)
```

### Khởi động lại toàn bộ

```bash
# Dừng tất cả
./STOP_IMAGE_SEARCH.sh
# Ctrl+C để dừng ASP.NET

# Khởi động lại
./START_IMAGE_SEARCH.sh
dotnet run
```

## 📝 Cấu Hình

### appsettings.json

```json
{
  "ImageSearch": {
    "PythonApiUrl": "http://localhost:8000"
  }
}
```

Để thay đổi port hoặc host của Python API, sửa giá trị `PythonApiUrl`.

### app.py

Để thay đổi port Python API:

```python
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
```

Thay `8000` thành port mong muốn (nhớ cập nhật `appsettings.json` tương ứng).

## 🐛 Debug

### Bật debug mode

**Python API:**
```python
# app.py, dòng cuối
app.run(host="0.0.0.0", port=8000, debug=True)  # debug=True
```

**ASP.NET:**
```bash
# Đã mặc định ở Development mode
dotnet run --environment=Development
```

### Check console logs

- **Browser:** F12 → Console tab
- **Python API:** Terminal đang chạy `python3 app.py`
- **ASP.NET:** Terminal đang chạy `dotnet run`

## 📞 Liên Hệ / Hỗ Trợ

Nếu gặp vấn đề, kiểm tra:
1. Python API có đang chạy không: `curl http://localhost:8000/health`
2. File model có tồn tại không: `ls -lh project_flowers/oxford102_m2_optimized.h5`
3. Dependencies đã cài đủ chưa: `pip3 list | grep -E "flask|tensorflow"`
4. Browser console có báo lỗi gì không

## ✨ Tính Năng Nâng Cao (Tương Lai)

- [ ] Cache kết quả phân tích
- [ ] Batch processing nhiều ảnh
- [ ] Tích hợp visual search (tìm theo màu sắc, hình dáng)
- [ ] Export kết quả dưới dạng PDF
- [ ] So sánh nhiều ảnh cùng lúc

---

**Phiên bản:** 1.0
**Cập nhật lần cuối:** 24/10/2025
**Tạo bởi:** Claude Code
