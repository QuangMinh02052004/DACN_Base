#!/usr/bin/env python3
"""
Test Script for Enhanced Flower Recognition API
So sánh kết quả giữa original API và enhanced API
"""

import requests
import os
import json
from datetime import datetime


def test_api_endpoint(image_path, api_url, mode="enhanced"):
    """Test API endpoint với hình ảnh"""
    if not os.path.exists(image_path):
        print(f"❌ Image not found: {image_path}")
        return None

    try:
        with open(image_path, "rb") as f:
            files = {"image": f}
            data = {"mode": mode} if "enhanced" in api_url else {}

            response = requests.post(api_url, files=files, data=data, timeout=30)

        if response.status_code == 200:
            return response.json()
        else:
            print(f"❌ API Error: {response.status_code} - {response.text}")
            return None

    except Exception as e:
        print(f"❌ Request failed: {str(e)}")
        return None


def compare_apis(image_path):
    """So sánh kết quả giữa original và enhanced API"""
    print(f"\n🔬 TESTING IMAGE: {os.path.basename(image_path)}")
    print("=" * 60)

    # URLs
    original_url = "http://localhost:8000/predict"
    enhanced_url = "http://localhost:8001/predict"  # Enhanced API on different port

    # Test original API
    print("📊 Testing Original API...")
    original_result = test_api_endpoint(image_path, original_url)

    # Test enhanced API - Enhanced mode
    print("🚀 Testing Enhanced API (Enhanced Mode)...")
    enhanced_result = test_api_endpoint(image_path, enhanced_url, "enhanced")

    # Test enhanced API - Oxford only mode
    print("📈 Testing Enhanced API (Oxford Only Mode)...")
    oxford_result = test_api_endpoint(image_path, enhanced_url, "oxford")

    # Test enhanced API - Visual rules mode
    print("🎨 Testing Enhanced API (Visual Rules Mode)...")
    visual_result = test_api_endpoint(image_path, enhanced_url, "visual")

    # Display comparison
    print("\n🏆 RESULTS COMPARISON:")
    print("=" * 60)

    if original_result and original_result.get("success"):
        top_original = original_result["predictions"][0]
        print(f"ORIGINAL API:")
        print(f"  🌸 {top_original['className']} ({top_original['confidence']:.1%})")
        print(f"  📝 {top_original['englishName']}")

    if enhanced_result and enhanced_result.get("success"):
        top_enhanced = enhanced_result["predictions"][0]
        print(f"\nENHANCED API (Enhanced Mode):")
        print(f"  🌸 {top_enhanced['className']} ({top_enhanced['confidence']:.1%})")
        print(f"  📝 {top_enhanced['englishName']}")
        if top_enhanced.get("enhanced"):
            print(f"  🚀 Enhanced from: {top_enhanced.get('originalName', 'N/A')}")
            print(f"  ⚡ Reason: {top_enhanced.get('enhancementReason', 'N/A')}")

        # Color analysis
        if "colorAnalysis" in enhanced_result:
            colors = enhanced_result["colorAnalysis"]
            print(f"  🎨 Dominant Color: {colors['dominant_color'].title()}")
            print(
                f"  🔴 Red: {colors['red_ratio']:.1%} | 🟢 Green: {colors['green_ratio']:.1%} | 🔵 Blue: {colors['blue_ratio']:.1%}"
            )

    if oxford_result and oxford_result.get("success"):
        top_oxford = oxford_result["predictions"][0]
        print(f"\nENHANCED API (Oxford Only):")
        print(f"  🌸 {top_oxford['className']} ({top_oxford['confidence']:.1%})")

    if visual_result and visual_result.get("success"):
        top_visual = visual_result["predictions"][0]
        print(f"\nENHANCED API (Visual Rules):")
        print(f"  🌸 {top_visual['className']} ({top_visual['confidence']:.1%})")

    # Analysis
    print(f"\n📈 ANALYSIS:")
    print("=" * 30)

    if original_result and enhanced_result:
        orig_conf = original_result["predictions"][0]["confidence"]
        enh_conf = enhanced_result["predictions"][0]["confidence"]

        if enh_conf > orig_conf:
            improvement = ((enh_conf - orig_conf) / orig_conf) * 100
            print(f"✅ Enhanced API improved confidence by {improvement:.1f}%")
        elif enh_conf < orig_conf:
            reduction = ((orig_conf - enh_conf) / orig_conf) * 100
            print(f"⚠️  Enhanced API reduced confidence by {reduction:.1f}%")
        else:
            print("➡️  No confidence change")

        # Check if prediction changed
        orig_name = original_result["predictions"][0]["englishName"].lower()
        enh_name = enhanced_result["predictions"][0]["englishName"].lower()

        if orig_name != enh_name:
            print(f"🔄 Prediction changed: {orig_name} → {enh_name}")
        else:
            print("🔄 Prediction unchanged")


def test_multiple_images():
    """Test với nhiều hình ảnh khác nhau"""
    test_images = [
        # Add your test images here
        "test_tulip.jpg",
        "test_rose.jpg",
        "test_sunflower.jpg",
        "test_daisy.jpg",
    ]

    print("🌸 ENHANCED FLOWER RECOGNITION API TESTING")
    print("=" * 60)
    print(f"🕒 Test started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

    for image_path in test_images:
        if os.path.exists(image_path):
            compare_apis(image_path)
        else:
            print(f"\n⚠️  Skipping {image_path} - file not found")

    print(f"\n✅ Testing completed at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")


def test_with_sample_data():
    """Test với sample data có sẵn"""
    # Look for sample images in current directory
    sample_extensions = [".jpg", ".jpeg", ".png", ".bmp"]
    sample_images = []

    for file in os.listdir("."):
        if any(file.lower().endswith(ext) for ext in sample_extensions):
            sample_images.append(file)

    if not sample_images:
        print("❌ No sample images found in current directory")
        print("💡 Please add some flower images (.jpg, .png, etc.) to test")
        return

    print(f"🔍 Found {len(sample_images)} sample images")

    for image_path in sample_images[:3]:  # Test first 3 images only
        compare_apis(image_path)


if __name__ == "__main__":
    print("🚀 Starting Enhanced API Test...")
    print("\n⚙️  Make sure both APIs are running:")
    print("   - Original API: python app.py (port 8000)")
    print("   - Enhanced API: python enhanced_api.py (port 8001)")
    print("\n" + "=" * 60)

    # Test with available sample data
    test_with_sample_data()
