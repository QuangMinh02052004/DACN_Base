namespace Bloomie.Models.Entities
{
    /// <summary>
    /// Junction table cho relationship N-N giữa CustomArrangement và FlowerType
    /// Lưu thông tin loại hoa, số lượng, và giá cho mỗi loại hoa trong bó hoa tùy chỉnh
    /// </summary>
    public class CustomArrangementFlower
    {
        public int Id { get; set; }

        // Foreign keys
        public int CustomArrangementId { get; set; }
        public CustomArrangement? CustomArrangement { get; set; }

        public int FlowerTypeId { get; set; }
        public FlowerType? FlowerType { get; set; }

        // Flower details
        public int Quantity { get; set; } // Số lượng bông/cành của loại hoa này
        public string Color { get; set; } // Màu sắc được chọn
        public decimal UnitPrice { get; set; } // Giá mỗi bông/cành tại thời điểm chọn
        public decimal TotalPrice { get; set; } // = Quantity * UnitPrice

        // Optional: Special instructions for this flower type
        public string? Notes { get; set; }
    }
}
