#!/usr/bin/env python3
"""
Enhanced GUI Test Tool with Improved Recognition
Kết hợp Oxford Flowers + Visual Rules + Color Analysis cho accuracy cao hơn
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
from PIL import Image, ImageTk
import tensorflow as tf
import numpy as np
import os
from datetime import datetime


class EnhancedFlowerRecognitionGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("🌸 Enhanced Flower Recognition Tool")
        self.root.geometry("900x750")
        self.root.resizable(True, True)

        # Initialize variables first
        self.oxford_model = None
        self.class_names = self.load_class_names()
        self.current_image_path = None
        self.current_image = None

        # Setup GUI first (creates status_var)
        self.setup_gui()

        # Load model after GUI is setup
        self.load_model()

    def load_class_names(self):
        """Load class names for Oxford Flowers 102"""
        return [
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

    def load_model(self):
        """Load the trained Oxford Flowers model"""
        try:
            script_dir = os.path.dirname(os.path.abspath(__file__))
            model_path = os.path.join(script_dir, "oxford102_m2_optimized.h5")

            print(f"Loading model from: {model_path}")

            if not os.path.exists(model_path):
                error_msg = f"Model file not found at: {model_path}"
                messagebox.showerror("Error", error_msg)
                self.update_status("Model loading failed: File not found")
                return

            self.oxford_model = tf.keras.models.load_model(model_path)
            print("Enhanced model loaded successfully!")
            self.update_status("🌸 Enhanced Recognition System Ready! ✓")

        except Exception as e:
            messagebox.showerror("Error", f"Failed to load model: {str(e)}")
            self.update_status(f"Model loading failed: {str(e)}")

    def setup_gui(self):
        """Setup the enhanced GUI layout"""
        # Main frame
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        # Configure grid weights
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        main_frame.rowconfigure(2, weight=1)

        # Enhanced title
        title_label = ttk.Label(
            main_frame,
            text="🌸 Enhanced Flower Recognition Tool",
            font=("Arial", 18, "bold"),
        )
        title_label.grid(row=0, column=0, columnspan=3, pady=(0, 15))

        subtitle_label = ttk.Label(
            main_frame,
            text="Oxford Flowers + Visual Rules + Color Analysis",
            font=("Arial", 10, "italic"),
            foreground="gray",
        )
        subtitle_label.grid(row=1, column=0, columnspan=3, pady=(0, 20))

        # Left panel - Enhanced Controls
        control_frame = ttk.LabelFrame(main_frame, text="🎛️ Controls", padding="10")
        control_frame.grid(
            row=2, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), padx=(0, 10)
        )

        # Upload button
        self.upload_btn = ttk.Button(
            control_frame, text="📁 Select Image", command=self.upload_image, width=22
        )
        self.upload_btn.grid(row=0, column=0, pady=(0, 10), sticky=tk.W + tk.E)

        # Analysis mode selection
        mode_frame = ttk.LabelFrame(control_frame, text="Analysis Mode", padding="5")
        mode_frame.grid(row=1, column=0, pady=(0, 10), sticky=tk.W + tk.E)

        self.analysis_mode = tk.StringVar(value="enhanced")
        ttk.Radiobutton(
            mode_frame,
            text="🔬 Enhanced (Recommended)",
            variable=self.analysis_mode,
            value="enhanced",
        ).pack(anchor=tk.W)
        ttk.Radiobutton(
            mode_frame,
            text="📊 Oxford Only",
            variable=self.analysis_mode,
            value="oxford",
        ).pack(anchor=tk.W)
        ttk.Radiobutton(
            mode_frame,
            text="🎨 Visual Rules Only",
            variable=self.analysis_mode,
            value="visual",
        ).pack(anchor=tk.W)

        # Predict button
        self.predict_btn = ttk.Button(
            control_frame, text="🔍 Analyze Image", command=self.predict_image, width=22
        )
        self.predict_btn.grid(row=2, column=0, pady=(10, 10), sticky=tk.W + tk.E)
        self.predict_btn.state(["disabled"])

        # Clear button
        self.clear_btn = ttk.Button(
            control_frame, text="🗑️ Clear All", command=self.clear_all, width=22
        )
        self.clear_btn.grid(row=3, column=0, pady=(0, 20), sticky=tk.W + tk.E)

        # Enhanced Image info
        info_frame = ttk.LabelFrame(
            control_frame, text="📊 Image Analysis", padding="5"
        )
        info_frame.grid(row=4, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), pady=(0, 10))

        self.image_info_text = tk.Text(info_frame, height=10, width=28, wrap=tk.WORD)
        info_scrollbar = ttk.Scrollbar(
            info_frame, orient=tk.VERTICAL, command=self.image_info_text.yview
        )
        self.image_info_text.configure(yscrollcommand=info_scrollbar.set)
        self.image_info_text.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        info_scrollbar.grid(row=0, column=1, sticky=(tk.N, tk.S))

        info_frame.columnconfigure(0, weight=1)
        info_frame.rowconfigure(0, weight=1)

        # Center panel - Image display
        image_frame = ttk.LabelFrame(main_frame, text="🖼️ Image Preview", padding="10")
        image_frame.grid(row=2, column=1, sticky=(tk.W, tk.E, tk.N, tk.S))

        # Image canvas
        self.image_canvas = tk.Canvas(image_frame, width=320, height=320, bg="white")
        self.image_canvas.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        image_frame.columnconfigure(0, weight=1)
        image_frame.rowconfigure(0, weight=1)

        # Right panel - Enhanced Results
        results_frame = ttk.LabelFrame(
            main_frame, text="🎯 Recognition Results", padding="10"
        )
        results_frame.grid(
            row=2, column=2, sticky=(tk.W, tk.E, tk.N, tk.S), padx=(10, 0)
        )

        # Results text
        self.results_text = tk.Text(results_frame, height=25, width=40, wrap=tk.WORD)
        results_scrollbar = ttk.Scrollbar(
            results_frame, orient=tk.VERTICAL, command=self.results_text.yview
        )
        self.results_text.configure(yscrollcommand=results_scrollbar.set)
        self.results_text.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        results_scrollbar.grid(row=0, column=1, sticky=(tk.N, tk.S))

        results_frame.columnconfigure(0, weight=1)
        results_frame.rowconfigure(0, weight=1)

        # Bottom status bar
        self.status_var = tk.StringVar()
        self.status_var.set("🌸 Enhanced Recognition System Loading...")
        status_bar = ttk.Label(
            main_frame, textvariable=self.status_var, relief=tk.SUNKEN
        )
        status_bar.grid(
            row=3, column=0, columnspan=3, sticky=(tk.W, tk.E), pady=(10, 0)
        )

    def upload_image(self):
        """Handle image upload"""
        try:
            file_path = filedialog.askopenfilename(
                title="Select a flower image",
                filetypes=[
                    ("Image files", "*.jpg *.jpeg *.png *.bmp *.gif *.tiff"),
                    ("JPEG files", "*.jpg *.jpeg"),
                    ("PNG files", "*.png"),
                    ("All files", "*.*"),
                ],
            )

            if not file_path:
                return

            # Load and display image
            self.current_image_path = file_path
            self.current_image = Image.open(file_path)

            # Display image
            self.display_image(self.current_image)

            # Update image info with analysis
            self.update_image_info_enhanced()

            # Enable predict button
            self.predict_btn.state(["!disabled"])

            self.update_status(
                f"Image loaded: {os.path.basename(file_path)} - Ready for analysis"
            )

        except Exception as e:
            messagebox.showerror("Error", f"Failed to load image: {str(e)}")
            self.update_status(f"Error loading image: {str(e)}")

    def display_image(self, pil_image):
        """Display image on canvas"""
        canvas_width = 320
        canvas_height = 320

        img_width, img_height = pil_image.size
        aspect_ratio = img_width / img_height

        if aspect_ratio > 1:
            new_width = canvas_width
            new_height = int(canvas_width / aspect_ratio)
        else:
            new_height = canvas_height
            new_width = int(canvas_height * aspect_ratio)

        display_image = pil_image.resize(
            (new_width, new_height), Image.Resampling.LANCZOS
        )
        self.photo = ImageTk.PhotoImage(display_image)

        self.image_canvas.delete("all")
        x = (canvas_width - new_width) // 2
        y = (canvas_height - new_height) // 2
        self.image_canvas.create_image(x, y, anchor=tk.NW, image=self.photo)

    def analyze_color_features(self, image):
        """Phân tích màu sắc của hình ảnh"""
        # Convert to numpy array
        img_array = np.array(image.resize((224, 224)))

        # Color analysis in RGB space
        red_ratio = np.mean(img_array[:, :, 0]) / 255.0
        green_ratio = np.mean(img_array[:, :, 1]) / 255.0
        blue_ratio = np.mean(img_array[:, :, 2]) / 255.0

        # Determine dominant colors
        dominant_color = "unknown"
        if red_ratio > green_ratio and red_ratio > blue_ratio:
            if red_ratio > 0.6:
                dominant_color = "red"
            elif red_ratio > 0.4:
                dominant_color = "pink"
        elif green_ratio > red_ratio and green_ratio > blue_ratio:
            dominant_color = "green"
        elif blue_ratio > red_ratio and blue_ratio > green_ratio:
            dominant_color = "blue"
        elif red_ratio > 0.5 and green_ratio > 0.5 and blue_ratio < 0.3:
            dominant_color = "yellow"

        return {
            "red_ratio": red_ratio,
            "green_ratio": green_ratio,
            "blue_ratio": blue_ratio,
            "dominant_color": dominant_color,
        }

    def update_image_info_enhanced(self):
        """Update enhanced image information display"""
        if not self.current_image:
            return

        # Basic info
        info = f"📁 FILE INFO:\n"
        info += f"Name: {os.path.basename(self.current_image_path)}\n"
        info += f"Size: {self.current_image.size[0]} x {self.current_image.size[1]}\n"
        info += f"Mode: {self.current_image.mode}\n"
        info += f"Format: {self.current_image.format}\n"

        # File size
        file_size = os.path.getsize(self.current_image_path)
        if file_size < 1024:
            info += f"File Size: {file_size} bytes\n\n"
        elif file_size < 1024 * 1024:
            info += f"File Size: {file_size / 1024:.1f} KB\n\n"
        else:
            info += f"File Size: {file_size / (1024 * 1024):.1f} MB\n\n"

        # Color analysis
        color_features = self.analyze_color_features(self.current_image)
        info += f"🎨 COLOR ANALYSIS:\n"
        info += f"Red: {color_features['red_ratio']:.1%}\n"
        info += f"Green: {color_features['green_ratio']:.1%}\n"
        info += f"Blue: {color_features['blue_ratio']:.1%}\n"
        info += f"Dominant: {color_features['dominant_color'].title()}\n\n"

        # Visual hints
        info += f"💡 VISUAL HINTS:\n"
        if color_features["dominant_color"] == "red":
            info += "• Likely: Rose, Tulip, Poppy\n"
        elif color_features["dominant_color"] == "yellow":
            info += "• Likely: Sunflower, Daisy, Marigold\n"
        elif color_features["dominant_color"] == "pink":
            info += "• Likely: Cherry Blossom, Peony, Tulip\n"
        else:
            info += "• Multiple colors detected\n"

        self.image_info_text.delete(1.0, tk.END)
        self.image_info_text.insert(1.0, info)

    def predict_image(self):
        """Enhanced prediction with multiple analysis modes"""
        if not self.oxford_model:
            messagebox.showerror("Error", "Model not loaded!")
            return

        if not self.current_image:
            messagebox.showerror("Error", "No image selected!")
            return

        try:
            mode = self.analysis_mode.get()
            self.update_status(f"Analyzing image using {mode} mode...")

            # Preprocess image
            image = self.current_image.convert("RGB")
            image_resized = image.resize((224, 224))
            image_array = np.array(image_resized) / 255.0
            image_array = np.expand_dims(image_array, axis=0)

            # Get color features
            color_features = self.analyze_color_features(self.current_image)

            if mode == "enhanced":
                results = self.enhanced_predict(image_array, color_features)
            elif mode == "oxford":
                results = self.oxford_only_predict(image_array)
            else:  # visual
                results = self.visual_rules_predict(color_features)

            # Display results
            self.display_enhanced_results(results, mode, color_features)

            # Update status
            best_match = results[0]["vietnamese_name"]
            best_confidence = results[0]["confidence"]
            self.update_status(
                f"Analysis complete! Best match: {best_match} ({best_confidence:.1%})"
            )

        except Exception as e:
            messagebox.showerror("Error", f"Prediction failed: {str(e)}")
            self.update_status(f"Analysis error: {str(e)}")

    def enhanced_predict(self, image_array, color_features):
        """Enhanced prediction combining Oxford + Visual Rules"""
        # Oxford prediction
        oxford_predictions = self.oxford_model.predict(image_array, verbose=0)
        top_5_indices = np.argsort(oxford_predictions[0])[-5:][::-1]

        results = []
        for i, idx in enumerate(top_5_indices):
            flower_name = self.class_names[idx]
            confidence = oxford_predictions[0][idx]

            # Apply enhancement rules
            enhanced_confidence, enhanced_name = self.apply_enhancement_rules(
                flower_name, confidence, color_features
            )

            results.append(
                {
                    "english_name": flower_name,
                    "vietnamese_name": self.map_flower_to_vietnamese(enhanced_name),
                    "confidence": enhanced_confidence,
                    "original_confidence": confidence,
                    "enhanced": enhanced_name != flower_name,
                }
            )

        # Sort by enhanced confidence
        results.sort(key=lambda x: x["confidence"], reverse=True)
        return results

    def oxford_only_predict(self, image_array):
        """Standard Oxford prediction only"""
        predictions = self.oxford_model.predict(image_array, verbose=0)
        top_5_indices = np.argsort(predictions[0])[-5:][::-1]

        results = []
        for idx in top_5_indices:
            flower_name = self.class_names[idx]
            confidence = predictions[0][idx]

            results.append(
                {
                    "english_name": flower_name,
                    "vietnamese_name": self.map_flower_to_vietnamese(flower_name),
                    "confidence": confidence,
                    "original_confidence": confidence,
                    "enhanced": False,
                }
            )

        return results

    def visual_rules_predict(self, color_features):
        """Prediction based on visual rules only"""
        results = []

        # Rule-based predictions
        if color_features["dominant_color"] == "red":
            results = [
                {
                    "english_name": "tulip",
                    "vietnamese_name": "Hoa Tulip",
                    "confidence": 0.85,
                },
                {
                    "english_name": "rose",
                    "vietnamese_name": "Hoa Hồng",
                    "confidence": 0.75,
                },
                {
                    "english_name": "poppy",
                    "vietnamese_name": "Hoa Anh Túc",
                    "confidence": 0.65,
                },
                {
                    "english_name": "carnation",
                    "vietnamese_name": "Hoa Cẩm Chướng",
                    "confidence": 0.55,
                },
                {
                    "english_name": "geranium",
                    "vietnamese_name": "Hoa Phong Lữ",
                    "confidence": 0.45,
                },
            ]
        elif color_features["dominant_color"] == "yellow":
            results = [
                {
                    "english_name": "sunflower",
                    "vietnamese_name": "Hoa Hướng Dương",
                    "confidence": 0.90,
                },
                {
                    "english_name": "marigold",
                    "vietnamese_name": "Hoa Vạn Thọ",
                    "confidence": 0.70,
                },
                {
                    "english_name": "daisy",
                    "vietnamese_name": "Hoa Cúc",
                    "confidence": 0.60,
                },
                {
                    "english_name": "daffodil",
                    "vietnamese_name": "Hoa Thủy Tiên",
                    "confidence": 0.50,
                },
                {
                    "english_name": "buttercup",
                    "vietnamese_name": "Hoa Mao Lương",
                    "confidence": 0.40,
                },
            ]
        else:
            results = [
                {
                    "english_name": "unknown flower",
                    "vietnamese_name": "Hoa Chưa Xác Định",
                    "confidence": 0.30,
                },
                {
                    "english_name": "mixed colors",
                    "vietnamese_name": "Hoa Nhiều Màu",
                    "confidence": 0.25,
                },
                {
                    "english_name": "composite flower",
                    "vietnamese_name": "Hoa Tổng Hợp",
                    "confidence": 0.20,
                },
                {
                    "english_name": "garden flower",
                    "vietnamese_name": "Hoa Vườn",
                    "confidence": 0.15,
                },
                {
                    "english_name": "wildflower",
                    "vietnamese_name": "Hoa Dại",
                    "confidence": 0.10,
                },
            ]

        # Add required fields
        for result in results:
            result["original_confidence"] = result["confidence"]
            result["enhanced"] = True

        return results

    def apply_enhancement_rules(self, flower_name, confidence, color_features):
        """Apply enhancement rules to improve accuracy"""
        enhanced_name = flower_name
        enhanced_confidence = confidence

        # Rule 1: Tulip detection
        if color_features["dominant_color"] in [
            "red",
            "pink",
        ] and flower_name.lower() in ["cyclamen", "cape flower", "hippeastrum"]:
            if confidence > 0.05:  # Only if Oxford has some confidence
                enhanced_name = "tulip"
                enhanced_confidence = min(confidence * 3.0, 0.95)  # Boost confidence

        # Rule 2: Rose detection
        elif (
            color_features["dominant_color"] == "red" and "rose" in flower_name.lower()
        ):
            enhanced_confidence = min(confidence * 1.5, 0.98)

        # Rule 3: Sunflower detection
        elif color_features["dominant_color"] == "yellow" and flower_name.lower() in [
            "sunflower",
            "marigold",
        ]:
            enhanced_confidence = min(confidence * 1.3, 0.95)

        # Rule 4: Low confidence penalty
        elif confidence < 0.1:
            enhanced_confidence = confidence * 0.8

        return enhanced_confidence, enhanced_name

    def display_enhanced_results(self, results, mode, color_features):
        """Display enhanced results with detailed analysis"""
        results_text = "🌸 ENHANCED FLOWER RECOGNITION\n"
        results_text += "=" * 45 + "\n"
        results_text += f"Analyzed at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
        results_text += f"Image: {os.path.basename(self.current_image_path)}\n"
        results_text += f"Analysis Mode: {mode.upper()}\n"
        results_text += (
            f"Dominant Color: {color_features['dominant_color'].title()}\n\n"
        )

        results_text += "TOP 5 PREDICTIONS:\n"
        results_text += "-" * 45 + "\n"

        for i, result in enumerate(results, 1):
            results_text += f"{i}. {result['vietnamese_name']}\n"
            results_text += f"   English: {result['english_name']}\n"
            results_text += f"   Confidence: {result['confidence']:.2%}\n"

            if result.get("enhanced", False):
                results_text += f"   Original: {result['original_confidence']:.2%}\n"
                results_text += f"   🚀 ENHANCED PREDICTION\n"

            if i == 1:
                results_text += f"   🏆 BEST MATCH\n"
            results_text += "\n"

        # Analysis summary
        results_text += "=" * 45 + "\n"
        results_text += "ANALYSIS SUMMARY:\n"
        results_text += f"• Color Profile: R:{color_features['red_ratio']:.1%} G:{color_features['green_ratio']:.1%} B:{color_features['blue_ratio']:.1%}\n"
        results_text += (
            f"• Enhancement: {'Active' if mode == 'enhanced' else 'Disabled'}\n"
        )
        results_text += f"• Model: Oxford Flowers 102 + Visual Rules\n"
        results_text += f"• Image Resolution: 224x224 (processed)\n"

        # Display results
        self.results_text.delete(1.0, tk.END)
        self.results_text.insert(1.0, results_text)

    def map_flower_to_vietnamese(self, english_name):
        """Enhanced Vietnamese mapping"""
        flower_mapping = {
            "tulip": "Hoa Tulip",
            "rose": "Hoa Hồng",
            "sunflower": "Hoa Hướng Dương",
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
            "daisy": "Hoa Cúc",
            "oxeye daisy": "Hoa Cúc Trắng",
            "barbeton daisy": "Hoa Đồng Tiền",
            "black-eyed susan": "Hoa Cúc Mắt Đen",
            "primrose": "Hoa Anh Thảo",
            "pink primrose": "Hoa Anh Thảo Hồng",
            "canterbury bells": "Hoa Chuông Canterbury",
            "sweet pea": "Hoa Đậu Hà Lan",
            "english marigold": "Hoa Cúc Vạn Thọ Anh",
            "tiger lily": "Hoa Lily Hổ",
            "moon orchid": "Hoa Lan Trăng",
            "bird of paradise": "Hoa Thiên Điểu",
            "hibiscus": "Hoa Dâm Bụt",
            "azalea": "Hoa Đỗ Quyên",
            "camellia": "Hoa Trà",
            "petunia": "Hoa Dạ Yến Thảo",
            "geranium": "Hoa Phong Lữ",
            "bougainvillea": "Hoa Giấy",
            "morning glory": "Hoa Bìm Bìm",
            "water lily": "Hoa Súng",
            "anthurium": "Hoa Hồng Môn",
            "cyclamen": "Hoa Tiên Khách",
            "cape flower": "Hoa Mũi Cape",
            "hippeastrum": "Hoa Huệ Tây",
        }

        english_lower = english_name.lower()
        for eng_name, vi_name in flower_mapping.items():
            if eng_name in english_lower:
                return vi_name

        return english_name.title()

    def clear_all(self):
        """Clear all data"""
        self.current_image = None
        self.current_image_path = None

        # Clear displays
        self.image_canvas.delete("all")
        self.image_info_text.delete(1.0, tk.END)
        self.results_text.delete(1.0, tk.END)

        # Disable predict button
        self.predict_btn.state(["disabled"])

        self.update_status(
            "🌸 Enhanced Recognition System Ready - Upload an image to begin"
        )

    def update_status(self, message):
        """Update status bar"""
        self.status_var.set(message)
        self.root.update_idletasks()


def main():
    """Main function"""
    root = tk.Tk()

    try:
        # Set window icon if available
        pass
    except Exception:
        pass

    app = EnhancedFlowerRecognitionGUI(root)

    # Center window on screen
    root.update_idletasks()
    width = root.winfo_width()
    height = root.winfo_height()
    x = (root.winfo_screenwidth() // 2) - (width // 2)
    y = (root.winfo_screenheight() // 2) - (height // 2)
    root.geometry(f"{width}x{height}+{x}+{y}")

    root.mainloop()


if __name__ == "__main__":
    main()
