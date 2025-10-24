#!/bin/bash

# Script để khởi động Flask API cho Image Search

echo "=============================================="
echo "Oxford Flowers Image Recognition API"
echo "=============================================="
echo ""

# Check if running in project_flowers directory
if [ ! -f "app.py" ]; then
    echo "Error: app.py not found. Please run this script from project_flowers directory."
    exit 1
fi

# Check if model file exists
if [ ! -f "oxford102_m2_optimized.h5" ]; then
    echo "Error: Model file oxford102_m2_optimized.h5 not found!"
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install/upgrade requirements
echo "Installing requirements..."
pip install -q --upgrade pip
pip install -q -r requirements.txt

# Start the Flask app
echo ""
echo "Starting Flask API server..."
echo "API will be available at: http://localhost:8000"
echo "Press Ctrl+C to stop the server"
echo ""

python app.py
