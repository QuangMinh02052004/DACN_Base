using Microsoft.AspNetCore.Http;

namespace Bloomie.Services.Interfaces
{
    public class ProductMatch
    {
        public int ProductId { get; set; }
        public string ImageUrl { get; set; } = string.Empty;
        public float SimilarityScore { get; set; }
        public string? ProductName { get; set; }
        public decimal? ProductPrice { get; set; }
    }

    public class SimilaritySearchResult
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public List<ProductMatch> Matches { get; set; } = new();
        public int TotalMatches { get; set; }
    }

    public interface IImageSimilarityService
    {
        /// <summary>
        /// Search for similar products by image
        /// </summary>
        Task<SimilaritySearchResult> SearchSimilarProductsAsync(IFormFile imageFile, int topK = 20);

        /// <summary>
        /// Check if Python API is healthy
        /// </summary>
        Task<bool> IsApiHealthyAsync();
    }
}
