# Image Similarity Search API

Shopee-style visual search API using deep learning for finding similar products.

## Features

- 🔍 Find similar products by uploading an image
- 🚀 Fast similarity search using pre-computed features
- 🎯 High accuracy with ResNet50 deep learning model
- 📊 RESTful API for easy integration
- 🔄 Supports multiple projects

## Installation

1. Install Python dependencies:
```bash
pip install -r requirements.txt
```

2. Pre-compute features for your products:
```bash
# Make sure your C# API is running first
python precompute_features.py
```

3. Start the API server:
```bash
python app.py
# Or with uvicorn:
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

## API Endpoints

### Health Check
```
GET /
GET /health
```

### Search Similar Products
```
POST /search/similar
Content-Type: multipart/form-data

Parameters:
- file: Image file (required)
- top_k: Number of results (default: 20)

Response:
{
  "success": true,
  "message": "Found 15 similar products",
  "matches": [
    {
      "product_id": 123,
      "image_url": "/uploads/product.jpg",
      "similarity_score": 0.95,
      "product_name": "Hoa hồng đỏ",
      "product_price": 250000
    }
  ],
  "total_matches": 15
}
```

### Extract Features
```
POST /features/extract
Content-Type: multipart/form-data

Parameters:
- file: Image file

Response:
{
  "success": true,
  "feature_dimension": 2048,
  "features": [0.123, -0.456, ...]
}
```

### Database Info
```
GET /database/info

Response:
{
  "database_loaded": true,
  "total_products": 150,
  "feature_dimension": 2048
}
```

### Reload Database
```
POST /database/reload

Response:
{
  "success": true,
  "message": "Database reloaded successfully",
  "total_products": 150
}
```

## How It Works

1. **Feature Extraction**: Uses ResNet50 (pre-trained on ImageNet) to extract 2048-dimensional feature vectors from images
2. **Pre-computation**: All product images are processed once and features are stored
3. **Similarity Search**: When user uploads an image, we extract its features and compare with all stored features using cosine similarity
4. **Results**: Returns top-K most similar products ranked by similarity score

## Configuration

Edit `app.py` to configure:
- `FEATURE_VECTOR_SIZE`: Feature dimension (default: 2048)
- `IMAGE_SIZE`: Input image size (default: 224x224)
- `FEATURES_DB_PATH`: Path to features database

Edit `precompute_features.py` to configure:
- `CSHARP_API_URL`: Your C# API URL
- `PRODUCTS_API_ENDPOINT`: Endpoint to fetch products

## Performance

- Feature extraction: ~100ms per image
- Similarity search: ~10ms for 1000 products
- Recommended: Pre-compute features for all products

## Integration with C#

See C# service examples in the main project.

## Troubleshooting

**Q: "Features database not loaded"**
A: Run `python precompute_features.py` first

**Q: "No products found"**
A: Make sure your C# API is running and accessible

**Q: Low accuracy**
A: Try increasing image quality or adjusting similarity threshold in code

## License

MIT
