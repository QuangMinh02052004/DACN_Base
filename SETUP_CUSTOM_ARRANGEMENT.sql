-- ==========================================
-- COMPLETE SETUP SCRIPT FOR CUSTOM FLOWER ARRANGEMENT
-- Run this file to setup everything needed
-- ==========================================

USE Bloomie;
GO

PRINT '========================================';
PRINT 'STARTING CUSTOM ARRANGEMENT SETUP';
PRINT '========================================';
PRINT '';

-- ==========================================
-- PART 1: ADD COLUMNS TO EXISTING TABLES
-- ==========================================

PRINT 'PART 1: Adding columns to existing tables...';
PRINT '';

-- Add columns to FlowerTypes table
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[FlowerTypes]') AND name = 'UnitPrice')
BEGIN
    ALTER TABLE FlowerTypes ADD UnitPrice DECIMAL(18,2) NOT NULL DEFAULT 0;
    PRINT '✓ Added UnitPrice to FlowerTypes';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[FlowerTypes]') AND name = 'ImageUrl')
BEGIN
    ALTER TABLE FlowerTypes ADD ImageUrl NVARCHAR(MAX) NULL;
    PRINT '✓ Added ImageUrl to FlowerTypes';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[FlowerTypes]') AND name = 'AvailableColors')
BEGIN
    ALTER TABLE FlowerTypes ADD AvailableColors NVARCHAR(MAX) NULL;
    PRINT '✓ Added AvailableColors to FlowerTypes';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[FlowerTypes]') AND name = 'Description')
BEGIN
    ALTER TABLE FlowerTypes ADD [Description] NVARCHAR(MAX) NULL;
    PRINT '✓ Added Description to FlowerTypes';
END

-- Add columns to PresentationStyles table
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[PresentationStyles]') AND name = 'BasePrice')
BEGIN
    ALTER TABLE PresentationStyles ADD BasePrice DECIMAL(18,2) NOT NULL DEFAULT 0;
    PRINT '✓ Added BasePrice to PresentationStyles';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[PresentationStyles]') AND name = 'Description')
BEGIN
    ALTER TABLE PresentationStyles ADD [Description] NVARCHAR(MAX) NULL;
    PRINT '✓ Added Description to PresentationStyles';
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[PresentationStyles]') AND name = 'ImageUrl')
BEGIN
    ALTER TABLE PresentationStyles ADD ImageUrl NVARCHAR(MAX) NULL;
    PRINT '✓ Added ImageUrl to PresentationStyles';
END

-- Add column to OrderDetails table
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[OrderDetails]') AND name = 'CustomArrangementId')
BEGIN
    ALTER TABLE OrderDetails ADD CustomArrangementId INT NULL;
    PRINT '✓ Added CustomArrangementId to OrderDetails';
END

PRINT '';
PRINT 'Part 1 completed!';
PRINT '';

-- ==========================================
-- PART 2: CREATE NEW TABLES
-- ==========================================

PRINT 'PART 2: Creating new tables...';
PRINT '';

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
    PRINT '✓ Created CustomArrangements table';
END
ELSE
BEGIN
    PRINT '  CustomArrangements table already exists';
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
    PRINT '✓ Created CustomArrangementFlowers table';
END
ELSE
BEGIN
    PRINT '  CustomArrangementFlowers table already exists';
END

PRINT '';
PRINT 'Part 2 completed!';
PRINT '';

-- ==========================================
-- PART 3: SEED DATA
-- ==========================================

PRINT 'PART 3: Adding seed data...';
PRINT '';

-- Insert/Update Presentation Styles
PRINT 'Adding Presentation Styles...';

MERGE PresentationStyles AS target
USING (VALUES
    (N'Bó hoa', 50000, N'Bó hoa được gói bằng giấy cao cấp', '/images/styles/bo-hoa.jpg'),
    (N'Lẵng hoa', 100000, N'Lẵng hoa sang trọng', '/images/styles/lang-hoa.jpg'),
    (N'Hộp hoa', 80000, N'Hoa cắm trong hộp vuông hiện đại', '/images/styles/hop-hoa.jpg'),
    (N'Giỏ hoa', 120000, N'Hoa cắm trong giỏ mây tự nhiên', '/images/styles/gio-hoa.jpg'),
    (N'Bình hoa', 70000, N'Hoa cắm trong bình thủy tinh', '/images/styles/binh-hoa.jpg'),
    (N'Hoa bó cổ điển', 60000, N'Bó hoa phong cách cổ điển', '/images/styles/bo-co-dien.jpg'),
    (N'Hoa để bàn', 90000, N'Hoa trang trí để bàn', '/images/styles/hoa-de-ban.jpg'),
    (N'Giỏ hoa hiện đại', 150000, N'Giỏ hoa phong cách hiện đại', '/images/styles/gio-hien-dai.jpg'),
    (N'Hộp hoa nghệ thuật', 110000, N'Hộp hoa thiết kế nghệ thuật', '/images/styles/hop-nghe-thuat.jpg'),
    (N'Lẵng hoa mini', 75000, N'Lẵng hoa nhỏ xinh', '/images/styles/lang-mini.jpg')
) AS source (Name, BasePrice, Description, ImageUrl)
ON target.Name = source.Name
WHEN MATCHED THEN
    UPDATE SET BasePrice = source.BasePrice,
               Description = source.Description,
               ImageUrl = source.ImageUrl
WHEN NOT MATCHED THEN
    INSERT (Name, BasePrice, Description, ImageUrl)
    VALUES (source.Name, source.BasePrice, source.Description, source.ImageUrl);

PRINT '✓ Presentation Styles: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows affected';

-- Update existing FlowerTypes
PRINT 'Updating FlowerTypes...';

UPDATE FlowerTypes
SET UnitPrice = 8000,
    AvailableColors = N'Đỏ,Hồng,Trắng,Vàng,Tím',
    Description = N'Hoa cẩm chướng tươi, biểu tượng của tình yêu',
    ImageUrl = '/images/flowers/cam-chuong.jpg'
WHERE Name LIKE N'%Cẩm Chướng%' AND UnitPrice = 0;

UPDATE FlowerTypes
SET UnitPrice = 12000,
    AvailableColors = N'Đỏ,Hồng,Trắng,Vàng,Cam,Tím',
    Description = N'Hoa cắt tươi đa dạng màu sắc',
    ImageUrl = '/images/flowers/cat-tuoi.jpg'
WHERE (Name LIKE N'%Cắt Tươi%' OR Name LIKE N'%Cắm Tươi%') AND UnitPrice = 0;

UPDATE FlowerTypes
SET UnitPrice = 5000,
    AvailableColors = N'Trắng,Vàng,Cam',
    Description = N'Hoa cúc họa mi thanh khiết',
    ImageUrl = '/images/flowers/cuc.jpg'
WHERE Name LIKE N'%Cúc%' AND UnitPrice = 0;

-- Insert common flower types
MERGE FlowerTypes AS target
USING (VALUES
    (N'Hoa Hồng', 500, 15000, N'Đỏ,Hồng,Trắng,Vàng,Cam,Tím', N'Hoa hồng tươi nhập khẩu', '/images/flowers/hong.jpg'),
    (N'Hoa Tulip', 300, 20000, N'Đỏ,Vàng,Trắng,Tím,Hồng,Cam', N'Hoa tulip Hà Lan cao cấp', '/images/flowers/tulip.jpg'),
    (N'Hoa Ly', 200, 25000, N'Trắng,Hồng,Vàng,Cam', N'Hoa ly thơm nhẹ nhàng', '/images/flowers/ly.jpg'),
    (N'Hoa Baby', 1000, 3000, N'Trắng,Hồng', N'Hoa baby điểm nhấn xinh xắn', '/images/flowers/baby.jpg'),
    (N'Hoa Lan Hồ Điệp', 150, 35000, N'Trắng,Hồng,Tím,Vàng', N'Hoa lan sang trọng', '/images/flowers/lan.jpg'),
    (N'Hoa Cúc Mẫu Đơn', 250, 18000, N'Hồng,Trắng,Vàng,Đỏ', N'Hoa cúc mẫu đơn lớn', '/images/flowers/cuc-mau-don.jpg'),
    (N'Hoa Hướng Dương', 180, 22000, N'Vàng,Cam', N'Hoa hướng dương rực rỡ', '/images/flowers/huong-duong.jpg'),
    (N'Hoa Đồng Tiền', 400, 7000, N'Trắng,Hồng,Vàng,Tím', N'Hoa đồng tiền nhỏ xinh', '/images/flowers/dong-tien.jpg'),
    (N'Hoa Cát Tường', 350, 10000, N'Tím,Trắng,Hồng', N'Hoa cát tường độc đáo', '/images/flowers/cat-tuong.jpg')
) AS source (Name, Quantity, UnitPrice, AvailableColors, Description, ImageUrl)
ON target.Name = source.Name
WHEN MATCHED THEN
    UPDATE SET UnitPrice = source.UnitPrice,
               AvailableColors = source.AvailableColors,
               Description = source.Description,
               ImageUrl = source.ImageUrl,
               Quantity = CASE WHEN target.Quantity < 100 THEN source.Quantity ELSE target.Quantity END,
               IsActive = 1
WHEN NOT MATCHED THEN
    INSERT (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (source.Name, source.Quantity, 1, source.UnitPrice, source.AvailableColors, source.Description, source.ImageUrl);

PRINT '✓ FlowerTypes: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows affected';

PRINT '';
PRINT 'Part 3 completed!';
PRINT '';

-- ==========================================
-- PART 4: MARK MIGRATION AS APPLIED
-- ==========================================

PRINT 'PART 4: Updating migration history...';
PRINT '';

IF NOT EXISTS (SELECT * FROM __EFMigrationsHistory WHERE MigrationId = '20251016065332_AddCustomArrangementFeature')
BEGIN
    INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion)
    VALUES ('20251016065332_AddCustomArrangementFeature', '9.0.4');
    PRINT '✓ Marked migration as applied';
END
ELSE
BEGIN
    PRINT '  Migration already marked as applied';
END

PRINT '';

-- ==========================================
-- SUMMARY
-- ==========================================

PRINT '';
PRINT '========================================';
PRINT 'SETUP COMPLETED SUCCESSFULLY!';
PRINT '========================================';
PRINT '';
PRINT 'Database Statistics:';
PRINT '-------------------';

DECLARE @PresentationCount INT, @FlowerCount INT, @ArrangementCount INT;
SET @PresentationCount = (SELECT COUNT(*) FROM PresentationStyles WHERE BasePrice > 0);
SET @FlowerCount = (SELECT COUNT(*) FROM FlowerTypes WHERE UnitPrice > 0 AND IsActive = 1);
SET @ArrangementCount = (SELECT COUNT(*) FROM CustomArrangements);

PRINT 'Presentation Styles: ' + CAST(@PresentationCount AS VARCHAR) + ' with prices';
PRINT 'Flower Types: ' + CAST(@FlowerCount AS VARCHAR) + ' active with prices';
PRINT 'Custom Arrangements: ' + CAST(@ArrangementCount AS VARCHAR);
PRINT '';
PRINT 'You can now use the Custom Flower Arrangement feature!';
PRINT 'Navigate to: http://localhost:5187/CustomArrangement/Designer';
PRINT '';
PRINT '========================================';

GO
