USE [Bloomie]
GO

-- Kiểm tra trước khi update
SELECT 'BEFORE UPDATE:' as Status
SELECT COUNT(*) as TotalProducts,
       SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) as ActiveProducts,
       SUM(CASE WHEN IsActive = 0 THEN 1 ELSE 0 END) as InactiveProducts
FROM Products
GO

-- Update tất cả Products thành IsActive = 1
UPDATE Products SET IsActive = 1
GO

-- Kiểm tra sau khi update
SELECT 'AFTER UPDATE:' as Status
SELECT COUNT(*) as TotalProducts,
       SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) as ActiveProducts,
       SUM(CASE WHEN IsActive = 0 THEN 1 ELSE 0 END) as InactiveProducts
FROM Products
GO

-- Hiển thị 5 products mẫu
SELECT 'SAMPLE PRODUCTS:' as Status
SELECT TOP 5
    Id,
    Name,
    Price,
    CategoryId,
    PresentationStyleId,
    IsActive,
    CASE WHEN ImageUrl IS NULL THEN 'No Image' ELSE 'Has Image' END as ImageStatus
FROM Products
GO

-- Thống kê tổng quan
SELECT 'SUMMARY:' as Status
SELECT
    'Categories' as TableName, COUNT(*) as RecordCount FROM Categories
UNION ALL SELECT 'PresentationStyles', COUNT(*) FROM PresentationStyles
UNION ALL SELECT 'FlowerTypes', COUNT(*) FROM FlowerTypes
UNION ALL SELECT 'Suppliers', COUNT(*) FROM Suppliers
UNION ALL SELECT 'Products', COUNT(*) FROM Products
UNION ALL SELECT 'AspNetUsers', COUNT(*) FROM AspNetUsers
UNION ALL SELECT 'AspNetRoles', COUNT(*) FROM AspNetRoles
GO
