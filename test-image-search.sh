#!/bin/bash

# Script to test Image Search feature end-to-end

echo "=================================================="
echo "🌸 Bloomie Image Search - End-to-End Test"
echo "=================================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a port is in use
check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        return 0 # Port is in use
    else
        return 1 # Port is free
    fi
}

# Function to print colored output
print_status() {
    local status=$1
    local message=$2
    if [ "$status" == "success" ]; then
        echo -e "${GREEN}✓${NC} $message"
    elif [ "$status" == "error" ]; then
        echo -e "${RED}✗${NC} $message"
    elif [ "$status" == "info" ]; then
        echo -e "${YELLOW}ℹ${NC} $message"
    fi
}

# Test 1: Check Flask API
echo "Test 1: Checking Flask API (port 8000)..."
if check_port 8000; then
    print_status "success" "Flask API is running on port 8000"

    # Test health endpoint
    response=$(curl -s http://localhost:8000/health)
    if echo "$response" | grep -q "healthy"; then
        print_status "success" "Flask API health check passed"
        echo "  Response: $response"
    else
        print_status "error" "Flask API health check failed"
        echo "  Response: $response"
    fi
else
    print_status "error" "Flask API is NOT running on port 8000"
    print_status "info" "Please start Flask API first:"
    echo "    cd project_flowers"
    echo "    ./start_api.sh"
    exit 1
fi
echo ""

# Test 2: Check ASP.NET Core
echo "Test 2: Checking ASP.NET Core (port 5187)..."
if check_port 5187; then
    print_status "success" "ASP.NET Core is running on port 5187"
else
    print_status "error" "ASP.NET Core is NOT running on port 5187"
    print_status "info" "Please start ASP.NET Core first:"
    echo "    dotnet run"
    exit 1
fi
echo ""

# Test 3: Test Flask API with sample image
echo "Test 3: Testing Flask API with sample image..."
if [ -f "project_flowers/images/jpg/image_00001.jpg" ]; then
    response=$(curl -s -X POST \
        -F "image=@project_flowers/images/jpg/image_00001.jpg" \
        http://localhost:8000/predict)

    if echo "$response" | grep -q "success"; then
        print_status "success" "Flask API prediction test passed"

        # Extract flower name and confidence
        className=$(echo "$response" | grep -o '"className":"[^"]*"' | head -1 | cut -d'"' -f4)
        confidence=$(echo "$response" | grep -o '"confidence":[0-9.]*' | head -1 | cut -d':' -f2)

        if [ ! -z "$className" ]; then
            print_status "info" "Predicted: $className (confidence: $confidence)"
        fi
    else
        print_status "error" "Flask API prediction test failed"
        echo "  Response: $response"
    fi
else
    print_status "info" "No sample image found, skipping prediction test"
fi
echo ""

# Test 4: Check frontend files
echo "Test 4: Checking frontend configuration..."
if grep -q "ImageSearch" "Views/Shared/_Layout.cshtml"; then
    print_status "success" "Frontend ImageSearch JavaScript found"
else
    print_status "error" "Frontend ImageSearch JavaScript NOT found"
fi

if grep -q "cameraModal" "Views/Shared/_Layout.cshtml"; then
    print_status "success" "Camera modal found in layout"
else
    print_status "error" "Camera modal NOT found in layout"
fi
echo ""

# Test 5: Check backend configuration
echo "Test 5: Checking backend configuration..."
if grep -q "ImageSearch" "appsettings.json"; then
    print_status "success" "ImageSearch config found in appsettings.json"
    pythonApiUrl=$(grep -A 1 "ImageSearch" appsettings.json | grep "PythonApiUrl" | cut -d'"' -f4)
    print_status "info" "Python API URL: $pythonApiUrl"
else
    print_status "error" "ImageSearch config NOT found in appsettings.json"
fi

if grep -q "IImageSearchService" "Program.cs"; then
    print_status "success" "ImageSearchService registered in Program.cs"
else
    print_status "error" "ImageSearchService NOT registered in Program.cs"
fi

if grep -q "ImageSearch" "Controllers/ProductController.cs"; then
    print_status "success" "ImageSearch endpoint found in ProductController"
else
    print_status "error" "ImageSearch endpoint NOT found in ProductController"
fi
echo ""

# Summary
echo "=================================================="
echo "📊 Test Summary"
echo "=================================================="
echo ""
print_status "info" "All backend services are running"
print_status "info" "Ready to test Image Search feature!"
echo ""
echo "Next steps:"
echo "  1. Open browser: http://localhost:5187"
echo "  2. Click on the search bar"
echo "  3. Click the camera icon 📷"
echo "  4. Choose 'Upload Image' or 'Open Camera'"
echo "  5. Select/capture an image of a flower"
echo "  6. Wait for analysis (3-5 seconds)"
echo "  7. You should be redirected to search results"
echo ""
echo "For detailed logs:"
echo "  - Flask API logs: Check terminal running start_api.sh"
echo "  - ASP.NET logs: Check terminal running dotnet run"
echo "  - Browser logs: F12 → Console tab"
echo ""
echo "=================================================="
