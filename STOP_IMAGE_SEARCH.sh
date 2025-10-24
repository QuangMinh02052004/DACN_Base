#!/bin/bash
# Script dừng Python API Server cho Bloomie
# Tạo bởi: Claude Code
# Ngày: 24/10/2025

echo "=========================================="
echo "🛑 Bloomie - Stop Image Search API"
echo "=========================================="
echo ""

# Màu sắc
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Kiểm tra xem có process nào đang chạy trên port 8000 không
if lsof -Pi :8000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo -e "${YELLOW}Đang dừng Python API Server...${NC}"

    # Lấy PIDs
    PIDS=$(lsof -ti:8000)

    # Kill từng process
    for PID in $PIDS; do
        echo "  Dừng process $PID..."
        kill $PID 2>/dev/null
    done

    # Đợi một chút
    sleep 2

    # Kiểm tra lại
    if lsof -Pi :8000 -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo -e "${YELLOW}  Một số process vẫn còn. Dùng kill -9...${NC}"
        PIDS=$(lsof -ti:8000)
        for PID in $PIDS; do
            kill -9 $PID 2>/dev/null
        done
    fi

    echo -e "${GREEN}✓ Đã dừng Python API Server${NC}"
else
    echo -e "${YELLOW}⚠ Không có Python API nào đang chạy${NC}"
fi

echo ""
echo "=========================================="
