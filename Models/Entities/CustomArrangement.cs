using Bloomie.Data;

namespace Bloomie.Models.Entities
{
    public class CustomArrangement
    {
        public int Id { get; set; }

        // User information (nullable for guest users)
        public string? UserId { get; set; }
        public ApplicationUser? User { get; set; }

        // Arrangement details
        public string Name { get; set; } // Tên bó hoa do khách đặt
        public string? Description { get; set; } // Mô tả/ghi chú của khách

        // Presentation style (kiểu trình bày: bó hoa, lọ, giỏ...)
        public int PresentationStyleId { get; set; }
        public PresentationStyle? PresentationStyle { get; set; }

        // Pricing
        public decimal BasePrice { get; set; } // Giá cơ bản (presentation style)
        public decimal FlowersCost { get; set; } // Tổng giá các loại hoa
        public decimal TotalPrice { get; set; } // Tổng giá = BasePrice + FlowersCost

        // Status
        public bool IsSaved { get; set; } = false; // Đã lưu để mua sau
        public bool IsOrdered { get; set; } = false; // Đã chuyển thành đơn hàng
        public string? OrderId { get; set; } // Reference to Order if ordered

        // Timestamps
        public DateTime CreatedDate { get; set; } = DateTime.Now;
        public DateTime? UpdatedDate { get; set; }

        // Navigation properties
        public ICollection<CustomArrangementFlower> CustomArrangementFlowers { get; set; } = new List<CustomArrangementFlower>();

        // Optional: Preview image (uploaded or generated)
        public string? PreviewImageUrl { get; set; }
    }
}
