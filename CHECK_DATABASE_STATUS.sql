USE [Bloomie]
GO

-- Kiểm tra số lượng records
SELECT 'AspNetUsers' as TableName, COUNT(*) as RecordCount FROM AspNetUsers
UNION ALL SELECT 'AspNetRoles', COUNT(*) FROM AspNetRoles  
UNION ALL SELECT 'Categories', COUNT(*) FROM Categories
UNION ALL SELECT 'FlowerTypes', COUNT(*) FROM FlowerTypes
UNION ALL SELECT 'PresentationStyles', COUNT(*) FROM PresentationStyles
UNION ALL SELECT 'Suppliers', COUNT(*) FROM Suppliers
UNION ALL SELECT 'Products', COUNT(*) FROM Products
UNION ALL SELECT 'ChatConversations', COUNT(*) FROM ChatConversations
UNION ALL SELECT 'ChatMessages', COUNT(*) FROM ChatMessages
GO

SELECT UserName, Email, FullName FROM AspNetUsers
GO
