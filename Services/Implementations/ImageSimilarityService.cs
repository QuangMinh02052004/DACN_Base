using Bloomie.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text.Json;

namespace Bloomie.Services.Implementations
{
    public class ImageSimilarityService : IImageSimilarityService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<ImageSimilarityService> _logger;
        private const string PYTHON_API_URL = "http://localhost:8000";

        public ImageSimilarityService(HttpClient httpClient, ILogger<ImageSimilarityService> logger)
        {
            _httpClient = httpClient;
            _logger = logger;
            _httpClient.BaseAddress = new Uri(PYTHON_API_URL);
            _httpClient.Timeout = TimeSpan.FromMinutes(2);
        }

        public async Task<SimilaritySearchResult> SearchSimilarProductsAsync(IFormFile imageFile, int topK = 20)
        {
            try
            {
                if (imageFile == null || imageFile.Length == 0)
                {
                    return new SimilaritySearchResult
                    {
                        Success = false,
                        Message = "No image file provided"
                    };
                }

                // Validate file type
                var allowedTypes = new[] { "image/jpeg", "image/jpg", "image/png", "image/webp" };
                if (!allowedTypes.Contains(imageFile.ContentType.ToLower()))
                {
                    return new SimilaritySearchResult
                    {
                        Success = false,
                        Message = "Invalid image format. Only JPG, PNG, and WebP are supported."
                    };
                }

                // Validate file size (max 15MB)
                if (imageFile.Length > 15 * 1024 * 1024)
                {
                    return new SimilaritySearchResult
                    {
                        Success = false,
                        Message = "Image size too large. Maximum 15MB allowed."
                    };
                }

                // Prepare multipart form data
                using var content = new MultipartFormDataContent();
                using var fileStream = imageFile.OpenReadStream();
                using var streamContent = new StreamContent(fileStream);

                streamContent.Headers.ContentType = new MediaTypeHeaderValue(imageFile.ContentType);
                content.Add(streamContent, "file", imageFile.FileName);

                // Call Python API
                _logger.LogInformation("Sending image to Python API for similarity search...");
                var response = await _httpClient.PostAsync($"/search/similar?top_k={topK}", content);

                if (!response.IsSuccessStatusCode)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    _logger.LogError($"Python API error: {response.StatusCode} - {errorContent}");

                    return new SimilaritySearchResult
                    {
                        Success = false,
                        Message = $"Python API error: {response.StatusCode}"
                    };
                }

                // Parse response
                var jsonResponse = await response.Content.ReadAsStringAsync();
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                var apiResponse = JsonSerializer.Deserialize<PythonApiResponse>(jsonResponse, options);

                if (apiResponse == null)
                {
                    return new SimilaritySearchResult
                    {
                        Success = false,
                        Message = "Failed to parse API response"
                    };
                }

                // Convert to our format
                var result = new SimilaritySearchResult
                {
                    Success = apiResponse.Success,
                    Message = apiResponse.Message,
                    TotalMatches = apiResponse.TotalMatches,
                    Matches = apiResponse.Matches.Select(m => new ProductMatch
                    {
                        ProductId = m.ProductId,
                        ImageUrl = m.ImageUrl,
                        SimilarityScore = m.SimilarityScore,
                        ProductName = m.ProductName,
                        ProductPrice = m.ProductPrice
                    }).ToList()
                };

                _logger.LogInformation($"Found {result.TotalMatches} similar products");
                return result;
            }
            catch (HttpRequestException ex)
            {
                _logger.LogError($"HTTP request error: {ex.Message}");
                return new SimilaritySearchResult
                {
                    Success = false,
                    Message = "Cannot connect to image similarity API. Make sure Python service is running."
                };
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error in similarity search: {ex.Message}");
                return new SimilaritySearchResult
                {
                    Success = false,
                    Message = $"Error: {ex.Message}"
                };
            }
        }

        public async Task<bool> IsApiHealthyAsync()
        {
            try
            {
                var response = await _httpClient.GetAsync("/health");
                return response.IsSuccessStatusCode;
            }
            catch
            {
                return false;
            }
        }

        // Private classes for JSON deserialization
        private class PythonApiResponse
        {
            public bool Success { get; set; }
            public string Message { get; set; } = string.Empty;
            public List<PythonProductMatch> Matches { get; set; } = new();
            public int TotalMatches { get; set; }
        }

        private class PythonProductMatch
        {
            public int ProductId { get; set; }
            public string ImageUrl { get; set; } = string.Empty;
            public float SimilarityScore { get; set; }
            public string? ProductName { get; set; }
            public decimal? ProductPrice { get; set; }
        }
    }
}
