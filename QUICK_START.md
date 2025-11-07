# Quick Start - Tạo Lại Database

## 🚀 Chỉ Cần 3 Bước

### 1️⃣ Xóa và tạo lại database
```bash
sqlcmd -S localhost -i RECREATE_DATABASE_FULL.sql
```

### 2️⃣ Tạo tất cả các bảng (bao gồm Chatbox)
```bash
dotnet ef database update
```

### 3️⃣ Import dữ liệu
```bash
sqlcmd -S localhost -d Bloomie -i "Bloomie (1).sql"
```

## ✅ Kiểm tra kết quả
```bash
sqlcmd -S localhost -i CHECK_DATABASE_STATUS.sql
```

## ⚡ Hoặc dùng SQL Server Management Studio

1. Chạy: `RECREATE_DATABASE_FULL.sql`
2. Terminal: `dotnet ef database update`
3. Chạy: `Bloomie (1).sql`
4. Chạy: `CHECK_DATABASE_STATUS.sql` để kiểm tra

---

**✨ Lưu ý:** Chức năng chatbox (ChatConversations + ChatMessages) sẽ tự động được tạo ở bước 2!
