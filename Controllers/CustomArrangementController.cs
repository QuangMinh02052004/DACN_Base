using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Bloomie.Services.Interfaces;
using Bloomie.Models.Entities;
using Bloomie.Models.ViewModels;
using Bloomie.Extensions;
using System.Security.Claims;

namespace Bloomie.Controllers
{
    public class CustomArrangementController : Controller
    {
        private readonly ICustomArrangementService _customArrangementService;
        private readonly ILogger<CustomArrangementController> _logger;

        public CustomArrangementController(
            ICustomArrangementService customArrangementService,
            ILogger<CustomArrangementController> logger)
        {
            _customArrangementService = customArrangementService;
            _logger = logger;
        }

        // GET: CustomArrangement/Designer
        public async Task<IActionResult> Designer(int? id)
        {
            var viewModel = new DesignerViewModel
            {
                AvailableFlowers = await _customArrangementService.GetAvailableFlowerTypesAsync(),
                PresentationStyles = await _customArrangementService.GetPresentationStylesAsync()
            };

            // If editing existing arrangement
            if (id.HasValue)
            {
                var arrangement = await _customArrangementService.GetArrangementByIdAsync(id.Value);
                if (arrangement != null)
                {
                    viewModel.CurrentArrangement = MapToViewModel(arrangement);
                }
            }

            return View(viewModel);
        }

        // POST: CustomArrangement/CreateArrangement
        [HttpPost]
        public async Task<IActionResult> CreateArrangement([FromBody] CustomArrangementViewModel model)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return Json(new { success = false, message = "Dữ liệu không hợp lệ" });
                }

                // Chỉ lưu UserId nếu người dùng đã đăng nhập thật sự
                string? userId = null;
                if (User.Identity?.IsAuthenticated == true)
                {
                    userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
                }

                var arrangement = new CustomArrangement
                {
                    UserId = userId, // NULL nếu chưa đăng nhập
                    Name = model.Name,
                    Description = model.Description,
                    PresentationStyleId = model.PresentationStyleId,
                    BasePrice = 0, // Will be calculated
                    FlowersCost = 0,
                    TotalPrice = 0,
                    IsSaved = false,
                    IsOrdered = false,
                    CreatedDate = DateTime.Now
                };

                var createdArrangement = await _customArrangementService.CreateArrangementAsync(arrangement);

                return Json(new { success = true, arrangementId = createdArrangement.Id });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error creating arrangement");
                return Json(new { success = false, message = "Có lỗi xảy ra khi tạo bó hoa" });
            }
        }

        // POST: CustomArrangement/AddFlower
        [HttpPost]
        public async Task<IActionResult> AddFlower([FromBody] AddFlowerRequest request)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return Json(new { success = false, message = "Dữ liệu không hợp lệ" });
                }

                if (request.ArrangementId <= 0)
                {
                    return Json(new { success = false, message = "Arrangement ID không hợp lệ" });
                }

                // Check availability
                var isAvailable = await _customArrangementService.CheckFlowerAvailabilityAsync(
                    request.FlowerTypeId, request.Quantity);

                if (!isAvailable)
                {
                    return Json(new { success = false, message = "Loại hoa này không đủ số lượng trong kho" });
                }

                // Get flower type to get unit price
                var flowers = await _customArrangementService.GetAvailableFlowerTypesAsync();
                var flowerType = flowers.FirstOrDefault(f => f.Id == request.FlowerTypeId);

                if (flowerType == null)
                {
                    return Json(new { success = false, message = "Không tìm thấy loại hoa" });
                }

                var flower = new CustomArrangementFlower
                {
                    CustomArrangementId = request.ArrangementId,
                    FlowerTypeId = request.FlowerTypeId,
                    Quantity = request.Quantity,
                    Color = request.Color,
                    UnitPrice = flowerType.UnitPrice,
                    TotalPrice = flowerType.UnitPrice * request.Quantity,
                    Notes = request.Notes
                };

                var success = await _customArrangementService.AddFlowerToArrangementAsync(request.ArrangementId, flower);

                if (success)
                {
                    var totalPrice = await _customArrangementService.CalculateTotalPriceAsync(request.ArrangementId);
                    return Json(new { success = true, totalPrice = totalPrice, flowerId = flower.Id });
                }

                return Json(new { success = false, message = "Không thể thêm hoa vào bó" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding flower");
                return Json(new { success = false, message = "Có lỗi xảy ra khi thêm hoa" });
            }
        }

        // POST: CustomArrangement/UpdateFlower
        [HttpPost]
        public async Task<IActionResult> UpdateFlower(int flowerId, int quantity, string color)
        {
            try
            {
                var success = await _customArrangementService.UpdateFlowerInArrangementAsync(flowerId, quantity, color);

                if (success)
                {
                    return Json(new { success = true });
                }

                return Json(new { success = false, message = "Không thể cập nhật hoa" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating flower");
                return Json(new { success = false, message = "Có lỗi xảy ra khi cập nhật hoa" });
            }
        }

        // POST: CustomArrangement/RemoveFlower
        [HttpPost]
        public async Task<IActionResult> RemoveFlower(int flowerId)
        {
            try
            {
                var success = await _customArrangementService.RemoveFlowerFromArrangementAsync(flowerId);

                if (success)
                {
                    return Json(new { success = true });
                }

                return Json(new { success = false, message = "Không thể xóa hoa" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error removing flower");
                return Json(new { success = false, message = "Có lỗi xảy ra khi xóa hoa" });
            }
        }

        // POST: CustomArrangement/SaveArrangement
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> SaveArrangement(int arrangementId)
        {
            try
            {
                var success = await _customArrangementService.SaveArrangementAsync(arrangementId);

                if (success)
                {
                    return Json(new { success = true, message = "Đã lưu bó hoa của bạn" });
                }

                return Json(new { success = false, message = "Không thể lưu bó hoa" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error saving arrangement");
                return Json(new { success = false, message = "Có lỗi xảy ra khi lưu bó hoa" });
            }
        }

        // GET: CustomArrangement/SavedArrangements
        [Authorize]
        public async Task<IActionResult> SavedArrangements()
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var arrangements = await _customArrangementService.GetSavedArrangementsAsync(userId);

            var viewModel = new SavedArrangementsViewModel
            {
                SavedArrangements = arrangements.Select(a => MapToViewModel(a))
            };

            return View(viewModel);
        }

        // GET: CustomArrangement/Preview/{id}
        public async Task<IActionResult> Preview(int id)
        {
            var arrangement = await _customArrangementService.GetArrangementByIdAsync(id);

            if (arrangement == null)
            {
                return NotFound();
            }

            var viewModel = MapToViewModel(arrangement);
            return View(viewModel);
        }

        // POST: CustomArrangement/AddToCart
        [HttpPost]
        public async Task<IActionResult> AddToCart(int arrangementId)
        {
            try
            {
                var arrangement = await _customArrangementService.GetArrangementByIdAsync(arrangementId);

                if (arrangement == null)
                {
                    return Json(new { success = false, message = "Không tìm thấy bó hoa" });
                }

                // Get shopping cart from session
                var cart = HttpContext.Session.GetObjectFromJson<ShoppingCart>("ShoppingCart") ?? new ShoppingCart();

                // Create cart item for custom arrangement
                var cartItem = new CartItem
                {
                    ProductId = 0, // Custom arrangement không có ProductId thực
                    CustomArrangementId = arrangement.Id,
                    Name = arrangement.Name,
                    Price = arrangement.TotalPrice,
                    DiscountedPrice = arrangement.TotalPrice,
                    Quantity = 1,
                    ImageUrl = arrangement.PreviewImageUrl ?? "/images/custom-flower-default.png"
                };

                cart.AddItem(cartItem);

                // Save back to session
                HttpContext.Session.SetObjectAsJson("ShoppingCart", cart);

                return Json(new
                {
                    success = true,
                    message = "Đã thêm bó hoa tùy chỉnh vào giỏ hàng",
                    redirectUrl = Url.Action("Index", "ShoppingCart")
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error adding to cart");
                return Json(new { success = false, message = "Có lỗi xảy ra khi thêm vào giỏ hàng" });
            }
        }

        // POST: CustomArrangement/DeleteArrangement
        [HttpPost]
        [Authorize]
        public async Task<IActionResult> DeleteArrangement(int id)
        {
            try
            {
                var success = await _customArrangementService.DeleteArrangementAsync(id);

                if (success)
                {
                    return Json(new { success = true, message = "Đã xóa bó hoa" });
                }

                return Json(new { success = false, message = "Không thể xóa bó hoa" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting arrangement");
                return Json(new { success = false, message = "Có lỗi xảy ra khi xóa bó hoa" });
            }
        }

        // GET: CustomArrangement/CalculatePrice
        [HttpGet]
        public async Task<IActionResult> CalculatePrice(int arrangementId)
        {
            try
            {
                var totalPrice = await _customArrangementService.CalculateTotalPriceAsync(arrangementId);
                return Json(new { success = true, totalPrice = totalPrice });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error calculating price");
                return Json(new { success = false, message = "Không thể tính giá" });
            }
        }

        // Helper method to map entity to view model
        private CustomArrangementViewModel MapToViewModel(CustomArrangement arrangement)
        {
            return new CustomArrangementViewModel
            {
                Id = arrangement.Id,
                Name = arrangement.Name,
                Description = arrangement.Description,
                PresentationStyleId = arrangement.PresentationStyleId,
                PresentationStyle = arrangement.PresentationStyle,
                BasePrice = arrangement.BasePrice,
                FlowersCost = arrangement.FlowersCost,
                TotalPrice = arrangement.TotalPrice,
                IsSaved = arrangement.IsSaved,
                IsOrdered = arrangement.IsOrdered,
                CreatedDate = arrangement.CreatedDate,
                UpdatedDate = arrangement.UpdatedDate,
                PreviewImageUrl = arrangement.PreviewImageUrl,
                Flowers = arrangement.CustomArrangementFlowers.Select(f => new CustomArrangementFlowerViewModel
                {
                    Id = f.Id,
                    CustomArrangementId = f.CustomArrangementId,
                    FlowerTypeId = f.FlowerTypeId,
                    FlowerType = f.FlowerType,
                    Quantity = f.Quantity,
                    Color = f.Color,
                    UnitPrice = f.UnitPrice,
                    TotalPrice = f.TotalPrice,
                    Notes = f.Notes
                }).ToList()
            };
        }
    }
}
