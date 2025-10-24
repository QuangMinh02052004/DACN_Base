#!/usr/bin/env python3
"""
Test Enhanced API with Flower Images
Test the enhanced flower recognition API with various flower types
"""

import requests
import json
import os
from pathlib import Path

# API endpoints
ENHANCED_API = "http://localhost:8001"


def test_api_health():
    """Test API health check"""
    try:
        response = requests.get(f"{ENHANCED_API}/health")
        print(f"✅ API Health: {response.json()}")
        return True
    except Exception as e:
        print(f"❌ API Health Failed: {e}")
        return False


def test_image_prediction(image_path, mode="enhanced"):
    """Test image prediction with enhanced API"""
    try:
        with open(image_path, "rb") as f:
            files = {"file": f}
            data = {"mode": mode}
            response = requests.post(f"{ENHANCED_API}/predict", files=files, data=data)

        result = response.json()
        print(f"\n🖼️  Testing: {os.path.basename(image_path)}")
        print(f"📊 Mode: {mode}")

        if result.get("success"):
            predictions = result.get("predictions", [])
            if predictions:
                top_prediction = predictions[0]
                print(
                    f"🌸 Top Result: {top_prediction.get('className')} ({top_prediction.get('confidence', 0):.1%})"
                )

                # Show top 3 results
                print("📋 Top 3 Results:")
                for i, flower in enumerate(predictions[:3], 1):
                    print(
                        f"   {i}. {flower.get('className')} - {flower.get('confidence', 0):.1%}"
                    )

                # Show enhancement info
                if top_prediction.get("enhanced"):
                    print(
                        f"🎨 Enhancement Applied: {top_prediction.get('enhanced', False)}"
                    )
                    print(
                        f"💭 Reason: {top_prediction.get('enhancementReason', 'N/A')}"
                    )
            else:
                print("🌸 No predictions returned")

        else:
            print(f"❌ Error: {result.get('message', 'Unknown error')}")

        return result

    except Exception as e:
        print(f"❌ Test failed: {e}")
        return None


def test_search_by_image(image_path):
    """Test search-by-image endpoint (C# compatible)"""
    try:
        with open(image_path, "rb") as f:
            files = {"image": f}
            response = requests.post(f"{ENHANCED_API}/search-by-image", files=files)

        result = response.json()
        print(f"\n🔍 Search Test: {os.path.basename(image_path)}")

        if result.get("success"):
            print(f"🌸 Flower: {result.get('flower_name')}")
            print(f"📈 Confidence: {result.get('confidence'):.1%}")
            print(f"📊 Level: {result.get('confidence_level')}")
            print(f"💬 Message: {result.get('message')}")
            print(f"📋 Max Results: {result.get('max_results')}")

            # Show filtering info
            filtering_info = result.get("filtering_info", {})
            if filtering_info:
                print(f"🎯 Filter Applied: {filtering_info}")

        else:
            print(f"❌ Error: {result.get('error')}")

        return result

    except Exception as e:
        print(f"❌ Search test failed: {e}")
        return None


def main():
    """Run enhanced API tests"""
    print("🚀 Testing Enhanced Flower Recognition API")
    print("=" * 50)

    # Test API health
    if not test_api_health():
        print("❌ API not available. Please start enhanced_api.py")
        return

    # Look for test images
    image_extensions = [".jpg", ".jpeg", ".png", ".bmp"]
    test_images = []

    # Check images/jpg folder
    images_jpg_dir = Path("images/jpg")
    if images_jpg_dir.exists():
        for ext in image_extensions:
            test_images.extend(list(images_jpg_dir.glob(f"*{ext}")))
            test_images.extend(list(images_jpg_dir.glob(f"*{ext.upper()}")))

    # Check images folder
    images_dir = Path("images")
    if images_dir.exists():
        for ext in image_extensions:
            test_images.extend(list(images_dir.glob(f"*{ext}")))
            test_images.extend(list(images_dir.glob(f"*{ext.upper()}")))

    # Check current directory
    current_dir = Path(".")
    for ext in image_extensions:
        test_images.extend(list(current_dir.glob(f"*{ext}")))
        test_images.extend(list(current_dir.glob(f"*{ext.upper()}")))

    if not test_images:
        print("❌ No test images found!")
        print("💡 Please add some flower images (.jpg, .png, etc.)")
        print("   Suggested images: rose.jpg, tulip.jpg, daisy.jpg")
        return

    # Remove duplicates and limit
    test_images = list(set(test_images))[
        :5
    ]  # Test with first 5 images    print(f"📸 Found {len(test_images)} test images")

    # Test each image with different modes
    for image_path in test_images[:3]:  # Limit to first 3 images
        print("\n" + "=" * 60)

        # Test enhanced mode
        test_image_prediction(str(image_path), mode="enhanced")

        # Test search-by-image
        test_search_by_image(str(image_path))

        # Test oxford mode for comparison
        print("\n📊 Oxford Mode Comparison:")
        test_image_prediction(str(image_path), mode="oxford")

    print("\n" + "=" * 60)
    print("✅ Enhanced API testing completed!")
    print("🌸 Check results above for accuracy improvements")


if __name__ == "__main__":
    main()
