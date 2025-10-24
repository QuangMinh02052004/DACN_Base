# Oxford Flowers Image Recognition API

API Flask để nhận dạng hoa dựa trên mô hình Oxford Flowers 102 đã được train.

## Tính năng

- **Nhận dạng 102 loài hoa**: Sử dụng mô hình TensorFlow đã được train trên Oxford Flowers dataset
- **Mapping tiếng Việt**: Tự động chuyển đổi tên hoa từ tiếng Anh sang tiếng Việt
- **Top 3 predictions**: Trả về 3 kết quả dự đoán có độ tin cậy cao nhất
- **Logging đầy đủ**: Theo dõi và ghi log các request và lỗi
- **Error handling**: Xử lý lỗi và validation đầy đủ
- **CORS support**: Cho phép gọi API từ web application

## Cài đặt

### Yêu cầu hệ thống

- Python 3.8+
- pip
- Khoảng 500MB dung lượng cho dependencies

### Cài đặt tự động

```bash
cd project_flowers
./start_api.sh
```

Script sẽ tự động:
1. Tạo virtual environment
2. Cài đặt tất cả dependencies
3. Khởi động API server

### Cài đặt thủ công

```bash
# 1. Tạo virtual environment
python3 -m venv venv

# 2. Activate virtual environment
source venv/bin/activate  # macOS/Linux
# hoặc
venv\Scripts\activate  # Windows

# 3. Cài đặt dependencies
pip install -r requirements.txt

# 4. Chạy API
python app.py
```

## API Endpoints

### 1. Health Check

**GET** `/health`

Kiểm tra trạng thái server.

**Response:**
```json
{
  "status": "healthy",
  "model": "Oxford102_m2_optimized"
}
```

### 2. Predict (Main endpoint)

**POST** `/predict`

Nhận dạng hoa từ hình ảnh.

**Request:**
- Content-Type: `multipart/form-data`
- Body: `image` - file ảnh (JPG, PNG, WEBP)

**Response:**
```json
{
  "success": true,
  "predictions": [
    {
      "className": "Hoa Hồng",
      "confidence": 0.89,
      "englishName": "rose"
    },
    {
      "className": "Hoa Tulip",
      "confidence": 0.07,
      "englishName": "tulip"
    },
    {
      "className": "Hoa Lily",
      "confidence": 0.03,
      "englishName": "lily"
    }
  ],
  "message": "Prediction successful"
}
```

### 3. Search by Image (Alternative endpoint)

**POST** `/search-by-image`

Endpoint thay thế với format response khác.

**Request:**
- Content-Type: `multipart/form-data`
- Body: `imageFile` - file ảnh

**Response:**
```json
{
  "class_id": 83,
  "class_name": "rose",
  "vietnamese_name": "Hoa Hồng",
  "probability": 0.89
}
```

## Testing

### Test bằng script Python

```bash
# Test với ảnh mặc định (tự động tìm ảnh trong thư mục images/)
python test_api.py

# Test với ảnh cụ thể
python test_api.py path/to/your/image.jpg
```

### Test bằng curl

```bash
# Health check
curl http://localhost:8000/health

# Predict
curl -X POST \
  -F "image=@path/to/image.jpg" \
  http://localhost:8000/predict
```

### Test bằng Postman

1. Import collection hoặc tạo request mới
2. Method: POST
3. URL: `http://localhost:8000/predict`
4. Body: form-data
5. Key: `image`, Type: File, Value: chọn file ảnh

## Sử dụng với C# Application

API này được thiết kế để tích hợp với Bloomie (ASP.NET Core application).

```csharp
// ImageSearchService sẽ gọi endpoint /predict
var response = await _httpClient.PostAsync($"{_pythonApiUrl}/predict", content);
```

Xem [ImageSearchService.cs](../Services/Implementations/ImageSearchService.cs) để biết thêm chi tiết.

## Cấu trúc dự án

```
project_flowers/
├── app.py                      # Main Flask application
├── requirements.txt            # Python dependencies
├── oxford102_m2_optimized.h5   # Trained model
├── class_names.json           # Flower class names
├── start_api.sh               # Auto start script
├── test_api.py                # Test script
├── README.md                  # Documentation
└── images/                    # Test images
    └── jpg/
```

## Các loài hoa được hỗ trợ

API hỗ trợ nhận dạng 102 loài hoa từ Oxford Flowers dataset, bao gồm:

- Hoa Hồng (Rose)
- Hoa Hướng Dương (Sunflower)
- Hoa Tulip (Tulip)
- Hoa Lily (Lily)
- Hoa Lan (Orchid)
- Hoa Cẩm Chướng (Carnation)
- Hoa Thủy Tiên (Daffodil)
- ... và 95 loài khác

Xem file `app.py` function `map_flower_to_vietnamese()` để biết danh sách đầy đủ.

## Troubleshooting

### Lỗi: Cannot load model

```
Error: Failed to load model: [Errno 2] No such file or directory: 'oxford102_m2_optimized.h5'
```

**Giải pháp:** Đảm bảo file model `oxford102_m2_optimized.h5` tồn tại trong thư mục project_flowers.

### Lỗi: Port already in use

```
OSError: [Errno 48] Address already in use
```

**Giải pháp:**
```bash
# Tìm process đang sử dụng port 8000
lsof -i :8000

# Kill process
kill -9 <PID>
```

### Lỗi: Module not found

```
ModuleNotFoundError: No module named 'flask'
```

**Giải pháp:** Đảm bảo đã activate virtual environment và cài đặt requirements:
```bash
source venv/bin/activate
pip install -r requirements.txt
```

### Lỗi: TensorFlow not found (macOS)

```
ModuleNotFoundError: No module named 'tensorflow'
```

**Giải pháp:** Trên macOS với Apple Silicon, sử dụng:
```bash
pip install tensorflow-macos tensorflow-metal
```

### API không connect được từ C#

**Giải pháp:**
1. Kiểm tra Flask API đang chạy: `curl http://localhost:8000/health`
2. Kiểm tra config trong `appsettings.json`:
   ```json
   {
     "ImageSearch": {
       "PythonApiUrl": "http://localhost:8000"
     }
   }
   ```
3. Kiểm tra firewall settings

## Performance

- **Model size:** ~11MB
- **Average prediction time:** 100-300ms
- **Max image size:** 5MB
- **Supported formats:** JPG, PNG, WEBP
- **Input resolution:** 224x224 (auto-resized)

## Logging

Logs được in ra console với format:
```
2024-10-24 13:00:00 - __main__ - INFO - Received prediction request
2024-10-24 13:00:00 - __main__ - INFO - Processing image: rose.jpg
2024-10-24 13:00:00 - __main__ - INFO - Running model prediction...
2024-10-24 13:00:01 - __main__ - INFO - Prediction successful. Top result: Hoa Hồng (89.23%)
```

## License

This project uses the Oxford Flowers 102 dataset.

## Support

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra logs trong console
2. Chạy test script: `python test_api.py`
3. Xem file [IMAGE_SEARCH_SETUP.md](../IMAGE_SEARCH_SETUP.md) để biết hướng dẫn chi tiết
