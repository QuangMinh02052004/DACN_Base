USE [Bloomie]
GO

-- Disable all FK constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO

-- Xóa dữ liệu
DELETE FROM [dbo].[ChatMessages]
DELETE FROM [dbo].[ChatConversations]
DELETE FROM [dbo].[CartItems]
DELETE FROM [dbo].[ShoppingCarts]
DELETE FROM [dbo].[OrderDetails]
DELETE FROM [dbo].[Orders]
DELETE FROM [dbo].[Payments]
DELETE FROM [dbo].[ProductImages]
DELETE FROM [dbo].[CustomArrangements]
DELETE FROM [dbo].[Products]
DELETE FROM [dbo].[ProductFlowerTypes]
DELETE FROM [dbo].[ProductCategories]
DELETE FROM [dbo].[Reviews]
DELETE FROM [dbo].[UserLikes]
DELETE FROM [dbo].[FlowerTypes]
DELETE FROM [dbo].[PresentationStyles]
DELETE FROM [dbo].[Categories]
DELETE FROM [dbo].[Suppliers]
DELETE FROM [dbo].[Notifications]
DELETE FROM [dbo].[AspNetUserTokens]
DELETE FROM [dbo].[AspNetUserRoles]
DELETE FROM [dbo].[AspNetUserLogins]
DELETE FROM [dbo].[AspNetUserClaims]
DELETE FROM [dbo].[AspNetRoleClaims]
DELETE FROM [dbo].[AspNetUsers]
DELETE FROM [dbo].[AspNetRoles]
GO

-- Enable all FK constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'
GO

PRINT 'Database cleared!'
