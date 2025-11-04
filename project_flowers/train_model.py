"""
Script để train lại model Oxford 102 Flowers với accuracy cao hơn
Tối ưu cho MacBook Air M2 16GB với Metal GPU acceleration
Sử dụng Transfer Learning với EfficientNetB0
"""

# Fix SSL certificate issue for macOS Python 3.13
import ssl
import certifi

ssl._create_default_https_context = ssl._create_unverified_context

import tensorflow as tf
import tensorflow_datasets as tfds
from tensorflow import keras
from tensorflow.keras.applications import MobileNetV2  # Changed from EfficientNetB0
from tensorflow.keras.layers import (
    Dense,
    GlobalAveragePooling2D,
    Dropout,
    BatchNormalization,
)
from tensorflow.keras.models import Model
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.callbacks import (
    ModelCheckpoint,
    EarlyStopping,
    ReduceLROnPlateau,
    TensorBoard,
)
import numpy as np
import json
import os
from datetime import datetime

# ==================== APPLE M2 OPTIMIZATION ====================
# Enable Metal GPU acceleration
print("=" * 70)
print("🚀 CONFIGURING TENSORFLOW FOR APPLE M2 GPU")
print("=" * 70)

# Check available devices
physical_devices = tf.config.list_physical_devices()
print(f"Available devices: {physical_devices}")

# Enable memory growth for GPU
gpus = tf.config.list_physical_devices("GPU")
if gpus:
    try:
        for gpu in gpus:
            tf.config.experimental.set_memory_growth(gpu, True)
        print(f"✅ Metal GPU enabled: {len(gpus)} GPU(s) found")
        print(f"   GPU devices: {[gpu.name for gpu in gpus]}")
    except RuntimeError as e:
        print(f"⚠️  GPU setup warning: {e}")
else:
    print("⚠️  No GPU found, using CPU only")

# NOTE: Mixed precision disabled due to compatibility issues with pre-trained weights
# tf.keras.mixed_precision.set_global_policy('mixed_float16')
print("ℹ️  Using float32 precision for compatibility with pre-trained weights")

print("=" * 70)
print()

# Configuration
IMG_SIZE = 224
BATCH_SIZE = 64  # Tăng batch size cho M2 16GB RAM
EPOCHS = 50
NUM_CLASSES = 102
LEARNING_RATE = 0.001
VALIDATION_SPLIT = 0.15


def create_improved_model():
    """
    Tạo model mới với MobileNetV2 base
    Accuracy dự kiến: 85-90%
    """
    print("Creating improved model with MobileNetV2...")

    # Load pre-trained MobileNetV2 (trained on ImageNet)
    base_model = MobileNetV2(
        weights="imagenet", include_top=False, input_shape=(IMG_SIZE, IMG_SIZE, 3)
    )

    # Freeze base model layers initially
    base_model.trainable = False

    # Add custom classification head
    x = base_model.output
    x = GlobalAveragePooling2D()(x)
    x = Dense(512, activation="relu")(x)
    x = Dropout(0.3)(x)
    x = Dense(256, activation="relu")(x)
    x = Dropout(0.2)(x)
    predictions = Dense(NUM_CLASSES, activation="softmax")(x)

    model = Model(inputs=base_model.input, outputs=predictions)

    print(f"Model created with {len(model.layers)} layers")
    return model, base_model


def compile_model(model):
    """Compile model với optimizer phù hợp"""
    model.compile(
        optimizer=Adam(learning_rate=LEARNING_RATE),
        loss="categorical_crossentropy",
        metrics=["accuracy", "top_k_categorical_accuracy"],
    )
    print("Model compiled successfully!")
    return model


def get_callbacks(model_name="oxford102_improved.h5"):
    """Tạo callbacks để train tốt hơn"""
    callbacks = [
        # Save best model
        ModelCheckpoint(
            model_name,
            monitor="val_accuracy",
            save_best_only=True,
            mode="max",
            verbose=1,
        ),
        # Early stopping nếu không cải thiện
        EarlyStopping(
            monitor="val_accuracy", patience=10, restore_best_weights=True, verbose=1
        ),
        # Giảm learning rate khi plateau
        ReduceLROnPlateau(
            monitor="val_loss", factor=0.5, patience=5, min_lr=1e-7, verbose=1
        ),
    ]
    return callbacks


def train_model_phase1(model, train_data, val_data):
    """
    Phase 1: Train top layers only (frozen base)
    """
    print("\n" + "=" * 60)
    print("PHASE 1: Training top layers only")
    print("=" * 60)

    history1 = model.fit(
        train_data,
        validation_data=val_data,
        epochs=10,
        callbacks=get_callbacks("oxford102_phase1.h5"),
        verbose=1,
    )
    return history1


def train_model_phase2(model, base_model, train_data, val_data):
    """
    Phase 2: Fine-tune last layers of base model
    """
    print("\n" + "=" * 60)
    print("PHASE 2: Fine-tuning base model")
    print("=" * 60)

    # Unfreeze last 20 layers of base model
    base_model.trainable = True
    for layer in base_model.layers[:-20]:
        layer.trainable = False

    # Recompile với learning rate thấp hơn
    model.compile(
        optimizer=Adam(learning_rate=LEARNING_RATE / 10),
        loss="categorical_crossentropy",
        metrics=["accuracy", "top_k_categorical_accuracy"],
    )

    history2 = model.fit(
        train_data,
        validation_data=val_data,
        epochs=40,
        callbacks=get_callbacks("oxford102_improved.h5"),
        verbose=1,
    )
    return history2


def load_and_prepare_data():
    """
    Load Oxford Flowers 102 dataset using TensorFlow Datasets
    Dataset sẽ tự động download (~350MB)
    """
    print("\n" + "=" * 70)
    print("📥 LOADING OXFORD FLOWERS 102 DATASET")
    print("=" * 70)

    # Load dataset from TensorFlow Datasets
    print("Downloading dataset... (this may take a few minutes)")
    (ds_train, ds_val, ds_test), ds_info = tfds.load(
        "oxford_flowers102",
        split=["train", "validation", "test"],
        as_supervised=True,
        with_info=True,
    )

    print(f"✅ Dataset loaded successfully!")
    print(f"   Train samples: {ds_info.splits['train'].num_examples}")
    print(f"   Validation samples: {ds_info.splits['validation'].num_examples}")
    print(f"   Test samples: {ds_info.splits['test'].num_examples}")
    print(f"   Number of classes: {ds_info.features['label'].num_classes}")

    # Data augmentation function
    def preprocess_train(image, label):
        """Augmentation for training data"""
        image = tf.image.resize(image, [IMG_SIZE, IMG_SIZE])
        image = tf.cast(image, tf.float32) / 255.0

        # Random augmentation
        image = tf.image.random_flip_left_right(image)
        image = tf.image.random_brightness(image, 0.2)
        image = tf.image.random_contrast(image, 0.8, 1.2)
        image = tf.image.random_saturation(image, 0.8, 1.2)

        # One-hot encode label
        label = tf.one_hot(label, NUM_CLASSES)
        return image, label

    def preprocess_val(image, label):
        """Simple preprocessing for validation/test data"""
        image = tf.image.resize(image, [IMG_SIZE, IMG_SIZE])
        image = tf.cast(image, tf.float32) / 255.0
        label = tf.one_hot(label, NUM_CLASSES)
        return image, label

    # Prepare datasets
    print("\n🔄 Preparing data pipelines...")
    AUTOTUNE = tf.data.AUTOTUNE

    train_data = (
        ds_train.map(preprocess_train, num_parallel_calls=AUTOTUNE)
        .cache()
        .shuffle(1000)
        .batch(BATCH_SIZE)
        .prefetch(AUTOTUNE)
    )

    val_data = (
        ds_val.map(preprocess_val, num_parallel_calls=AUTOTUNE)
        .cache()
        .batch(BATCH_SIZE)
        .prefetch(AUTOTUNE)
    )

    test_data = (
        ds_test.map(preprocess_val, num_parallel_calls=AUTOTUNE)
        .cache()
        .batch(BATCH_SIZE)
        .prefetch(AUTOTUNE)
    )

    print("✅ Data pipelines ready!")
    print(f"   Batch size: {BATCH_SIZE}")
    print(f"   Image size: {IMG_SIZE}x{IMG_SIZE}")
    print("=" * 70)

    return train_data, val_data, test_data


def main():
    """
    Main training pipeline - TỰ ĐỘNG HÓA HOÀN TOÀN
    Tối ưu cho MacBook Air M2 16GB
    """
    print("\n" + "=" * 70)
    print("🌸 OXFORD 102 FLOWERS - IMPROVED MODEL TRAINING")
    print("🍎 Optimized for Apple M2 GPU")
    print("=" * 70)

    start_time = datetime.now()

    try:
        # Step 1: Load dataset
        train_data, val_data, test_data = load_and_prepare_data()

        # Step 2: Create model
        model, base_model = create_improved_model()
        model = compile_model(model)

        # Print model summary
        print("\n📊 MODEL ARCHITECTURE:")
        model.summary()

        # Step 3: Two-phase training
        print("\n" + "=" * 70)
        print("🚀 STARTING TRAINING")
        print("=" * 70)

        history1 = train_model_phase1(model, train_data, val_data)
        history2 = train_model_phase2(model, base_model, train_data, val_data)

        # Step 4: Evaluate on test set
        print("\n" + "=" * 70)
        print("📈 EVALUATING ON TEST SET")
        print("=" * 70)
        test_loss, test_acc, test_top5_acc = model.evaluate(test_data)
        print(f"Test Accuracy: {test_acc:.2%}")
        print(f"Test Top-5 Accuracy: {test_top5_acc:.2%}")

        # Step 5: Save final results
        elapsed_time = datetime.now() - start_time
        print("\n" + "=" * 70)
        print("✅ TRAINING COMPLETED!")
        print("=" * 70)
        print(f"⏱️  Total training time: {elapsed_time}")
        print(
            f"🎯 Best validation accuracy: {max(history2.history['val_accuracy']):.2%}"
        )
        print(f"🎯 Test accuracy: {test_acc:.2%}")
        print(f"💾 Model saved as: oxford102_improved.h5")
        print("=" * 70)

        # Save training history
        history_file = "training_history.json"
        with open(history_file, "w") as f:
            json.dump(
                {
                    "phase1": {
                        k: [float(v) for v in vals]
                        for k, vals in history1.history.items()
                    },
                    "phase2": {
                        k: [float(v) for v in vals]
                        for k, vals in history2.history.items()
                    },
                    "test_accuracy": float(test_acc),
                    "test_top5_accuracy": float(test_top5_acc),
                    "training_time": str(elapsed_time),
                },
                f,
                indent=2,
            )
        print(f"📊 Training history saved to: {history_file}")

    except KeyboardInterrupt:
        print("\n\n⚠️  Training interrupted by user!")
        print("Model checkpoints have been saved.")
    except Exception as e:
        print(f"\n\n❌ Error during training: {e}")
        raise


if __name__ == "__main__":
    main()
