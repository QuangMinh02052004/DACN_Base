using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using Bloomie.Models;
using Bloomie.Models.Entities;
using Bloomie.Services.Interfaces;

namespace Bloomie.Services.Implementations
{
    public class GeminiService : IAIChatService
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiKey;
        private readonly string _model;
        private readonly ILogger<GeminiService> _logger;

        private const string GEMINI_API_BASE = "https://generativelanguage.googleapis.com/v1beta/models";

        // System prompt để AI hiểu vai trò của nó
        private const string SYSTEM_PROMPT = @"Bạn là trợ lý ảo thông minh của Bloomie - hệ thống bán hoa trực tuyến cao cấp tại Việt Nam.

Vai trò của bạn:
- Tư vấn khách hàng về các loại hoa, bó hoa phù hợp cho từng dịp
- Giúp khách hàng tìm sản phẩm phù hợp với nhu cầu và ngân sách
- Trả lời thắc mắc về đơn hàng, giao hàng, thanh toán
- Hướng dẫn sử dụng website và ứng dụng
- Tư vấn về cách chăm sóc hoa tươi lâu
- Gợi ý các sản phẩm phổ biến cho sinh nhật, kỷ niệm, lễ tết, Valentine, 20/10, etc.

Phong cách giao tiếp:
- Thân thiện, nhiệt tình, chuyên nghiệp
- Sử dụng tiếng Việt tự nhiên, dễ hiểu
- Ngắn gọn nhưng đầy đủ thông tin
- Emoji phù hợp để tạo sự gần gũi (nhưng không lạm dụng)

Lưu ý:
- Luôn ưu tiên gợi ý sản phẩm có sẵn trong hệ thống
- Nếu không chắc chắn về giá hoặc tồn kho, hướng dẫn khách check trên website
- Với câu hỏi về đơn hàng cụ thể, yêu cầu mã đơn hàng
- Không đưa ra thông tin sai lệch về sản phẩm";

        public GeminiService(
            IHttpClientFactory httpClientFactory,
            IConfiguration configuration,
            ILogger<GeminiService> logger)
        {
            _httpClient = httpClientFactory.CreateClient("GeminiClient");
            _apiKey = configuration["Gemini:ApiKey"] ?? throw new InvalidOperationException("Gemini API Key is not configured");
            _model = configuration["Gemini:Model"] ?? "gemini-2.0-flash-exp";
            _logger = logger;
        }

        public async Task<string> GetResponseAsync(string userMessage, List<ChatMessage>? conversationHistory = null)
        {
            try
            {
                var requestBody = BuildRequestBody(userMessage, conversationHistory, stream: false);
                var url = $"{GEMINI_API_BASE}/{_model}:generateContent?key={_apiKey}";

                _logger.LogInformation("Sending request to Gemini API...");

                var response = await _httpClient.PostAsync(url,
                    new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json"));

                response.EnsureSuccessStatusCode();

                var responseBody = await response.Content.ReadAsStringAsync();
                _logger.LogInformation("Gemini API Response Body: {ResponseBody}", responseBody);

                // Use case-insensitive deserialization
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                var result = JsonSerializer.Deserialize<GeminiResponse>(responseBody, options);

                _logger.LogInformation("Deserialized result - Candidates count: {Count}", result?.Candidates?.Count ?? 0);

                var text = result?.Candidates?.FirstOrDefault()?.Content?.Parts?.FirstOrDefault()?.Text;

                if (string.IsNullOrEmpty(text))
                {
                    _logger.LogWarning("No text found in Gemini response. Full response: {Response}", responseBody);
                    return "Xin lỗi, tôi không thể tạo phản hồi lúc này. Vui lòng thử lại sau.";
                }

                _logger.LogInformation("Successfully extracted AI response text (length: {Length})", text.Length);
                return text;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error calling Gemini API");
                return "Xin lỗi, đã xảy ra lỗi khi xử lý yêu cầu của bạn. Vui lòng thử lại sau.";
            }
        }

        public async Task<string> StreamResponseAsync(
            string userMessage,
            List<ChatMessage>? conversationHistory = null,
            Action<string>? onChunkReceived = null)
        {
            try
            {
                var requestBody = BuildRequestBody(userMessage, conversationHistory, stream: true);
                var url = $"{GEMINI_API_BASE}/{_model}:streamGenerateContent?key={_apiKey}&alt=sse";

                var request = new HttpRequestMessage(HttpMethod.Post, url)
                {
                    Content = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json")
                };

                using var response = await _httpClient.SendAsync(request, HttpCompletionOption.ResponseHeadersRead);
                response.EnsureSuccessStatusCode();

                var fullResponse = new StringBuilder();

                await using var stream = await response.Content.ReadAsStreamAsync();
                using var reader = new StreamReader(stream);

                while (!reader.EndOfStream)
                {
                    var line = await reader.ReadLineAsync();
                    if (string.IsNullOrWhiteSpace(line)) continue;

                    if (line.StartsWith("data: "))
                    {
                        var jsonData = line.Substring(6);
                        try
                        {
                            var chunk = JsonSerializer.Deserialize<GeminiResponse>(jsonData);
                            var text = chunk?.Candidates?.FirstOrDefault()?.Content?.Parts?.FirstOrDefault()?.Text;

                            if (!string.IsNullOrEmpty(text))
                            {
                                fullResponse.Append(text);
                                onChunkReceived?.Invoke(text);
                            }
                        }
                        catch
                        {
                            // Skip invalid JSON chunks
                        }
                    }
                }

                return fullResponse.ToString();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error streaming from Gemini API");
                return "Xin lỗi, đã xảy ra lỗi khi xử lý yêu cầu của bạn.";
            }
        }

        public async Task<string> GenerateConversationTitleAsync(string firstMessage)
        {
            try
            {
                var prompt = $"Tạo tiêu đề ngắn gọn (3-7 từ) cho cuộc trò chuyện bắt đầu bằng câu hỏi: \"{firstMessage}\". Chỉ trả về tiêu đề, không giải thích.";

                var requestBody = new
                {
                    contents = new[]
                    {
                        new
                        {
                            parts = new[] { new { text = prompt } }
                        }
                    }
                };

                var url = $"{GEMINI_API_BASE}/{_model}:generateContent?key={_apiKey}";
                var response = await _httpClient.PostAsync(url,
                    new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json"));

                response.EnsureSuccessStatusCode();

                var responseBody = await response.Content.ReadAsStringAsync();

                // Use case-insensitive deserialization
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                var result = JsonSerializer.Deserialize<GeminiResponse>(responseBody, options);

                var title = result?.Candidates?.FirstOrDefault()?.Content?.Parts?.FirstOrDefault()?.Text?.Trim()
                    ?? "Cuộc trò chuyện mới";

                // Limit title length
                return title.Length > 50 ? title.Substring(0, 50) + "..." : title;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error generating conversation title");
                return "Cuộc trò chuyện mới";
            }
        }

        public async Task<string> GetProductRecommendationAsync(string query, List<Product>? availableProducts = null)
        {
            try
            {
                var productsContext = "";
                if (availableProducts != null && availableProducts.Any())
                {
                    var productList = string.Join("\n", availableProducts.Select(p =>
                        $"- {p.Name}: {p.Description} (Giá: {p.Price:N0}₫)"));
                    productsContext = $"\n\nSản phẩm có sẵn:\n{productList}";
                }

                var prompt = $@"Khách hàng hỏi: ""{query}""
{productsContext}

Hãy tư vấn sản phẩm hoa phù hợp. Nếu có danh sách sản phẩm, ưu tiên gợi ý từ danh sách đó.
Trả lời ngắn gọn, thân thiện, tập trung vào lợi ích cho khách hàng.";

                return await GetResponseAsync(prompt);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting product recommendation");
                return "Xin lỗi, tôi không thể đưa ra gợi ý sản phẩm lúc này. Vui lòng xem danh sách sản phẩm trên website.";
            }
        }

        private object BuildRequestBody(string userMessage, List<ChatMessage>? conversationHistory, bool stream)
        {
            var contents = new List<object>();

            // Add system prompt as first message
            contents.Add(new
            {
                role = "user",
                parts = new[] { new { text = SYSTEM_PROMPT } }
            });
            contents.Add(new
            {
                role = "model",
                parts = new[] { new { text = "Chào bạn! Tôi là trợ lý ảo của Bloomie. Tôi sẵn sàng giúp bạn tìm những bó hoa đẹp nhất! 🌸" } }
            });

            // Add conversation history
            if (conversationHistory != null && conversationHistory.Any())
            {
                foreach (var msg in conversationHistory.TakeLast(10)) // Limit to last 10 messages
                {
                    contents.Add(new
                    {
                        role = msg.Role == "user" ? "user" : "model",
                        parts = new[] { new { text = msg.Content } }
                    });
                }
            }

            // Add current user message
            contents.Add(new
            {
                role = "user",
                parts = new[] { new { text = userMessage } }
            });

            return new
            {
                contents = contents,
                generationConfig = new
                {
                    temperature = 0.7,
                    topK = 40,
                    topP = 0.95,
                    maxOutputTokens = 1024,
                }
            };
        }

        #region Response Models
        private class GeminiResponse
        {
            [JsonPropertyName("candidates")]
            public List<Candidate>? Candidates { get; set; }

            [JsonPropertyName("promptFeedback")]
            public object? PromptFeedback { get; set; }
        }

        private class Candidate
        {
            [JsonPropertyName("content")]
            public Content? Content { get; set; }

            [JsonPropertyName("finishReason")]
            public string? FinishReason { get; set; }

            [JsonPropertyName("safetyRatings")]
            public List<object>? SafetyRatings { get; set; }
        }

        private class Content
        {
            [JsonPropertyName("parts")]
            public List<Part>? Parts { get; set; }

            [JsonPropertyName("role")]
            public string? Role { get; set; }
        }

        private class Part
        {
            [JsonPropertyName("text")]
            public string? Text { get; set; }
        }
        #endregion
    }
}
