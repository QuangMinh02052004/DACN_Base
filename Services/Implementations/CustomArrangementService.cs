using Microsoft.EntityFrameworkCore;
using Bloomie.Data;
using Bloomie.Models.Entities;
using Bloomie.Services.Interfaces;

namespace Bloomie.Services.Implementations
{
    public class CustomArrangementService : ICustomArrangementService
    {
        private readonly ApplicationDbContext _context;

        public CustomArrangementService(ApplicationDbContext context)
        {
            _context = context;
        }

        // Get arrangements
        public async Task<IEnumerable<CustomArrangement>> GetAllArrangementsAsync()
        {
            return await _context.CustomArrangements
                .Include(ca => ca.PresentationStyle)
                .Include(ca => ca.CustomArrangementFlowers)
                    .ThenInclude(caf => caf.FlowerType)
                .Include(ca => ca.User)
                .ToListAsync();
        }

        public async Task<IEnumerable<CustomArrangement>> GetUserArrangementsAsync(string userId)
        {
            return await _context.CustomArrangements
                .Where(ca => ca.UserId == userId)
                .Include(ca => ca.PresentationStyle)
                .Include(ca => ca.CustomArrangementFlowers)
                    .ThenInclude(caf => caf.FlowerType)
                .OrderByDescending(ca => ca.CreatedDate)
                .ToListAsync();
        }

        public async Task<CustomArrangement?> GetArrangementByIdAsync(int id)
        {
            return await _context.CustomArrangements
                .Include(ca => ca.PresentationStyle)
                .Include(ca => ca.CustomArrangementFlowers)
                    .ThenInclude(caf => caf.FlowerType)
                .Include(ca => ca.User)
                .FirstOrDefaultAsync(ca => ca.Id == id);
        }

        public async Task<IEnumerable<CustomArrangement>> GetSavedArrangementsAsync(string userId)
        {
            return await _context.CustomArrangements
                .Where(ca => ca.UserId == userId && ca.IsSaved == true && ca.IsOrdered == false)
                .Include(ca => ca.PresentationStyle)
                .Include(ca => ca.CustomArrangementFlowers)
                    .ThenInclude(caf => caf.FlowerType)
                .OrderByDescending(ca => ca.UpdatedDate ?? ca.CreatedDate)
                .ToListAsync();
        }

        // Create/Update/Delete arrangements
        public async Task<CustomArrangement> CreateArrangementAsync(CustomArrangement arrangement)
        {
            // ensure UserId refers to an existing user, otherwise set to null
            if (!string.IsNullOrEmpty(arrangement.UserId))
            {
                var userExists = await _context.Users.AnyAsync(u => u.Id == arrangement.UserId);
                if (!userExists)
                {
                    arrangement.UserId = null;
                }
            }

            _context.CustomArrangements.Add(arrangement);

            try
            {
                await _context.SaveChangesAsync();
                return arrangement;
            }
            catch (DbUpdateException ex)
            {
                // Log the error (uncomment ex variable name and write a log line here)
                throw; // hoặc trả về null/Result tùy design; ở controller xử lý ngoại lệ
            }
        }

        public async Task<bool> UpdateArrangementAsync(CustomArrangement arrangement)
        {
            try
            {
                arrangement.UpdatedDate = DateTime.Now;
                _context.CustomArrangements.Update(arrangement);
                await _context.SaveChangesAsync();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> DeleteArrangementAsync(int id)
        {
            try
            {
                var arrangement = await _context.CustomArrangements.FindAsync(id);
                if (arrangement == null) return false;

                _context.CustomArrangements.Remove(arrangement);
                await _context.SaveChangesAsync();
                return true;
            }
            catch
            {
                return false;
            }
        }

        // Manage flowers in arrangement
        public async Task<bool> AddFlowerToArrangementAsync(int arrangementId, CustomArrangementFlower flower)
        {
            try
            {
                flower.CustomArrangementId = arrangementId;
                _context.CustomArrangementFlowers.Add(flower);
                await _context.SaveChangesAsync();

                // Recalculate total price
                await CalculateTotalPriceAsync(arrangementId);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> UpdateFlowerInArrangementAsync(int flowerId, int quantity, string color)
        {
            try
            {
                var flower = await _context.CustomArrangementFlowers.FindAsync(flowerId);
                if (flower == null) return false;

                flower.Quantity = quantity;
                flower.Color = color;
                flower.TotalPrice = flower.UnitPrice * quantity;

                _context.CustomArrangementFlowers.Update(flower);
                await _context.SaveChangesAsync();

                // Recalculate total price
                await CalculateTotalPriceAsync(flower.CustomArrangementId);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> RemoveFlowerFromArrangementAsync(int flowerId)
        {
            try
            {
                var flower = await _context.CustomArrangementFlowers.FindAsync(flowerId);
                if (flower == null) return false;

                var arrangementId = flower.CustomArrangementId;
                _context.CustomArrangementFlowers.Remove(flower);
                await _context.SaveChangesAsync();

                // Recalculate total price
                await CalculateTotalPriceAsync(arrangementId);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // Calculate pricing
        public async Task<decimal> CalculateTotalPriceAsync(int arrangementId)
        {
            var arrangement = await _context.CustomArrangements
                .Include(ca => ca.CustomArrangementFlowers)
                .Include(ca => ca.PresentationStyle)
                .FirstOrDefaultAsync(ca => ca.Id == arrangementId);

            if (arrangement == null) return 0;

            // Calculate total flowers cost
            decimal flowersCost = arrangement.CustomArrangementFlowers.Sum(f => f.TotalPrice);

            // Get base price from presentation style
            decimal basePrice = arrangement.PresentationStyle?.BasePrice ?? 0;

            // Update arrangement prices
            arrangement.BasePrice = basePrice;
            arrangement.FlowersCost = flowersCost;
            arrangement.TotalPrice = basePrice + flowersCost;
            arrangement.UpdatedDate = DateTime.Now;

            _context.CustomArrangements.Update(arrangement);
            await _context.SaveChangesAsync();

            return arrangement.TotalPrice;
        }

        // Save/Unsave arrangements
        public async Task<bool> SaveArrangementAsync(int arrangementId)
        {
            try
            {
                var arrangement = await _context.CustomArrangements.FindAsync(arrangementId);
                if (arrangement == null) return false;

                arrangement.IsSaved = true;
                arrangement.UpdatedDate = DateTime.Now;
                _context.CustomArrangements.Update(arrangement);
                await _context.SaveChangesAsync();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> UnsaveArrangementAsync(int arrangementId)
        {
            try
            {
                var arrangement = await _context.CustomArrangements.FindAsync(arrangementId);
                if (arrangement == null) return false;

                arrangement.IsSaved = false;
                arrangement.UpdatedDate = DateTime.Now;
                _context.CustomArrangements.Update(arrangement);
                await _context.SaveChangesAsync();
                return true;
            }
            catch
            {
                return false;
            }
        }

        // Check stock availability
        public async Task<bool> CheckFlowerAvailabilityAsync(int flowerTypeId, int quantity)
        {
            var flowerType = await _context.FlowerTypes.FindAsync(flowerTypeId);
            if (flowerType == null) return false;

            return flowerType.Quantity >= quantity && flowerType.IsActive;
        }

        // Get available flower types and presentation styles
        public async Task<IEnumerable<FlowerType>> GetAvailableFlowerTypesAsync()
        {
            return await _context.FlowerTypes
                .Where(ft => ft.IsActive && ft.Quantity > 0)
                .OrderBy(ft => ft.Name)
                .ToListAsync();
        }

        public async Task<IEnumerable<PresentationStyle>> GetPresentationStylesAsync()
        {
            return await _context.PresentationStyles
                .OrderBy(ps => ps.BasePrice)
                .ToListAsync();
        }
    }
}
