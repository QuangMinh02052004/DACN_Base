namespace Bloomie.Api.V1.DTOs.Responses;

/// <summary>
/// DTO cho Order response
/// </summary>
public class OrderDto
{
    public int OrderId { get; set; }
    public string OrderCode { get; set; } = string.Empty;
    public DateTime OrderDate { get; set; }
    public string Status { get; set; } = string.Empty;
    public decimal TotalAmount { get; set; }
    public string? CustomerName { get; set; }
    public string? CustomerPhone { get; set; }
    public string? ShippingAddress { get; set; }
    public string? PaymentMethod { get; set; }
    public string? PaymentStatus { get; set; }
    public DateTime? DeliveryDate { get; set; }
    public string? Notes { get; set; }
}

/// <summary>
/// DTO cho Order detail với order items
/// </summary>
public class OrderDetailDto : OrderDto
{
    public List<OrderItemDto> OrderItems { get; set; } = new();
    public List<OrderStatusHistoryDto> StatusHistory { get; set; } = new();
    public ShippingInfoDto? ShippingInfo { get; set; }
    public PaymentInfoDto? PaymentInfo { get; set; }
}

/// <summary>
/// DTO cho Order item
/// </summary>
public class OrderItemDto
{
    public int OrderDetailId { get; set; }
    public int ProductId { get; set; }
    public string ProductName { get; set; } = string.Empty;
    public string? ProductImage { get; set; }
    public int Quantity { get; set; }
    public decimal UnitPrice { get; set; }
    public decimal TotalPrice { get; set; }
}

/// <summary>
/// DTO cho Order status history
/// </summary>
public class OrderStatusHistoryDto
{
    public int HistoryId { get; set; }
    public string Status { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public DateTime ChangedAt { get; set; }
    public string? ChangedBy { get; set; }
}

/// <summary>
/// DTO cho Shipping info
/// </summary>
public class ShippingInfoDto
{
    public int ShippingId { get; set; }
    public string? ShippingMethod { get; set; }
    public decimal ShippingFee { get; set; }
    public string? TrackingNumber { get; set; }
    public string? ShippingAddress { get; set; }
    public DateTime? EstimatedDelivery { get; set; }
    public DateTime? ActualDelivery { get; set; }
}

/// <summary>
/// DTO cho Payment info
/// </summary>
public class PaymentInfoDto
{
    public int PaymentId { get; set; }
    public string PaymentMethod { get; set; } = string.Empty;
    public decimal Amount { get; set; }
    public string Status { get; set; } = string.Empty;
    public DateTime? PaidAt { get; set; }
    public string? TransactionId { get; set; }
}
