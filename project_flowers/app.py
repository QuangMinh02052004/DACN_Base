from flask import Flask, request, jsonify
from flask_cors import CORS
import tensorflow as tf
import numpy as np
from PIL import Image
import io
import os
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

app = Flask(__name__)
CORS(app)

# Load model Oxford Flowers
try:
    logger.info("Loading Oxford Flowers model...")
    model = tf.keras.models.load_model("oxford102_m2_optimized.h5")
    logger.info("Model loaded successfully!")
except Exception as e:
    logger.error(f"Failed to load model: {str(e)}")
    raise

# Danh sách 102 loài hoa từ dataset Oxford Flowers
class_names = [
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


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "healthy", "model": "Oxford102_m2_optimized"})


@app.route("/predict", methods=["POST"])
def predict():
    """API endpoint để nhận dạng hoa từ hình ảnh"""
    try:
        logger.info("Received prediction request")

        # Kiểm tra có file ảnh không
        if "image" not in request.files:
            logger.warning("No image file provided in request")
            return jsonify({"success": False, "message": "No image file provided"}), 400

        file = request.files["image"]
        if file.filename == "":
            logger.warning("Empty filename in request")
            return jsonify({"success": False, "message": "No image file selected"}), 400

        logger.info(f"Processing image: {file.filename}")

        # Đọc và xử lý ảnh
        image_bytes = file.read()
        image = Image.open(io.BytesIO(image_bytes))

        # Validate image
        if image.mode not in ['RGB', 'RGBA', 'L']:
            logger.warning(f"Unsupported image mode: {image.mode}")
            return jsonify({"success": False, "message": "Unsupported image format"}), 400

        # Resize về kích thước model yêu cầu (224x224)
        image = image.convert("RGB")
        image = image.resize((224, 224))

        # Chuẩn hóa dữ liệu
        image_array = np.array(image) / 255.0
        image_array = np.expand_dims(image_array, axis=0)

        # Dự đoán
        logger.info("Running model prediction...")
        predictions = model.predict(image_array, verbose=0)

        # Lấy top 3 predictions
        top_3_indices = np.argsort(predictions[0])[-3:][::-1]

        result_predictions = []
        for idx in top_3_indices:
            flower_name = class_names[idx]
            vietnamese_name = map_flower_to_vietnamese(flower_name)
            confidence = float(predictions[0][idx])

            result_predictions.append({
                "className": vietnamese_name,
                "confidence": confidence,
                "englishName": flower_name
            })

        logger.info(f"Prediction successful. Top result: {result_predictions[0]['className']} ({result_predictions[0]['confidence']:.2%})")

        # Trả về kết quả theo format mà C# service mong đợi
        return jsonify(
            {
                "success": True,
                "predictions": result_predictions,
                "message": "Prediction successful",
            }
        )

    except Image.UnidentifiedImageError:
        logger.error("Invalid image file - cannot be identified")
        return jsonify(
            {"success": False, "message": "Invalid image file. Please upload a valid image."}
        ), 400
    except Exception as e:
        logger.error(f"Error in prediction: {str(e)}", exc_info=True)
        return jsonify(
            {"success": False, "message": f"Error processing image: {str(e)}"}
        ), 500


@app.route("/search-by-image", methods=["POST"])
def search_by_image():
    """Alternative endpoint for image search with different response format"""
    try:
        logger.info("Received search-by-image request")

        if "imageFile" not in request.files:
            logger.warning("No imageFile in request")
            return jsonify({"error": "No image file"}), 400

        file = request.files["imageFile"]
        if file.filename == "":
            logger.warning("Empty filename in search-by-image request")
            return jsonify({"error": "No selected file"}), 400

        logger.info(f"Processing image for search: {file.filename}")

        # Preprocess image cho model Oxford Flowers (224x224)
        image_bytes = file.read()
        image = Image.open(io.BytesIO(image_bytes))

        # Validate image
        if image.mode not in ['RGB', 'RGBA', 'L']:
            logger.warning(f"Unsupported image mode: {image.mode}")
            return jsonify({"error": "Unsupported image format"}), 400

        image = image.convert("RGB")
        image = image.resize((224, 224))
        image_array = np.array(image) / 255.0
        image_array = np.expand_dims(image_array, axis=0)

        # Predict
        logger.info("Running model prediction for search...")
        predictions = model.predict(image_array, verbose=0)
        predicted_class = np.argmax(predictions[0])
        confidence = float(predictions[0][predicted_class])

        # Map tên hoa sang tiếng Việt
        flower_name = class_names[predicted_class]
        vietnamese_name = map_flower_to_vietnamese(flower_name)

        logger.info(f"Search result: {vietnamese_name} ({confidence:.2%})")

        return jsonify(
            {
                "class_id": int(predicted_class),
                "class_name": flower_name,
                "vietnamese_name": vietnamese_name,
                "probability": confidence,
            }
        )

    except Image.UnidentifiedImageError:
        logger.error("Invalid image file in search-by-image")
        return jsonify({"error": "Invalid image file"}), 400
    except Exception as e:
        logger.error(f"Error in search-by-image: {str(e)}", exc_info=True)
        return jsonify({"error": str(e)}), 500


def map_flower_to_vietnamese(english_name):
    """Map tên hoa từ tiếng Anh sang tiếng Việt - Đầy đủ cho Oxford Flowers 102"""
    flower_mapping = {
        # Common flowers
        "rose": "Hoa Hồng",
        "sunflower": "Hoa Hướng Dương",
        "tulip": "Hoa Tulip",
        "lily": "Hoa Lily",
        "orchid": "Hoa Lan",
        "carnation": "Hoa Cẩm Chướng",
        "daffodil": "Hoa Thủy Tiên",
        "iris": "Hoa Diên Vĩ",
        "dahlia": "Hoa Thược Dược",
        "magnolia": "Hoa Mộc Lan",
        "marigold": "Hoa Vạn Thọ",
        "poppy": "Hoa Anh Túc",
        "lotus": "Hoa Sen",

        # Daisy family
        "daisy": "Hoa Cúc",
        "oxeye daisy": "Hoa Cúc Trắng",
        "barbeton daisy": "Hoa Đồng Tiền",
        "black-eyed susan": "Hoa Cúc Mắt Đen",

        # Specific flowers
        "primrose": "Hoa Anh Thảo",
        "pink primrose": "Hoa Anh Thảo Hồng",
        "canterbury bells": "Hoa Chuông Canterbury",
        "sweet pea": "Hoa Đậu Hà Lan",
        "english marigold": "Hoa Cúc Vạn Thọ Anh",
        "tiger lily": "Hoa Lily Hổ",
        "moon orchid": "Hoa Lan Trăng",
        "bird of paradise": "Hoa Thiên Điểu",
        "monkshood": "Hoa Mũ Tu Sĩ",
        "globe thistle": "Hoa Kế Cầu",
        "snapdragon": "Hoa Mõm Sói",
        "king protea": "Hoa Protea Vua",
        "spear thistle": "Hoa Kế Gai",
        "yellow iris": "Hoa Diên Vĩ Vàng",
        "purple coneflower": "Hoa Cúc Tím",
        "peruvian lily": "Hoa Lily Peru",
        "balloon flower": "Hoa Cát Cánh",
        "giant white arum lily": "Hoa Rum Trắng",
        "fire lily": "Hoa Lily Lửa",
        "pincushion flower": "Hoa Cúc Gối",
        "fritillary": "Hoa Fritillary",
        "red ginger": "Hoa Gừng Đỏ",
        "grape hyacinth": "Hoa Đậu Biếc",
        "corn poppy": "Hoa Anh Túc Đỏ",
        "prince of wales feathers": "Hoa Lông Hoàng Tử",
        "stemless gentian": "Hoa Long Đởm",
        "artichoke": "Hoa Atiso",
        "sweet william": "Hoa Cẩm Chướng Thơm",
        "garden phlox": "Hoa Phlox Vườn",
        "love in the mist": "Hoa Cúc Mơ",
        "mexican aster": "Hoa Cúc Mexico",
        "alpine sea holly": "Hoa Cúc Gai Biển",
        "cape flower": "Hoa Mũi Cape",
        "great masterwort": "Hoa Astrantia",
        "siam tulip": "Hoa Tulip Xiêm",
        "lenten rose": "Hoa Helleborus",
        "sword lily": "Hoa Lay Ơn",
        "poinsettia": "Hoa Trạng Nguyên",
        "wallflower": "Hoa Tường Vi",
        "buttercup": "Hoa Mao Lương",
        "common dandelion": "Hoa Bồ Công Anh",
        "petunia": "Hoa Dạ Yến Thảo",
        "wild pansy": "Hoa Păng-xê Dại",
        "primula": "Hoa Anh Thảo",
        "pelargonium": "Hoa Phong Lữ Thảo",
        "geranium": "Hoa Phong Lữ",
        "orange dahlia": "Hoa Thược Dược Cam",
        "pink-yellow dahlia": "Hoa Thược Dược Hồng Vàng",
        "japanese anemone": "Hoa Hải Quỳ Nhật",
        "silverbush": "Hoa Bạc",
        "californian poppy": "Hoa Anh Túc California",
        "spring crocus": "Hoa Nghệ Tây Mùa Xuân",
        "bearded iris": "Hoa Diên Vĩ Râu",
        "windflower": "Hoa Gió",
        "tree poppy": "Hoa Anh Túc Cây",
        "gazania": "Hoa Cúc Gazania",
        "azalea": "Hoa Đỗ Quyên",
        "water lily": "Hoa Súng",
        "thorn apple": "Hoa Táo Gai",
        "morning glory": "Hoa Bìm Bìm",
        "passion flower": "Hoa Lạc Tiên",
        "toad lily": "Hoa Lily Cóc",
        "anthurium": "Hoa Hồng Môn",
        "frangipani": "Hoa Đại",
        "clematis": "Hoa Tơ Hồng",
        "hibiscus": "Hoa Dâm Bụt",
        "columbine": "Hoa Huyền Sâm",
        "desert-rose": "Hoa Sứ",
        "tree mallow": "Hoa Cẩm Quỳ Cây",
        "cyclamen": "Hoa Tiên Khách",
        "watercress": "Hoa Cải Xoong",
        "canna lily": "Hoa Dong Riềng",
        "hippeastrum": "Hoa Huệ Tây",
        "bee balm": "Hoa Bạc Hà Ong",
        "ball moss": "Rêu Cầu",
        "foxglove": "Hoa Mao Địa Hoàng",
        "bougainvillea": "Hoa Giấy",
        "camellia": "Hoa Trà",
        "mallow": "Hoa Cẩm Quỳ",
        "mexican petunia": "Hoa Dạ Yến Thảo Mexico",
        "bromelia": "Hoa Dứa Cảnh",
        "blanket flower": "Hoa Cúc Thảm",
        "trumpet creeper": "Hoa Kèn Hồng",
        "blackberry lily": "Hoa Lily Dâu Đen",
        "gerbera": "Hoa Đồng Tiền",
        "hydrangea": "Hoa Cẩm Tú Cầu",
    }

    # Tìm tên phù hợp (case-insensitive)
    english_lower = english_name.lower()
    for eng_name, vi_name in flower_mapping.items():
        if eng_name in english_lower:
            return vi_name

    # Nếu không tìm thấy, capitalize tên gốc
    return english_name.title()


if __name__ == "__main__":
    logger.info("=" * 60)
    logger.info("Starting Oxford Flowers Recognition API")
    logger.info("=" * 60)
    logger.info("Model file: oxford102_m2_optimized.h5")
    logger.info(f"Number of flower classes: {len(class_names)}")
    logger.info("API Endpoints:")
    logger.info("  - GET  /health - Health check")
    logger.info("  - POST /predict - Main prediction endpoint")
    logger.info("  - POST /search-by-image - Alternative search endpoint")
    logger.info("Server starting on http://0.0.0.0:8000")
    logger.info("=" * 60)
    app.run(host="0.0.0.0", port=8000, debug=True)
