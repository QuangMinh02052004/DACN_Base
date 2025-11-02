namespace Bloomie.Api.V1.DTOs.Responses;

/// <summary>
/// DTO cho Product response
/// </summary>
public class ProductDto
{
    public int ProductId { get; set; }
    public string ProductName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public decimal Price { get; set; }
    public decimal? DiscountedPrice { get; set; }
    public int StockQuantity { get; set; }
    public bool IsAvailable { get; set; }
    public int? CategoryId { get; set; }
    public string? CategoryName { get; set; }
    public List<ProductImageDto> Images { get; set; } = new();
    public List<string> FlowerTypes { get; set; } = new();
    public decimal? AverageRating { get; set; }
    public int TotalRatings { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}

/// <summary>
/// DTO cho Product image
/// </summary>
public class ProductImageDto
{
    public int ImageId { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
    public bool IsPrimary { get; set; }
    public int DisplayOrder { get; set; }
}

/// <summary>
/// DTO cho danh sách product (simplified)
/// </summary>
public class ProductListDto
{
    public int ProductId { get; set; }
    public string ProductName { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public decimal? DiscountedPrice { get; set; }
    public int StockQuantity { get; set; }
    public bool IsAvailable { get; set; }
    public string? CategoryName { get; set; }
    public string? PrimaryImage { get; set; }
    public decimal? AverageRating { get; set; }
    public int TotalRatings { get; set; }
}

/// <summary>
/// DTO cho Product detail với thông tin đầy đủ
/// </summary>
public class ProductDetailDto : ProductDto
{
    public int? SupplierId { get; set; }
    public string? SupplierName { get; set; }
    public List<PromotionDto>? ActivePromotions { get; set; }
    public List<RatingDto>? RecentRatings { get; set; }
    public List<ProductDto>? RelatedProducts { get; set; }
}

/// <summary>
/// DTO cho Promotion
/// </summary>
public class PromotionDto
{
    public int PromotionId { get; set; }
    public string PromotionName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public decimal DiscountPercentage { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
}

/// <summary>
/// DTO cho Rating
/// </summary>
public class RatingDto
{
    public int RatingId { get; set; }
    public int RatingValue { get; set; }
    public string? Comment { get; set; }
    public string UserName { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
}
