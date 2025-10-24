using System.Collections.Generic;

namespace Bloomie.Services.Implementations
{
    /// <summary>
    /// Mapping các loại hoa từ Oxford Flowers dataset về các loại hoa chính mà shop bán
    /// Giảm từ 102 loại xuống còn khoảng 15-20 loại phổ biến
    /// </summary>
    public static class FlowerPriorityMapping
    {
        // Danh sách các loại hoa CHÍNH mà shop thường bán
        public static readonly HashSet<string> PriorityFlowers = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            // Top flowers - Hoa bán chạy nhất
            "rose",              // Hoa Hồng
            "sunflower",         // Hoa Hướng Dương
            "lily",              // Hoa Lily
            "orchid",            // Hoa Lan
            "carnation",         // Hoa Cẩm Chướng
            "tulip",             // Hoa Tulip
            "daisy",             // Hoa Cúc
            "chrysanthemum",     // Hoa Cúc (loại khác)

            // Popular flowers - Hoa phổ biến
            "hydrangea",         // Hoa Cẩm Tú Cầu
            "peony",             // Hoa Mẫu Đơn
            "lotus",             // Hoa Sen
            "jasmine",           // Hoa Nhài
            "lavender",          // Hoa Lavender
            "gerbera",           // Hoa Đồng Tiền
            "dahlia",            // Hoa Thược Dược

            // Special occasions - Hoa dịp đặc biệt
            "iris",              // Hoa Diên Vĩ
            "magnolia",          // Hoa Mộc Lan
            "camellia",          // Hoa Trà
            "azalea",            // Hoa Đỗ Quyên
            "hibiscus"           // Hoa Dâm Bụt
        };

        // Mapping từ Oxford Flowers names → Shop flower names
        public static readonly Dictionary<string, string> FlowerNameMapping = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
        {
            // === ROSES ===
            ["rose"] = "Hồng",

            // === SUNFLOWERS ===
            ["sunflower"] = "Hướng Dương",

            // === LILIES ===
            ["lily"] = "Lily",
            ["tiger lily"] = "Lily",
            ["fire lily"] = "Lily",
            ["peruvian lily"] = "Lily",
            ["canna lily"] = "Lily",
            ["toad lily"] = "Lily",
            ["blackberry lily"] = "Lily",
            ["giant white arum lily"] = "Lily",
            ["water lily"] = "Súng",

            // === ORCHIDS ===
            ["orchid"] = "Lan",
            ["moon orchid"] = "Lan",
            ["hard-leaved pocket orchid"] = "Lan",

            // === CARNATIONS ===
            ["carnation"] = "Cẩm Chướng",
            ["sweet william"] = "Cẩm Chướng",

            // === TULIPS ===
            ["tulip"] = "Tulip",
            ["siam tulip"] = "Tulip",

            // === DAISIES / CHRYSANTHEMUMS ===
            ["daisy"] = "Cúc",
            ["oxeye daisy"] = "Cúc",
            ["barbeton daisy"] = "Cúc",
            ["black-eyed susan"] = "Cúc",
            ["mexican aster"] = "Cúc",
            ["purple coneflower"] = "Cúc",
            ["gazania"] = "Cúc",
            ["osteospermum"] = "Cúc",

            // === HYDRANGEA ===
            ["hydrangea"] = "Cẩm Tú Cầu",

            // === DAHLIA ===
            ["dahlia"] = "Thược Dược",
            ["orange dahlia"] = "Thược Dược",
            ["pink-yellow dahlia"] = "Thược Dược",

            // === IRIS ===
            ["iris"] = "Diên Vĩ",
            ["yellow iris"] = "Diên Vĩ",
            ["bearded iris"] = "Diên Vĩ",

            // === MAGNOLIA ===
            ["magnolia"] = "Mộc Lan",

            // === CAMELLIA ===
            ["camellia"] = "Trà",

            // === AZALEA ===
            ["azalea"] = "Đỗ Quyên",

            // === HIBISCUS ===
            ["hibiscus"] = "Dâm Bụt",

            // === LOTUS ===
            ["lotus"] = "Sen",

            // === GERBERA ===
            ["gerbera"] = "Đồng Tiền",

            // === POINSETTIA ===
            ["poinsettia"] = "Trạng Nguyên",

            // === ANTHURIUM ===
            ["anthurium"] = "Hồng Môn",

            // === MARIGOLD ===
            ["marigold"] = "Vạn Thọ",
            ["english marigold"] = "Vạn Thọ",

            // === PETUNIA ===
            ["petunia"] = "Dạ Yến Thảo",
            ["mexican petunia"] = "Dạ Yến Thảo",

            // === OTHERS - Map to closest popular flower ===
            ["bird of paradise"] = "Thiên Điểu",
            ["snapdragon"] = "Mõm Sói",
            ["daffodil"] = "Thủy Tiên",
            ["primrose"] = "Anh Thảo",
            ["pink primrose"] = "Anh Thảo",
            ["sweet pea"] = "Đậu Hà Lan",
            ["grape hyacinth"] = "Đậu Biếc",
            ["primula"] = "Anh Thảo",
            ["clematis"] = "Tơ Hồng",
            ["morning glory"] = "Bìm Bìm",
            ["passion flower"] = "Lạc Tiên",
            ["bougainvillea"] = "Giấy",
            ["geranium"] = "Phong Lữ",
            ["pelargonium"] = "Phong Lữ",
            ["balloon flower"] = "Cát Cánh",
            ["windflower"] = "Hải Quỳ",
            ["columbine"] = "Huyền Sâm",
            ["foxglove"] = "Mao Địa Hoàng",
            ["buttercup"] = "Mao Lương",
            ["dandelion"] = "Bồ Công Anh",
            ["common dandelion"] = "Bồ Công Anh",
            ["poppy"] = "Anh Túc",
            ["corn poppy"] = "Anh Túc",
            ["californian poppy"] = "Anh Túc",
            ["tree poppy"] = "Anh Túc",
        };

        // Nhóm các loại hoa tương tự
        public static readonly Dictionary<string, List<string>> FlowerGroups = new Dictionary<string, List<string>>
        {
            ["Hồng"] = new List<string> { "rose", "desert-rose" },
            ["Lily"] = new List<string> { "lily", "tiger lily", "fire lily", "peruvian lily", "canna lily", "toad lily", "blackberry lily", "giant white arum lily" },
            ["Lan"] = new List<string> { "orchid", "moon orchid", "hard-leaved pocket orchid" },
            ["Cúc"] = new List<string> { "daisy", "oxeye daisy", "barbeton daisy", "black-eyed susan", "gazania", "osteospermum", "mexican aster", "purple coneflower" },
            ["Cẩm Chướng"] = new List<string> { "carnation", "sweet william" },
            ["Tulip"] = new List<string> { "tulip", "siam tulip" },
            ["Thược Dược"] = new List<string> { "dahlia", "orange dahlia", "pink-yellow dahlia" },
            ["Diên Vĩ"] = new List<string> { "iris", "yellow iris", "bearded iris" },
            ["Anh Thảo"] = new List<string> { "primrose", "pink primrose", "primula" },
            ["Anh Túc"] = new List<string> { "poppy", "corn poppy", "californian poppy", "tree poppy" },
        };

        /// <summary>
        /// Kiểm tra xem loại hoa có phải là loại ưu tiên không
        /// </summary>
        public static bool IsPriorityFlower(string flowerName)
        {
            if (string.IsNullOrWhiteSpace(flowerName))
                return false;

            var lowerName = flowerName.ToLower();

            // Check exact match in priority list
            foreach (var priority in PriorityFlowers)
            {
                if (lowerName.Contains(priority) || priority.Contains(lowerName))
                    return true;
            }

            // Check in mapping
            return FlowerNameMapping.ContainsKey(lowerName);
        }

        /// <summary>
        /// Lấy tên hoa chuẩn hóa cho shop
        /// </summary>
        public static string GetNormalizedFlowerName(string flowerName)
        {
            if (string.IsNullOrWhiteSpace(flowerName))
                return "Hoa";

            var lowerName = flowerName.ToLower();

            // Try exact match first
            if (FlowerNameMapping.TryGetValue(lowerName, out var mappedName))
                return mappedName;

            // Try partial match
            foreach (var kvp in FlowerNameMapping)
            {
                if (lowerName.Contains(kvp.Key) || kvp.Key.Contains(lowerName))
                    return kvp.Value;
            }

            // Fallback: capitalize first letter
            return char.ToUpper(flowerName[0]) + flowerName.Substring(1).ToLower();
        }

        /// <summary>
        /// Lấy màu sắc mặc định cho loại hoa
        /// </summary>
        public static List<string> GetDefaultColors(string vietnameseFlowerName)
        {
            return vietnameseFlowerName switch
            {
                "Hồng" => new List<string> { "Đỏ", "Hồng", "Trắng", "Vàng" },
                "Hướng Dương" => new List<string> { "Vàng", "Cam" },
                "Lily" => new List<string> { "Trắng", "Hồng", "Cam", "Vàng" },
                "Lan" => new List<string> { "Trắng", "Tím", "Hồng" },
                "Cẩm Chướng" => new List<string> { "Đỏ", "Hồng", "Trắng" },
                "Tulip" => new List<string> { "Đỏ", "Hồng", "Vàng", "Tím", "Trắng" },
                "Cúc" => new List<string> { "Trắng", "Vàng", "Hồng" },
                "Thược Dược" => new List<string> { "Đỏ", "Hồng", "Cam", "Vàng" },
                "Diên Vĩ" => new List<string> { "Tím", "Vàng", "Trắng" },
                "Sen" => new List<string> { "Hồng", "Trắng" },
                "Đồng Tiền" => new List<string> { "Đỏ", "Cam", "Vàng", "Hồng" },
                _ => new List<string> { "Đỏ", "Hồng", "Trắng", "Vàng" }
            };
        }
    }
}
