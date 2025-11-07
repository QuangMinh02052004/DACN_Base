USE [Bloomie]
GO

-- Disable all constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO

-- Delete data from all tables (in correct order to respect foreign keys)
DELETE FROM [dbo].[OrderDetails]
DELETE FROM [dbo].[Payments]
DELETE FROM [dbo].[Orders]
DELETE FROM [dbo].[CartItems]
DELETE FROM [dbo].[ShoppingCarts]
DELETE FROM [dbo].[ProductImages]
DELETE FROM [dbo].[InventoryTransactions]
DELETE FROM [dbo].[Products]
DELETE FROM [dbo].[CustomArrangements]
DELETE FROM [dbo].[Categories]
DELETE FROM [dbo].[FlowerTypes]
DELETE FROM [dbo].[PresentationStyles]
DELETE FROM [dbo].[Suppliers]
DELETE FROM [dbo].[Shippings]
DELETE FROM [dbo].[Promotions]
DELETE FROM [dbo].[AspNetUserRoles]
DELETE FROM [dbo].[AspNetUsers]
DELETE FROM [dbo].[AspNetRoles]
DELETE FROM [dbo].[ChatMessages]
DELETE FROM [dbo].[ChatConversations]
GO

-- Reset identity columns
DBCC CHECKIDENT ('[dbo].[Categories]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[FlowerTypes]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[PresentationStyles]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[Products]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[ProductImages]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[InventoryTransactions]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[CustomArrangements]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[ShoppingCarts]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[CartItems]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[OrderDetails]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[Payments]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[Shippings]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[Promotions]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[Suppliers]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[ChatConversations]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[ChatMessages]', RESEED, 0)
GO

-- Re-enable all constraints
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'
GO

PRINT 'Database cleared successfully!'
