# HƯỚNG DẪN IMPORT DỮ LIỆU NHANH

## ⚡ CÁCH NHANH NHẤT - Dùng SQL Server Management Studio

### Bước 1: Tạo lại Database
Mở SQL Server Management Studio, chạy script sau:

```sql
USE master;
GO

-- Đóng tất cả connections
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Bloomie')
BEGIN
    ALTER DATABASE [Bloomie] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [Bloomie];
END
GO

-- Tạo lại database
CREATE DATABASE [Bloomie]
GO
```

### Bước 2: Tạo tất cả các bảng
Mở Terminal trong thư mục project:

```bash
dotnet ef migrations script --output FULL_MIGRATION.sql
```

**Nếu lệnh trên bị lỗi**, dùng file SQL sau:

Chạy file: **`Bloomie (1).sql`** (file này đã có đầy đủ cấu trúc bảng)

**LƯU Ý:** Trong SQL Server Management Studio:
1. Chọn database **Bloomie**
2. Mở file **Bloomie (1).sql**
3. Nhấn **F5** để chạy

### Bước 3: Xác nhận tạo bảng thành công

Chạy query sau để kiểm tra:

```sql
USE Bloomie
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME
GO
```

Bạn phải thấy TẤT CẢ các bảng bao gồm:
- ✅ AspNetUsers
- ✅ AspNetRoles
- ✅ **ChatConversations** ← Chatbox
- ✅ **ChatMessages** ← Chatbox
- ✅ Products
- ✅ Categories
- ✅ FlowerTypes
- ✅ ... (và các bảng khác)

### Bước 4: Kiểm tra dữ liệu Chatbox

```sql
-- Kiểm tra số lượng dữ liệu
SELECT 'ChatConversations' as TableName, COUNT(*) as Total FROM ChatConversations
UNION ALL
SELECT 'ChatMessages', COUNT(*) FROM ChatMessages
GO

-- Xem dữ liệu mẫu
SELECT TOP 5 * FROM ChatConversations ORDER BY CreatedAt DESC
SELECT TOP 5 * FROM ChatMessages ORDER BY CreatedAt DESC
GO
```

## 🔥 CÁCH NHANH NHỮ ĂN LIỀN - Chỉ 1 File SQL

Nếu file **Bloomie (1).sql** đã chứa cả:
- CREATE TABLE statements
- INSERT DATA statements

Thì bạn chỉ cần:
1. Drop database Bloomie (nếu có)
2. Create database Bloomie
3. Chạy file **Bloomie (1).sql**

## ❌ LỖI THƯỜNG GẶP

### Lỗi: "Cannot drop database because it is currently in use"
```sql
USE master;
GO
ALTER DATABASE [Bloomie] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE [Bloomie];
GO
```

### Lỗi: "Table already exists"
Nghĩa là bảng đã được tạo rồi. Chạy:
```sql
DROP TABLE [TableName]
GO
```

Hoặc drop toàn bộ database và tạo lại.

## 📞 HỖ TRỢ

Nếu gặp vấn đề, kiểm tra:
1. ✅ SQL Server đã chạy chưa?
2. ✅ Connection string trong appsettings.json đúng chưa?
3. ✅ Database "Bloomie" đã được tạo chưa?
4. ✅ File "Bloomie (1).sql" có tồn tại không?
