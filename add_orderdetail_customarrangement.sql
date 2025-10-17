-- Add CustomArrangementId to OrderDetail table
USE Bloomie;
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[OrderDetails]') AND name = 'CustomArrangementId')
BEGIN
    ALTER TABLE OrderDetails ADD CustomArrangementId INT NULL;
    PRINT 'Added CustomArrangementId to OrderDetails';
END
ELSE
BEGIN
    PRINT 'CustomArrangementId already exists in OrderDetails';
END
GO
