#!/usr/bin/env python3
"""
GUI Test Tool for Oxford Flowers Image Recognition
Sử dụng tkinter để test việc nhận dạng hoa từ hình ảnh
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
from PIL import Image, ImageTk
import tensorflow as tf
import numpy as np
import os
import sys
from datetime import datetime


class FlowerRecognitionGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Oxford Flowers Recognition Test Tool")
        self.root.geometry("800x700")
        self.root.resizable(True, True)

        # Initialize variables first
        self.model = None
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
            # Get the script directory and model path
            script_dir = os.path.dirname(os.path.abspath(__file__))
            model_path = os.path.join(script_dir, "oxford102_m2_optimized.h5")

            print(f"Script directory: {script_dir}")
            print(f"Model path: {model_path}")
            print(f"Model file exists: {os.path.exists(model_path)}")

            if not os.path.exists(model_path):
                error_msg = f"Model file not found at: {model_path}"
                messagebox.showerror("Error", error_msg)
                self.update_status(f"Model loading failed: File not found")
                return

            print("Loading TensorFlow model...")
            self.model = tf.keras.models.load_model(model_path)
            print("Model loaded successfully!")
            self.update_status("Model loaded successfully! ✓")

        except Exception as e:
            messagebox.showerror("Error", f"Failed to load model: {str(e)}")
            self.update_status(f"Model loading failed: {str(e)}")

    def setup_gui(self):
        """Setup the GUI layout"""
        # Main frame
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        # Configure grid weights
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        main_frame.rowconfigure(2, weight=1)

        # Title
        title_label = ttk.Label(
            main_frame,
            text="Oxford Flowers Recognition Test Tool",
            font=("Arial", 16, "bold"),
        )
        title_label.grid(row=0, column=0, columnspan=3, pady=(0, 20))

        # Left panel - Controls
        control_frame = ttk.LabelFrame(main_frame, text="Controls", padding="10")
        control_frame.grid(
            row=1, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), padx=(0, 10)
        )

        # Upload button
        self.upload_btn = ttk.Button(
            control_frame, text="📁 Select Image", command=self.upload_image, width=20
        )
        self.upload_btn.grid(row=0, column=0, pady=(0, 10), sticky=tk.W + tk.E)

        # Predict button
        self.predict_btn = ttk.Button(
            control_frame, text="🔍 Analyze Image", command=self.predict_image, width=20
        )
        self.predict_btn.grid(row=1, column=0, pady=(0, 10), sticky=tk.W + tk.E)
        self.predict_btn.state(["disabled"])

        # Clear button
        self.clear_btn = ttk.Button(
            control_frame, text="🗑️ Clear All", command=self.clear_all, width=20
        )
        self.clear_btn.grid(row=2, column=0, pady=(0, 20), sticky=tk.W + tk.E)

        # Image info
        info_frame = ttk.LabelFrame(control_frame, text="Image Info", padding="5")
        info_frame.grid(row=3, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), pady=(0, 10))

        self.image_info_text = tk.Text(info_frame, height=8, width=25, wrap=tk.WORD)
        info_scrollbar = ttk.Scrollbar(
            info_frame, orient=tk.VERTICAL, command=self.image_info_text.yview
        )
        self.image_info_text.configure(yscrollcommand=info_scrollbar.set)
        self.image_info_text.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        info_scrollbar.grid(row=0, column=1, sticky=(tk.N, tk.S))

        # Configure image info frame
        info_frame.columnconfigure(0, weight=1)
        info_frame.rowconfigure(0, weight=1)

        # Center panel - Image display
        image_frame = ttk.LabelFrame(main_frame, text="Image Preview", padding="10")
        image_frame.grid(row=1, column=1, sticky=(tk.W, tk.E, tk.N, tk.S))

        # Image canvas
        self.image_canvas = tk.Canvas(image_frame, width=300, height=300, bg="white")
        self.image_canvas.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        image_frame.columnconfigure(0, weight=1)
        image_frame.rowconfigure(0, weight=1)

        # Right panel - Results
        results_frame = ttk.LabelFrame(
            main_frame, text="Recognition Results", padding="10"
        )
        results_frame.grid(
            row=1, column=2, sticky=(tk.W, tk.E, tk.N, tk.S), padx=(10, 0)
        )

        # Results text
        self.results_text = tk.Text(results_frame, height=20, width=35, wrap=tk.WORD)
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
        self.status_var.set("Ready. Please load a model and select an image.")
        status_bar = ttk.Label(
            main_frame, textvariable=self.status_var, relief=tk.SUNKEN
        )
        status_bar.grid(
            row=2, column=0, columnspan=3, sticky=(tk.W, tk.E), pady=(10, 0)
        )

    def upload_image(self):
        """Handle image upload"""
        try:
            file_path = filedialog.askopenfilename(
                title="Select an image",
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

            # Update image info
            self.update_image_info()

            # Enable predict button
            self.predict_btn.state(["!disabled"])

            self.update_status(f"Image loaded: {os.path.basename(file_path)}")

        except Exception as e:
            messagebox.showerror("Error", f"Failed to load image: {str(e)}")
            self.update_status(f"Error loading image: {str(e)}")

    def display_image(self, pil_image):
        """Display image on canvas"""
        # Resize image to fit canvas while maintaining aspect ratio
        canvas_width = 300
        canvas_height = 300

        img_width, img_height = pil_image.size
        aspect_ratio = img_width / img_height

        if aspect_ratio > 1:  # Wide image
            new_width = canvas_width
            new_height = int(canvas_width / aspect_ratio)
        else:  # Tall image
            new_height = canvas_height
            new_width = int(canvas_height * aspect_ratio)

        # Resize image
        display_image = pil_image.resize(
            (new_width, new_height), Image.Resampling.LANCZOS
        )

        # Convert to PhotoImage
        self.photo = ImageTk.PhotoImage(display_image)

        # Clear canvas and display image
        self.image_canvas.delete("all")
        x = (canvas_width - new_width) // 2
        y = (canvas_height - new_height) // 2
        self.image_canvas.create_image(x, y, anchor=tk.NW, image=self.photo)

    def update_image_info(self):
        """Update image information display"""
        if not self.current_image:
            return

        info = f"File: {os.path.basename(self.current_image_path)}\n"
        info += f"Path: {self.current_image_path}\n"
        info += f"Size: {self.current_image.size[0]} x {self.current_image.size[1]}\n"
        info += f"Mode: {self.current_image.mode}\n"
        info += f"Format: {self.current_image.format}\n"

        # File size
        file_size = os.path.getsize(self.current_image_path)
        if file_size < 1024:
            info += f"File Size: {file_size} bytes\n"
        elif file_size < 1024 * 1024:
            info += f"File Size: {file_size / 1024:.1f} KB\n"
        else:
            info += f"File Size: {file_size / (1024 * 1024):.1f} MB\n"

        self.image_info_text.delete(1.0, tk.END)
        self.image_info_text.insert(1.0, info)

    def predict_image(self):
        """Predict the flower type"""
        if not self.model:
            messagebox.showerror("Error", "Model not loaded!")
            return

        if not self.current_image:
            messagebox.showerror("Error", "No image selected!")
            return

        try:
            self.update_status("Analyzing image...")

            # Preprocess image
            image = self.current_image.convert("RGB")
            image = image.resize((224, 224))
            image_array = np.array(image) / 255.0
            image_array = np.expand_dims(image_array, axis=0)

            # Predict
            predictions = self.model.predict(image_array, verbose=0)

            # Get top 5 predictions
            top_5_indices = np.argsort(predictions[0])[-5:][::-1]

            # Format results
            results = f"🌸 FLOWER RECOGNITION RESULTS\n"
            results += f"{'=' * 40}\n"
            results += f"Analyzed at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
            results += f"Image: {os.path.basename(self.current_image_path)}\n\n"

            results += f"TOP 5 PREDICTIONS:\n"
            results += f"{'-' * 40}\n"

            for i, idx in enumerate(top_5_indices, 1):
                flower_name = self.class_names[idx]
                vietnamese_name = self.map_flower_to_vietnamese(flower_name)
                confidence = predictions[0][idx] * 100

                results += f"{i}. {vietnamese_name}\n"
                results += f"   English: {flower_name}\n"
                results += f"   Confidence: {confidence:.2f}%\n"

                if i == 1:
                    results += f"   🏆 BEST MATCH\n"
                results += f"\n"

            # Additional info
            results += f"{'=' * 40}\n"
            results += f"Model: Oxford Flowers 102\n"
            results += f"Total classes: {len(self.class_names)}\n"
            results += f"Image size processed: 224x224\n"

            # Display results
            self.results_text.delete(1.0, tk.END)
            self.results_text.insert(1.0, results)

            # Update status
            best_match = self.map_flower_to_vietnamese(
                self.class_names[top_5_indices[0]]
            )
            best_confidence = predictions[0][top_5_indices[0]] * 100
            self.update_status(
                f"Analysis complete! Best match: {best_match} ({best_confidence:.1f}%)"
            )

        except Exception as e:
            messagebox.showerror("Error", f"Prediction failed: {str(e)}")
            self.update_status(f"Prediction error: {str(e)}")

    def map_flower_to_vietnamese(self, english_name):
        """Map English flower names to Vietnamese"""
        flower_mapping = {
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

        self.update_status("Cleared all data. Ready for new image.")

    def update_status(self, message):
        """Update status bar"""
        self.status_var.set(message)
        self.root.update_idletasks()


def main():
    """Main function"""
    root = tk.Tk()

    # Set icon if available
    try:
        # You can add an icon file here
        pass
    except:
        pass

    app = FlowerRecognitionGUI(root)

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
