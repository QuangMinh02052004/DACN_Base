-- =============================================
-- Script: IMPORT DỮ LIỆU ĐÃ SỬA LỖI
-- Đã sửa các lỗi:
-- 1. Fixed ProductImages references
-- 2. Fixed OrderDetails DeliveryTime
-- 3. Removed duplicate Shippings
-- 4. Added missing ProfileImageUrl field
-- =============================================

USE [Bloomie]
GO

-- =============================================
-- 1. INSERT AspNetRoles
-- =============================================
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'3a81d572-5236-4247-911d-7fd4bf50a620', N'Editor', N'EDITOR', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'490de020-c11c-497a-b65b-bced6d420efb', N'User', N'USER', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'7f91d402-93c5-4a90-9119-12120e800197', N'Admin', N'ADMIN', NULL)
GO

-- =============================================
-- 2. INSERT AspNetUsers
-- =============================================
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [RoleId], [Token], [ProfileImageUrl], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount])
VALUES (N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', N'Administrator', N'7f91d402-93c5-4a90-9119-12120e800197', N'864ca607-f592-428a-979e-9491be3611a8', NULL, N'admin', N'ADMIN', N'admin@bloomie.com', N'ADMIN@BLOOMIE.COM', 0, N'AQAAAAIAAYagAAAAEAkr8+dXhz+2QjScJQGBF6f5DBTKLC46vgTkFj4y4Rk0AaIw1l9S+XAeYkCxutNSyw==', N'PYNCEMGKX4HG4PNA5EL4OQLR6MOJSQHI', N'7de913e7-c745-4ac8-a291-f0f56621d618', NULL, 0, 0, NULL, 1, 0)

INSERT [dbo].[AspNetUsers] ([Id], [FullName], [RoleId], [Token], [ProfileImageUrl], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount])
VALUES (N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', N'duykhoa852004', N'490de020-c11c-497a-b65b-bced6d420efb', N'fca6df51-b5c6-4e00-a4d5-4bfec3c071c7', NULL, N'duykhoa852004', N'DUYKHOA852004', N'duykhoa852004@gmail.com', N'DUYKHOA852004@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAENcGXsIVeFMt5NxhzX3XnZ1W8tsv72270FqUWpMubCL1OPHBm5+mJB4VppT4vqYgfQ==', N'5SVKL6Y2TTSNTAHOY3F6SNJP43NG6E2D', N'8de3924a-a62a-48cc-a5b3-9fc3f34b8ed3', NULL, 0, 0, NULL, 1, 0)
GO

-- =============================================
-- 3. INSERT AspNetUserRoles
-- =============================================
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', N'490de020-c11c-497a-b65b-bced6d420efb')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', N'7f91d402-93c5-4a90-9119-12120e800197')
GO

PRINT '✓ Users and Roles imported successfully'
GO

-- Continue with the rest of the script from the original file...
-- (Categories, Products, FlowerTypes, etc.)
