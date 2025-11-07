# HƯỚNG DẪN IMPORT SQL VÀ CẬP NHẬT HỆ THỐNG

## 🎯 MỤC TIÊU
Import dữ liệu từ file "Bloomie (1).sql" vào database và cập nhật hệ thống tìm kiếm bằng hình ảnh.

---

## 📋 BƯỚC 1: IMPORT FILE SQL

### Cách 1: Sử dụng Azure Data Studio (Khuyến nghị)

1. **Mở Azure Data Studio**
2. **Kết nối đến SQL Server**:
   - Server: `localhost,1433`
   - Authentication type: SQL Login
   - User name: `sa`
   - Password: `Minhlion02052004`
   - Database: `Bloomie`
3. **Mở file SQL**:
   - File → Open File
   - Chọn `Bloomie (1).sql`
4. **Chạy script**:
   - Nhấn `F5` hoặc nút Run
   - Đợi script chạy xong (có thể mất vài phút)

### Cách 2: Sử dụng sqlcmd (Command Line)

```bash
# Cài đặt ODBC driver (nếu chưa có)
brew install unixodbc

# Import SQL file
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P 'Minhlion02052004' -d Bloomie -i "Bloomie (1).sql"
```

---

## ✅ BƯỚC 2: VERIFY DỮ LIỆU ĐÃ IMPORT

Sau khi import xong, chạy command này để kiểm tra:

```bash
curl -s http://localhost:5187/api/products | python3 -c "import sys, json; data = json.load(sys.stdin); print(f'✅ Có {len(data)} products trong database')"
```

**Kết quả mong đợi**:
- Nếu thấy `Có 0 products` → Có thể products bị `IsActive = false`
- Nếu thấy `Có X products` (X > 0) → Thành công! Chuyển sang bước 3

### Nếu có 0 products (IsActive = false)

Chạy script này để update:

```bash
cd /Users/lequangminh/Documents/DACN_Base-3
python3 update_products_active.py
```

Hoặc update trực tiếp trong Azure Data Studio:

```sql
-- Kiểm tra số products
SELECT COUNT(*) as Total FROM Products;
SELECT COUNT(*) as Active FROM Products WHERE IsActive = 1;

-- Update tất cả products thành active
UPDATE Products SET IsActive = 1;

-- Verify lại
SELECT COUNT(*) as Active FROM Products WHERE IsActive = 1;
```

---

## 🔄 BƯỚC 3: CHẠY PRECOMPUTE FEATURES TỪ DATABASE

Sau khi có dữ liệu trong database, extract features cho tất cả sản phẩm:

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/image_similarity_api
python3 precompute_features.py
```

**Script này sẽ:**
1. Lấy tất cả products từ API `http://localhost:5187/api/products`
2. Tải ảnh từ ImageUrl của mỗi product
3. Extract features bằng ResNet50
4. Lưu vào `features_database/product_features.pkl`

**Thời gian chạy**: Phụ thuộc vào số lượng products (khoảng 1-2 giây/product)

**Kết quả mong đợi**:
```
Loading ResNet50 model...
Model loaded successfully!
Fetching products from C# API...
Found X products to process
Processing product 1/X: Product Name
...
Saved X product features
Done! You can now start the API server.
```

---

## 🚀 BƯỚC 4: RESTART PYTHON API

Sau khi precompute xong, restart Python API để load features mới:

```bash
# Stop Python API cũ
pkill -f "python3.*app.py"

# Start Python API mới
cd /Users/lequangminh/Documents/DACN_Base-3/image_similarity_api
nohup python3 app.py > api_log_updated.txt 2>&1 &
echo "Python API started!"

# Đợi 5 giây để API khởi động
sleep 5

# Verify API đã load features mới
curl -s http://localhost:8000/health | python3 -m json.tool
```

**Kết quả mong đợi**:
```json
{
    "status": "healthy",
    "model_loaded": true,
    "database_loaded": true,
    "total_products": [số products của bạn],
    "feature_dimension": 2048
}
```

---

## 🧪 BƯỚC 5: TEST HỆ THỐNG

### Test 1: Kiểm tra API hoạt động

```bash
curl -s http://localhost:5187 -o /dev/null -w "C# API: %{http_code}\n"
curl -s http://localhost:8000/health -o /dev/null -w "Python API: %{http_code}\n"
```

### Test 2: Test tìm kiếm với ảnh mẫu

```bash
# Chọn một ảnh từ thư mục images
curl -X POST \
  -F "file=@/Users/lequangminh/Documents/DACN_Base-3/wwwroot/images/02c5cff4-a5fb-4b8f-b71d-e4abc5c4da97.jpg" \
  -F "top_k=5" \
  http://localhost:8000/search/similar | python3 -m json.tool
```

**Kết quả mong đợi**: Trả về JSON với danh sách sản phẩm tương tự

### Test 3: Test trên giao diện web

1. Mở trình duyệt: http://localhost:5187
2. Tìm icon camera 📷 trong thanh tìm kiếm (header)
3. Click vào camera và upload một ảnh hoa
4. Xem kết quả tìm kiếm

---

## 🎨 BƯỚC 6: SỬ DỤNG TRÊN WEB

### Cách sử dụng tính năng tìm kiếm bằng hình ảnh:

1. **Truy cập website**: http://localhost:5187
2. **Tìm nút camera**: Trong thanh tìm kiếm ở góc trên phải, bạn sẽ thấy 2 icon:
   - 🔍 Kính lúp (tìm kiếm text)
   - 📷 **Camera (tìm kiếm ảnh)** ← Click vào đây!
3. **Upload ảnh**:
   - Chọn ảnh từ máy tính
   - Hoặc chụp ảnh trực tiếp (nếu có webcam)
4. **Xem kết quả**: Hệ thống tự động hiển thị các sản phẩm hoa tương tự

### Tính năng AI phân tích:

- **Màu sắc**: Tìm hoa cùng tone màu
- **Hình dạng**: Tìm bó hoa cùng kiểu dáng
- **Phong cách**: Cách bày trí và sắp xếp tương tự
- **Độ chính xác**: Sử dụng ResNet50 (2048-dimensional features)

---

## 🔧 TROUBLESHOOTING

### Vấn đề 1: Không import được SQL

**Lỗi**: Cannot open database "Bloomie"

**Giải pháp**: Tạo database trước:
```sql
CREATE DATABASE Bloomie;
GO
USE Bloomie;
```

### Vấn đề 2: API trả về 0 products

**Nguyên nhân**: Products có `IsActive = false`

**Giải pháp**: Chạy update:
```sql
UPDATE Products SET IsActive = 1;
```

### Vấn đề 3: Precompute features lỗi "Cannot fetch products"

**Nguyên nhân**: C# API chưa chạy hoặc chạy sai port

**Giải pháp**:
```bash
# Kiểm tra C# API
curl http://localhost:5187/api/products

# Nếu không chạy, restart
pkill -f "dotnet.*Bloomie"
ASPNETCORE_URLS="http://localhost:5187" dotnet bin/Debug/net8.0/Bloomie.dll &
```

### Vấn đề 4: Tìm kiếm ảnh không hoạt động

**Kiểm tra**:
1. Python API có chạy không: `curl http://localhost:8000/health`
2. Features đã được load không: Xem `total_products` trong health check
3. C# API có gọi được Python API không: Xem logs

**Giải pháp**: Restart cả 2 APIs theo hướng dẫn ở Bước 4

### Vấn đề 5: Ảnh không hiển thị trong kết quả

**Nguyên nhân**: ImageUrl trong database không đúng

**Kiểm tra**:
```sql
SELECT TOP 5 Id, Name, ImageUrl FROM Products;
```

**ImageUrl phải có dạng**: `/images/filename.ext`

---

## 📊 KIỂM TRA TRẠNG THÁI HỆ THỐNG

### Script tổng hợp kiểm tra:

```bash
echo "=== KIỂM TRA HỆ THỐNG ==="
echo ""
echo "1. C# API:"
curl -s http://localhost:5187 -o /dev/null && echo "   ✅ Running" || echo "   ❌ Not running"

echo ""
echo "2. Python API:"
curl -s http://localhost:8000/health | python3 -c "import sys, json; d=json.load(sys.stdin); print(f'   ✅ Healthy - {d[\"total_products\"]} products loaded')" 2>/dev/null || echo "   ❌ Not running"

echo ""
echo "3. Products in database:"
curl -s http://localhost:5187/api/products | python3 -c "import sys, json; print(f'   ✅ {len(json.load(sys.stdin))} products')" 2>/dev/null || echo "   ❌ Cannot fetch"

echo ""
echo "4. Image similarity working:"
curl -s -X POST -F "file=@wwwroot/images/02c5cff4-a5fb-4b8f-b71d-e4abc5c4da97.jpg" -F "top_k=1" http://localhost:8000/search/similar -o /dev/null && echo "   ✅ Working" || echo "   ❌ Not working"
```

---

## 📁 CẤU TRÚC FILES

```
DACN_Base-3/
├── Bloomie (1).sql                    # File SQL cần import
├── image_similarity_api/
│   ├── app.py                          # Python API
│   ├── precompute_features.py          # Script extract features
│   └── features_database/
│       ├── product_features.pkl        # Features đã extract
│       └── product_metadata.json       # Metadata sản phẩm
├── wwwroot/images/                     # Thư mục chứa ảnh sản phẩm
├── bin/Debug/net8.0/Bloomie.dll       # C# API compiled
└── update_products_active.py           # Script update IsActive
```

---

## ✅ CHECKLIST HOÀN THÀNH

- [ ] Import file SQL vào database Bloomie
- [ ] Verify có dữ liệu: `SELECT COUNT(*) FROM Products`
- [ ] Update IsActive = 1 nếu cần
- [ ] Chạy precompute_features.py
- [ ] Restart Python API
- [ ] Test API health checks
- [ ] Test tìm kiếm với ảnh mẫu
- [ ] Test trên giao diện web

---

## 🎉 KẾT QUẢ CUỐI CÙNG

Sau khi hoàn thành tất cả các bước:

✅ Website chạy tại: http://localhost:5187
✅ Tính năng tìm kiếm bằng hình ảnh hoạt động
✅ Database có đầy đủ dữ liệu sản phẩm
✅ AI có thể tìm sản phẩm tương tự dựa trên ảnh upload

**Chúc bạn thành công! 🌸**
