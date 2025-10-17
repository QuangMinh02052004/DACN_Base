#!/bin/bash

# Script tải ảnh hoa từ Unsplash
# Chạy: bash download_flower_images.sh

echo "Đang tải ảnh hoa từ Unsplash..."

# Tạo thư mục nếu chưa có
mkdir -p "wwwroot/images/flowers"
mkdir -p "wwwroot/images/styles"

cd "wwwroot/images/flowers"

# Tải ảnh các loại hoa
curl -L "https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400" -o "hong.jpg"
echo "✓ Đã tải hoa hồng"

curl -L "https://images.unsplash.com/photo-1582794543139-8ac9cb0f7b11?w=400" -o "tulip.jpg"
echo "✓ Đã tải hoa tulip"

curl -L "https://images.unsplash.com/photo-1597848212624-e37f33be3c4d?w=400" -o "huong-duong.jpg"
echo "✓ Đã tải hoa hướng dương"

curl -L "https://images.unsplash.com/photo-1566478989037-eec170784c5a?w=400" -o "lan.jpg"
echo "✓ Đã tải hoa lan"

curl -L "https://images.unsplash.com/photo-1563241527-3004b7be0ffd?w=400" -o "ly.jpg"
echo "✓ Đã tải hoa ly"

curl -L "https://images.unsplash.com/photo-1588423771073-b8edd1e145ca?w=400" -o "cam-chuong.jpg"
echo "✓ Đã tải hoa cẩm chướng"

curl -L "https://images.unsplash.com/photo-1574684891174-df0e9a41c18b?w=400" -o "cuc.jpg"
echo "✓ Đã tải hoa cúc"

curl -L "https://images.unsplash.com/photo-1615231644180-65104c8e1285?w=400" -o "baby.jpg"
echo "✓ Đã tải hoa baby"

curl -L "https://images.unsplash.com/photo-1561181286-d3fee7d55364?w=400" -o "cat-tuong.jpg"
echo "✓ Đã tải hoa cát tường"

curl -L "https://images.unsplash.com/photo-1464297162577-f5295c892194?w=400" -o "cuc-mau-don.jpg"
echo "✓ Đã tải hoa cúc mẫu đơn"

curl -L "https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400" -o "dong-tien.jpg"
echo "✓ Đã tải hoa đồng tiền"

# Quay về thư mục gốc
cd ../../..

# Tải ảnh presentation styles
cd "wwwroot/images/styles"

curl -L "https://images.unsplash.com/photo-1563241527-3004b7be0ffd?w=300" -o "bo-hoa.jpg"
echo "✓ Đã tải ảnh bó hoa"

curl -L "https://images.unsplash.com/photo-1487530811176-3780de880c2d?w=300" -o "gio-hoa.jpg"
echo "✓ Đã tải ảnh giỏ hoa"

curl -L "https://images.unsplash.com/photo-1544725121-be3bf52e2dc8?w=300" -o "binh-hoa.jpg"
echo "✓ Đã tải ảnh bình hoa"

curl -L "https://images.unsplash.com/photo-1587334207976-c7cc3c1ec00f?w=300" -o "hop-hoa.jpg"
echo "✓ Đã tải ảnh hộp hoa"

curl -L "https://images.unsplash.com/photo-1522057384400-681b421cfebc?w=300" -o "lang-hoa.jpg"
echo "✓ Đã tải ảnh lẵng hoa"

echo ""
echo "✅ HOÀN THÀNH! Đã tải xong tất cả ảnh."
echo "Bạn có thể chạy lại ứng dụng: dotnet run"
