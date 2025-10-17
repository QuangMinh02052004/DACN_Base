-- Seed data for Custom Flower Arrangement feature
-- Run this AFTER running add_custom_arrangement_columns.sql

USE Bloomie;
GO

-- Insert/Update Presentation Styles with prices
PRINT 'Adding/Updating Presentation Styles...';

-- Update existing or insert new presentation styles
IF EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Bó hoa')
BEGIN
    UPDATE PresentationStyles
    SET BasePrice = 50000,
        Description = N'Bó hoa được gói bằng giấy cao cấp',
        ImageUrl = '/images/styles/bo-hoa.jpg'
    WHERE Name = N'Bó hoa';
    PRINT 'Updated Bó hoa';
END
ELSE
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Bó hoa', 50000, N'Bó hoa được gói bằng giấy cao cấp', '/images/styles/bo-hoa.jpg');
    PRINT 'Inserted Bó hoa';
END

IF EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Lẵng hoa')
BEGIN
    UPDATE PresentationStyles
    SET BasePrice = 100000,
        Description = N'Lẵng hoa sang trọng',
        ImageUrl = '/images/styles/lang-hoa.jpg'
    WHERE Name = N'Lẵng hoa';
    PRINT 'Updated Lẵng hoa';
END
ELSE
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Lẵng hoa', 100000, N'Lẵng hoa sang trọng', '/images/styles/lang-hoa.jpg');
    PRINT 'Inserted Lẵng hoa';
END

IF EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Hộp hoa')
BEGIN
    UPDATE PresentationStyles
    SET BasePrice = 80000,
        Description = N'Hoa cắm trong hộp vuông hiện đại',
        ImageUrl = '/images/styles/hop-hoa.jpg'
    WHERE Name = N'Hộp hoa';
    PRINT 'Updated Hộp hoa';
END
ELSE
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Hộp hoa', 80000, N'Hoa cắm trong hộp vuông hiện đại', '/images/styles/hop-hoa.jpg');
    PRINT 'Inserted Hộp hoa';
END

IF NOT EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Giỏ hoa')
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Giỏ hoa', 120000, N'Hoa cắm trong giỏ mây tự nhiên', '/images/styles/gio-hoa.jpg');
    PRINT 'Inserted Giỏ hoa';
END

IF NOT EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Bình hoa')
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Bình hoa', 70000, N'Hoa cắm trong bình thủy tinh', '/images/styles/binh-hoa.jpg');
    PRINT 'Inserted Bình hoa';
END

IF NOT EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Hoa bó cổ điển')
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Hoa bó cổ điển', 60000, N'Bó hoa phong cách cổ điển', '/images/styles/bo-co-dien.jpg');
    PRINT 'Inserted Hoa bó cổ điển';
END

IF NOT EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Hoa để bàn')
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Hoa để bàn', 90000, N'Hoa trang trí để bàn', '/images/styles/hoa-de-ban.jpg');
    PRINT 'Inserted Hoa để bàn';
END

IF NOT EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Giỏ hoa hiện đại')
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Giỏ hoa hiện đại', 150000, N'Giỏ hoa phong cách hiện đại', '/images/styles/gio-hien-dai.jpg');
    PRINT 'Inserted Giỏ hoa hiện đại';
END

IF NOT EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Hộp hoa nghệ thuật')
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Hộp hoa nghệ thuật', 110000, N'Hộp hoa thiết kế nghệ thuật', '/images/styles/hop-nghe-thuat.jpg');
    PRINT 'Inserted Hộp hoa nghệ thuật';
END

IF NOT EXISTS (SELECT 1 FROM PresentationStyles WHERE Name = N'Lẵng hoa mini')
BEGIN
    INSERT INTO PresentationStyles (Name, BasePrice, Description, ImageUrl)
    VALUES (N'Lẵng hoa mini', 75000, N'Lẵng hoa nhỏ xinh', '/images/styles/lang-mini.jpg');
    PRINT 'Inserted Lẵng hoa mini';
END

PRINT 'Presentation Styles completed!';
GO

-- Update FlowerTypes with prices and colors
PRINT 'Updating FlowerTypes with prices...';

-- Cẩm Chướng
UPDATE FlowerTypes
SET UnitPrice = 8000,
    AvailableColors = N'Đỏ,Hồng,Trắng,Vàng,Tím',
    Description = N'Hoa cẩm chướng tươi, biểu tượng của tình yêu và sự ngưỡng mộ',
    ImageUrl = '/images/flowers/cam-chuong.jpg'
WHERE Name LIKE N'%Cẩm Chướng%';
PRINT 'Updated Cẩm Chướng';

-- Hoa Cắt Tươi
UPDATE FlowerTypes
SET UnitPrice = 12000,
    AvailableColors = N'Đỏ,Hồng,Trắng,Vàng,Cam,Tím',
    Description = N'Hoa cắt tươi đa dạng màu sắc',
    ImageUrl = '/images/flowers/cat-tuoi.jpg'
WHERE Name LIKE N'%Cắt Tươi%' OR Name LIKE N'%Cắm Tươi%';
PRINT 'Updated Hoa Cắt Tươi';

-- Hoa Cúc
UPDATE FlowerTypes
SET UnitPrice = 5000,
    AvailableColors = N'Trắng,Vàng,Cam',
    Description = N'Hoa cúc họa mi thanh khiết',
    ImageUrl = '/images/flowers/cuc.jpg'
WHERE Name LIKE N'%Cúc%';
PRINT 'Updated Hoa Cúc';

-- Add more common flower types if they don't exist
IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Hồng')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Hồng', 500, 1, 15000, N'Đỏ,Hồng,Trắng,Vàng,Cam,Tím', N'Hoa hồng tươi nhập khẩu, biểu tượng của tình yêu', '/images/flowers/hong.jpg');
    PRINT 'Inserted Hoa Hồng';
END
ELSE
BEGIN
    UPDATE FlowerTypes
    SET UnitPrice = 15000,
        AvailableColors = N'Đỏ,Hồng,Trắng,Vàng,Cam,Tím',
        Description = N'Hoa hồng tươi nhập khẩu, biểu tượng của tình yêu',
        ImageUrl = '/images/flowers/hong.jpg',
        Quantity = CASE WHEN Quantity < 100 THEN 500 ELSE Quantity END
    WHERE Name = N'Hoa Hồng';
    PRINT 'Updated Hoa Hồng';
END

IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Tulip')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Tulip', 300, 1, 20000, N'Đỏ,Vàng,Trắng,Tím,Hồng,Cam', N'Hoa tulip Hà Lan cao cấp', '/images/flowers/tulip.jpg');
    PRINT 'Inserted Hoa Tulip';
END

IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Ly')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Ly', 200, 1, 25000, N'Trắng,Hồng,Vàng,Cam', N'Hoa ly thơm nhẹ nhàng, sang trọng', '/images/flowers/ly.jpg');
    PRINT 'Inserted Hoa Ly';
END

IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Baby')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Baby', 1000, 1, 3000, N'Trắng,Hồng', N'Hoa baby điểm nhấn xinh xắn', '/images/flowers/baby.jpg');
    PRINT 'Inserted Hoa Baby';
END

IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Lan Hồ Điệp')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Lan Hồ Điệp', 150, 1, 35000, N'Trắng,Hồng,Tím,Vàng', N'Hoa lan hồ điệp sang trọng, quý phái', '/images/flowers/lan-ho-diep.jpg');
    PRINT 'Inserted Hoa Lan Hồ Điệp';
END

IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Cúc Mẫu Đơn')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Cúc Mẫu Đơn', 250, 1, 18000, N'Hồng,Trắng,Vàng,Đỏ', N'Hoa cúc mẫu đơn lớn, đẹp mắt', '/images/flowers/cuc-mau-don.jpg');
    PRINT 'Inserted Hoa Cúc Mẫu Đơn';
END

IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Hướng Dương')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Hướng Dương', 180, 1, 22000, N'Vàng,Cam', N'Hoa hướng dương rực rỡ, tươi vui', '/images/flowers/huong-duong.jpg');
    PRINT 'Inserted Hoa Hướng Dương';
END

IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Đồng Tiền')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Đồng Tiền', 400, 1, 7000, N'Trắng,Hồng,Vàng,Tím', N'Hoa đồng tiền nhỏ xinh, đa dạng', '/images/flowers/dong-tien.jpg');
    PRINT 'Inserted Hoa Đồng Tiền';
END

IF NOT EXISTS (SELECT 1 FROM FlowerTypes WHERE Name = N'Hoa Cát Tường')
BEGIN
    INSERT INTO FlowerTypes (Name, Quantity, IsActive, UnitPrice, AvailableColors, Description, ImageUrl)
    VALUES (N'Hoa Cát Tường', 350, 1, 10000, N'Tím,Trắng,Hồng', N'Hoa cát tường điểm nhấn độc đáo', '/images/flowers/cat-tuong.jpg');
    PRINT 'Inserted Hoa Cát Tường';
END

PRINT 'FlowerTypes update completed!';
GO

PRINT '';
PRINT '========================================';
PRINT 'SEED DATA COMPLETED SUCCESSFULLY!';
PRINT '========================================';
PRINT 'Total Presentation Styles: ' + CAST((SELECT COUNT(*) FROM PresentationStyles) AS VARCHAR);
PRINT 'Total Flower Types: ' + CAST((SELECT COUNT(*) FROM FlowerTypes WHERE IsActive = 1) AS VARCHAR);
PRINT '';
PRINT 'You can now use the Custom Flower Arrangement feature!';
PRINT 'Navigate to: /CustomArrangement/Designer';
GO
