using Bloomie.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Bloomie.Services.Implementations
{
    public class ImageSearchService : IImageSearchService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<ImageSearchService> _logger;
        private readonly string _pythonApiUrl;
        private readonly IConfiguration _configuration;

        // Note: Mapping đã được chuyển sang FlowerPriorityMapping.cs để quản lý tập trung

        public ImageSearchService(HttpClient httpClient, ILogger<ImageSearchService> logger, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _logger = logger;
            _configuration = configuration;

            // Support switching between local and production API
            var useProduction = configuration.GetValue<bool>("ImageSearch:UseProduction");
            _pythonApiUrl = useProduction
                ? configuration["ImageSearch:ProductionApiUrl"] ?? "http://localhost:8001"
                : configuration["ImageSearch:PythonApiUrl"] ?? "http://localhost:8001";

            // Set timeout from configuration or default to 30 seconds
            var timeoutSeconds = configuration.GetValue<int>("ImageSearch:RequestTimeoutSeconds", 30);
            _httpClient.Timeout = TimeSpan.FromSeconds(timeoutSeconds);

            _logger.LogInformation($"ImageSearchService initialized with API URL: {_pythonApiUrl}");
        }

        public async Task<ImageSearchResult> AnalyzeImageAsync(IFormFile imageFile)
        {
            try
            {
                if (imageFile == null || imageFile.Length == 0)
                {
                    return new ImageSearchResult
                    {
                        Success = false,
                        Message = "Không có file ảnh được tải lên."
                    };
                }

                // Validate file size (max 5MB)
                if (imageFile.Length > 5 * 1024 * 1024)
                {
                    return new ImageSearchResult
                    {
                        Success = false,
                        Message = "File ảnh quá lớn. Vui lòng chọn ảnh nhỏ hơn 5MB."
                    };
                }

                // Validate file type
                var allowedTypes = new[] { "image/jpeg", "image/png", "image/webp", "image/jpg" };
                if (!allowedTypes.Contains(imageFile.ContentType.ToLower()))
                {
                    return new ImageSearchResult
                    {
                        Success = false,
                        Message = "Định dạng file không được hỗ trợ. Vui lòng chọn file JPG, PNG hoặc WEBP."
                    };
                }

                using var memoryStream = new MemoryStream();
                await imageFile.CopyToAsync(memoryStream);
                var imageBytes = memoryStream.ToArray();

                return await AnalyzeImageAsync(imageBytes, imageFile.FileName);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error analyzing image from form file");
                return new ImageSearchResult
                {
                    Success = false,
                    Message = "Đã có lỗi xảy ra khi phân tích ảnh. Vui lòng thử lại."
                };
            }
        }

        public async Task<ImageSearchResult> AnalyzeImageAsync(byte[] imageBytes, string fileName)
        {
            try
            {
                // Call Python API để phân tích ảnh
                var response = await CallPythonApiAsync(imageBytes, fileName);

                if (response == null)
                {
                    return new ImageSearchResult
                    {
                        Success = false,
                        Message = "Không thể kết nối đến dịch vụ phân tích ảnh."
                    };
                }

                return ProcessApiResponse(response);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error analyzing image from bytes");
                return new ImageSearchResult
                {
                    Success = false,
                    Message = "Đã có lỗi xảy ra khi phân tích ảnh. Vui lòng thử lại."
                };
            }
        }

        private async Task<PythonApiResponse?> CallPythonApiAsync(byte[] imageBytes, string fileName)
        {
            try
            {
                using var content = new MultipartFormDataContent();
                using var imageContent = new ByteArrayContent(imageBytes);
                imageContent.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("image/jpeg");
                content.Add(imageContent, "imageFile", fileName);

                // Use enhanced API endpoint
                var response = await _httpClient.PostAsync($"{_pythonApiUrl}/search-by-image", content);

                if (!response.IsSuccessStatusCode)
                {
                    _logger.LogWarning($"Python API returned status code: {response.StatusCode}");
                    return null;
                }

                var responseContent = await response.Content.ReadAsStringAsync();

                // Log raw response for debugging
                _logger.LogInformation("Raw Python API response: {Response}", responseContent);

                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                var result = JsonSerializer.Deserialize<PythonApiResponse>(responseContent, options);

                // Log parsed result
                if (result != null)
                {
                    _logger.LogInformation("Parsed response - ClassId: {ClassId}, ClassName: {ClassName}, VietnameseName: {VietnameseName}, Probability: {Probability}",
                        result.ClassId, result.ClassName, result.VietnameseName, result.Probability);
                }
                else
                {
                    _logger.LogWarning("Failed to deserialize Python API response");
                }

                return result;
            }
            catch (HttpRequestException ex)
            {
                _logger.LogError(ex, "HTTP error calling Python API");
                return null;
            }
            catch (TaskCanceledException ex)
            {
                _logger.LogError(ex, "Timeout calling Python API");
                return null;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error calling Python API");
                return null;
            }
        }

        private ImageSearchResult ProcessApiResponse(PythonApiResponse response)
        {
            try
            {
                var result = new ImageSearchResult { Success = true };

                // Check for error in response
                if (!string.IsNullOrEmpty(response.Error))
                {
                    _logger.LogWarning("Python API returned error: {Error}", response.Error);
                    return new ImageSearchResult
                    {
                        Success = false,
                        Message = $"Lỗi phân tích: {response.Error}"
                    };
                }

                // Check if we have a valid prediction
                if (response.ClassId.HasValue && response.Probability > 0)
                {
                    var className = response.ClassName ?? "Không xác định";
                    var vietnameseName = response.VietnameseName ?? className;

                    _logger.LogInformation("API returned: {VietnameseName} ({Confidence:P2})", vietnameseName, response.Probability);

                    // Use Vietnamese name as recognized flower
                    result.RecognizedFlower = vietnameseName;
                    result.Confidence = response.Probability;

                    // Check if this is a priority flower (check English name)
                    if (FlowerPriorityMapping.IsPriorityFlower(className))
                    {
                        result.FlowerTypes.Add(vietnameseName);
                        result.Colors = FlowerPriorityMapping.GetDefaultColors(vietnameseName);
                        result.Presentation = "Bó hoa";

                        _logger.LogInformation("Priority flower detected: {FlowerName}", vietnameseName);
                    }
                    else
                    {
                        // Non-priority flower, try to map to closest priority flower
                        var normalizedName = FlowerPriorityMapping.GetNormalizedFlowerName(className);

                        result.FlowerTypes.Add(normalizedName);
                        result.Colors = FlowerPriorityMapping.GetDefaultColors(normalizedName);
                        result.Presentation = "Bó hoa";

                        _logger.LogInformation("Non-priority flower: {OriginalName} -> Mapped to: {NormalizedName}", vietnameseName, normalizedName);
                    }

                    // Add to flowers list
                    result.Flowers.Add(new FlowerDetection
                    {
                        Name = result.FlowerTypes.First(),
                        Confidence = response.Probability,
                        Colors = result.Colors,
                        Presentation = result.Presentation
                    });

                    // Process alternative predictions (top 3)
                    if (response.TopPredictions != null && response.TopPredictions.Count > 1)
                    {
                        foreach (var pred in response.TopPredictions)
                        {
                            var altVietnameseName = pred.VietnameseName ?? pred.ClassName ?? "Không xác định";
                            var altClassName = pred.ClassName ?? "Không xác định";

                            // Map to priority flower
                            List<string> altFlowerTypes = new List<string>();
                            if (FlowerPriorityMapping.IsPriorityFlower(altClassName))
                            {
                                altFlowerTypes.Add(altVietnameseName);
                            }
                            else
                            {
                                var normalizedAltName = FlowerPriorityMapping.GetNormalizedFlowerName(altClassName);
                                altFlowerTypes.Add(normalizedAltName);
                            }

                            result.AlternativePredictions.Add(new AlternativePrediction
                            {
                                FlowerName = altVietnameseName,
                                EnglishName = altClassName,
                                Confidence = pred.Probability,
                                FlowerTypes = altFlowerTypes
                            });
                        }

                        _logger.LogInformation("Added {Count} alternative predictions", result.AlternativePredictions.Count);
                    }

                    // Create redirect URL
                    var flowerTypesParam = string.Join(",", result.FlowerTypes);
                    var colorParam = string.Join(",", result.Colors);
                    result.RedirectUrl = $"/Product/ImageSearchResults?flowerTypes={Uri.EscapeDataString(flowerTypesParam)}&colors={Uri.EscapeDataString(colorParam)}&recognizedFlower={Uri.EscapeDataString(result.RecognizedFlower)}&confidence={result.Confidence:F2}";

                    _logger.LogInformation("Redirect URL: {RedirectUrl}", result.RedirectUrl);

                    return result;
                }
                else
                {
                    _logger.LogWarning("Không có predictions hợp lệ từ Python API");
                    return new ImageSearchResult
                    {
                        Success = false,
                        Message = "Không thể nhận dạng loại hoa từ ảnh. Vui lòng thử ảnh khác có độ rõ nét hơn."
                    };
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error processing API response");
                return new ImageSearchResult
                {
                    Success = false,
                    Message = "Đã có lỗi xảy ra khi xử lý kết quả. Vui lòng thử lại."
                };
            }
        }


        private class PythonApiResponse
        {
            [JsonPropertyName("class_id")]
            public int? ClassId { get; set; }

            [JsonPropertyName("class_name")]
            public string ClassName { get; set; } = string.Empty;

            [JsonPropertyName("vietnamese_name")]
            public string VietnameseName { get; set; } = string.Empty;

            [JsonPropertyName("probability")]
            public float Probability { get; set; }

            [JsonPropertyName("error")]
            public string? Error { get; set; }

            [JsonPropertyName("top_predictions")]
            public List<PredictionItem>? TopPredictions { get; set; }
        }

        private class PredictionItem
        {
            [JsonPropertyName("class_id")]
            public int ClassId { get; set; }

            [JsonPropertyName("class_name")]
            public string ClassName { get; set; } = string.Empty;

            [JsonPropertyName("vietnamese_name")]
            public string VietnameseName { get; set; } = string.Empty;

            [JsonPropertyName("probability")]
            public float Probability { get; set; }
        }
    }
}