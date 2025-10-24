#!/usr/bin/env python3
"""
Script để test Flask API cho Image Search
"""

import requests
import sys
import os
from pathlib import Path

API_URL = "http://localhost:8000"

def test_health():
    """Test health check endpoint"""
    print("Testing /health endpoint...")
    try:
        response = requests.get(f"{API_URL}/health", timeout=5)
        if response.status_code == 200:
            print("✓ Health check passed!")
            print(f"  Response: {response.json()}")
            return True
        else:
            print(f"✗ Health check failed with status {response.status_code}")
            return False
    except requests.exceptions.ConnectionError:
        print("✗ Cannot connect to API. Make sure the server is running on port 8000")
        return False
    except Exception as e:
        print(f"✗ Error: {str(e)}")
        return False

def test_predict(image_path):
    """Test predict endpoint with an image"""
    print(f"\nTesting /predict endpoint with image: {image_path}")

    if not os.path.exists(image_path):
        print(f"✗ Image file not found: {image_path}")
        return False

    try:
        with open(image_path, 'rb') as f:
            files = {'image': f}
            response = requests.post(f"{API_URL}/predict", files=files, timeout=30)

        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                print("✓ Prediction successful!")
                print(f"  Top predictions:")
                for i, pred in enumerate(data.get('predictions', []), 1):
                    print(f"    {i}. {pred['className']} - {pred['confidence']:.2%}")
                    if 'englishName' in pred:
                        print(f"       (English: {pred['englishName']})")
                return True
            else:
                print(f"✗ Prediction failed: {data.get('message')}")
                return False
        else:
            print(f"✗ Request failed with status {response.status_code}")
            print(f"  Response: {response.text}")
            return False
    except Exception as e:
        print(f"✗ Error: {str(e)}")
        return False

def find_test_image():
    """Find a test image in the images directory"""
    images_dir = Path("images/jpg")
    if images_dir.exists():
        image_files = list(images_dir.glob("*.jpg"))
        if image_files:
            return str(image_files[0])
    return None

def main():
    print("=" * 60)
    print("Oxford Flowers API Test")
    print("=" * 60)

    # Test 1: Health check
    if not test_health():
        print("\n⚠ API server is not running or not responding properly")
        print("Please start the API server first using:")
        print("  cd project_flowers && ./start_api.sh")
        print("  OR")
        print("  cd project_flowers && python app.py")
        sys.exit(1)

    # Test 2: Prediction
    if len(sys.argv) > 1:
        image_path = sys.argv[1]
    else:
        image_path = find_test_image()
        if not image_path:
            print("\n⚠ No test image provided and no images found in images/jpg/")
            print("Usage: python test_api.py <path_to_image>")
            sys.exit(1)

    success = test_predict(image_path)

    print("\n" + "=" * 60)
    if success:
        print("✓ All tests passed!")
    else:
        print("✗ Some tests failed")
    print("=" * 60)

    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
