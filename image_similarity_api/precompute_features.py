"""
Pre-compute features for all products in the database
Run this script whenever new products are added
"""

import os
import sys
import json
import pickle
import requests
import numpy as np
from PIL import Image
from io import BytesIO
from pathlib import Path
import tensorflow as tf
from tensorflow.keras.applications import ResNet50
from tensorflow.keras.applications.resnet50 import preprocess_input
from tensorflow.keras.preprocessing import image as keras_image
from urllib.parse import urljoin
from tqdm import tqdm

# Configuration
IMAGE_SIZE = (224, 224)
FEATURES_DB_PATH = "features_database"
FEATURES_FILE = os.path.join(FEATURES_DB_PATH, "product_features.pkl")
METADATA_FILE = os.path.join(FEATURES_DB_PATH, "product_metadata.json")

# API configuration - adjust based on your C# API
CSHARP_API_URL = "http://localhost:5000"  # Adjust port if needed
PRODUCTS_API_ENDPOINT = "/api/products"  # Endpoint to get all products


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


def load_image_from_url(image_url: str, base_url: str = None) -> Image.Image:
    """Load image from URL"""
    try:
        # Handle relative URLs
        if base_url and not image_url.startswith('http'):
            image_url = urljoin(base_url, image_url)

        # Download image
        response = requests.get(image_url, timeout=10)
        response.raise_for_status()

        img = Image.open(BytesIO(response.content))
        return img
    except Exception as e:
        print(f"Error loading image from {image_url}: {e}")
        return None


def load_image_from_local(image_path: str) -> Image.Image:
    """Load image from local file system"""
    try:
        # Handle wwwroot paths
        if image_path.startswith('/'):
            # Relative to project root
            project_root = Path(__file__).parent.parent
            full_path = project_root / image_path.lstrip('/')
        else:
            full_path = Path(image_path)

        if not full_path.exists():
            print(f"Image file not found: {full_path}")
            return None

        img = Image.open(full_path)
        return img
    except Exception as e:
        print(f"Error loading image from {image_path}: {e}")
        return None


def fetch_products_from_api():
    """Fetch all products from C# API"""
    print(f"Fetching products from {CSHARP_API_URL}{PRODUCTS_API_ENDPOINT}...")

    try:
        response = requests.get(f"{CSHARP_API_URL}{PRODUCTS_API_ENDPOINT}", timeout=30)
        response.raise_for_status()

        products = response.json()
        print(f"Fetched {len(products)} products")
        return products
    except Exception as e:
        print(f"Error fetching products from API: {e}")
        print("Will try to load from local database instead...")
        return None


def load_products_from_database():
    """Load products directly from database connection string"""
    print("Loading products from local database...")

    try:
        import pyodbc

        # Connection string - adjust based on your setup
        conn_str = (
            "Driver={SQL Server};"
            "Server=localhost;"
            "Database=BloomieDB;"
            "Trusted_Connection=yes;"
        )

        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()

        query = """
        SELECT Id, Name, ImageUrl, Price
        FROM Products
        WHERE IsActive = 1 AND ImageUrl IS NOT NULL
        """

        cursor.execute(query)
        rows = cursor.fetchall()

        products = []
        for row in rows:
            products.append({
                'id': row.Id,
                'name': row.Name,
                'imageUrl': row.ImageUrl,
                'price': float(row.Price) if row.Price else None
            })

        conn.close()
        print(f"Loaded {len(products)} products from database")
        return products

    except Exception as e:
        print(f"Error loading from database: {e}")
        return None


def precompute_features():
    """Main function to pre-compute features for all products"""
    print("=" * 60)
    print("Pre-computing features for product images")
    print("=" * 60)

    # Create output directory
    os.makedirs(FEATURES_DB_PATH, exist_ok=True)

    # Load feature extractor
    model = load_feature_extractor()

    # Fetch products
    products = fetch_products_from_api()

    if products is None:
        products = load_products_from_database()

    if products is None or len(products) == 0:
        print("ERROR: No products found!")
        print("Please ensure:")
        print("1. C# API is running, OR")
        print("2. Database connection is configured")
        return

    # Extract features
    features_list = []
    metadata_list = []
    failed_count = 0

    print(f"\nProcessing {len(products)} products...")

    for product in tqdm(products, desc="Extracting features"):
        try:
            product_id = product.get('id')
            image_url = product.get('imageUrl')
            product_name = product.get('name', '')
            product_price = product.get('price')

            if not image_url:
                failed_count += 1
                continue

            # Load image (try local first, then URL)
            img = None

            # Check if it's a local path
            if image_url.startswith('/') or not image_url.startswith('http'):
                img = load_image_from_local(image_url)

            # If local failed or it's a URL, try loading from URL
            if img is None and image_url.startswith('http'):
                img = load_image_from_url(image_url)

            # If still no image, try with base URL
            if img is None:
                img = load_image_from_url(image_url, base_url=CSHARP_API_URL)

            if img is None:
                failed_count += 1
                continue

            # Extract features
            features = extract_features_from_image(model, img)

            # Store
            features_list.append(features)
            metadata_list.append({
                'product_id': product_id,
                'image_url': image_url,
                'product_name': product_name,
                'product_price': product_price
            })

        except Exception as e:
            print(f"\nError processing product {product.get('id')}: {e}")
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

        print(f"✓ Successfully processed {len(features_list)} products")
        print(f"✗ Failed to process {failed_count} products")
        print(f"\nFiles saved:")
        print(f"  - Features: {FEATURES_FILE}")
        print(f"  - Metadata: {METADATA_FILE}")
        print("\nDone! You can now start the API server.")

    else:
        print("ERROR: No features extracted!")
        print("Please check image URLs and network connection.")


if __name__ == "__main__":
    precompute_features()
