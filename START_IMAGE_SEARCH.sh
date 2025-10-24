#!/bin/bash
# Script khởi động hệ thống tìm kiếm hình ảnh cho Bloomie
# Tạo bởi: Claude Code
# Ngày: 24/10/2025

echo "=========================================="
echo "🌸 Bloomie - Image Search Startup Script"
echo "=========================================="
echo ""

# Màu sắc cho terminal
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Kiểm tra xem Python API đã chạy chưa
echo -e "${YELLOW}[1/3] Kiểm tra Python API Server...${NC}"
if lsof -Pi :8000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Python API đã chạy trên port 8000${NC}"
    echo ""
else
    echo -e "${YELLOW}⚠ Python API chưa chạy. Đang khởi động...${NC}"
    cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers

    # Kiểm tra model file
    if [ ! -f "oxford102_m2_optimized.h5" ]; then
        echo -e "${RED}✗ Lỗi: Không tìm thấy file model oxford102_m2_optimized.h5${NC}"
        exit 1
    fi

    # Khởi động Python API trong background
    nohup python3 app.py > /tmp/bloomie_api.log 2>&1 &
    PYTHON_PID=$!
    echo -e "${GREEN}✓ Python API đã khởi động (PID: $PYTHON_PID)${NC}"
    echo "  Log file: /tmp/bloomie_api.log"

    # Đợi API khởi động
    echo -n "  Đang chờ API sẵn sàng"
    for i in {1..10}; do
        sleep 1
        echo -n "."
        if curl -s http://localhost:8000/health > /dev/null 2>&1; then
            echo -e " ${GREEN}OK!${NC}"
            break
        fi
    done
    echo ""
fi

# Test API
echo -e "${YELLOW}[2/3] Test Python API...${NC}"
API_STATUS=$(curl -s http://localhost:8000/health | python3 -c "import sys, json; print(json.load(sys.stdin)['status'])" 2>/dev/null)
if [ "$API_STATUS" = "healthy" ]; then
    echo -e "${GREEN}✓ API hoạt động tốt${NC}"
    echo ""
else
    echo -e "${RED}✗ API không phản hồi. Kiểm tra log tại /tmp/bloomie_api.log${NC}"
    exit 1
fi

# Hướng dẫn khởi động C# app
echo -e "${YELLOW}[3/3] Hướng dẫn khởi động ASP.NET App${NC}"
echo "  1. Mở terminal mới"
echo "  2. Chạy lệnh:"
echo -e "     ${GREEN}cd /Users/lequangminh/Documents/DACN_Base-3${NC}"
echo -e "     ${GREEN}dotnet run${NC}"
echo "  3. Mở browser: http://localhost:5187"
echo ""

echo "=========================================="
echo -e "${GREEN}✓ Python API Server sẵn sàng!${NC}"
echo "=========================================="
echo ""
echo "API Endpoints:"
echo "  - http://localhost:8000/health (health check)"
echo "  - http://localhost:8000/predict (phân tích ảnh)"
echo ""
echo "Để dừng Python API:"
echo "  kill \$(lsof -ti:8000)"
echo ""
echo "Để xem log realtime:"
echo "  tail -f /tmp/bloomie_api.log"
echo ""
