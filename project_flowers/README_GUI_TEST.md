# 🌸 Oxford Flowers Recognition GUI Test Tool

## Giới thiệu
Tool GUI này được tạo để test trực tiếp tính năng nhận dạng hoa từ hình ảnh sử dụng mô hình Oxford Flowers 102. Bạn có thể upload hình ảnh và xem kết quả phân tích ngay lập tức.

## Cài đặt

### 1. Cài đặt Python packages
```bash
pip install -r requirements_gui.txt
```

### 2. Đảm bảo có file model
Đảm bảo file `oxford102_m2_optimized.h5` có trong thư mục `project_flowers/`

## Cách sử dụng

### 1. Chạy GUI Tool
```bash
cd project_flowers
python test_image_gui.py
```

### 2. Sử dụng giao diện
1. **Select Image**: Click để chọn file hình ảnh (hỗ trợ jpg, png, bmp, gif, tiff)
2. **Analyze Image**: Click để phân tích hình ảnh đã chọn
3. **Clear All**: Xóa tất cả dữ liệu và bắt đầu lại

### 3. Kết quả hiển thị
- **Image Preview**: Hiển thị hình ảnh đã chọn
- **Image Info**: Thông tin chi tiết về file ảnh
- **Recognition Results**: Top 5 kết quả nhận dạng với độ tin cậy

## Tính năng chính

### ✨ Giao diện thân thiện
- GUI hiện đại với tkinter
- Preview hình ảnh trực tiếp
- Hiển thị thông tin file chi tiết

### 🔍 Phân tích chính xác
- Sử dụng model Oxford Flowers 102
- Top 5 predictions với confidence score
- Tên hoa bằng tiếng Việt và tiếng Anh

### 📊 Thông tin chi tiết
- Hiển thị thời gian phân tích
- Thông tin kỹ thuật về model
- File size và format hình ảnh

## Supported Image Formats
- JPEG (.jpg, .jpeg)
- PNG (.png)
- BMP (.bmp)
- GIF (.gif)
- TIFF (.tiff)

## Model Information
- **Model**: Oxford Flowers 102
- **Input Size**: 224x224 pixels
- **Classes**: 102 loài hoa khác nhau
- **Accuracy**: Optimized model với độ chính xác cao

## Troubleshooting

### Model không load được
- Kiểm tra file `oxford102_m2_optimized.h5` có tồn tại
- Đảm bảo TensorFlow được cài đặt đúng

### Hình ảnh không hiển thị
- Kiểm tra format hình ảnh có được hỗ trợ
- Thử với file ảnh khác

### Lỗi memory
- Thử với hình ảnh nhỏ hơn
- Restart tool và thử lại

## Test Cases

### Recommended Test Images
1. **Hoa hồng đỏ**: Kiểm tra nhận dạng cơ bản
2. **Hoa hướng dương**: Test với hoa to, rõ nét
3. **Hoa lan**: Test với hoa có cấu trúc phức tạp
4. **Hoa cúc**: Test với hoa có nhiều cánh nhỏ
5. **Hoa tulip**: Test với hoa có hình dạng đặc biệt

### Expected Results
- Confidence > 50% cho hình ảnh rõ nét
- Top prediction đúng loài hoa
- Tên tiếng Việt hiển thị chính xác

## Development Notes
- GUI sử dụng tkinter (built-in Python)
- Image processing với PIL/Pillow
- Model inference với TensorFlow
- Vietnamese name mapping cho user experience

---
**Lưu ý**: Tool này chỉ dành cho testing. Để sử dụng trong production, hãy sử dụng Flask API (`app.py`).