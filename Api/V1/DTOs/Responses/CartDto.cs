namespace Bloomie.Api.V1.DTOs.Responses;

/// <summary>
/// DTO cho Shopping Cart response
/// </summary>
public class CartDto
{
    public int CartId { get; set; }
    public string UserId { get; set; } = string.Empty;
    public List<CartItemDto> Items { get; set; } = new();
    public int TotalItems { get; set; }
    public decimal SubTotal { get; set; }
    public decimal? DiscountAmount { get; set; }
    public decimal TotalAmount { get; set; }
    public DateTime? UpdatedAt { get; set; }
}

/// <summary>
/// DTO cho Cart item
/// </summary>
public class CartItemDto
{
    public int CartItemId { get; set; }
    public int ProductId { get; set; }
    public string ProductName { get; set; } = string.Empty;
    public string? ProductImage { get; set; }
    public decimal Price { get; set; }
    public int Quantity { get; set; }
    public decimal TotalPrice { get; set; }
    public int StockQuantity { get; set; }
    public bool IsAvailable { get; set; }
}
