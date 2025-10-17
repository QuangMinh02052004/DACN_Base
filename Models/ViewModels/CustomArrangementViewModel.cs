using Bloomie.Models.Entities;
using System.ComponentModel.DataAnnotations;

namespace Bloomie.Models.ViewModels
{
    public class CustomArrangementViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Vui lòng đặt tên cho bó hoa của bạn")]
        [StringLength(200, ErrorMessage = "Tên không được quá 200 ký tự")]
        public string Name { get; set; }

        [StringLength(1000, ErrorMessage = "Mô tả không được quá 1000 ký tự")]
        public string? Description { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn kiểu trình bày")]
        public int PresentationStyleId { get; set; }

        public decimal BasePrice { get; set; }
        public decimal FlowersCost { get; set; }
        public decimal TotalPrice { get; set; }

        public bool IsSaved { get; set; }
        public bool IsOrdered { get; set; }

        public DateTime CreatedDate { get; set; }
        public DateTime? UpdatedDate { get; set; }

        public string? PreviewImageUrl { get; set; }

        // For display
        public PresentationStyle? PresentationStyle { get; set; }
        public List<CustomArrangementFlowerViewModel> Flowers { get; set; } = new List<CustomArrangementFlowerViewModel>();
    }

    public class CustomArrangementFlowerViewModel
    {
        public int Id { get; set; }
        public int CustomArrangementId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn loại hoa")]
        public int FlowerTypeId { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập số lượng")]
        [Range(1, 1000, ErrorMessage = "Số lượng phải từ 1 đến 1000")]
        public int Quantity { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn màu sắc")]
        [StringLength(50)]
        public string Color { get; set; }

        public decimal UnitPrice { get; set; }
        public decimal TotalPrice { get; set; }

        public string? Notes { get; set; }

        // For display
        public FlowerType? FlowerType { get; set; }
    }

    public class DesignerViewModel
    {
        public IEnumerable<FlowerType> AvailableFlowers { get; set; } = new List<FlowerType>();
        public IEnumerable<PresentationStyle> PresentationStyles { get; set; } = new List<PresentationStyle>();
        public CustomArrangementViewModel? CurrentArrangement { get; set; }
    }

    public class SavedArrangementsViewModel
    {
        public IEnumerable<CustomArrangementViewModel> SavedArrangements { get; set; } = new List<CustomArrangementViewModel>();
    }

    public class AddFlowerRequest
    {
        [Required]
        public int ArrangementId { get; set; }

        [Required]
        public int FlowerTypeId { get; set; }

        [Required]
        [Range(1, 1000)]
        public int Quantity { get; set; }

        [Required]
        public string Color { get; set; }

        public string? Notes { get; set; }
    }
}
