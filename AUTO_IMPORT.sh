#!/bin/bash
# =============================================
# Script tự động: Tạo lại database và import dữ liệu
# =============================================

echo "========================================="
echo "BẮT ĐẦU QUY TRÌNH TỰ ĐỘNG"
echo "========================================="
echo ""

# Bước 1: Xóa và tạo lại database
echo "Bước 1: Xóa và tạo lại database..."
sqlcmd -S localhost -i "RECREATE_DATABASE_FULL.sql"

if [ $? -eq 0 ]; then
    echo "✓ Database đã được tạo lại thành công!"
else
    echo "✗ Lỗi khi tạo database!"
    exit 1
fi

echo ""

# Bước 2: Chạy migrations để tạo bảng
echo "Bước 2: Tạo tất cả các bảng (bao gồm ChatConversations và ChatMessages)..."
dotnet ef database update

if [ $? -eq 0 ]; then
    echo "✓ Tất cả các bảng đã được tạo thành công!"
else
    echo "✗ Lỗi khi chạy migrations!"
    exit 1
fi

echo ""

# Bước 3: Import dữ liệu từ file Untitled-1
echo "Bước 3: Import dữ liệu..."
sqlcmd -S localhost -d Bloomie -i "Untitled-1.sql"

if [ $? -eq 0 ]; then
    echo "✓ Dữ liệu đã được import thành công!"
else
    echo "✗ Lỗi khi import dữ liệu!"
    exit 1
fi

echo ""

# Bước 4: Kiểm tra kết quả
echo "Bước 4: Kiểm tra database..."
sqlcmd -S localhost -i "CHECK_DATABASE_STATUS.sql"

echo ""
echo "========================================="
echo "✓✓✓ HOÀN TẤT QUY TRÌNH!"
echo "========================================="
echo ""
echo "Database Bloomie đã sẵn sàng với:"
echo "- Tất cả các bảng (bao gồm ChatConversations và ChatMessages)"
echo "- Dữ liệu đã được import"
echo ""
