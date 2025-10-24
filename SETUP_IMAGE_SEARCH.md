# Hướng dẫn setup và áp dụng Image Search vào dự án Bloomie

## Tổng quan
Chức năng Image Search cho phép người dùng tìm kiếm sản phẩm hoa bằng cách:
1. Chụp ảnh trực tiếp từ camera
2. Tải ảnh lên từ thiết bị

Hệ thống sử dụng AI model (Oxford Flowers 102) để nhận dạng loài hoa và đề xuất sản phẩm phù hợp.

## Kiến trúc hệ thống

```
Frontend (JavaScript) → ASP.NET Core (C#) → Flask API (Python) → TensorFlow Model
        ↓                      ↓                    ↓                    ↓
   Camera/Upload      ImageSearchService    Model Prediction      102 Flower Classes
        ↓                      ↓                    ↓                    ↓
   FormData POST        HTTP Request         AI Analysis         Vietnamese Names
        ↓                      ↓                    ↓                    ↓
   Analysis Modal      Process Response      JSON Response       Redirect to Results
```

## Bước 1: Kiểm tra Backend đã sẵn sàng

### 1.1 Kiểm tra ImageSearchService
File: `Services/Implementations/ImageSearchService.cs`
- ✅ Đã có
- ✅ Có method AnalyzeImageAsync
- ✅ Mapping 102 loài hoa tiếng Việt

### 1.2 Kiểm tra ProductController
File: `Controllers/ProductController.cs`
- ✅ Đã có endpoint ImageSearch (line 1208)
- ✅ Đã inject IImageSearchService (line 42-50)

### 1.3 Kiểm tra Program.cs
File: `Program.cs`
- ✅ Đã register IImageSearchService (line 137)
- ✅ Đã setup HttpClient (line 140)

### 1.4 Kiểm tra appsettings.json
File: `appsettings.json`
- ✅ Đã có config ImageSearch.PythonApiUrl (line 32-34)
- ✅ URL: http://localhost:8000

## Bước 2: Sửa lỗi Frontend

### Vấn đề phát hiện:
Trong `Views/Shared/_Layout.cshtml` line 1478, có lỗi `formData` không được định nghĩa.

### Cách sửa:
Tôi sẽ tạo file JavaScript riêng để dễ quản lý.

## Bước 3: Khởi động Python Flask API

### 3.1 Mở Terminal và chạy:

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
./start_api.sh
```

Hoặc chạy thủ công:

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers

# Tạo virtual environment (nếu chưa có)
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Cài đặt dependencies
pip install -r requirements.txt

# Khởi động Flask API
python app.py
```

**Kết quả mong đợi:**
```
============================================================
Starting Oxford Flowers Recognition API
============================================================
Model file: oxford102_m2_optimized.h5
Number of flower classes: 102
API Endpoints:
  - GET  /health - Health check
  - POST /predict - Main prediction endpoint
  - POST /search-by-image - Alternative search endpoint
Server starting on http://0.0.0.0:8000
============================================================
 * Running on http://0.0.0.0:8000
```

### 3.2 Test Flask API (Terminal khác):

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers

# Test health check
curl http://localhost:8000/health

# Test với ảnh
python test_api.py
```

## Bước 4: Khởi động ASP.NET Core Application

### 4.1 Mở Terminal mới và chạy:

```bash
cd /Users/lequangminh/Documents/DACN_Base-3

# Build project
dotnet build

# Run application
dotnet run
```

**Kết quả mong đợi:**
```
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: http://localhost:5187
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
```

## Bước 5: Test End-to-End

### 5.1 Mở browser: http://localhost:5187

### 5.2 Test Image Search:

**Option 1: Upload ảnh**
1. Click vào ô search
2. Click icon "📷" (camera)
3. Chọn "Upload Image"
4. Select file ảnh hoa
5. Đợi phân tích (3-5 giây)
6. Tự động redirect đến trang kết quả

**Option 2: Chụp ảnh từ camera**
1. Click vào ô search
2. Click icon "📷" (camera)
3. Click "Open Camera"
4. Cho phép truy cập camera
5. Click "Capture"
6. Click "Submit"
7. Đợi phân tích
8. Tự động redirect đến trang kết quả

## Bước 6: Troubleshooting

### Lỗi 1: Python API không kết nối được

**Triệu chứng:**
- Console log: "Không thể kết nối đến dịch vụ phân tích ảnh"

**Giải pháp:**
```bash
# Kiểm tra Flask API có đang chạy không
curl http://localhost:8000/health

# Nếu không chạy, start lại
cd project_flowers
./start_api.sh
```

### Lỗi 2: CSRF Token validation failed

**Triệu chứng:**
- HTTP 400 Bad Request
- "The antiforgery token could not be validated"

**Giải pháp:**
- Đã được fix trong file JavaScript mới
- Đảm bảo `ValidateAntiForgeryToken` attribute được thêm vào ProductController

### Lỗi 3: File quá lớn

**Triệu chứng:**
- "Ảnh quá lớn (tối đa 5MB)"

**Giải pháp:**
- Resize ảnh trước khi upload
- Hoặc tăng limit trong `RequestSizeLimit` attribute

### Lỗi 4: Camera không hoạt động

**Triệu chứng:**
- "Không thể truy cập camera"

**Giải pháp:**
1. Kiểm tra browser permissions
2. Đảm bảo đang dùng HTTPS hoặc localhost
3. Thử browser khác (Chrome, Edge recommended)

### Lỗi 5: Model không tìm thấy

**Triệu chứng:**
- Flask API crash khi start
- "Failed to load model: No such file"

**Giải pháp:**
```bash
# Kiểm tra file model có tồn tại không
ls -lh project_flowers/oxford102_m2_optimized.h5

# Nếu không có, cần download model từ source
```

## Bước 7: Monitoring và Logging

### 7.1 Python Flask API Logs:
- Console sẽ hiển thị mỗi request
- Format: `[timestamp] - level - message`

### 7.2 ASP.NET Core Logs:
- Check console output
- Check Application Insights (nếu có)

### 7.3 Browser Console:
- F12 → Console tab
- Xem logs của JavaScript

## Kiểm tra hoàn chỉnh

- [ ] Flask API chạy trên port 8000
- [ ] ASP.NET Core chạy trên port 5187
- [ ] Có thể upload ảnh và nhận kết quả
- [ ] Có thể chụp ảnh từ camera và nhận kết quả
- [ ] Redirect đến trang kết quả tìm kiếm với filter đúng
- [ ] Hiển thị sản phẩm phù hợp với màu sắc nhận dạng được

## Tính năng nâng cao (Optional)

### 1. Cache predictions
- Lưu kết quả nhận dạng để tránh gọi API nhiều lần cho cùng ảnh

### 2. Batch processing
- Xử lý nhiều ảnh cùng lúc

### 3. Fine-tune model
- Train lại model với dataset riêng của bạn

### 4. Performance optimization
- Sử dụng GPU cho inference
- Optimize model size (quantization)

## Support

Nếu gặp vấn đề:
1. Kiểm tra logs của cả 3 thành phần (Frontend, Backend, Python API)
2. Xem file IMAGE_SEARCH_SETUP.md trong project_flowers
3. Chạy test script: `python test_api.py`
