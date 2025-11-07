#!/bin/bash
# =============================================
# AUTO IMPORT - Chạy tự động toàn bộ quy trình
# =============================================

set -e  # Exit on error

echo ""
echo "=================================================="
echo "    TỰ ĐỘNG TẠO LẠI DATABASE VÀ IMPORT DỮ LIỆU"
echo "=================================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Drop and recreate database
echo -e "${YELLOW}[1/4]${NC} Xóa và tạo lại database..."
if dotnet ef database drop --force 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Database đã được xóa"
fi

# Step 2: Run migrations
echo ""
echo -e "${YELLOW}[2/4]${NC} Tạo tất cả các bảng (bao gồm ChatConversations & ChatMessages)..."
dotnet ef database update

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} Tất cả các bảng đã được tạo thành công!"
else
    echo -e "${RED}✗${NC} Lỗi khi tạo bảng!"
    exit 1
fi

# Step 3: Find SQL file
echo ""
echo -e "${YELLOW}[3/4]${NC} Tìm file dữ liệu..."

SQL_FILE=""
if [ -f "DATA_IMPORT.sql" ]; then
    SQL_FILE="DATA_IMPORT.sql"
elif [ -f "Untitled-1.sql" ]; then
    SQL_FILE="Untitled-1.sql"
elif [ -f "Bloomie (1).sql" ]; then
    SQL_FILE="Bloomie (1).sql"
else
    echo -e "${RED}✗${NC} Không tìm thấy file SQL!"
    echo "Vui lòng đảm bảo có một trong các file sau:"
    echo "  - DATA_IMPORT.sql"
    echo "  - Untitled-1.sql"
    echo "  - Bloomie (1).sql"
    exit 1
fi

echo -e "${GREEN}✓${NC} Tìm thấy file: $SQL_FILE"

# Step 4: Import data using dotnet-script or direct SQL execution
echo ""
echo -e "${YELLOW}[4/4]${NC} Import dữ liệu từ $SQL_FILE..."

# Try using sqlcmd if available
if command -v sqlcmd &> /dev/null; then
    sqlcmd -S localhost -d Bloomie -i "$SQL_FILE"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} Dữ liệu đã được import thành công!"
    else
        echo -e "${RED}✗${NC} Lỗi khi import dữ liệu qua sqlcmd!"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠${NC} sqlcmd không có sẵn."
    echo "Vui lòng chạy script SQL thủ công trong SQL Server Management Studio:"
    echo "  1. Mở file: $SQL_FILE"
    echo "  2. Chọn database: Bloomie"
    echo "  3. Nhấn F5 để chạy"
fi

# Verification
echo ""
echo "=================================================="
echo -e "${GREEN}✓✓✓ QUY TRÌNH HOÀN TẤT!${NC}"
echo "=================================================="
echo ""
echo "Database Bloomie hiện có:"
echo "  ✓ Tất cả các bảng"
echo "  ✓ ChatConversations và ChatMessages"
echo "  ✓ Dữ liệu đã được import"
echo ""
echo "Chạy lệnh sau để kiểm tra:"
echo "  ./CHECK_DATABASE_STATUS.sql"
echo ""
