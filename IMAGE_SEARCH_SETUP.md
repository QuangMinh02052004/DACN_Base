# Hướng dẫn thiết lập chức năng Image Search

## Tổng quan
Chức năng Image Search cho phép người dùng tìm kiếm sản phẩm hoa bằng cách tải ảnh lên hoặc chụp ảnh trực tiếp từ camera. Hệ thống sử dụng AI model đã training để nhận dạng loài hoa và đề xuất sản phẩm phù hợp.

## Kiến trúc hệ thống

### 1. Frontend (JavaScript)
- **Camera Modal**: Cho phép chụp ảnh trực tiếp từ camera
- **File Upload**: Tải ảnh từ thiết bị
- **Analysis Modal**: Hiển thị quá trình phân tích
- **Auto Redirect**: Tự động chuyển hướng đến kết quả tìm kiếm

### 2. Backend C# (.NET Core)
- **ImageSearchService**: Service xử lý request và gọi Python API
- **ProductController.ImageSearch**: API endpoint nhận ảnh từ frontend
- **Validation**: Kiểm tra file size, format, security

### 3. AI Service (Python Flask)
- **Model**: Oxford Flowers 102 đã training
- **API Endpoint**: `/predict` nhận ảnh và trả về prediction
- **Mapping**: Map tên hoa tiếng Anh sang tiếng Việt và thuộc tính

## Cài đặt

### Bước 1: Thiết lập Python Flask API

1. Navigate vào thư mục project_flowers:
```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
```

2. Tạo virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
```

3. Cài đặt dependencies:
```bash
pip install flask flask-cors tensorflow pillow numpy
```

4. Kiểm tra model file tồn tại:
- `oxford102_m2_optimized.h5` (model đã training)
- `class_names.json` (danh sách tên các loài hoa)

5. Chạy Flask API:
```bash
python app.py
```
API sẽ chạy trên `http://localhost:8000`

### Bước 2: Test Flask API

Test bằng curl:
```bash
curl -X POST -F "image=@test_image.jpg" http://localhost:8000/predict
```

Expected response:
```json
{
  "success": true,
  "predictions": [
    {
      "className": "Hoa Hồng",
      "confidence": 0.89
    }
  ],
  "message": "Prediction successful"
}
```

### Bước 3: Chạy ứng dụng .NET

1. Build project:
```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet build
```

2. Chạy ứng dụng:
```bash
dotnet run
```
Ứng dụng sẽ chạy trên `http://localhost:5187`

### Bước 4: Test chức năng Image Search

1. Mở website: `http://localhost:5187`
2. Tại search bar, click vào nút camera hoặc upload
3. Chụp ảnh hoặc tải ảnh hoa lên
4. Hệ thống sẽ phân tích và redirect đến kết quả tìm kiếm

## Flow hoạt động

1. **User Upload/Capture Image** → Frontend JavaScript
2. **FormData POST** → `/Product/ImageSearch` (C#)
3. **Validation & Processing** → ImageSearchService (C#)
4. **HTTP Request** → `http://localhost:8000/predict` (Python)
5. **AI Prediction** → TensorFlow Model
6. **Response Mapping** → Flower info + Colors + Presentation
7. **Redirect URL** → `/Product/Index?colors=...&presentations=...`
8. **Display Results** → Filtered products

## Configuration

### appsettings.json
```json
{
  "ImageSearch": {
    "PythonApiUrl": "http://localhost:8000"
  }
}
```

### JavaScript Settings (_Layout.cshtml)
- Timeout: 15 seconds
- Max file size: 5MB
- Allowed formats: JPG, PNG, WEBP
- Camera resolution: Device dependent

## Troubleshooting

### Flask API không start
1. Kiểm tra Python version: `python3 --version`
2. Kiểm tra virtual environment đã activate
3. Kiểm tra model file tồn tại
4. Kiểm tra port 8000 có bị chiếm không

### C# API lỗi connection
1. Kiểm tra Flask API đang chạy
2. Kiểm tra URL trong appsettings.json
3. Kiểm tra firewall settings

### Image không được nhận dạng
1. Kiểm tra quality ảnh (clear, good lighting)
2. Kiểm tra ảnh có chứa hoa không
3. Kiểm tra model có support loài hoa đó không

## Mở rộng

### Thêm loài hoa mới
1. Update `flower_mapping` trong `ImageSearchService.cs`
2. Update `map_flower_to_vietnamese()` trong `app.py`
3. Retrain model nếu cần

### Cải thiện accuracy
1. Sử dụng model mới hơn
2. Implement ensemble prediction
3. Add preprocessing filters

### Performance optimization
1. Cache predictions
2. Optimize image preprocessing
3. Use async/await properly
4. Implement CDN for static assets

## Notes
- Model hiện tại support 102 loài hoa từ Oxford Flowers dataset
- Accuracy phụ thuộc vào quality ảnh input
- Cần internet connection để download TensorFlow models lần đầu
- Recommend sử dụng ảnh có resolution >= 224x224px