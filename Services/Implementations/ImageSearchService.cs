using Bloomie.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using System.Text;
using System.Text.Json;

namespace Bloomie.Services.Implementations
{
    public class ImageSearchService : IImageSearchService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<ImageSearchService> _logger;
        private readonly string _pythonApiUrl;

        // Note: Mapping đã được chuyển sang FlowerPriorityMapping.cs để quản lý tập trung

        public ImageSearchService(HttpClient httpClient, ILogger<ImageSearchService> logger, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _logger = logger;
            _pythonApiUrl = configuration["ImageSearch:PythonApiUrl"] ?? "http://localhost:5000";

            // Set timeout cho HTTP client
            _httpClient.Timeout = TimeSpan.FromSeconds(30);
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
                content.Add(imageContent, "image", fileName);

                var response = await _httpClient.PostAsync($"{_pythonApiUrl}/predict", content);

                if (!response.IsSuccessStatusCode)
                {
                    _logger.LogWarning($"Python API returned status code: {response.StatusCode}");
                    return null;
                }

                var responseContent = await response.Content.ReadAsStringAsync();
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                return JsonSerializer.Deserialize<PythonApiResponse>(responseContent, options);
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

                if (response.Predictions != null && response.Predictions.Any())
                {
                    // Lọc chỉ lấy các loại hoa ưu tiên
                    var priorityPredictions = response.Predictions
                        .Where(p => FlowerPriorityMapping.IsPriorityFlower(p.ClassName))
                        .OrderByDescending(p => p.Confidence)
                        .ToList();

                    // Nếu không có loại hoa nào ưu tiên, thử lấy top prediction
                    if (priorityPredictions.Count == 0)
                    {
                        var topPreds = string.Join(", ", response.Predictions.Take(3).Select(p => p.ClassName ?? "N/A"));
                        _logger.LogWarning("Không tìm thấy loại hoa ưu tiên. Top predictions: {TopPredictions}", topPreds);

                        // Lấy top prediction và map về loại gần nhất
                        var topPrediction = response.Predictions.First();
                        var className = topPrediction.ClassName ?? "Không xác định";
                        var normalizedName = FlowerPriorityMapping.GetNormalizedFlowerName(className);

                        result.RecognizedFlower = className;
                        result.Confidence = topPrediction.Confidence;
                        result.FlowerTypes.Add(normalizedName);
                        result.Colors = FlowerPriorityMapping.GetDefaultColors(normalizedName);
                        result.Presentation = "Bó hoa";

                        _logger.LogInformation("Loại hoa không phổ biến: {OriginalName} -> Mapped to: {NormalizedName}", result.RecognizedFlower, normalizedName);
                    }
                    else
                    {
                        // Có loại hoa ưu tiên
                        var topPrediction = priorityPredictions.First();
                        var className = topPrediction.ClassName ?? "Không xác định";

                        result.RecognizedFlower = className;
                        result.Confidence = topPrediction.Confidence;

                        // Chuẩn hóa tên hoa
                        var normalizedName = FlowerPriorityMapping.GetNormalizedFlowerName(className);
                        result.FlowerTypes.Add(normalizedName);
                        result.Colors = FlowerPriorityMapping.GetDefaultColors(normalizedName);
                        result.Presentation = "Bó hoa";

                        _logger.LogInformation("Nhận dạng hoa: {OriginalName} -> {NormalizedName} (độ tin cậy: {Confidence:P2})", result.RecognizedFlower, normalizedName, result.Confidence);

                        result.Flowers.Add(new FlowerDetection
                        {
                            Name = normalizedName,
                            Confidence = topPrediction.Confidence,
                            Colors = result.Colors,
                            Presentation = result.Presentation
                        });

                        // Thêm các predictions ưu tiên khác nếu confidence cao
                        foreach (var pred in priorityPredictions.Skip(1).Take(2))
                        {
                            if (pred.Confidence > 0.15) // Chỉ thêm nếu confidence > 15%
                            {
                                var altClassName = pred.ClassName ?? "N/A";
                                var altName = FlowerPriorityMapping.GetNormalizedFlowerName(altClassName);
                                if (!result.FlowerTypes.Contains(altName))
                                {
                                    result.FlowerTypes.Add(altName);
                                    _logger.LogInformation("Alternative: {OriginalName} -> {NormalizedName} ({Confidence:P2})", altClassName, altName, pred.Confidence);
                                }
                            }
                        }
                    }

                    var flowerTypesList = string.Join(", ", result.FlowerTypes);
                    var colorsList = string.Join(", ", result.Colors);
                    _logger.LogInformation("Tìm kiếm theo: Loại hoa = [{FlowerTypes}], Màu sắc = [{Colors}]", flowerTypesList, colorsList);
                }
                else
                {
                    // Không nhận dạng được
                    result.Success = false;
                    result.Message = "Không thể nhận dạng loại hoa từ ảnh. Vui lòng thử ảnh khác rõ nét hơn.";
                    _logger.LogWarning("Không có predictions từ Python API");
                    return result;
                }

                // Tạo URL redirect với loại hoa
                var flowerTypesParam = string.Join(",", result.FlowerTypes);
                var colorParam = string.Join(",", result.Colors);

                result.RedirectUrl = $"/Product/ImageSearchResults?flowerTypes={Uri.EscapeDataString(flowerTypesParam)}&colors={Uri.EscapeDataString(colorParam)}&recognizedFlower={Uri.EscapeDataString(result.RecognizedFlower)}&confidence={result.Confidence:F2}";

                _logger.LogInformation("Redirect URL: {RedirectUrl}", result.RedirectUrl);

                return result;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error processing API response");
                return new ImageSearchResult
                {
                    Success = false,
                    Message = "Lỗi xử lý kết quả phân tích ảnh."
                };
            }
        }


        private class PythonApiResponse
        {
            public List<Prediction> Predictions { get; set; } = new List<Prediction>();
            public bool Success { get; set; }
            public string Message { get; set; } = string.Empty;
        }

        private class Prediction
        {
            public string ClassName { get; set; } = string.Empty;
            public float Confidence { get; set; }
        }
    }
}