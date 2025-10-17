using Bloomie.Models.Entities;

namespace Bloomie.Services.Interfaces
{
    public interface ICustomArrangementService
    {
        // Get arrangements
        Task<IEnumerable<CustomArrangement>> GetAllArrangementsAsync();
        Task<IEnumerable<CustomArrangement>> GetUserArrangementsAsync(string userId);
        Task<CustomArrangement?> GetArrangementByIdAsync(int id);
        Task<IEnumerable<CustomArrangement>> GetSavedArrangementsAsync(string userId);

        // Create/Update/Delete arrangements
        Task<CustomArrangement> CreateArrangementAsync(CustomArrangement arrangement);
        Task<bool> UpdateArrangementAsync(CustomArrangement arrangement);
        Task<bool> DeleteArrangementAsync(int id);

        // Manage flowers in arrangement
        Task<bool> AddFlowerToArrangementAsync(int arrangementId, CustomArrangementFlower flower);
        Task<bool> UpdateFlowerInArrangementAsync(int flowerId, int quantity, string color);
        Task<bool> RemoveFlowerFromArrangementAsync(int flowerId);

        // Calculate pricing
        Task<decimal> CalculateTotalPriceAsync(int arrangementId);

        // Save/Unsave arrangements
        Task<bool> SaveArrangementAsync(int arrangementId);
        Task<bool> UnsaveArrangementAsync(int arrangementId);

        // Check stock availability
        Task<bool> CheckFlowerAvailabilityAsync(int flowerTypeId, int quantity);

        // Get available flower types for custom arrangements
        Task<IEnumerable<FlowerType>> GetAvailableFlowerTypesAsync();
        Task<IEnumerable<PresentationStyle>> GetPresentationStylesAsync();
    }
}
