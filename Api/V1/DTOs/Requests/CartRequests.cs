using System.ComponentModel.DataAnnotations;

namespace Bloomie.Api.V1.DTOs.Requests;

/// <summary>
/// Request DTO cho thêm item vào cart
/// </summary>
public class AddToCartRequest
{
    [Required]
    public int ProductId { get; set; }

    [Required]
    [Range(1, int.MaxValue, ErrorMessage = "Số lượng phải lớn hơn 0")]
    public int Quantity { get; set; } = 1;
}

/// <summary>
/// Request DTO cho cập nhật cart item
/// </summary>
public class UpdateCartItemRequest
{
    [Required]
    public int CartItemId { get; set; }

    [Required]
    [Range(1, int.MaxValue, ErrorMessage = "Số lượng phải lớn hơn 0")]
    public int Quantity { get; set; }
}

/// <summary>
/// Request DTO cho xóa cart item
/// </summary>
public class RemoveCartItemRequest
{
    [Required]
    public int CartItemId { get; set; }
}
