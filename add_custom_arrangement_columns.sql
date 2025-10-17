-- Script to add Custom Flower Arrangement columns to existing database
-- Run this if migration fails due to existing tables

USE Bloomie;
GO

-- Add columns to FlowerTypes table
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[FlowerTypes]') AND name = 'UnitPrice')
BEGIN
    ALTER TABLE FlowerTypes ADD UnitPrice DECIMAL(18,2) NOT NULL DEFAULT 0;
    PRINT 'Added UnitPrice to FlowerTypes';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[FlowerTypes]') AND name = 'ImageUrl')
BEGIN
    ALTER TABLE FlowerTypes ADD ImageUrl NVARCHAR(MAX) NULL;
    PRINT 'Added ImageUrl to FlowerTypes';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[FlowerTypes]') AND name = 'AvailableColors')
BEGIN
    ALTER TABLE FlowerTypes ADD AvailableColors NVARCHAR(MAX) NULL;
    PRINT 'Added AvailableColors to FlowerTypes';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[FlowerTypes]') AND name = 'Description')
BEGIN
    ALTER TABLE FlowerTypes ADD [Description] NVARCHAR(MAX) NULL;
    PRINT 'Added Description to FlowerTypes';
END

-- Add columns to PresentationStyles table
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[PresentationStyles]') AND name = 'BasePrice')
BEGIN
    ALTER TABLE PresentationStyles ADD BasePrice DECIMAL(18,2) NOT NULL DEFAULT 0;
    PRINT 'Added BasePrice to PresentationStyles';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[PresentationStyles]') AND name = 'Description')
BEGIN
    ALTER TABLE PresentationStyles ADD [Description] NVARCHAR(MAX) NULL;
    PRINT 'Added Description to PresentationStyles';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[PresentationStyles]') AND name = 'ImageUrl')
BEGIN
    ALTER TABLE PresentationStyles ADD ImageUrl NVARCHAR(MAX) NULL;
    PRINT 'Added ImageUrl to PresentationStyles';
END

-- Create CustomArrangements table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomArrangements]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[CustomArrangements](
        [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [UserId] NVARCHAR(450) NULL,
        [Name] NVARCHAR(200) NOT NULL,
        [Description] NVARCHAR(1000) NULL,
        [PresentationStyleId] INT NOT NULL,
        [BasePrice] DECIMAL(18,2) NOT NULL,
        [FlowersCost] DECIMAL(18,2) NOT NULL,
        [TotalPrice] DECIMAL(18,2) NOT NULL,
        [IsSaved] BIT NOT NULL DEFAULT 0,
        [IsOrdered] BIT NOT NULL DEFAULT 0,
        [OrderId] NVARCHAR(MAX) NULL,
        [CreatedDate] DATETIME2 NOT NULL,
        [UpdatedDate] DATETIME2 NULL,
        [PreviewImageUrl] NVARCHAR(MAX) NULL,
        CONSTRAINT [FK_CustomArrangements_AspNetUsers] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers]([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_CustomArrangements_PresentationStyles] FOREIGN KEY ([PresentationStyleId]) REFERENCES [PresentationStyles]([Id]) ON DELETE NO ACTION
    );
    PRINT 'Created CustomArrangements table';
END

-- Create CustomArrangementFlowers table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomArrangementFlowers]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[CustomArrangementFlowers](
        [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [CustomArrangementId] INT NOT NULL,
        [FlowerTypeId] INT NOT NULL,
        [Quantity] INT NOT NULL,
        [Color] NVARCHAR(50) NOT NULL,
        [UnitPrice] DECIMAL(18,2) NOT NULL,
        [TotalPrice] DECIMAL(18,2) NOT NULL,
        [Notes] NVARCHAR(MAX) NULL,
        CONSTRAINT [FK_CustomArrangementFlowers_CustomArrangements] FOREIGN KEY ([CustomArrangementId]) REFERENCES [CustomArrangements]([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_CustomArrangementFlowers_FlowerTypes] FOREIGN KEY ([FlowerTypeId]) REFERENCES [FlowerTypes]([Id]) ON DELETE NO ACTION
    );
    PRINT 'Created CustomArrangementFlowers table';
END

-- Mark migrations as applied
IF NOT EXISTS (SELECT * FROM __EFMigrationsHistory WHERE MigrationId = '20251016065332_AddCustomArrangementFeature')
BEGIN
    INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion)
    VALUES ('20251016065332_AddCustomArrangementFeature', '9.0.4');
    PRINT 'Marked migration as applied';
END

PRINT 'Custom Arrangement feature database update completed!';
GO
