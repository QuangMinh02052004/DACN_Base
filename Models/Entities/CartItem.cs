namespace Bloomie.Models.Entities
{
    public class CartItem
    {
        // Database properties for API use
        public int CartItemId { get; set; }
        public int CartId { get; set; }
        public DateTime AddedAt { get; set; } = DateTime.Now;
        
        // Product properties
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; } // Số lượng sản phẩm
        public decimal DiscountedPrice { get; set; } // Giá sau khi áp dụng giảm giá theo sản phẩm
        public string ImageUrl { get; set; }
        public DateTime? DeliveryDate { get; set; } // Ngày giao hàng
        public string DeliveryTime { get; set; } // Thời gian giao hàng

        // For Custom Flower Arrangement
        public int? CustomArrangementId { get; set; } // ID của bó hoa tùy chỉnh (nullable)
        public bool IsCustomArrangement => CustomArrangementId.HasValue;
        
        // Navigation properties
        public ShoppingCart Cart { get; set; }
        public Product Product { get; set; }
    }
}
