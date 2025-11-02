namespace Bloomie.Api.V1.DTOs.Responses;

/// <summary>
/// DTO cho Category response
/// </summary>
public class CategoryDto
{
    public int CategoryId { get; set; }
    public string CategoryName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int? ParentCategoryId { get; set; }
    public string? ParentCategoryName { get; set; }
    public int ProductCount { get; set; }
    public List<CategoryDto>? SubCategories { get; set; }
}

/// <summary>
/// DTO cho Category tree (hierarchy)
/// </summary>
public class CategoryTreeDto
{
    public int CategoryId { get; set; }
    public string CategoryName { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int ProductCount { get; set; }
    public List<CategoryTreeDto>? Children { get; set; }
}
