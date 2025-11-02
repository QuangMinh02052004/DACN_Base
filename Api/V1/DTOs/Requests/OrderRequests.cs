using System.ComponentModel.DataAnnotations;

namespace Bloomie.Api.V1.DTOs.Requests;

/// <summary>
/// Request DTO cho tạo order
/// </summary>
public class CreateOrderRequest
{
    [Required(ErrorMessage = "Tên khách hàng là bắt buộc")]
    [StringLength(100, ErrorMessage = "Tên khách hàng không được quá 100 ký tự")]
    public string CustomerName { get; set; } = string.Empty;

    [Required(ErrorMessage = "Số điện thoại là bắt buộc")]
    [Phone(ErrorMessage = "Số điện thoại không hợp lệ")]
    public string CustomerPhone { get; set; } = string.Empty;

    [Required(ErrorMessage = "Địa chỉ giao hàng là bắt buộc")]
    [StringLength(500, ErrorMessage = "Địa chỉ không được quá 500 ký tự")]
    public string ShippingAddress { get; set; } = string.Empty;

    [Required(ErrorMessage = "Phương thức thanh toán là bắt buộc")]
    public string PaymentMethod { get; set; } = string.Empty;

    public string? Notes { get; set; }

    [Required]
    public List<OrderItemRequest> Items { get; set; } = new();

    public int? PromotionId { get; set; }
}

/// <summary>
/// Request DTO cho order item
/// </summary>
public class OrderItemRequest
{
    [Required]
    public int ProductId { get; set; }

    [Required]
    [Range(1, int.MaxValue, ErrorMessage = "Số lượng phải lớn hơn 0")]
    public int Quantity { get; set; }
}

/// <summary>
/// Request DTO cho cập nhật order status
/// </summary>
public class UpdateOrderStatusRequest
{
    [Required(ErrorMessage = "Trạng thái là bắt buộc")]
    public string Status { get; set; } = string.Empty;

    public string? Notes { get; set; }
}

/// <summary>
/// Request DTO cho order search/filter
/// </summary>
public class OrderSearchRequest
{
    public string? OrderCode { get; set; }
    public string? CustomerName { get; set; }
    public string? Status { get; set; }
    public DateTime? FromDate { get; set; }
    public DateTime? ToDate { get; set; }
    public decimal? MinAmount { get; set; }
    public decimal? MaxAmount { get; set; }
    public string? SortBy { get; set; } // date, amount
    public bool SortDescending { get; set; } = true;
    public int Page { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}
