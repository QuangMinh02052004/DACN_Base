"""
Pre-compute features for images in wwwroot/images directory
Fallback script when database is not accessible
"""

import os
import sys
import json
import pickle
import numpy as np
from PIL import Image
from pathlib import Path
import tensorflow as tf
from tensorflow.keras.applications import ResNet50
from tensorflow.keras.applications.resnet50 import preprocess_input
from tensorflow.keras.preprocessing import image as keras_image
from tqdm import tqdm

# Configuration
IMAGE_SIZE = (224, 224)
FEATURES_DB_PATH = "features_database"
FEATURES_FILE = os.path.join(FEATURES_DB_PATH, "product_features.pkl")
METADATA_FILE = os.path.join(FEATURES_DB_PATH, "product_metadata.json")

# Path to wwwroot/images
PROJECT_ROOT = Path(__file__).parent.parent
IMAGES_DIR = PROJECT_ROOT / "wwwroot" / "images"


def load_feature_extractor():
    """Load pre-trained ResNet50 model"""
    print("Loading ResNet50 model...")
    base_model = ResNet50(weights='imagenet', include_top=False, pooling='avg')
    print("Model loaded!")
    return base_model


def extract_features_from_image(model, img: Image.Image) -> np.ndarray:
    """Extract feature vector from image"""
    # Resize and preprocess
    img = img.convert('RGB')
    img = img.resize(IMAGE_SIZE)
    img_array = keras_image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array = preprocess_input(img_array)

    # Extract features
    features = model.predict(img_array, verbose=0)
    features = features.flatten()

    # Normalize
    features = features / np.linalg.norm(features)

    return features


def precompute_features_from_directory():
    """Main function to pre-compute features from wwwroot/images"""
    print("=" * 60)
    print("Pre-computing features from local images directory")
    print("=" * 60)

    # Check if images directory exists
    if not IMAGES_DIR.exists():
        print(f"ERROR: Images directory not found: {IMAGES_DIR}")
        return

    # Create output directory
    os.makedirs(FEATURES_DB_PATH, exist_ok=True)

    # Load feature extractor
    model = load_feature_extractor()

    # Find all image files
    image_extensions = ('.jpg', '.jpeg', '.png', '.gif', '.bmp')
    image_files = []
    for ext in image_extensions:
        image_files.extend(list(IMAGES_DIR.glob(f"*{ext}")))
        image_files.extend(list(IMAGES_DIR.glob(f"*{ext.upper()}")))

    if len(image_files) == 0:
        print(f"ERROR: No images found in {IMAGES_DIR}")
        return

    print(f"Found {len(image_files)} images")

    # Extract features
    features_list = []
    metadata_list = []
    failed_count = 0

    print(f"\nProcessing {len(image_files)} images...")

    for idx, image_path in enumerate(tqdm(image_files, desc="Extracting features")):
        try:
            # Load image
            img = Image.open(image_path)

            # Extract features
            features = extract_features_from_image(model, img)

            # Store
            features_list.append(features)

            # Use filename as product_id
            product_id = idx + 1  # Simple numeric ID
            image_filename = image_path.name

            metadata_list.append({
                'product_id': product_id,
                'image_url': f"/images/{image_filename}",
                'product_name': f"Product {product_id}",
                'product_price': 0.0,
                'local_path': str(image_path)
            })

        except Exception as e:
            print(f"\nError processing {image_path.name}: {e}")
            failed_count += 1
            continue

    # Save features
    if len(features_list) > 0:
        print(f"\nSaving {len(features_list)} product features...")

        # Save features as pickle
        with open(FEATURES_FILE, 'wb') as f:
            pickle.dump({
                'features': features_list,
                'feature_dimension': len(features_list[0])
            }, f)

        # Save metadata as JSON
        with open(METADATA_FILE, 'w', encoding='utf-8') as f:
            json.dump(metadata_list, f, ensure_ascii=False, indent=2)

        print(f"✓ Successfully processed {len(features_list)} images")
        print(f"✗ Failed to process {failed_count} images")
        print(f"\nFiles saved:")
        print(f"  - Features: {FEATURES_FILE}")
        print(f"  - Metadata: {METADATA_FILE}")
        print(f"\nDone! You can now test the image similarity search.")

    else:
        print("ERROR: No features extracted!")


if __name__ == "__main__":
    precompute_features_from_directory()
