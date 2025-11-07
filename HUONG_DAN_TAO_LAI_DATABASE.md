# Hướng Dẫn Tạo Lại Database Bloomie

## ✅ Đảm Bảo An Toàn

**QUAN TRỌNG:** Chức năng chatbox của bạn ĐÃ ĐƯỢC LƯU trong migrations và sẽ tự động được tạo lại!

### Các bảng chatbox sẽ được tạo lại:
- ✅ **ChatConversations** - Lưu các cuộc trò chuyện
- ✅ **ChatMessages** - Lưu các tin nhắn trong cuộc trò chuyện
- ✅ Tất cả foreign keys và relationships

## 📋 Quy Trình Thực Hiện

### Bước 1: Xóa và Tạo Lại Database

Chạy file SQL trong SQL Server Management Studio:
```bash
RECREATE_DATABASE_FULL.sql
```

Hoặc chạy trực tiếp:
```bash
sqlcmd -S localhost -i RECREATE_DATABASE_FULL.sql
```

### Bước 2: Tạo Lại Tất Cả Các Bảng (Bao Gồm Chatbox)

Chạy lệnh Entity Framework:
```bash
dotnet ef database update
```

Lệnh này sẽ tự động:
- ✅ Tạo tất cả các bảng AspNetUsers, AspNetRoles, Products, Categories, v.v.
- ✅ Tạo bảng **ChatConversations** và **ChatMessages**
- ✅ Tạo tất cả foreign keys, indexes, và constraints
- ✅ Áp dụng tất cả 3 migrations:
  - InitialCreate
  - AddChatTables (Chatbox)
  - AddShoppingCartAndCartItem

### Bước 3: Import Dữ Liệu

Nếu bạn có dữ liệu cũ, import từ file:
```bash
Bloomie (1).sql
```

**Cách import trong SQL Server Management Studio:**
1. Mở file `Bloomie (1).sql`
2. Chọn database `Bloomie`
3. Nhấn F5 để chạy script

**Hoặc dùng command line:**
```bash
sqlcmd -S localhost -d Bloomie -i "Bloomie (1).sql"
```

### Bước 4: Import Dữ Liệu Chatbox (Nếu Có)

Nếu bạn có script riêng cho chatbox, chạy nó sau bước 3:
```bash
sqlcmd -S localhost -d Bloomie -i your_chatbox_data.sql
```

## 🔍 Kiểm Tra Sau Khi Hoàn Thành

```sql
-- Kiểm tra các bảng chatbox đã được tạo
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('ChatConversations', 'ChatMessages')

-- Kiểm tra số lượng records
SELECT COUNT(*) AS TotalConversations FROM ChatConversations
SELECT COUNT(*) AS TotalMessages FROM ChatMessages
```

## ⚠️ Lưu Ý Quan Trọng

1. **Backup dữ liệu trước khi xóa database** (nếu có dữ liệu quan trọng)
2. Chức năng chatbox SẼ KHÔNG BỊ MẤT vì đã có trong migrations
3. Chỉ cần import lại dữ liệu nếu cần
4. Nếu gặp lỗi, kiểm tra connection string trong `appsettings.json`

## 🆘 Troubleshooting

### Lỗi: "Cannot open database"
```bash
# Kiểm tra SQL Server đã chạy chưa
dotnet ef database drop --force
dotnet ef database update
```

### Lỗi: "Migration already applied"
```bash
# Xóa bảng __EFMigrationsHistory và chạy lại
DROP TABLE __EFMigrationsHistory
dotnet ef database update
```

### Kiểm tra migrations đã apply:
```sql
SELECT * FROM __EFMigrationsHistory
```

Bạn sẽ thấy:
- 20251024062437_InitialCreate
- 20251102231920_AddChatTables ← **Chatbox của bạn**
- 20251103120150_AddShoppingCartAndCartItem

## 📞 Cần Hỗ Trợ?

Nếu bạn có script dữ liệu riêng cho chatbox, hãy cho tôi xem để tôi kiểm tra và đảm bảo nó tương thích với schema hiện tại.
