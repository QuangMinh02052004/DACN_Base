# 🎓 Hướng dẫn Training Model cho độ chính xác cao hơn

## ❌ Vấn đề hiện tại:
- Oxford Flowers 102 model được train với **102 loại hoa quốc tế**
- Database của bạn có **các loại hoa Việt Nam** khác
- Model nhận diện sai vì không được train với ảnh hoa từ shop bạn

---

## 🎯 Giải pháp: Fine-tune Model với dữ liệu thực tế

### Phương án 1: Transfer Learning (Khuyến nghị - Dễ nhất)

**Ý tưởng:** Dùng Oxford model làm nền tảng, train thêm với ảnh từ database của bạn.

#### Bước 1: Chuẩn bị dữ liệu

```bash
# Tạo cấu trúc thư mục
cd project_flowers
mkdir -p training_data/{train,validation}
```

**Thu thập ảnh:**
```
training_data/
├── train/
│   ├── hoa_hong/          # 50-100 ảnh hoa hồng từ shop bạn
│   ├── hoa_cuc/           # 50-100 ảnh hoa cúc
│   ├── hoa_huong_duong/   # 50-100 ảnh hướng dương
│   ├── hoa_ly/            # 50-100 ảnh lily
│   └── ...
└── validation/
    ├── hoa_hong/          # 10-20 ảnh test
    ├── hoa_cuc/
    └── ...
```

#### Bước 2: Script Training

```python
# train_custom_model.py
import tensorflow as tf
from tensorflow.keras.applications import EfficientNetB0
from tensorflow.keras.layers import Dense, GlobalAveragePooling2D, Dropout
from tensorflow.keras.models import Model
from tensorflow.keras.preprocessing.image import ImageDataGenerator
import os

# Configuration
IMG_SIZE = 224
BATCH_SIZE = 32
EPOCHS = 50
NUM_CLASSES = len(os.listdir('training_data/train'))  # Số loại hoa của bạn

# Load base model (Oxford hoặc EfficientNet)
base_model = EfficientNetB0(
    weights='imagenet',
    include_top=False,
    input_shape=(IMG_SIZE, IMG_SIZE, 3)
)

# Freeze base layers
base_model.trainable = False

# Add custom layers
x = base_model.output
x = GlobalAveragePooling2D()(x)
x = Dense(512, activation='relu')(x)
x = Dropout(0.5)(x)
predictions = Dense(NUM_CLASSES, activation='softmax')(x)

model = Model(inputs=base_model.input, outputs=predictions)

# Compile
model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

# Data augmentation
train_datagen = ImageDataGenerator(
    rescale=1./255,
    rotation_range=20,
    width_shift_range=0.2,
    height_shift_range=0.2,
    horizontal_flip=True,
    fill_mode='nearest'
)

val_datagen = ImageDataGenerator(rescale=1./255)

# Load data
train_generator = train_datagen.flow_from_directory(
    'training_data/train',
    target_size=(IMG_SIZE, IMG_SIZE),
    batch_size=BATCH_SIZE,
    class_mode='categorical'
)

validation_generator = val_datagen.flow_from_directory(
    'training_data/validation',
    target_size=(IMG_SIZE, IMG_SIZE),
    batch_size=BATCH_SIZE,
    class_mode='categorical'
)

# Train
history = model.fit(
    train_generator,
    epochs=EPOCHS,
    validation_data=validation_generator,
    callbacks=[
        tf.keras.callbacks.EarlyStopping(patience=5, restore_best_weights=True),
        tf.keras.callbacks.ReduceLROnPlateau(patience=3, factor=0.5)
    ]
)

# Save model
model.save('bloomie_custom_model.h5')

# Save class names
import json
class_names = list(train_generator.class_indices.keys())
with open('bloomie_class_names.json', 'w', encoding='utf-8') as f:
    json.dump(class_names, f, ensure_ascii=False, indent=2)

print(f"✅ Model trained successfully!")
print(f"📊 Classes: {class_names}")
print(f"🎯 Final accuracy: {max(history.history['val_accuracy']):.2%}")
```

#### Bước 3: Chạy Training

```bash
cd project_flowers
python train_custom_model.py
```

**Thời gian:** 30 phút - 2 giờ (tùy số lượng ảnh và máy tính)

#### Bước 4: Sử dụng model mới

Update `enhanced_api.py`:
```python
def load_model(self):
    try:
        # Dùng model custom thay vì Oxford
        self.oxford_model = tf.keras.models.load_model('bloomie_custom_model.h5')
        logger.info("✅ Loaded custom Bloomie model")
    except Exception as e:
        # Fallback to Oxford
        self.oxford_model = tf.keras.models.load_model('oxford102_m2_optimized.h5')
        logger.warning("⚠️ Using Oxford model as fallback")
```

---

## 🔧 Phương án 2: Cải thiện Enhancement Rules (Nhanh hơn)

Không cần train lại, chỉ cần **thêm rules thông minh hơn** dựa trên:

### A. Color Analysis + Shape Detection

```python
def advanced_flower_detection(self, image, predictions):
    """Enhanced detection với nhiều features"""
    
    # 1. Color analysis (đã có)
    color = self.analyze_flower_color(image)
    
    # 2. Shape detection (NEW)
    shape = self.detect_flower_shape(image)  # round, star, bell, etc.
    
    # 3. Texture analysis (NEW)
    texture = self.analyze_texture(image)  # smooth, layered, etc.
    
    # 4. Size estimation (NEW)
    size = self.estimate_flower_size(image)  # small, medium, large
    
    # Combine all features
    if color == "red" and shape == "layered_petals" and texture == "smooth":
        return {
            "className": "Hoa Hồng",
            "confidence": 0.90,
            "reason": "color+shape+texture match"
        }
    
    # More rules...
```

### B. Database Matching

Kết hợp với database thực tế:
```python
def match_with_database(self, predicted_name, color_analysis):
    """So sánh với sản phẩm trong database"""
    
    # Query database
    db_flowers = get_flowers_from_database()
    
    # Find best match by:
    # - Vietnamese name similarity
    # - Color matching
    # - Price range
    # - Availability
    
    best_match = find_best_match(predicted_name, db_flowers, color_analysis)
    return best_match
```

---

## 📊 Phương án 3: Hybrid Approach (Tốt nhất)

Kết hợp **Model + Rules + Database**:

```python
class HybridFlowerRecognition:
    def predict(self, image):
        # 1. Model prediction
        model_result = self.model.predict(image)
        
        # 2. Enhancement rules
        enhanced_result = self.apply_enhancement_rules(image, model_result)
        
        # 3. Database matching
        final_result = self.match_with_database(enhanced_result)
        
        # 4. Confidence boosting
        if database_has_exact_match:
            final_result['confidence'] = min(0.95, final_result['confidence'] + 0.15)
        
        return final_result
```

---

## 🎯 So sánh các phương án:

| Phương án | Độ chính xác | Thời gian setup | Chi phí | Khuyến nghị |
|-----------|--------------|-----------------|---------|-------------|
| **Fine-tune Model** | ⭐⭐⭐⭐⭐ (95%+) | 2-3 ngày | Cần GPU | Production |
| **Enhancement Rules** | ⭐⭐⭐⭐ (85-90%) | 1-2 giờ | Free | Quick fix |
| **Hybrid** | ⭐⭐⭐⭐⭐ (98%+) | 3-4 ngày | Cần GPU | Best |

---

## ✅ Khuyến nghị cho bạn:

### Ngắn hạn (1-2 ngày):
1. ✅ **Thu thập ảnh** từ website của shop hoa Việt Nam
2. ✅ **Cải thiện enhancement rules** với nhiều màu sắc và patterns
3. ✅ **Kết hợp database matching**

### Dài hạn (1-2 tuần):
1. 📸 **Thu thập 50-100 ảnh cho mỗi loại hoa** trong database
2. 🎓 **Train custom model** với transfer learning
3. 🚀 **Deploy model mới** thay thế Oxford model

---

## 💡 Quick Wins (Làm ngay):

### 1. Thêm mapping cho hoa Việt Nam:

```python
# Vietnamese flower mapping
VIETNAMESE_FLOWER_MAP = {
    "rose": "Hoa Hồng",
    "sunflower": "Hoa Hướng Dương", 
    "lily": "Hoa Lily",
    "daisy": "Hoa Cúc",
    "carnation": "Hoa Cẩm Chướng",
    "tulip": "Hoa Tulip",
    "orchid": "Hoa Lan",
    "chrysanthemum": "Hoa Cúc Vàng",
    # Add more...
}
```

### 2. Color-based correction:

```python
def color_correction(predicted_class, dominant_color):
    """Fix common mistakes based on color"""
    
    # Red flowers
    if dominant_color == "red":
        if "lily" in predicted_class.lower():
            return "Hoa Hồng"  # Likely a rose, not lily
    
    # Yellow flowers
    if dominant_color == "bright_yellow":
        if "daisy" in predicted_class.lower():
            return "Hoa Hướng Dương"  # Likely sunflower
    
    return predicted_class
```

---

## 🆘 Tôi có thể giúp gì?

1. ✅ **Viết script training** cho model custom
2. ✅ **Cải thiện enhancement rules** với patterns mới
3. ✅ **Setup database integration** để match với sản phẩm thật
4. ✅ **Thu thập và label data** từ nguồn online

Bạn muốn làm theo phương án nào? Tôi sẽ implement ngay! 🚀
