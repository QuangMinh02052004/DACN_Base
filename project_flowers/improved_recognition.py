#!/usr/bin/env python3
"""
Improved Flower Recognition with Multiple Models
Kết hợp Oxford Flowers với mapping rule-based cho accuracy cao hơn
"""

import tensorflow as tf
import numpy as np
from PIL import Image
import os


class ImprovedFlowerRecognition:
    def __init__(self):
        self.oxford_model = None
        self.load_oxford_model()

        # Enhanced mapping với visual features
        self.visual_rules = {
            "tulip_features": {
                "colors": ["red", "pink", "yellow", "white", "purple"],
                "shape": "cup-shaped",
                "petals": 6,
                "characteristics": ["smooth_petals", "single_stem", "pointed_leaves"],
            }
        }

        # Oxford classes mapping
        self.oxford_classes = [
            "pink primrose",
            "hard-leaved pocket orchid",
            "canterbury bells",
            "sweet pea",
            "english marigold",
            "tiger lily",
            "moon orchid",
            "bird of paradise",
            "monkshood",
            "globe thistle",
            "snapdragon",
            "colt's foot",
            "king protea",
            "spear thistle",
            "yellow iris",
            "globe-flower",
            "purple coneflower",
            "peruvian lily",
            "balloon flower",
            "giant white arum lily",
            "fire lily",
            "pincushion flower",
            "fritillary",
            "red ginger",
            "grape hyacinth",
            "corn poppy",
            "prince of wales feathers",
            "stemless gentian",
            "artichoke",
            "sweet william",
            "carnation",
            "garden phlox",
            "love in the mist",
            "mexican aster",
            "alpine sea holly",
            "ruby-lipped cattleya",
            "cape flower",
            "great masterwort",
            "siam tulip",
            "lenten rose",
            "barbeton daisy",
            "daffodil",
            "sword lily",
            "poinsettia",
            "bolero deep blue",
            "wallflower",
            "marigold",
            "buttercup",
            "oxeye daisy",
            "common dandelion",
            "petunia",
            "wild pansy",
            "primula",
            "sunflower",
            "pelargonium",
            "bishop of llandaff",
            "gaura",
            "geranium",
            "orange dahlia",
            "pink-yellow dahlia",
            "cautleya spicata",
            "japanese anemone",
            "black-eyed susan",
            "silverbush",
            "californian poppy",
            "osteospermum",
            "spring crocus",
            "bearded iris",
            "windflower",
            "tree poppy",
            "gazania",
            "azalea",
            "water lily",
            "rose",
            "thorn apple",
            "morning glory",
            "passion flower",
            "lotus",
            "toad lily",
            "anthurium",
            "frangipani",
            "clematis",
            "hibiscus",
            "columbine",
            "desert-rose",
            "tree mallow",
            "magnolia",
            "cyclamen",
            "watercress",
            "canna lily",
            "hippeastrum",
            "bee balm",
            "ball moss",
            "foxglove",
            "bougainvillea",
            "camellia",
            "mallow",
            "mexican petunia",
            "bromelia",
            "blanket flower",
            "trumpet creeper",
            "blackberry lily",
        ]

    def load_oxford_model(self):
        """Load Oxford Flowers model"""
        try:
            script_dir = os.path.dirname(os.path.abspath(__file__))
            model_path = os.path.join(script_dir, "oxford102_m2_optimized.h5")
            self.oxford_model = tf.keras.models.load_model(model_path)
            print("Oxford model loaded successfully!")
        except Exception as e:
            print(f"Failed to load Oxford model: {e}")

    def analyze_visual_features(self, image):
        """Phân tích đặc điểm visual của hình ảnh"""
        # Convert to HSV để phân tích màu sắc
        import cv2

        image_cv = cv2.cvtColor(np.array(image), cv2.COLOR_RGB2HSV)

        # Phân tích màu sắc dominant
        dominant_colors = self.get_dominant_colors(image_cv)

        # Phân tích hình dạng (basic shape detection)
        shape_features = self.analyze_shape(image)

        return {"dominant_colors": dominant_colors, "shape_features": shape_features}

    def get_dominant_colors(self, hsv_image):
        """Lấy màu sắc chủ đạo"""
        # Simplified color analysis
        h_channel = hsv_image[:, :, 0]

        # Red range (0-10, 170-180)
        red_mask = ((h_channel >= 0) & (h_channel <= 10)) | (
            (h_channel >= 170) & (h_channel <= 180)
        )
        red_ratio = np.sum(red_mask) / h_channel.size

        # Other color ranges...
        pink_mask = (h_channel >= 140) & (h_channel <= 170)
        pink_ratio = np.sum(pink_mask) / h_channel.size

        yellow_mask = (h_channel >= 20) & (h_channel <= 30)
        yellow_ratio = np.sum(yellow_mask) / h_channel.size

        return {"red": red_ratio, "pink": pink_ratio, "yellow": yellow_ratio}

    def analyze_shape(self, image):
        """Phân tích hình dạng cơ bản"""
        # Simplified shape analysis
        return {"shape_type": "unknown"}  # Placeholder

    def enhanced_predict(self, image):
        """Prediction với rule-based enhancement"""
        if not self.oxford_model:
            return None

        # Chuẩn bị image cho Oxford model
        image_resized = image.resize((224, 224))
        image_array = np.array(image_resized) / 255.0
        image_array = np.expand_dims(image_array, axis=0)

        # Oxford prediction
        oxford_predictions = self.oxford_model.predict(image_array, verbose=0)
        top_5_indices = np.argsort(oxford_predictions[0])[-5:][::-1]

        # Visual analysis
        visual_features = self.analyze_visual_features(image)

        # Rule-based corrections
        corrected_predictions = self.apply_visual_rules(
            oxford_predictions[0], visual_features, top_5_indices
        )

        return corrected_predictions

    def apply_visual_rules(self, oxford_pred, visual_features, top_indices):
        """Áp dụng rules để correct predictions"""
        results = []

        for i, idx in enumerate(top_indices):
            class_name = self.oxford_classes[idx]
            confidence = oxford_pred[idx]

            # Rule 1: Tulip detection
            if self.is_likely_tulip(visual_features, class_name, confidence):
                # Boost tulip-like predictions
                results.append(
                    {
                        "class_name": "tulip",
                        "vietnamese_name": "Hoa Tulip",
                        "confidence": min(confidence * 2.0, 1.0),
                        "source": "rule_enhanced",
                    }
                )
            else:
                results.append(
                    {
                        "class_name": class_name,
                        "vietnamese_name": self.map_to_vietnamese(class_name),
                        "confidence": confidence,
                        "source": "oxford_model",
                    }
                )

        # Sort by confidence
        results.sort(key=lambda x: x["confidence"], reverse=True)
        return results[:5]

    def is_likely_tulip(self, visual_features, predicted_class, confidence):
        """Kiểm tra xem có phải tulip không dựa trên visual features"""
        colors = visual_features["dominant_colors"]

        # Rule: Nếu có màu đỏ/hồng dominant và oxford predict cyclamen/cape flower
        # thì rất có thể là tulip
        tulip_like_classes = ["cyclamen", "cape flower", "hippeastrum"]

        if any(cls in predicted_class.lower() for cls in tulip_like_classes):
            if colors["red"] > 0.3 or colors["pink"] > 0.3:
                return True

        return False

    def map_to_vietnamese(self, english_name):
        """Map tên hoa sang tiếng Việt"""
        mapping = {
            "tulip": "Hoa Tulip",
            "rose": "Hoa Hồng",
            "sunflower": "Hoa Hướng Dương",
            "cyclamen": "Hoa Tiên Khách",
            "cape flower": "Hoa Mũi Cape",
            "hippeastrum": "Hoa Huệ Tây",
            # Add more mappings...
        }

        for eng, viet in mapping.items():
            if eng in english_name.lower():
                return viet

        return english_name.title()


# Test function
def test_improved_recognition():
    recognizer = ImprovedFlowerRecognition()

    # Test với image
    test_image_path = "test_tulip.jpg"  # Your tulip image
    if os.path.exists(test_image_path):
        image = Image.open(test_image_path)
        results = recognizer.enhanced_predict(image)

        print("IMPROVED RECOGNITION RESULTS:")
        print("=" * 50)
        for i, result in enumerate(results, 1):
            print(f"{i}. {result['vietnamese_name']}")
            print(f"   English: {result['class_name']}")
            print(f"   Confidence: {result['confidence']:.2%}")
            print(f"   Source: {result['source']}")
            print()


if __name__ == "__main__":
    test_improved_recognition()
