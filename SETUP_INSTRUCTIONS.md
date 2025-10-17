# 🚀 HƯỚNG DẪN SETUP CUSTOM FLOWER ARRANGEMENT

## ⚡ QUICK START (3 BƯỚC)

### **Bước 1: Chạy SQL Script**

Mở **Azure Data Studio** hoặc **SQL Server Management Studio**, connect vào database `Bloomie` và chạy file:

```
SETUP_CUSTOM_ARRANGEMENT.sql
```

Hoặc dùng command line:

```bash
sqlcmd -S localhost,1433 -U sa -P <your_password> -d Bloomie -i "SETUP_CUSTOM_ARRANGEMENT.sql"
```

Script này sẽ:
- ✅ Add columns mới vào FlowerTypes, PresentationStyles, OrderDetails
- ✅ Create tables: CustomArrangements, CustomArrangementFlowers
- ✅ Insert seed data (10 Presentation Styles + 9 Flower Types)
- ✅ Mark migration as applied

### **Bước 2: Rebuild & Run**

```bash
dotnet build
dotnet run
```

### **Bước 3: Truy cập**

Mở trình duyệt:
```
http://localhost:5187/CustomArrangement/Designer
```

Hoặc click menu: **"🎨 Thiết kế bó hoa"**

---

## 📋 CHI TIẾT

### **Seed Data Đã Có:**

**Presentation Styles (10):**
1. Bó hoa - 50,000 VNĐ
2. Lẵng hoa - 100,000 VNĐ
3. Hộp hoa - 80,000 VNĐ
4. Giỏ hoa - 120,000 VNĐ
5. Bình hoa - 70,000 VNĐ
6. Hoa bó cổ điển - 60,000 VNĐ
7. Hoa để bàn - 90,000 VNĐ
8. Giỏ hoa hiện đại - 150,000 VNĐ
9. Hộp hoa nghệ thuật - 110,000 VNĐ
10. Lẵng hoa mini - 75,000 VNĐ

**Flower Types (9):**
1. Hoa Hồng - 15,000 VNĐ/bông (6 màu)
2. Hoa Tulip - 20,000 VNĐ/bông (6 màu)
3. Hoa Ly - 25,000 VNĐ/bông (4 màu)
4. Hoa Baby - 3,000 VNĐ/cành (2 màu)
5. Hoa Lan Hồ Điệp - 35,000 VNĐ/cành (4 màu)
6. Hoa Cúc Mẫu Đơn - 18,000 VNĐ/bông (4 màu)
7. Hoa Hướng Dương - 22,000 VNĐ/bông (2 màu)
8. Hoa Đồng Tiền - 7,000 VNĐ/bông (4 màu)
9. Hoa Cát Tường - 10,000 VNĐ/cành (3 màu)

---

## 🧪 TEST WORKFLOW

1. **Vào Designer**: Click "Thiết kế bó hoa" trong menu
2. **Chọn kiểu trình bày**: Click vào "Bó hoa" (50k)
3. **Thêm hoa**:
   - Click "Thêm" ở "Hoa Hồng"
   - Số lượng: 10
   - Màu: Đỏ
   - Click "Thêm vào bó hoa"
4. **Kiểm tra giá**:
   - Giá cơ bản: 50,000 VNĐ
   - Giá hoa: 150,000 VNĐ (10 x 15,000)
   - Tổng: 200,000 VNĐ ✅
5. **Thêm hoa khác**:
   - Hoa Baby: 20 bông, màu Trắng
   - Giá thêm: 60,000 VNĐ
   - Tổng mới: 260,000 VNĐ ✅
6. **Nhập tên**: "Bó hoa sinh nhật"
7. **Lưu thiết kế** (cần login)
8. **Thêm vào giỏ hàng**
9. **Checkout** như bình thường

---

## 🛒 THANH TOÁN

Khi add vào giỏ hàng, custom arrangement sẽ:
- ✅ Hiển thị trong cart như sản phẩm thường
- ✅ Tên: Tên bạn đặt
- ✅ Giá: Tổng giá đã tính
- ✅ Quantity: 1 (mỗi bó hoa là 1 item riêng)
- ✅ Có thể checkout bình thường

**Lưu ý**: Custom arrangement KHÔNG được merge khi add nhiều lần. Mỗi lần add = 1 item riêng trong cart.

---

## 🔧 TROUBLESHOOTING

### **Lỗi: Invalid column name**
➡️ Chạy lại `SETUP_CUSTOM_ARRANGEMENT.sql`

### **Designer trống không có hoa**
➡️ Kiểm tra:
```sql
SELECT COUNT(*) FROM FlowerTypes WHERE UnitPrice > 0 AND IsActive = 1;
SELECT COUNT(*) FROM PresentationStyles WHERE BasePrice > 0;
```
Nếu = 0, chạy lại phần seed data trong script.

### **Không tính giá**
➡️ Mở browser console (F12), check JavaScript errors

### **Không thêm được vào giỏ hàng**
➡️ Check session đã enabled chưa (đã có trong Program.cs)

---

## 📁 FILES QUAN TRỌNG

### **SQL Scripts:**
- `SETUP_CUSTOM_ARRANGEMENT.sql` - **CHẠY FILE NÀY!** (All-in-one)
- `add_custom_arrangement_columns.sql` - (Backup) Chỉ add columns
- `seed_data.sql` - (Backup) Chỉ seed data
- `add_orderdetail_customarrangement.sql` - (Backup) OrderDetail column

### **Code Files:**
- `Models/Entities/CustomArrangement.cs`
- `Models/Entities/CustomArrangementFlower.cs`
- `Models/Entities/FlowerType.cs` (updated)
- `Models/Entities/PresentationStyle.cs` (updated)
- `Models/Entities/CartItem.cs` (updated)
- `Models/Entities/ShoppingCart.cs` (updated)
- `Models/Entities/OrderDetail.cs` (updated)
- `Services/Interfaces/ICustomArrangementService.cs`
- `Services/Implementations/CustomArrangementService.cs`
- `Controllers/CustomArrangementController.cs`
- `Models/ViewModels/CustomArrangementViewModel.cs`
- `Views/CustomArrangement/Designer.cshtml`
- `Views/CustomArrangement/Preview.cshtml`
- `Views/CustomArrangement/SavedArrangements.cshtml`
- `wwwroot/js/customArrangement.js`

### **Documentation:**
- `CUSTOM_ARRANGEMENT_IMPLEMENTATION.md` - Full documentation
- `SETUP_INSTRUCTIONS.md` - File này!

---

## ✨ TÍNH NĂNG ĐÃ CÓ

✅ Chọn kiểu trình bày với giá
✅ Chọn nhiều loại hoa với số lượng và màu
✅ Tính giá tự động real-time
✅ Lưu thiết kế (cần login)
✅ Xem danh sách đã lưu
✅ Preview chi tiết
✅ Thêm vào giỏ hàng
✅ Checkout & thanh toán

---

## 🎯 NEXT STEPS (OPTIONAL)

1. **Upload images** cho FlowerTypes và PresentationStyles
2. **Admin management** để CRUD flowers và styles
3. **Stock management** khi checkout custom arrangement
4. **Email confirmation** khi đặt hàng custom

---

## 📞 SUPPORT

Nếu gặp lỗi:
1. Check logs trong terminal
2. Check browser console (F12)
3. Verify database columns đã có
4. Rebuild project: `dotnet build`

---

**🎉 ENJOY YOUR CUSTOM FLOWER ARRANGEMENT FEATURE!**
