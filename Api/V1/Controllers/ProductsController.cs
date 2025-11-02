using Bloomie.Api.V1.DTOs.Requests;
using Bloomie.Api.V1.DTOs.Responses;
using Bloomie.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Bloomie.Api.V1.Controllers;

/// <summary>
/// API Controller cho Products
/// </summary>
[ApiController]
[Route("api/v1/[controller]")]
[Produces("application/json")]
public class ProductsController : ControllerBase
{
    private readonly IProductService _productService;
    private readonly ILogger<ProductsController> _logger;

    public ProductsController(
        IProductService productService,
        ILogger<ProductsController> logger)
    {
        _productService = productService;
        _logger = logger;
    }

    /// <summary>
    /// Lấy danh sách tất cả products với pagination và filter
    /// </summary>
    [HttpGet]
    [AllowAnonymous]
    public async Task<ActionResult<ApiResponse<List<ProductListDto>>>> GetProducts([FromQuery] ProductSearchRequest request)
    {
        try
        {
            var products = await _productService.GetAllProductsAsync();

            // Apply filters
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                products = products.Where(p => p.ProductName.Contains(request.Keyword, StringComparison.OrdinalIgnoreCase)).ToList();
            }

            if (request.CategoryId.HasValue)
            {
                products = products.Where(p => p.CategoryId == request.CategoryId.Value).ToList();
            }

            if (request.MinPrice.HasValue)
            {
                products = products.Where(p => p.Price >= request.MinPrice.Value).ToList();
            }

            if (request.MaxPrice.HasValue)
            {
                products = products.Where(p => p.Price <= request.MaxPrice.Value).ToList();
            }

            if (request.IsAvailable.HasValue)
            {
                products = products.Where(p => p.IsAvailable == request.IsAvailable.Value).ToList();
            }

            // Apply sorting
            products = request.SortBy?.ToLower() switch
            {
                "price" => request.SortDescending
                    ? products.OrderByDescending(p => p.Price).ToList()
                    : products.OrderBy(p => p.Price).ToList(),
                "name" => request.SortDescending
                    ? products.OrderByDescending(p => p.ProductName).ToList()
                    : products.OrderBy(p => p.ProductName).ToList(),
                _ => products.OrderByDescending(p => p.ProductId).ToList()
            };

            // Calculate pagination
            var totalCount = products.Count;
            var totalPages = (int)Math.Ceiling(totalCount / (double)request.PageSize);
            var pagedProducts = products
                .Skip((request.Page - 1) * request.PageSize)
                .Take(request.PageSize)
                .ToList();

            // Map to DTOs
            var productDtos = pagedProducts.Select(p => new ProductListDto
            {
                ProductId = p.ProductId,
                ProductName = p.ProductName,
                Price = p.Price,
                DiscountedPrice = p.DiscountedPrice,
                StockQuantity = p.StockQuantity,
                IsAvailable = p.IsAvailable,
                CategoryName = p.Category?.CategoryName,
                PrimaryImage = p.ProductImages?.FirstOrDefault(img => img.IsPrimary)?.ImageUrl,
                AverageRating = p.Ratings?.Any() == true ? (decimal?)p.Ratings.Average(r => r.RatingValue) : null,
                TotalRatings = p.Ratings?.Count ?? 0
            }).ToList();

            var paginationMeta = new PaginationMeta
            {
                CurrentPage = request.Page,
                PageSize = request.PageSize,
                TotalPages = totalPages,
                TotalCount = totalCount
            };

            return Ok(ApiResponse<List<ProductListDto>>.SuccessResponseWithPagination(
                productDtos,
                paginationMeta,
                "Lấy danh sách sản phẩm thành công"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting products");
            return StatusCode(500, ApiResponse<List<ProductListDto>>.ErrorResponse("Đã xảy ra lỗi khi lấy danh sách sản phẩm"));
        }
    }

    /// <summary>
    /// Lấy chi tiết product theo ID
    /// </summary>
    [HttpGet("{id}")]
    [AllowAnonymous]
    public async Task<ActionResult<ApiResponse<ProductDetailDto>>> GetProductById(int id)
    {
        try
        {
            var product = await _productService.GetProductByIdAsync(id);

            if (product == null)
            {
                return NotFound(ApiResponse<ProductDetailDto>.ErrorResponse("Không tìm thấy sản phẩm"));
            }

            var productDto = new ProductDetailDto
            {
                ProductId = product.ProductId,
                ProductName = product.ProductName,
                Description = product.Description,
                Price = product.Price,
                DiscountedPrice = product.DiscountedPrice,
                StockQuantity = product.StockQuantity,
                IsAvailable = product.IsAvailable,
                CategoryId = product.CategoryId,
                CategoryName = product.Category?.CategoryName,
                SupplierId = product.SupplierId,
                SupplierName = product.Supplier?.SupplierName,
                Images = product.ProductImages?.Select(img => new ProductImageDto
                {
                    ImageId = img.ImageId,
                    ImageUrl = img.ImageUrl,
                    IsPrimary = img.IsPrimary,
                    DisplayOrder = img.DisplayOrder
                }).OrderBy(img => img.DisplayOrder).ToList() ?? new List<ProductImageDto>(),
                FlowerTypes = product.FlowerTypeProducts?.Select(ftp => ftp.FlowerType.FlowerTypeName).ToList() ?? new List<string>(),
                AverageRating = product.Ratings?.Any() == true ? (decimal?)product.Ratings.Average(r => r.RatingValue) : null,
                TotalRatings = product.Ratings?.Count ?? 0,
                CreatedAt = product.CreatedAt,
                UpdatedAt = product.UpdatedAt,
                ActivePromotions = product.PromotionProducts?
                    .Where(pp => pp.Promotion.StartDate <= DateTime.Now && pp.Promotion.EndDate >= DateTime.Now)
                    .Select(pp => new PromotionDto
                    {
                        PromotionId = pp.Promotion.PromotionId,
                        PromotionName = pp.Promotion.PromotionName,
                        Description = pp.Promotion.Description,
                        DiscountPercentage = pp.Promotion.DiscountPercentage,
                        StartDate = pp.Promotion.StartDate,
                        EndDate = pp.Promotion.EndDate
                    }).ToList(),
                RecentRatings = product.Ratings?
                    .OrderByDescending(r => r.CreatedAt)
                    .Take(5)
                    .Select(r => new RatingDto
                    {
                        RatingId = r.RatingId,
                        RatingValue = r.RatingValue,
                        Comment = r.Comment,
                        UserName = r.User?.UserName ?? "Anonymous",
                        CreatedAt = r.CreatedAt
                    }).ToList()
            };

            return Ok(ApiResponse<ProductDetailDto>.SuccessResponse(productDto, "Lấy thông tin sản phẩm thành công"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting product by id {ProductId}", id);
            return StatusCode(500, ApiResponse<ProductDetailDto>.ErrorResponse("Đã xảy ra lỗi khi lấy thông tin sản phẩm"));
        }
    }

    /// <summary>
    /// Tạo product mới (Admin only)
    /// </summary>
    [HttpPost]
    [Authorize(Roles = "Admin,Manager")]
    public async Task<ActionResult<ApiResponse<ProductDto>>> CreateProduct([FromBody] CreateProductRequest request)
    {
        try
        {
            // TODO: Implement create product logic using IProductService
            // This requires updating IProductService to add CreateProductAsync method

            return StatusCode(501, ApiResponse<ProductDto>.ErrorResponse("Chức năng đang được phát triển"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating product");
            return StatusCode(500, ApiResponse<ProductDto>.ErrorResponse("Đã xảy ra lỗi khi tạo sản phẩm"));
        }
    }

    /// <summary>
    /// Cập nhật product (Admin only)
    /// </summary>
    [HttpPut("{id}")]
    [Authorize(Roles = "Admin,Manager")]
    public async Task<ActionResult<ApiResponse<ProductDto>>> UpdateProduct(int id, [FromBody] UpdateProductRequest request)
    {
        try
        {
            if (id != request.ProductId)
            {
                return BadRequest(ApiResponse<ProductDto>.ErrorResponse("Product ID không khớp"));
            }

            // TODO: Implement update product logic using IProductService
            // This requires updating IProductService to add UpdateProductAsync method

            return StatusCode(501, ApiResponse<ProductDto>.ErrorResponse("Chức năng đang được phát triển"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating product {ProductId}", id);
            return StatusCode(500, ApiResponse<ProductDto>.ErrorResponse("Đã xảy ra lỗi khi cập nhật sản phẩm"));
        }
    }

    /// <summary>
    /// Xóa product (Admin only)
    /// </summary>
    [HttpDelete("{id}")]
    [Authorize(Roles = "Admin")]
    public async Task<ActionResult<ApiResponse<object>>> DeleteProduct(int id)
    {
        try
        {
            await _productService.DeleteProductAsync(id);
            return Ok(ApiResponse<object>.SuccessResponse(null, "Xóa sản phẩm thành công"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting product {ProductId}", id);
            return StatusCode(500, ApiResponse<object>.ErrorResponse("Đã xảy ra lỗi khi xóa sản phẩm"));
        }
    }

    /// <summary>
    /// Đánh giá sản phẩm
    /// </summary>
    [HttpPost("{id}/ratings")]
    [Authorize]
    public async Task<ActionResult<ApiResponse<RatingDto>>> CreateRating(int id, [FromBody] CreateRatingRequest request)
    {
        try
        {
            if (id != request.ProductId)
            {
                return BadRequest(ApiResponse<RatingDto>.ErrorResponse("Product ID không khớp"));
            }

            // TODO: Implement rating logic
            // This requires adding rating service method

            return StatusCode(501, ApiResponse<RatingDto>.ErrorResponse("Chức năng đang được phát triển"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating rating for product {ProductId}", id);
            return StatusCode(500, ApiResponse<RatingDto>.ErrorResponse("Đã xảy ra lỗi khi đánh giá sản phẩm"));
        }
    }

    /// <summary>
    /// Tìm kiếm sản phẩm bằng hình ảnh
    /// </summary>
    [HttpPost("search-by-image")]
    [AllowAnonymous]
    public async Task<ActionResult<ApiResponse<List<ProductListDto>>>> SearchByImage([FromForm] IFormFile image)
    {
        try
        {
            if (image == null || image.Length == 0)
            {
                return BadRequest(ApiResponse<List<ProductListDto>>.ErrorResponse("Vui lòng tải lên hình ảnh"));
            }

            // TODO: Implement image search using ImageSearchService
            // This is already implemented in ImageSearchService

            return StatusCode(501, ApiResponse<List<ProductListDto>>.ErrorResponse("Chức năng đang được phát triển"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching by image");
            return StatusCode(500, ApiResponse<List<ProductListDto>>.ErrorResponse("Đã xảy ra lỗi khi tìm kiếm"));
        }
    }
}
