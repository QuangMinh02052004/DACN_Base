#!/bin/bash

# ==========================================
# OXFORD 102 FLOWERS MODEL TRAINING SCRIPT
# Optimized for MacBook Air M2 16GB
# ==========================================

echo "========================================================================"
echo "🌸 OXFORD 102 FLOWERS - MODEL TRAINING"
echo "🍎 MacBook Air M2 16GB - Training Script"
echo "========================================================================"
echo ""

# Check Python version
PYTHON_VERSION=$(python3 --version)
echo "✅ Python version: $PYTHON_VERSION"

# Check if we're in the right directory
if [ ! -f "train_model.py" ]; then
    echo "❌ Error: train_model.py not found!"
    echo "Please run this script from the project_flowers directory"
    exit 1
fi

echo ""
echo "📋 THÔNG TIN TRAINING:"
echo "   - Dataset: Oxford Flowers 102 (102 classes)"
echo "   - Model: EfficientNetB0 with Transfer Learning"
echo "   - Batch size: 64"
echo "   - Epochs: Phase 1 (10) + Phase 2 (40) = 50 total"
echo "   - Expected accuracy: 87-92%"
echo "   - Estimated time: 2-4 hours on M2"
echo ""
echo "⚠️  LƯU Ý:"
echo "   - Dataset sẽ tự động download (~350MB) ở lần chạy đầu tiên"
echo "   - Không tắt máy trong quá trình training"
echo "   - Model checkpoint sẽ tự động lưu sau mỗi epoch"
echo "   - Bạn có thể dừng bằng Ctrl+C, model đã save sẽ được giữ lại"
echo ""
echo "========================================================================"
echo ""

# Ask for confirmation
read -p "🚀 Bắt đầu training? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Training cancelled."
    exit 1
fi

echo ""
echo "🚀 STARTING TRAINING..."
echo "========================================================================"
echo ""

# Run training with unbuffered output
python3 -u train_model.py

# Check exit status
EXIT_CODE=$?

echo ""
echo "========================================================================"

if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ TRAINING COMPLETED SUCCESSFULLY!"
    echo ""
    echo "📁 Files created:"
    echo "   - oxford102_improved.h5 (trained model)"
    echo "   - oxford102_phase1.h5 (phase 1 checkpoint)"
    echo "   - training_history.json (training metrics)"
    echo ""
    echo "🔄 NEXT STEPS:"
    echo "   1. Replace old model: mv oxford102_improved.h5 oxford102_m2_optimized.h5"
    echo "   2. Restart Python API: python3 app.py"
    echo "   3. Test với ảnh mới trong web app"
else
    echo "⚠️  Training stopped with exit code: $EXIT_CODE"
    echo ""
    echo "📁 Checkpoint files may have been saved:"
    echo "   - oxford102_phase1.h5"
    echo "   - oxford102_improved.h5"
fi

echo "========================================================================"
