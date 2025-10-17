namespace Bloomie.Models.Entities
{
    public class PresentationStyle
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal BasePrice { get; set; } // Giá cơ bản cho kiểu trình bày (vật liệu: lọ, giấy gói, giỏ...)
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
        public List<Product> Products { get; set; } = new List<Product>();
        public ICollection<CustomArrangement> CustomArrangements { get; set; } = new List<CustomArrangement>();
    }
}
