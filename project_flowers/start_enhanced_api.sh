#!/bin/bash
# Enhanced Flower Recognition API Startup Script

echo "🌸 Starting Enhanced Flower Recognition API..."
echo "=============================================="

# Check if model file exists
if [ ! -f "oxford102_m2_optimized.h5" ]; then
    echo "❌ Error: Model file 'oxford102_m2_optimized.h5' not found!"
    echo "Please ensure the model file is in the current directory."
    exit 1
fi

# Check Python dependencies
echo "📦 Checking dependencies..."
python3 -c "import tensorflow, flask, PIL, numpy" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "❌ Error: Missing dependencies. Installing..."
    pip3 install tensorflow flask flask-cors pillow numpy
fi

# Start the enhanced API
echo "🚀 Starting Enhanced API on http://localhost:8000..."
echo "Features:"
echo "  ✅ Enhanced accuracy with visual rules"
echo "  ✅ Color analysis and smart enhancement" 
echo "  ✅ Multiple analysis modes"
echo "  ✅ Improved tulip detection"
echo ""
echo "Press Ctrl+C to stop the server"
echo "=============================================="

python3 enhanced_api.py