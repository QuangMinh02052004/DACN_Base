# HƯỚNG DẪN SỬ DỤNG HỆ THỐNG TÌM KIẾM HOA BẰNG HÌNH ẢNH

## ✅ TRẠNG THÁI HỆ THỐNG

**Cả 2 API đã đang chạy thành công:**

### 1. C# API (Website Bloomie)
- **URL**: http://localhost:5000
- **PID**: 51144
- **Status**: ✅ Running
- **Database**: Bloomie (SQL Server)

### 2. Python Image Similarity API
- **URL**: http://localhost:8000
- **Status**: ✅ Healthy
- **Products loaded**: 236 sản phẩm
- **Model**: ResNet50 (2048-dimensional features)
- **Algorithm**: Cosine Similarity

---

## 🎯 CÁCH SỬ DỤNG TRÊN GIAO DIỆN WEB

### BƯỚC 1: Truy cập website
Mở trình duyệt và truy cập: **http://localhost:5000**

### BƯỚC 2: Tìm nút Camera
Trong thanh tìm kiếm ở header (góc trên phải), bạn sẽ thấy:
- 🔍 Icon kính lúp (tìm kiếm bằng text)
- 📷 **Icon camera (tìm kiếm bằng hình ảnh)** ← Click vào đây!

### BƯỚC 3: Upload ảnh
Sau khi click icon camera:
1. Chọn ảnh từ máy tính của bạn
2. Hoặc chụp ảnh trực tiếp (nếu có webcam)

### BƯỚC 4: Xem kết quả
Hệ thống sẽ tự động:
- Phân tích hình ảnh bằng AI (ResNet50)
- Tìm các sản phẩm hoa tương tự
- Hiển thị danh sách kết quả với độ tương đồng cao nhất

---

## 🔧 TEST TRỰC TIẾP BẰNG COMMAND LINE

Nếu bạn muốn test API trực tiếp:

```bash
# Test với một ảnh mẫu
curl -X POST \
  -F "file=@wwwroot/images/02c5cff4-a5fb-4b8f-b71d-e4abc5c4da97.jpg" \
  -F "top_k=10" \
  http://localhost:8000/search/similar
```

Kết quả sẽ trả về JSON với:
- `product_id`: ID sản phẩm
- `image_url`: Đường dẫn ảnh
- `similarity_score`: Độ tương đồng (0-1, càng gần 1 càng giống)
- `product_name`: Tên sản phẩm
- `product_price`: Giá sản phẩm

---

## 📊 KIỂM TRA HEALTH

### Check Python API:
```bash
curl http://localhost:8000/health
```

Kết quả mong đợi:
```json
{
    "status": "healthy",
    "model_loaded": true,
    "database_loaded": true,
    "total_products": 236,
    "feature_dimension": 2048
}
```

### Check C# API:
Truy cập: http://localhost:5000

---

## 🚀 KHỞI ĐỘNG LẠI HỆ THỐNG (NẾU CẦN)

### Khởi động C# API:
```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet bin/Debug/net8.0/Bloomie.dll
```

### Khởi động Python API:
```bash
cd /Users/lequangminh/Documents/DACN_Base-3/image_similarity_api
python3 app.py
```

---

## ⚙️ CẬP NHẬT FEATURES TỪ DATABASE

**Lưu ý**: Hiện tại hệ thống đang sử dụng 236 sản phẩm từ thư mục `wwwroot/images/`.

Nếu bạn muốn cập nhật features từ database (sau khi import SQL đầy đủ):

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/image_similarity_api
python3 precompute_features.py
```

Script này sẽ:
1. Gọi API `GET http://localhost:5000/api/products`
2. Tải ảnh từ các sản phẩm trong database
3. Extract features bằng ResNet50
4. Lưu vào `features_database/`

**Sau đó restart Python API:**
```bash
pkill -f "python3.*app.py"
cd image_similarity_api
nohup python3 app.py > api_log.txt 2>&1 &
```

---

## 📝 LƯU Ý QUAN TRỌNG

### 1. Về Database
API endpoint `/api/products` hiện trả về 0 products vì:
- Products trong database có `IsActive = false`, HOẶC
- `ImageUrl` bị NULL hoặc rỗng

Tuy nhiên, hệ thống vẫn hoạt động tốt với 236 products đã được precompute.

### 2. Về Port
- C# API: Port **5000** (không phải 5187)
- Python API: Port **8000**

### 3. Về Tính năng
Tìm kiếm bằng hình ảnh sử dụng:
- **Deep Learning**: ResNet50 pre-trained trên ImageNet
- **Feature Extraction**: 2048-dimensional vectors
- **Similarity Search**: Cosine similarity
- **Performance**: Tìm kiếm trong 236 products trong vài milliseconds

---

## 🎨 DEMO FEATURES

Hệ thống có thể tìm sản phẩm tương tự dựa trên:
- Màu sắc hoa
- Hình dạng bó hoa
- Cách bố cục và sắp xếp
- Phong cách tổng thể

Ví dụ: Upload ảnh hoa hồng đỏ → Hệ thống sẽ tìm các bó hoa hồng đỏ tương tự khác.

---

## 🆘 TROUBLESHOOTING

### API không chạy?
```bash
# Check process
ps aux | grep -i dotnet
ps aux | grep -i python3

# Check ports
lsof -i:5000
lsof -i:8000
```

### Lỗi khi search?
- Kiểm tra xem Python API có healthy không: `curl http://localhost:8000/health`
- Xem logs: `tail -50 image_similarity_api/api_log.txt`

### Website không load?
- Kiểm tra C# API logs: `tail -50 csharp_api_final.txt`
- Verify database connection trong `appsettings.json`

---

## 📞 LIÊN HỆ

Nếu có vấn đề, check logs:
- C# API: `csharp_api_final.txt`
- Python API: `image_similarity_api/api_log.txt`

---

**Chúc bạn sử dụng hệ thống hiệu quả! 🌸🔍**
