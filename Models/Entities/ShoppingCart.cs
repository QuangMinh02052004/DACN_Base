using Microsoft.CodeAnalysis;

namespace Bloomie.Models.Entities
{
    public class ShoppingCart
    {
        public string UserId { get; set; }
        public List<CartItem> Items { get; set; } = new List<CartItem>();
        public decimal TotalPrice => Items.Sum(item => item.DiscountedPrice * item.Quantity);

        public int TotalItems
        {
            get { return Items.Sum(item => item.Quantity); }
        }

        // Thêm 1 sản phẩm vào giỏ hàng
        public void AddItem(CartItem item)
        {
            // Custom arrangement luôn là item riêng (không merge)
            if (item.IsCustomArrangement)
            {
                Items.Add(item);
                return;
            }

            // Kiểm tra xem sản phẩm đã tồn tại
            var existingItem = Items.FirstOrDefault(i => i.ProductId == item.ProductId && !i.IsCustomArrangement);
            if (existingItem != null)
            {
                existingItem.Quantity += item.Quantity;
            }
            else
            {
                Items.Add(item);
            }
        }

        // Xóa sản phẩm
        public void RemoveItem(int productId)
        {
            Items.RemoveAll(i => i.ProductId == productId && !i.IsCustomArrangement);
        }

        // Xóa custom arrangement
        public void RemoveCustomArrangement(int customArrangementId)
        {
            Items.RemoveAll(i => i.CustomArrangementId == customArrangementId);
        }
    }
}
