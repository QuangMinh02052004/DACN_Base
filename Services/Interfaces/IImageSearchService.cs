using Microsoft.AspNetCore.Http;

namespace Bloomie.Services.Interfaces
{
    public interface IImageSearchService
    {
        Task<ImageSearchResult> AnalyzeImageAsync(IFormFile imageFile);
        Task<ImageSearchResult> AnalyzeImageAsync(byte[] imageBytes, string fileName);
    }

    public class ImageSearchResult
    {
        public bool Success { get; set; }
        public string Message { get; set; } = string.Empty;
        public List<string> Colors { get; set; } = new List<string>();
        public string Presentation { get; set; } = string.Empty;
        public List<FlowerDetection> Flowers { get; set; } = new List<FlowerDetection>();
        public List<string> FlowerTypes { get; set; } = new List<string>(); // Tên loại hoa để tìm kiếm
        public string RecognizedFlower { get; set; } = string.Empty; // Tên hoa được nhận dạng
        public float Confidence { get; set; } // Độ chính xác nhận dạng
        public string RedirectUrl { get; set; } = string.Empty;
        public List<AlternativePrediction> AlternativePredictions { get; set; } = new List<AlternativePrediction>(); // Top 3 predictions
    }

    public class FlowerDetection
    {
        public string Name { get; set; } = string.Empty;
        public float Confidence { get; set; }
        public List<string> Colors { get; set; } = new List<string>();
        public string Presentation { get; set; } = string.Empty;
    }

    public class AlternativePrediction
    {
        public string FlowerName { get; set; } = string.Empty;
        public string EnglishName { get; set; } = string.Empty;
        public float Confidence { get; set; }
        public List<string> FlowerTypes { get; set; } = new List<string>();
    }
}