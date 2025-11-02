using System.ComponentModel.DataAnnotations;

namespace Bloomie.Api.V1.DTOs.Requests;

/// <summary>
/// Request DTO cho tạo/cập nhật product
/// </summary>
public class CreateProductRequest
{
    [Required(ErrorMessage = "Tên sản phẩm là bắt buộc")]
    [StringLength(200, ErrorMessage = "Tên sản phẩm không được quá 200 ký tự")]
    public string ProductName { get; set; } = string.Empty;

    [StringLength(2000, ErrorMessage = "Mô tả không được quá 2000 ký tự")]
    public string? Description { get; set; }

    [Required(ErrorMessage = "Giá là bắt buộc")]
    [Range(0, double.MaxValue, ErrorMessage = "Giá phải lớn hơn 0")]
    public decimal Price { get; set; }

    [Range(0, int.MaxValue, ErrorMessage = "Số lượng phải lớn hơn hoặc bằng 0")]
    public int StockQuantity { get; set; }

    public int? CategoryId { get; set; }

    public int? SupplierId { get; set; }

    public List<int>? FlowerTypeIds { get; set; }

    public bool IsAvailable { get; set; } = true;
}

/// <summary>
/// Request DTO cho cập nhật product
/// </summary>
public class UpdateProductRequest : CreateProductRequest
{
    [Required]
    public int ProductId { get; set; }
}

/// <summary>
/// Request DTO cho product search/filter
/// </summary>
public class ProductSearchRequest
{
    public string? Keyword { get; set; }
    public int? CategoryId { get; set; }
    public decimal? MinPrice { get; set; }
    public decimal? MaxPrice { get; set; }
    public List<int>? FlowerTypeIds { get; set; }
    public bool? IsAvailable { get; set; }
    public string? SortBy { get; set; } // price, name, date, rating
    public bool SortDescending { get; set; } = false;
    public int Page { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}

/// <summary>
/// Request DTO cho product rating
/// </summary>
public class CreateRatingRequest
{
    [Required]
    public int ProductId { get; set; }

    [Required(ErrorMessage = "Đánh giá là bắt buộc")]
    [Range(1, 5, ErrorMessage = "Đánh giá phải từ 1-5 sao")]
    public int RatingValue { get; set; }

    [StringLength(1000, ErrorMessage = "Nhận xét không được quá 1000 ký tự")]
    public string? Comment { get; set; }
}
