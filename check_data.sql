USE [Bloomie]
GO

-- Kiểm tra số lượng records
SELECT 'Categories' as TableName, COUNT(*) as RecordCount FROM Categories
UNION ALL SELECT 'PresentationStyles', COUNT(*) FROM PresentationStyles
UNION ALL SELECT 'FlowerTypes', COUNT(*) FROM FlowerTypes
UNION ALL SELECT 'Suppliers', COUNT(*) FROM Suppliers
UNION ALL SELECT 'Products', COUNT(*) FROM Products
UNION ALL SELECT 'AspNetUsers', COUNT(*) FROM AspNetUsers
UNION ALL SELECT 'AspNetRoles', COUNT(*) FROM AspNetRoles
GO

-- Kiểm tra Products có ImageUrl và IsActive
SELECT TOP 5 Id, Name, Price, CategoryId, PresentationStyleId, IsActive, ImageUrl FROM Products
GO
