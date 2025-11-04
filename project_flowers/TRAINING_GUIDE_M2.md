# 🌸 OXFORD 102 FLOWERS MODEL TRAINING

## 📊 THÔNG TIN HỆ THỐNG

**MacBook Air M2 16GB RAM** - Cấu hình tối ưu cho deep learning!

### Ưu điểm của M2:
- ✅ **16GB Unified Memory** → Load toàn bộ dataset vào RAM
- ✅ **8-core CPU** → Training nhanh hơn Intel 2-3x
- ✅ **10-core GPU** → Tăng tốc matrix operations
- ✅ **Neural Engine** → Tối ưu inference speed

## 🚀 CÁCH TRAINING MODEL MỚI

### Option 1: Sử dụng script tự động (KHUYẾN NGHỊ)

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
./START_TRAINING.sh
```

Script sẽ:
1. ✅ Tự động download Oxford Flowers 102 dataset (~350MB)
2. ✅ Configure TensorFlow cho M2
3. ✅ Training 2 phases (10 + 40 epochs)
4. ✅ Lưu model và training history

### Option 2: Chạy trực tiếp Python

```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
python3 train_model.py
```

## ⏱️ THỜI GIAN DỰ KIẾN

| Phase | Epochs | Time (M2) | Accuracy Expected |
|-------|--------|-----------|-------------------|
| Phase 1: Train top layers | 10 | 30-45 phút | ~75-80% |
| Phase 2: Fine-tune | 40 | 2-3 giờ | ~87-92% |
| **TOTAL** | **50** | **~2.5-4 giờ** | **87-92%** |

## 📦 DATASET

**Oxford Flowers 102**
- **Số lượng classes:** 102 loại hoa
- **Training samples:** 1,020 ảnh
- **Validation samples:** 1,020 ảnh
- **Test samples:** 6,149 ảnh
- **Kích thước download:** ~350MB
- **Tự động download:** Có (qua TensorFlow Datasets)

Dataset bao gồm các loại hoa phổ biến:
- Hoa Hồng (Rose)
- Hoa Tulip (Tulip)
- Hoa Cẩm Chướng (Carnation)
- Hoa Hướng Dương (Sunflower)
- Hoa Lan (Orchid)
- ... và 97 loài khác

## 🏗️ KIẾN TRÚC MODEL

**Base Model:** EfficientNetB0 (pre-trained trên ImageNet)
- Số lượng parameters: ~5.3M
- Input size: 224x224x3
- Transfer Learning: Sử dụng weights từ ImageNet

**Custom Head:**
```
GlobalAveragePooling2D
→ Dense(512, relu)
→ Dropout(0.3)
→ Dense(256, relu)
→ Dropout(0.2)
→ Dense(102, softmax)
```

**Total parameters:** ~5.9M
**Trainable parameters:** Phase 1: ~2M | Phase 2: ~4M

## 🎯 KẾT QUẢ DỰ KIẾN

| Metric | Target | Actual (after training) |
|--------|--------|------------------------|
| Training Accuracy | >90% | TBD |
| Validation Accuracy | >85% | TBD |
| Test Accuracy | >85% | TBD |
| Top-3 Accuracy | >95% | TBD |
| Model Size | 30-50MB | TBD |

## 📁 FILES ĐƯỢC TẠO

Sau khi training xong, các file sau sẽ được tạo:

```
oxford102_improved.h5          # Model cuối cùng (best validation accuracy)
oxford102_phase1.h5            # Checkpoint sau phase 1
training_history.json          # Lịch sử training (loss, accuracy)
```

## 🔄 SAU KHI TRAINING XONG

### 1. Kiểm tra accuracy

```bash
# Xem training history
cat training_history.json | python3 -m json.tool
```

### 2. Thay thế model cũ

```bash
# Backup model cũ (10MB)
mv oxford102_m2_optimized.h5 oxford102_m2_optimized_OLD.h5

# Dùng model mới
mv oxford102_improved.h5 oxford102_m2_optimized.h5
```

### 3. Restart Python API

```bash
# Stop API cũ (Ctrl+C nếu đang chạy)
# Start lại API
python3 app.py
```

### 4. Test trên web app

1. Mở http://localhost:5187
2. Upload ảnh hoa để test
3. Kiểm tra confidence score (nên >30%)
4. Verify Top 3 predictions có chính xác không

## 🛠️ TROUBLESHOOTING

### Lỗi: "Out of Memory"

```bash
# Giảm batch size trong train_model.py
BATCH_SIZE = 32  # Thay vì 64
```

### Lỗi: "Dataset download failed"

```bash
# Download manual dataset
python3 -c "import tensorflow_datasets as tfds; tfds.load('oxford_flowers102', download=True)"
```

### Training quá chậm

- ✅ Đóng các app nặng khác (Chrome, etc.)
- ✅ Cắm sạc (M2 throttle khi dùng pin)
- ✅ Tắt FileVault nếu đang encrypt disk

### Muốn stop và resume

```bash
# Stop bằng Ctrl+C
# Model checkpoint đã được lưu tại oxford102_phase1.h5

# Resume từ checkpoint (TODO: thêm resume logic)
```

## 📊 MONITORING TRAINING

Trong quá trình training, bạn sẽ thấy:

```
Epoch 1/10
32/32 [==============================] - 45s 1.4s/step
  loss: 3.4521
  accuracy: 0.2156
  val_loss: 2.9834
  val_accuracy: 0.3245
```

**Giải thích:**
- `loss` giảm dần → Model đang học
- `accuracy` tăng dần → Model ngày càng chính xác
- `val_accuracy` > 85% sau 50 epochs → Thành công!

## 💡 TIPS TỐI ƯU

1. **Chạy vào ban đêm:** Để máy chạy qua đêm, sáng kiểm tra kết quả
2. **Disable sleep:** System Settings → Lock Screen → Never
3. **Close apps:** Đóng Chrome/Safari để free RAM
4. **Plug in power:** Cắm sạc để M2 chạy full performance
5. **Check temperature:** Dùng cooling pad nếu máy nóng

## 🎓 HỌC THÊM

**Transfer Learning:**
- https://www.tensorflow.org/tutorials/images/transfer_learning

**EfficientNet:**
- https://arxiv.org/abs/1905.11946

**Oxford Flowers 102:**
- https://www.robots.ox.ac.uk/~vgg/data/flowers/102/

**TensorFlow on Apple Silicon:**
- https://developer.apple.com/metal/tensorflow-plugin/

---

**Created:** November 4, 2025  
**System:** MacBook Air M2 16GB  
**TensorFlow:** 2.20.0  
**Python:** 3.13.2
