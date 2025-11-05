"""
Image Similarity Search API
Shopee-style visual search using deep learning features
"""

from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import numpy as np
import tensorflow as tf
from tensorflow.keras.applications import ResNet50
from tensorflow.keras.applications.resnet50 import preprocess_input
from tensorflow.keras.preprocessing import image
import os
import json
import pickle
from pathlib import Path
from PIL import Image
import io
from sklearn.metrics.pairwise import cosine_similarity

app = FastAPI(
    title="Image Similarity Search API",
    description="Visual search API for finding similar products",
    version="1.0.0"
)

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configuration
FEATURE_VECTOR_SIZE = 2048
IMAGE_SIZE = (224, 224)
FEATURES_DB_PATH = "features_database"
FEATURES_FILE = os.path.join(FEATURES_DB_PATH, "product_features.pkl")
METADATA_FILE = os.path.join(FEATURES_DB_PATH, "product_metadata.json")

# Global variables
feature_extractor = None
products_database = None
features_matrix = None


class ProductMatch(BaseModel):
    product_id: int
    image_url: str
    similarity_score: float
    product_name: Optional[str] = None
    product_price: Optional[float] = None


class SimilaritySearchResponse(BaseModel):
    success: bool
    message: str
    matches: List[ProductMatch] = []
    total_matches: int = 0


class ProductFeature(BaseModel):
    product_id: int
    image_url: str
    product_name: Optional[str] = None
    product_price: Optional[float] = None


def load_feature_extractor():
    """Load pre-trained ResNet50 model for feature extraction"""
    global feature_extractor

    if feature_extractor is None:
        print("Loading ResNet50 model...")
        base_model = ResNet50(weights='imagenet', include_top=False, pooling='avg')
        feature_extractor = base_model
        print("Model loaded successfully!")

    return feature_extractor


def load_products_database():
    """Load pre-computed product features from disk"""
    global products_database, features_matrix

    if not os.path.exists(FEATURES_FILE) or not os.path.exists(METADATA_FILE):
        print("Features database not found. Please run pre-compute script first.")
        return False

    try:
        # Load features
        with open(FEATURES_FILE, 'rb') as f:
            data = pickle.load(f)
            features_matrix = np.array(data['features'])

        # Load metadata
        with open(METADATA_FILE, 'r', encoding='utf-8') as f:
            products_database = json.load(f)

        print(f"Loaded {len(products_database)} products from database")
        return True
    except Exception as e:
        print(f"Error loading database: {e}")
        return False


def extract_features_from_image(img: Image.Image) -> np.ndarray:
    """Extract feature vector from image using ResNet50"""
    model = load_feature_extractor()

    # Resize and preprocess
    img = img.convert('RGB')
    img = img.resize(IMAGE_SIZE)
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array = preprocess_input(img_array)

    # Extract features
    features = model.predict(img_array, verbose=0)
    features = features.flatten()

    # Normalize
    features = features / np.linalg.norm(features)

    return features


def find_similar_products(query_features: np.ndarray, top_k: int = 20) -> List[ProductMatch]:
    """Find most similar products using cosine similarity"""
    global features_matrix, products_database

    if features_matrix is None or products_database is None:
        return []

    # Compute similarities
    query_features = query_features.reshape(1, -1)
    similarities = cosine_similarity(query_features, features_matrix)[0]

    # Get top K indices
    top_indices = np.argsort(similarities)[::-1][:top_k]

    # Build results
    matches = []
    for idx in top_indices:
        similarity_score = float(similarities[idx])

        # Only return results with reasonable similarity (> 0.3)
        if similarity_score < 0.3:
            continue

        product = products_database[idx]
        matches.append(ProductMatch(
            product_id=product['product_id'],
            image_url=product['image_url'],
            similarity_score=similarity_score,
            product_name=product.get('product_name'),
            product_price=product.get('product_price')
        ))

    return matches


@app.on_event("startup")
async def startup_event():
    """Initialize models and database on startup"""
    print("Starting Image Similarity API...")
    os.makedirs(FEATURES_DB_PATH, exist_ok=True)

    load_feature_extractor()
    load_products_database()

    print("API ready!")


@app.get("/")
async def root():
    """Health check endpoint"""
    return {
        "service": "Image Similarity Search API",
        "status": "running",
        "version": "1.0.0",
        "database_loaded": products_database is not None,
        "total_products": len(products_database) if products_database else 0
    }


@app.get("/health")
async def health_check():
    """Detailed health check"""
    return {
        "status": "healthy",
        "model_loaded": feature_extractor is not None,
        "database_loaded": products_database is not None,
        "total_products": len(products_database) if products_database else 0,
        "feature_dimension": FEATURE_VECTOR_SIZE
    }


@app.post("/search/similar", response_model=SimilaritySearchResponse)
async def search_similar_products(
    file: UploadFile = File(...),
    top_k: int = 20
):
    """
    Find similar products by uploading an image

    Args:
        file: Image file (jpg, png, webp)
        top_k: Number of similar products to return (default: 20)

    Returns:
        List of similar products with similarity scores
    """
    try:
        # Validate file type
        if not file.content_type.startswith('image/'):
            raise HTTPException(status_code=400, detail="File must be an image")

        # Check if database is loaded
        if products_database is None or features_matrix is None:
            raise HTTPException(
                status_code=503,
                detail="Features database not loaded. Please run pre-compute script."
            )

        # Read image
        contents = await file.read()
        img = Image.open(io.BytesIO(contents))

        # Extract features
        query_features = extract_features_from_image(img)

        # Find similar products
        matches = find_similar_products(query_features, top_k=top_k)

        return SimilaritySearchResponse(
            success=True,
            message=f"Found {len(matches)} similar products",
            matches=matches,
            total_matches=len(matches)
        )

    except HTTPException:
        raise
    except Exception as e:
        print(f"Error processing image: {e}")
        raise HTTPException(status_code=500, detail=f"Error processing image: {str(e)}")


@app.post("/features/extract")
async def extract_features(file: UploadFile = File(...)):
    """
    Extract feature vector from an image

    Useful for debugging or pre-computing features
    """
    try:
        if not file.content_type.startswith('image/'):
            raise HTTPException(status_code=400, detail="File must be an image")

        contents = await file.read()
        img = Image.open(io.BytesIO(contents))

        features = extract_features_from_image(img)

        return {
            "success": True,
            "feature_dimension": len(features),
            "features": features.tolist()[:10]  # Return first 10 values as sample
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/database/info")
async def database_info():
    """Get information about the features database"""
    if products_database is None:
        return {
            "database_loaded": False,
            "message": "No database loaded"
        }

    return {
        "database_loaded": True,
        "total_products": len(products_database),
        "feature_dimension": FEATURE_VECTOR_SIZE,
        "sample_products": products_database[:3] if len(products_database) > 0 else []
    }


@app.post("/database/reload")
async def reload_database():
    """Reload the features database"""
    success = load_products_database()

    if success:
        return {
            "success": True,
            "message": "Database reloaded successfully",
            "total_products": len(products_database) if products_database else 0
        }
    else:
        raise HTTPException(
            status_code=500,
            detail="Failed to reload database"
        )


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
