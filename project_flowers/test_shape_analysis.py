"""
Quick test for shape-based flower detection
"""

from PIL import Image
import sys


# Test shape analysis
def test_shape_detection():
    from enhanced_api import EnhancedFlowerRecognitionAPI

    api = EnhancedFlowerRecognitionAPI()

    # Test với ảnh mẫu nếu có
    print("Testing shape detection...")

    # Create a simple test image
    test_image = Image.new("RGB", (224, 224), color="red")

    shape_features = api.analyze_flower_shape(test_image)

    print(f"Shape Features:")
    print(f"  Edge Density: {shape_features['edge_density']:.4f}")
    print(f"  Center Complexity: {shape_features['center_complexity']:.4f}")
    print(f"  Variance: {shape_features['variance']:.2f}")
    print(f"  Is Layered (Rose-like): {shape_features['is_layered']}")
    print(f"  Is Simple (Tulip-like): {shape_features['is_simple']}")

    print("\n✅ Shape analysis working!")


if __name__ == "__main__":
    test_shape_detection()
