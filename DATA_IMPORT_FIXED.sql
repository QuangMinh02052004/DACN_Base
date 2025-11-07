GO
USE [Bloomie]
GO

INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'3a81d572-5236-4247-911d-7fd4bf50a620', N'Editor', N'EDITOR', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'490de020-c11c-497a-b65b-bced6d420efb', N'User', N'USER', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'7f91d402-93c5-4a90-9119-12120e800197', N'Admin', N'ADMIN', NULL)
GO
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [RoleId], [Token], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', N'Administrator', N'7f91d402-93c5-4a90-9119-12120e800197', N'864ca607-f592-428a-979e-9491be3611a8', N'admin', N'ADMIN', N'admin@bloomie.com', N'ADMIN@BLOOMIE.COM', 0, N'AQAAAAIAAYagAAAAEAkr8+dXhz+2QjScJQGBF6f5DBTKLC46vgTkFj4y4Rk0AaIw1l9S+XAeYkCxutNSyw==', N'PYNCEMGKX4HG4PNA5EL4OQLR6MOJSQHI', N'7de913e7-c745-4ac8-a291-f0f56621d618', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [FullName], [RoleId], [Token], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', N'duykhoa852004', N'490de020-c11c-497a-b65b-bced6d420efb', N'fca6df51-b5c6-4e00-a4d5-4bfec3c071c7', N'duykhoa852004', N'DUYKHOA852004', N'duykhoa852004@gmail.com', N'DUYKHOA852004@GMAIL.COM', 0, N'AQAAAAIAAYagAAAAENcGXsIVeFMt5NxhzX3XnZ1W8tsv72270FqUWpMubCL1OPHBm5+mJB4VppT4vqYgfQ==', N'5SVKL6Y2TTSNTAHOY3F6SNJP43NG6E2D', N'8de3924a-a62a-48cc-a5b3-9fc3f34b8ed3', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', N'490de020-c11c-497a-b65b-bced6d420efb')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', N'7f91d402-93c5-4a90-9119-12120e800197')
GO
SET IDENTITY_INSERT [dbo].[Categories] ON
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (1, N'Chủ đề', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (2, N'Đối tượng', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (3, N'Kiểu dáng', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (4, N'Hoa tươi', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (5, N'Hoa cưới', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (6, N'Quà tặng', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (7, N'Bộ sưu tập', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (8, N'Sinh Nhật', 1, N'Hoa Chúc Mừng Sinh Nhật')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (9, N'Khai Trương', 1, N'Hoa Khai Trương')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (10, N'Chúc Mừng', 1, N'Hoa Chúc Mừng')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (11, N'Chia Buồn', 1, N'Hoa Chia Buồn')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (12, N'Cảm Ơn', 1, N'Món Quà Cảm Ơn')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (13, N'Lãng Mạn', 1, N'Hoa Yêu Thương')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (14, N'Ngày Kỉ Niệm', 1, N'Quà Kỷ Niệm')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (15, N'Tốt Nghiệp', 1, N'Hoa Tốt Nghiệp')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (16, N'Hoa Tặng Người Yêu', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (17, N'Hoa Tặng Bạn Bè', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (18, N'Hoa Tặng Vợ', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (19, N'Hoa Tặng Chồng', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (20, N'Hoa Tặng Mẹ', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (21, N'Hoa Tặng Trẻ Em', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (22, N'Hoa Tặng Cho Nữ', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (23, N'Hoa Tặng Cho Nam', 2, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (24, N'Bó Hoa Tươi', 3, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (25, N'Giỏ Hoa Tươi', 3, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (26, N'Hộp Hoa Tươi', 3, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (27, N'Lẵng Hoa Khai Trương', 3, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (28, N'Bình Hoa Tươi', 3, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (29, N'Lẵng Hoa Chia Buồn', 3, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (30, N'Hoa Hồng', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (31, N'Hoa Hướng Dương', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (32, N'Hoa Đồng Tiền', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (33, N'Lan Hồ Điệp', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (34, N'Cẩm Chướng', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (35, N'Hoa Cát Tường', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (36, N'Hoa Ly', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (37, N'Hoa Cúc', 4, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (38, N'Bánh Kem', 6, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (39, N'Chocolate', 6, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (40, N'Trái Cây', 6, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (41, N'Gấu Bông', 6, NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO

-- FIXED: Added BasePrice column (required NOT NULL field)
SET IDENTITY_INSERT [dbo].[PresentationStyles] ON
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (1, N'Bó hoa', 50000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (2, N'Giỏ hoa', 80000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (3, N'Hộp hoa', 70000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (4, N'Lẵng hoa', 100000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (5, N'Bình hoa', 60000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (6, N'Hoa bó cổ điển', 50000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (7, N'Hoa để bàn', 80000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (8, N'Giỏ hoa hiện đại', 80000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (9, N'Hộp hoa nghệ thuật', 70000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (10, N'Lẵng hoa mini', 100000.00)
SET IDENTITY_INSERT [dbo].[PresentationStyles] OFF
GO

-- FIXED: Added UnitPrice column (required NOT NULL field)
SET IDENTITY_INSERT [dbo].[FlowerTypes] ON
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (1, N'Hoa Hồng', 1080, 15000.00, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (2, N'Hoa Hướng Dương', 1883, 20000.00, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (3, N'Hoa Đồng Tiền', 137, 25000.00, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (4, N'Lan Hồ Điệp', 65, 50000.00, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (5, N'Cẩm Chướng', 762, 12000.00, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (6, N'Hoa Cát Tường', 69, 18000.00, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (7, N'Hoa Ly', 120, 30000.00, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (9, N'Hoa Cúc', 172, 10000.00, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [UnitPrice], [IsActive]) VALUES (10, N'Hoa Cẩm Tú Cầu', 182, 35000.00, 1)
SET IDENTITY_INSERT [dbo].[FlowerTypes] OFF
GO

SET IDENTITY_INSERT [dbo].[Suppliers] ON
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (1, N'Công ty TNHH Hoa Tươi Phú Quý', N'0901122334', N'phuquy.htflowers@gmail.com', N'88 Đường Nguyễn Văn Linh, Quận 7, TP. HCM', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (2, N'Nhà Vườn Hoa Lan Thanh Tú', N'0918456231', N'hoalan.thanhtu@yahoo.com', N'36 Đường Số 10, P. Linh Trung, Thủ Đức, TP. HCM', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (3, N'Nông trại Hoa Hồng Vàng', N'0944567890', N'hoahongvang.dalat@gmail.com', N'Thôn 2, Xã Tà Nung, Đà Lạt, Lâm Đồng', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (4, N'Công ty CP Hoa Tươi Hương Sắc Việt', N'0977788899', N'sales.huongsacviet@gmail.com', N'150 Đường Láng, Đống Đa, Hà Nội', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (5, N'Cửa Hàng Hoa Quỳnh Anh', N'0933344556', N'quynhanh.florist@gmail.com', N'25 Phan Chu Trinh, TP. Vinh, Nghệ An', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (6, N'Công ty TNHH Hoa Nhập Khẩu Eden', N'0966677888', N'contact.edenflowers@gmail.com', N'12 Lý Tự Trọng, Quận Hải Châu, Đà Nẵng', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (7, N'Nhà cung cấp Hoa Tươi Miền Bắc', N'0909988776', N'hoamienbac.co.ltd@gmail.com', N'89 Nguyễn Văn Cừ, Long Biên, Hà Nội', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (8, N'Công ty TNHH GreenFlorist', N'0988123456', N'greenflorist.vn@gmail.com', N'100 Trường Chinh, Q. Tân Bình, TP. HCM', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (9, N'Công ty TNHH Hoa Tươi Việt Phát', N'0923344556', N'vietphat.flowers.co@gmail.com', N'21 Hoàng Diệu, TP. Nha Trang, Khánh Hòa', 0)
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO

PRINT '✅ Import hoàn tất! Database đã có đầy đủ dữ liệu cơ bản.'
PRINT 'Bạn có thể thêm Products, Orders và dữ liệu khác sau.'
