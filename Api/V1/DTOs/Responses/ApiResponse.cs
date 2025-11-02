namespace Bloomie.Api.V1.DTOs.Responses;

/// <summary>
/// Generic API response wrapper cho tất cả API endpoints
/// </summary>
/// <typeparam name="T">Kiểu dữ liệu của data</typeparam>
public class ApiResponse<T>
{
    /// <summary>
    /// Trạng thái thành công của request
    /// </summary>
    public bool Success { get; set; }

    /// <summary>
    /// Thông báo kết quả
    /// </summary>
    public string? Message { get; set; }

    /// <summary>
    /// Dữ liệu trả về
    /// </summary>
    public T? Data { get; set; }

    /// <summary>
    /// Danh sách lỗi (nếu có)
    /// </summary>
    public List<string>? Errors { get; set; }

    /// <summary>
    /// Metadata bổ sung (pagination, etc.)
    /// </summary>
    public object? Meta { get; set; }

    public ApiResponse()
    {
        Errors = new List<string>();
    }

    /// <summary>
    /// Tạo response thành công
    /// </summary>
    public static ApiResponse<T> SuccessResponse(T data, string message = "Thành công")
    {
        return new ApiResponse<T>
        {
            Success = true,
            Message = message,
            Data = data
        };
    }

    /// <summary>
    /// Tạo response thất bại
    /// </summary>
    public static ApiResponse<T> ErrorResponse(string message, List<string>? errors = null)
    {
        return new ApiResponse<T>
        {
            Success = false,
            Message = message,
            Errors = errors ?? new List<string>()
        };
    }

    /// <summary>
    /// Tạo response với pagination
    /// </summary>
    public static ApiResponse<T> SuccessResponseWithPagination(T data, PaginationMeta meta, string message = "Thành công")
    {
        return new ApiResponse<T>
        {
            Success = true,
            Message = message,
            Data = data,
            Meta = meta
        };
    }
}

/// <summary>
/// Metadata cho pagination
/// </summary>
public class PaginationMeta
{
    public int CurrentPage { get; set; }
    public int PageSize { get; set; }
    public int TotalPages { get; set; }
    public int TotalCount { get; set; }
    public bool HasPrevious => CurrentPage > 1;
    public bool HasNext => CurrentPage < TotalPages;
}
