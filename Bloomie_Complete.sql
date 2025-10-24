-- =============================================
-- Bloomie Flower Shop Database - Complete Setup
-- Generated: 2025-10-24
-- =============================================

USE master;
GO

-- Drop database if exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Bloomie_Test')
BEGIN
    ALTER DATABASE Bloomie_Test SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Bloomie_Test;
END
GO

-- Create database
CREATE DATABASE Bloomie_Test;
GO

USE Bloomie_Test;
GO

-- =============================================
-- 1. IDENTITY TABLES (ASP.NET Core Identity)
-- =============================================

-- AspNetRoles
CREATE TABLE AspNetRoles (
    Id NVARCHAR(450) NOT NULL PRIMARY KEY,
    Name NVARCHAR(256) NULL,
    NormalizedName NVARCHAR(256) NULL,
    ConcurrencyStamp NVARCHAR(MAX) NULL
);

-- AspNetUsers
CREATE TABLE AspNetUsers (
    Id NVARCHAR(450) NOT NULL PRIMARY KEY,
    UserName NVARCHAR(256) NULL,
    NormalizedUserName NVARCHAR(256) NULL,
    Email NVARCHAR(256) NULL,
    NormalizedEmail NVARCHAR(256) NULL,
    EmailConfirmed BIT NOT NULL,
    PasswordHash NVARCHAR(MAX) NULL,
    SecurityStamp NVARCHAR(MAX) NULL,
    ConcurrencyStamp NVARCHAR(MAX) NULL,
    PhoneNumber NVARCHAR(MAX) NULL,
    PhoneNumberConfirmed BIT NOT NULL,
    TwoFactorEnabled BIT NOT NULL,
    LockoutEnd DATETIMEOFFSET(7) NULL,
    LockoutEnabled BIT NOT NULL,
    AccessFailedCount INT NOT NULL,
    FullName NVARCHAR(MAX) NOT NULL,
    RoleId NVARCHAR(MAX) NOT NULL,
    Token NVARCHAR(MAX) NOT NULL,
    ProfileImageUrl NVARCHAR(MAX) NULL
);

-- AspNetUserRoles
CREATE TABLE AspNetUserRoles (
    UserId NVARCHAR(450) NOT NULL,
    RoleId NVARCHAR(450) NOT NULL,
    PRIMARY KEY (UserId, RoleId),
    FOREIGN KEY (RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- AspNetUserClaims
CREATE TABLE AspNetUserClaims (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId NVARCHAR(450) NOT NULL,
    ClaimType NVARCHAR(MAX) NULL,
    ClaimValue NVARCHAR(MAX) NULL,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- AspNetUserLogins
CREATE TABLE AspNetUserLogins (
    LoginProvider NVARCHAR(450) NOT NULL,
    ProviderKey NVARCHAR(450) NOT NULL,
    ProviderDisplayName NVARCHAR(MAX) NULL,
    UserId NVARCHAR(450) NOT NULL,
    PRIMARY KEY (LoginProvider, ProviderKey),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- AspNetUserTokens
CREATE TABLE AspNetUserTokens (
    UserId NVARCHAR(450) NOT NULL,
    LoginProvider NVARCHAR(450) NOT NULL,
    Name NVARCHAR(450) NOT NULL,
    Value NVARCHAR(MAX) NULL,
    PRIMARY KEY (UserId, LoginProvider, Name),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- AspNetRoleClaims
CREATE TABLE AspNetRoleClaims (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    RoleId NVARCHAR(450) NOT NULL,
    ClaimType NVARCHAR(MAX) NULL,
    ClaimValue NVARCHAR(MAX) NULL,
    FOREIGN KEY (RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
);

-- =============================================
-- 2. CORE BUSINESS TABLES
-- =============================================

-- Categories
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    ParentCategoryId INT NULL,
    ImageUrl NVARCHAR(MAX) NULL,
    FOREIGN KEY (ParentCategoryId) REFERENCES Categories(Id)
);

-- PresentationStyles
CREATE TABLE PresentationStyles (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    BasePrice DECIMAL(18,2) NOT NULL DEFAULT 0,
    ImageUrl NVARCHAR(MAX) NULL
);

-- Suppliers
CREATE TABLE Suppliers (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Phone NVARCHAR(MAX) NOT NULL,
    Email NVARCHAR(MAX) NOT NULL,
    Address NVARCHAR(MAX) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);

-- FlowerTypes
CREATE TABLE FlowerTypes (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    ImageUrl NVARCHAR(MAX) NULL,
    IsActive BIT NOT NULL DEFAULT 1
);

-- Products
CREATE TABLE Products (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    DiscountPercentage DECIMAL(18,2) NULL,
    DiscountPrice DECIMAL(18,2) NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    CategoryId INT NOT NULL,
    PresentationStyleId INT NULL,
    ImageUrl NVARCHAR(MAX) NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    IsFeatured BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    Colors NVARCHAR(MAX) NULL, -- JSON array: ["Đỏ","Hồng","Trắng"]
    Occasions NVARCHAR(MAX) NULL, -- JSON array
    Objects NVARCHAR(MAX) NULL, -- JSON array
    FlowerTypes NVARCHAR(MAX) NULL, -- JSON array
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id),
    FOREIGN KEY (PresentationStyleId) REFERENCES PresentationStyles(Id)
);

-- ProductImages
CREATE TABLE ProductImages (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductId INT NOT NULL,
    Url NVARCHAR(MAX) NOT NULL,
    IsPrimary BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE
);

-- FlowerTypeProducts (Many-to-Many)
CREATE TABLE FlowerTypeProducts (
    FlowerTypeId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (FlowerTypeId, ProductId),
    FOREIGN KEY (FlowerTypeId) REFERENCES FlowerTypes(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE
);

-- Batches
CREATE TABLE Batches (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    BatchNumber NVARCHAR(MAX) NOT NULL,
    SupplierId INT NOT NULL,
    ImportDate DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    ExpiryDate DATETIME2(7) NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    TotalQuantity INT NOT NULL,
    RemainingQuantity INT NOT NULL,
    Notes NVARCHAR(MAX) NULL,
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(Id)
);

-- BatchFlowerTypes (Many-to-Many)
CREATE TABLE BatchFlowerTypes (
    BatchId INT NOT NULL,
    FlowerTypeId INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (BatchId, FlowerTypeId),
    FOREIGN KEY (BatchId) REFERENCES Batches(Id) ON DELETE CASCADE,
    FOREIGN KEY (FlowerTypeId) REFERENCES FlowerTypes(Id)
);

-- FlowerTypeSuppliers (Many-to-Many)
CREATE TABLE FlowerTypeSuppliers (
    FlowerTypesId INT NOT NULL,
    SuppliersId INT NOT NULL,
    PRIMARY KEY (FlowerTypesId, SuppliersId),
    FOREIGN KEY (FlowerTypesId) REFERENCES FlowerTypes(Id) ON DELETE CASCADE,
    FOREIGN KEY (SuppliersId) REFERENCES Suppliers(Id) ON DELETE CASCADE
);

-- Promotions
CREATE TABLE Promotions (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Code NVARCHAR(MAX) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    DiscountPercentage DECIMAL(18,2) NOT NULL,
    MinimumOrderValue DECIMAL(18,2) NULL,
    MaximumDiscountValue DECIMAL(18,2) NULL,
    StartDate DATETIME2(7) NOT NULL,
    EndDate DATETIME2(7) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    UsageLimit INT NULL,
    UsedCount INT NOT NULL DEFAULT 0
);

-- PromotionProducts (Many-to-Many)
CREATE TABLE PromotionProducts (
    PromotionId INT NOT NULL,
    ProductId INT NOT NULL,
    PRIMARY KEY (PromotionId, ProductId),
    FOREIGN KEY (PromotionId) REFERENCES Promotions(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE
);

-- Orders
CREATE TABLE Orders (
    Id NVARCHAR(450) NOT NULL PRIMARY KEY,
    UserId NVARCHAR(450) NOT NULL,
    OrderDate DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    TotalPrice DECIMAL(18,2) NOT NULL,
    Status NVARCHAR(MAX) NOT NULL,
    ShippingAddress NVARCHAR(MAX) NOT NULL,
    PhoneNumber NVARCHAR(MAX) NOT NULL,
    Notes NVARCHAR(MAX) NULL,
    PaymentMethod NVARCHAR(MAX) NULL,
    PaymentStatus NVARCHAR(MAX) NULL,
    ShippingMethod NVARCHAR(MAX) NOT NULL,
    ShippingFee DECIMAL(18,2) NOT NULL DEFAULT 0,
    DiscountAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    SenderName NVARCHAR(MAX) NOT NULL,
    SenderEmail NVARCHAR(MAX) NOT NULL,
    SenderPhoneNumber NVARCHAR(MAX) NOT NULL,
    ReceiverName NVARCHAR(MAX) NOT NULL,
    ReceiverEmail NVARCHAR(MAX) NOT NULL,
    ReceiverPhoneNumber NVARCHAR(MAX) NOT NULL,
    DeliveryDate DATETIME2(7) NULL,
    DeliveryTime NVARCHAR(MAX) NULL,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id)
);

-- OrderDetails
CREATE TABLE OrderDetails (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderId NVARCHAR(450) NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    DiscountAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    DeliveryTime NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

-- OrderStatusHistories
CREATE TABLE OrderStatusHistories (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderId NVARCHAR(450) NOT NULL,
    Status NVARCHAR(MAX) NOT NULL,
    ChangedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    ChangedBy NVARCHAR(MAX) NOT NULL,
    Notes NVARCHAR(MAX) NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id) ON DELETE CASCADE
);

-- Payments
CREATE TABLE Payments (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderId NVARCHAR(450) NOT NULL UNIQUE,
    Amount DECIMAL(18,2) NOT NULL,
    PaymentMethod NVARCHAR(MAX) NOT NULL,
    PaymentStatus NVARCHAR(MAX) NOT NULL,
    PaymentDate DATETIME2(7) NULL,
    TransactionId NVARCHAR(MAX) NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id) ON DELETE CASCADE
);

-- Shippings
CREATE TABLE Shippings (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    EstimatedDays INT NOT NULL,
    Ward NVARCHAR(MAX) NOT NULL,
    District NVARCHAR(MAX) NOT NULL,
    City NVARCHAR(MAX) NOT NULL
);

-- InventoryTransactions
CREATE TABLE InventoryTransactions (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TransactionType NVARCHAR(MAX) NOT NULL,
    ProductId INT NULL,
    FlowerTypeId INT NULL,
    Quantity INT NOT NULL,
    Reason NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(MAX) NOT NULL,
    OrderId NVARCHAR(450) NULL,
    UnitPrice DECIMAL(18,2) NULL,
    SupplierId INT NULL,
    BatchId INT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (FlowerTypeId) REFERENCES FlowerTypes(Id),
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(Id),
    FOREIGN KEY (BatchId) REFERENCES Batches(Id)
);

-- CustomArrangements
CREATE TABLE CustomArrangements (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId NVARCHAR(450) NOT NULL,
    Name NVARCHAR(MAX) NOT NULL,
    PresentationStyleId INT NOT NULL,
    BasePrice DECIMAL(18,2) NOT NULL,
    FlowersCost DECIMAL(18,2) NOT NULL,
    TotalPrice DECIMAL(18,2) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(MAX) NOT NULL,
    Notes NVARCHAR(MAX) NULL,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id),
    FOREIGN KEY (PresentationStyleId) REFERENCES PresentationStyles(Id)
);

-- CustomArrangementFlowers
CREATE TABLE CustomArrangementFlowers (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CustomArrangementId INT NOT NULL,
    FlowerTypeId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    TotalPrice DECIMAL(18,2) NOT NULL,
    Color NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (CustomArrangementId) REFERENCES CustomArrangements(Id) ON DELETE CASCADE,
    FOREIGN KEY (FlowerTypeId) REFERENCES FlowerTypes(Id)
);

-- Ratings
CREATE TABLE Ratings (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductId INT NOT NULL,
    UserId NVARCHAR(450) NOT NULL,
    Score INT NOT NULL,
    Comment NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    ImageUrl NVARCHAR(MAX) NOT NULL,
    Status NVARCHAR(MAX) NOT NULL,
    IsVerified BIT NOT NULL DEFAULT 0,
    UpdatedAt DATETIME2(7) NULL,
    LastModifiedBy NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id)
);

-- Replies
CREATE TABLE Replies (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    RatingId INT NOT NULL,
    UserId NVARCHAR(450) NOT NULL,
    Comment NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(MAX) NOT NULL,
    IsVerified BIT NOT NULL DEFAULT 0,
    UpdatedAt DATETIME2(7) NULL,
    LastModifiedBy NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (RatingId) REFERENCES Ratings(Id),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id)
);

-- Reports
CREATE TABLE Reports (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    RatingId INT NOT NULL,
    ReporterId NVARCHAR(450) NOT NULL,
    Reason NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    ResolvedBy NVARCHAR(MAX) NOT NULL,
    ResolvedAt DATETIME2(7) NULL,
    FOREIGN KEY (RatingId) REFERENCES Ratings(Id),
    FOREIGN KEY (ReporterId) REFERENCES AspNetUsers(Id)
);

-- UserLikes
CREATE TABLE UserLikes (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId NVARCHAR(450) NOT NULL,
    RatingId INT NULL,
    ReplyId INT NULL,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id),
    FOREIGN KEY (RatingId) REFERENCES Ratings(Id),
    FOREIGN KEY (ReplyId) REFERENCES Replies(Id) ON DELETE CASCADE
);

-- Notifications
CREATE TABLE Notifications (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Title NVARCHAR(MAX) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    UserId NVARCHAR(450) NOT NULL,
    Link NVARCHAR(MAX) NOT NULL,
    IsRead BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- Messages
CREATE TABLE Messages (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    SenderId NVARCHAR(450) NOT NULL,
    SenderName NVARCHAR(MAX) NOT NULL,
    ReceiverId NVARCHAR(450) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    IsRead BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (SenderId) REFERENCES AspNetUsers(Id),
    FOREIGN KEY (ReceiverId) REFERENCES AspNetUsers(Id)
);

-- UserAccessLogs
CREATE TABLE UserAccessLogs (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId NVARCHAR(450) NOT NULL,
    AccessTime DATETIME2(7) NOT NULL DEFAULT GETDATE(),
    Url NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id)
);

-- =============================================
-- 3. SEED DATA
-- =============================================

-- Insert Roles
INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES
(NEWID(), 'Admin', 'ADMIN', NEWID()),
(NEWID(), 'User', 'USER', NEWID()),
(NEWID(), 'Staff', 'STAFF', NEWID()),
(NEWID(), 'Manager', 'MANAGER', NEWID());
GO

-- Insert Admin User (Password: Admin@123)
DECLARE @AdminRoleId NVARCHAR(450) = (SELECT Id FROM AspNetRoles WHERE NormalizedName = 'ADMIN');
DECLARE @AdminId NVARCHAR(450) = NEWID();

INSERT INTO AspNetUsers (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnabled, AccessFailedCount, FullName, RoleId, Token)
VALUES (
    @AdminId,
    'admin',
    'ADMIN',
    'admin@bloomie.com',
    'ADMIN@BLOOMIE.COM',
    1,
    'AQAAAAIAAYagAAAAEHVlKvDmkN8NZ5N+6zJxGqxDDK0lEzGxYz3qN8vN7Y1vLQWMZ6EHvN9nN8NZ5N+6zA==', -- Admin@123
    NEWID(),
    NEWID(),
    '0123456789',
    1,
    0,
    1,
    0,
    N'Administrator',
    @AdminRoleId,
    NEWID()
);

INSERT INTO AspNetUserRoles (UserId, RoleId) VALUES (@AdminId, @AdminRoleId);
GO

-- Insert Categories
INSERT INTO Categories (Name, Description, ParentCategoryId, ImageUrl) VALUES
(N'Chủ đề', N'Phân loại theo chủ đề sự kiện', NULL, NULL),
(N'Đối tượng', N'Phân loại theo đối tượng tặng', NULL, NULL),
(N'Hoa sinh nhật', N'Hoa tươi dành cho sinh nhật', 1, '/images/hoasinhnhat.jpg'),
(N'Hoa chúc mừng', N'Hoa chúc mừng thành công', 1, '/images/hoachucmung.jpg'),
(N'Hoa cưới', N'Hoa trang trí đám cưới', 1, '/images/hoacuoi.jpg'),
(N'Hoa tình yêu', N'Hoa tặng người yêu', 1, '/images/hoatinhyeu.webp'),
(N'Hoa chia buồn', N'Hoa chia buồn tang lễ', 1, '/images/02c5cff4-a5fb-4b8f-b71d-e4abc5c4da97.jpg'),
(N'Hoa khai trương', N'Hoa chúc mừng khai trương', 1, '/images/0b3881ef-7914-4942-a370-73e15e731031.jpg'),
(N'Hoa tặng mẹ', N'Hoa dành tặng mẹ', 2, '/images/0b622e33-aec4-44e3-88f1-37918bfd22b9.jpg'),
(N'Hoa tặng bạn bè', N'Hoa tặng bạn bè', 2, '/images/0bb01b69-f140-496d-bdac-0db021fc6c92.jpg'),
(N'Hoa tặng đồng nghiệp', N'Hoa tặng đồng nghiệp', 2, '/images/0bc829f6-436e-45b5-a864-729ad45d103b.jpg');
GO

-- Insert PresentationStyles
INSERT INTO PresentationStyles (Name, Description, BasePrice, ImageUrl) VALUES
(N'Bó hoa', N'Hoa được bó tròn tay', 50000, '/images/014d03dd-90bb-4d1c-b57b-28a62aaf60fc.webp'),
(N'Giỏ hoa', N'Hoa được cắm trong giỏ', 100000, '/images/019f21c9-2d87-409f-81b6-edfb9c6a379d.webp'),
(N'Hộp hoa', N'Hoa được xếp trong hộp', 150000, '/images/01d936e5-523a-4e27-9238-4e48711d925e.webp'),
(N'Bình hoa', N'Hoa được cắm trong bình', 80000, '/images/024bb24f-74aa-4d4e-9e54-88105bc5596f.webp'),
(N'Chậu hoa', N'Hoa trồng trong chậu', 120000, '/images/0251269b-2b99-459b-9fba-1155e15d6032.webp'),
(N'Kệ hoa', N'Kệ hoa chúc mừng', 500000, '/images/029f5bc6-2e29-4d9b-8961-5729e776d003.webp'),
(N'Hoa cài áo', N'Hoa cài áo nhỏ', 30000, '/images/02fb74b1-d06b-474f-8ff2-d0b08df69abc.webp');
GO

-- Insert Suppliers
INSERT INTO Suppliers (Name, Phone, Email, Address, IsActive) VALUES
(N'Vườn hoa Đà Lạt', '0901234567', 'dalat@flowers.vn', N'Đà Lạt, Lâm Đồng', 1),
(N'Nhà vườn Sài Gòn', '0912345678', 'saigon@flowers.vn', N'TP. Hồ Chí Minh', 1),
(N'Hoa nhập khẩu Hà Lan', '0923456789', 'holland@flowers.vn', N'Quận 1, TP.HCM', 1),
(N'Vườn hoa Mộc Châu', '0934567890', 'mocchau@flowers.vn', N'Mộc Châu, Sơn La', 1);
GO

-- Insert FlowerTypes với màu sắc chuẩn
INSERT INTO FlowerTypes (Name, Description, UnitPrice, StockQuantity, ImageUrl, IsActive) VALUES
(N'Hồng đỏ', N'Hoa hồng đỏ tươi', 15000, 500, '/images/0392cb62-e8f4-4b10-bcb8-c2065d0d2be3.webp', 1),
(N'Hồng hồng', N'Hoa hồng màu hồng', 15000, 400, '/images/03dc321a-d33b-4a09-b2bb-559291dba420.webp', 1),
(N'Hồng trắng', N'Hoa hồng trắng tinh khôi', 18000, 300, '/images/03f94f50-c5d9-489a-82d6-a716e002c31b.webp', 1),
(N'Hồng vàng', N'Hoa hồng vàng rực rỡ', 20000, 200, '/images/04a8c142-dbd4-48a7-8681-e2d852d840ef.webp', 1),
(N'Ly trắng', N'Hoa ly trắng thanh khiết', 25000, 250, '/images/04b72980-0e1e-40b8-be33-257bec1d5bce.jpg', 1),
(N'Ly hồng', N'Hoa ly màu hồng', 25000, 200, '/images/04c57e21-96e3-41e5-b1c5-90030af9bfab.webp', 1),
(N'Cẩm chướng đỏ', N'Hoa cẩm chướng đỏ', 8000, 600, '/images/0538d107-899b-4e31-a259-f58acda6e03c.webp', 1),
(N'Cẩm chướng hồng', N'Hoa cẩm chướng hồng', 8000, 550, '/images/0545fd69-2437-4a3b-851b-741270784830.jpg', 1),
(N'Cẩm chướng trắng', N'Hoa cẩm chướng trắng', 8000, 500, '/images/0619f742-8f74-40ba-bf3c-cf600fcfa258.jpg', 1),
(N'Hướng dương', N'Hoa hướng dương vàng', 30000, 150, '/images/0643960d-d7e0-4710-a272-6205090c1791.webp', 1),
(N'Cúc họa mi', N'Hoa cúc họa mi trắng', 5000, 800, '/images/066be83a-c02d-4c32-9380-ba9a21c1b3e2.webp', 1),
(N'Tulip đỏ', N'Hoa tulip đỏ nhập khẩu', 35000, 100, '/images/06a8bdfb-e3f6-4644-a728-7c5e621585c9.jpg', 1),
(N'Tulip hồng', N'Hoa tulip hồng', 35000, 100, '/images/06cc9603-4a29-4adc-bcaf-9c0038a26c7a.webp', 1),
(N'Lan hồ điệp trắng', N'Lan hồ điệp trắng sang trọng', 45000, 80, '/images/070f95cd-7f4b-43f8-a33a-1af1347b84ab.webp', 1),
(N'Lan hồ điệp tím', N'Lan hồ điệp tím quý phái', 45000, 70, '/images/079f688f-7dd4-4e1f-8a2b-0b38e6883b83.jpg', 1),
(N'Đồng tiền vàng', N'Hoa đồng tiền vàng', 12000, 400, '/images/07fcf560-05f5-4829-b81a-d1c5881ba2cc.webp', 1),
(N'Đồng tiền đỏ', N'Hoa đồng tiền đỏ', 12000, 400, '/images/08243cc8-7393-4876-871b-bd9916bd3c40.webp', 1),
(N'Baby trắng', N'Hoa baby trắng', 10000, 500, '/images/0890debd-82c7-4c1c-b67e-4cc25885b9fb.webp', 1),
(N'Cẩm tú cầu xanh', N'Hoa cẩm tú cầu xanh', 40000, 120, '/images/08aa36ec-1ea5-4351-9b9f-9f68876ac09a.jpg', 1),
(N'Cẩm tú cầu hồng', N'Hoa cẩm tú cầu hồng', 40000, 120, '/images/08b5d6a9-f832-48ef-83f9-c77016055180.webp', 1);
GO

-- Link FlowerTypes with Suppliers
DECLARE @Supplier1 INT = (SELECT TOP 1 Id FROM Suppliers WHERE Name LIKE N'%Đà Lạt%');
DECLARE @Supplier2 INT = (SELECT TOP 1 Id FROM Suppliers WHERE Name LIKE N'%Sài Gòn%');
DECLARE @Supplier3 INT = (SELECT TOP 1 Id FROM Suppliers WHERE Name LIKE N'%Hà Lan%');

INSERT INTO FlowerTypeSuppliers (FlowerTypesId, SuppliersId)
SELECT ft.Id, @Supplier1 FROM FlowerTypes ft WHERE ft.Name LIKE N'%Hồng%' OR ft.Name LIKE N'%Cẩm chướng%';

INSERT INTO FlowerTypeSuppliers (FlowerTypesId, SuppliersId)
SELECT ft.Id, @Supplier2 FROM FlowerTypes ft WHERE ft.Name LIKE N'%Hướng dương%' OR ft.Name LIKE N'%Đồng tiền%';

INSERT INTO FlowerTypeSuppliers (FlowerTypesId, SuppliersId)
SELECT ft.Id, @Supplier3 FROM FlowerTypes ft WHERE ft.Name LIKE N'%Tulip%' OR ft.Name LIKE N'%Lan%';
GO

-- Insert Batches
DECLARE @Now DATETIME2 = GETDATE();
DECLARE @Supplier1 INT = (SELECT TOP 1 Id FROM Suppliers WHERE Name LIKE N'%Đà Lạt%');
DECLARE @Supplier2 INT = (SELECT TOP 1 Id FROM Suppliers WHERE Name LIKE N'%Sài Gòn%');

INSERT INTO Batches (BatchNumber, SupplierId, ImportDate, ExpiryDate, UnitPrice, TotalQuantity, RemainingQuantity, Notes) VALUES
('BATCH001', @Supplier1, @Now, DATEADD(DAY, 30, @Now), 15000, 500, 500, N'Lô hồng đỏ tháng 10'),
('BATCH002', @Supplier1, @Now, DATEADD(DAY, 30, @Now), 15000, 400, 400, N'Lô hồng hồng tháng 10'),
('BATCH003', @Supplier2, @Now, DATEADD(DAY, 20, @Now), 30000, 150, 150, N'Lô hướng dương tháng 10');
GO

-- Insert Products với Colors đúng format
DECLARE @Cat1 INT = (SELECT Id FROM Categories WHERE Name = N'Hoa tình yêu');
DECLARE @Cat2 INT = (SELECT Id FROM Categories WHERE Name = N'Hoa sinh nhật');
DECLARE @Cat3 INT = (SELECT Id FROM Categories WHERE Name = N'Hoa chúc mừng');
DECLARE @Style1 INT = (SELECT Id FROM PresentationStyles WHERE Name = N'Bó hoa');
DECLARE @Style2 INT = (SELECT Id FROM PresentationStyles WHERE Name = N'Giỏ hoa');
DECLARE @Style3 INT = (SELECT Id FROM PresentationStyles WHERE Name = N'Hộp hoa');

INSERT INTO Products (Name, Description, Price, CategoryId, PresentationStyleId, StockQuantity, ImageUrl, IsActive, IsFeatured, Colors, Occasions, Objects) VALUES
(N'Bó hồng đỏ 20 bông', N'Bó hoa hồng đỏ tươi 20 bông, tượng trưng cho tình yêu nồng cháy', 450000, @Cat1, @Style1, 50, '/images/08baca5b-6e5b-4e49-9d75-1a417f4c63ac.webp', 1, 1, '["Đỏ","Xanh lá"]', '["Tình yêu","Sinh nhật"]', '["Người yêu","Vợ"]'),
(N'Bó hồng hồng 12 bông', N'Bó hoa hồng màu hồng 12 bông, dịu dàng và lãng mạn', 320000, @Cat1, @Style1, 60, '/images/08be29ae-509c-4941-bb4e-17454e1c29bd.jpg', 1, 1, '["Hồng","Trắng"]', '["Tình yêu","Sinh nhật"]', '["Người yêu","Bạn gái"]'),
(N'Giỏ hoa sinh nhật rực rỡ', N'Giỏ hoa sinh nhật đa dạng màu sắc, tươi vui', 550000, @Cat2, @Style2, 30, '/images/090c736f-206d-4563-a0d4-d0330332df58.webp', 1, 1, '["Đỏ","Vàng","Hồng"]', '["Sinh nhật"]', '["Mẹ","Bạn bè"]'),
(N'Hộp hoa hồng trắng cao cấp', N'Hộp hoa hồng trắng 30 bông, sang trọng và tinh tế', 850000, @Cat1, @Style3, 20, '/images/09b3eb7d-bf4a-4ca9-a2c3-9092f3cfa5f9.webp', 1, 1, '["Trắng","Xanh lá"]', '["Tình yêu","Cưới"]', '["Người yêu","Vợ"]'),
(N'Bó hướng dương rực rỡ', N'Bó hoa hướng dương vàng 10 bông, tràn đầy năng lượng', 380000, @Cat2, @Style1, 40, '/images/0a84b6b3-461c-4a6b-b074-0c96962c2ece.webp', 1, 1, '["Vàng","Xanh lá"]', '["Sinh nhật","Chúc mừng"]', '["Bạn bè","Mẹ"]'),
(N'Giỏ hoa chúc mừng mix', N'Giỏ hoa chúc mừng kết hợp nhiều loại hoa đẹp', 680000, @Cat3, @Style2, 25, '/images/0acf55e3-0b77-42f8-8610-3fb44d27c322.webp', 1, 1, '["Đa màu"]', '["Chúc mừng","Khai trương"]', '["Đồng nghiệp","Bạn bè"]'),
(N'Bó ly trắng thanh khiết', N'Bó hoa ly trắng 10 bông, thanh khiết và sang trọng', 520000, @Cat1, @Style1, 35, '/images/0af70b71-cb8c-4bdc-b160-eafe54e54f12.jpg', 1, 1, '["Trắng","Xanh lá"]', '["Tình yêu","Cưới"]', '["Người yêu","Vợ"]'),
(N'Hộp hoa tulip nhập khẩu', N'Hộp hoa tulip Hà Lan cao cấp 20 bông', 950000, @Cat1, @Style3, 15, '/images/0b0a650c-14ab-4a92-af0a-e269fd1aa90e.webp', 1, 1, '["Đỏ","Hồng","Vàng"]', '["Tình yêu","Sinh nhật"]', '["Người yêu","Vợ"]'),
(N'Bó cẩm chướng ngọt ngào', N'Bó hoa cẩm chướng hồng 30 bông, dễ thương', 280000, @Cat2, @Style1, 70, '/images/0bca52c6-6965-4026-92d6-10112656be07.webp', 1, 0, '["Hồng","Trắng"]', '["Sinh nhật","Cảm ơn"]', '["Mẹ","Bạn bè"]'),
(N'Giỏ hoa lan hồ điệp', N'Giỏ hoa lan hồ điệp cao cấp, quý phái', 1200000, @Cat3, @Style2, 10, '/images/0c089dae-3c4d-42ad-9288-af84d8575e09.webp', 1, 1, '["Trắng","Tím"]', '["Chúc mừng","Khai trương"]', '["Sếp","Đồng nghiệp"]');
GO

-- Link Products with FlowerTypes
DECLARE @Product1 INT = (SELECT Id FROM Products WHERE Name = N'Bó hồng đỏ 20 bông');
DECLARE @Product2 INT = (SELECT Id FROM Products WHERE Name = N'Bó hồng hồng 12 bông');
DECLARE @FlowerType1 INT = (SELECT Id FROM FlowerTypes WHERE Name = N'Hồng đỏ');
DECLARE @FlowerType2 INT = (SELECT Id FROM FlowerTypes WHERE Name = N'Hồng hồng');

INSERT INTO FlowerTypeProducts (FlowerTypeId, ProductId, Quantity) VALUES
(@FlowerType1, @Product1, 20),
(@FlowerType2, @Product2, 12);
GO

-- Insert Sample Promotions
INSERT INTO Promotions (Code, Description, DiscountPercentage, MinimumOrderValue, MaximumDiscountValue, StartDate, EndDate, IsActive, UsageLimit, UsedCount) VALUES
(N'KHAI_TRUONG', N'Giảm 15% đơn hàng khai trương', 15, 500000, 200000, GETDATE(), DATEADD(MONTH, 1, GETDATE()), 1, 100, 0),
(N'VALENTINE2025', N'Giảm 20% nhân dịp Valentine', 20, 300000, 150000, GETDATE(), DATEADD(DAY, 14, GETDATE()), 1, 200, 0),
(N'SINH_NHAT', N'Giảm 10% hoa sinh nhật', 10, 200000, 100000, GETDATE(), DATEADD(MONTH, 3, GETDATE()), 1, 500, 0);
GO

PRINT 'Database created successfully with seed data!';
PRINT 'Admin account: admin@bloomie.com / Admin@123';
PRINT 'Total Categories: ' + CAST((SELECT COUNT(*) FROM Categories) AS VARCHAR);
PRINT 'Total Products: ' + CAST((SELECT COUNT(*) FROM Products) AS VARCHAR);
PRINT 'Total FlowerTypes: ' + CAST((SELECT COUNT(*) FROM FlowerTypes) AS VARCHAR);
GO
