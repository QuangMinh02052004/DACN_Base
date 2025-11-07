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
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (8, N'Sinh Nhật', 1, N'Hoa Chúc Mừng Sinh Nhật: Biểu Tượng của Sự Tươi Mát và Hạnh Phúc
Hoa chúc mừng sinh nhật không chỉ là một món quà đẹp mắt mà còn là biểu tượng của sự tươi mới và hạnh phúc trong ngày kỷ niệm đặc biệt. Tại cửa hàng hoa của chúng tôi, chúng tôi tự hào cung cấp những bó hoa chúc mừng sinh nhật tươi sáng và ý nghĩa, giúp bạn gửi đi những lời chúc tốt đẹp nhất đến người nhận.

Hoa Chúc Mừng Sinh Nhật: Sự Lựa Chọn Tốt Nhất Cho Một Ngày Đặc Biệt
Bó hoa chúc mừng sinh nhật không chỉ là một cách thể hiện sự quan tâm mà còn là dấu hiệu của sự tinh tế và tôn trọng. Mỗi bó hoa được sắp đặt với sự cẩn thận và kỹ lưỡng, mang lại niềm vui và sự bất ngờ cho người nhận trong ngày sinh nhật của họ.

Hoa Chúc Mừng Sinh Nhật: Sự Phong Phú và Đa Dạng của Sự Lựa Chọn
Với sự đa dạng về loại hoa và màu sắc, chúng tôi cam kết mang đến cho bạn những lựa chọn hoa chúc mừng sinh nhật phong phú và đa dạng. Từ những bó hoa lãng mạn và tinh tế đến những bó hoa sáng tạo và ấn tượng, chúng tôi sẽ giúp bạn tìm ra bó hoa hoàn hảo nhất để gửi đi những lời chúc chân thành nhất.

Hoa Chúc Mừng Sinh Nhật: Sự Hài Lòng Của Bạn Là Ưu Tiên Hàng Đầu
Chúng tôi luôn đặt sự hài lòng của bạn lên hàng đầu. Mỗi bó hoa của chúng tôi được chăm sóc và thiết kế với tình yêu và tâm huyết để đảm bảo rằng bạn sẽ nhận được sản phẩm tốt nhất và phục vụ tốt nhất từ chúng tôi.

Hoa Chúc Mừng Sinh Nhật: Đặt Hàng Ngay Hôm Nay để Tạo Ra Một Ngày Đặc Biệt Không Thể Quên
Hãy đặt hàng ngay hôm nay để gửi đi những lời chúc mừng sinh nhật chân thành nhất đến người thân yêu của bạn và tạo ra một ngày sinh nhật đáng nhớ không thể quên. Chúng tôi cam kết mang lại cho bạn trải nghiệm mua sắm hoa trực tuyến tuyệt vời nhất với sản phẩm chất lượng và dịch vụ chu đáo.')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (9, N'Khai Trương', 1, N'Hoa Khai Trương: Biểu Tượng của Sự Thành Công và Sự Mở Đầu Mới
Hoa khai trương không chỉ là một món quà đẹp mắt mà còn là biểu tượng của sự thành công và sự mở đầu mới trong kinh doanh. Tại cửa hàng hoa của chúng tôi, chúng tôi cung cấp những bó hoa khai trương độc đáo và ý nghĩa, giúp bạn truyền tải lời chúc mừng và hy vọng cho sự phát triển của doanh nghiệp mới.

Hoa Khai Trương Sự Chúc Phúc và Sự Thịnh Vượng
Bó hoa khai trương không chỉ mang lại sự chúc phúc mà còn là biểu tượng của sự thịnh vượng và thành công trong tương lai. Chúng tôi tin rằng mỗi bó hoa được trao đi sẽ mang lại niềm vui và may mắn cho người nhận, đồng thời tạo ra một bước khởi đầu tốt đẹp cho doanh nghiệp mới.

Hoa Khai Trương Sự Tôn Vinh và Sự Kiêng Nể
Bằng cách tặng một bó hoa khai trương, bạn không chỉ tôn vinh mà còn kiêng nể sự cố gắng và sự quyết tâm của người nhận trong việc khởi nghiệp. Chúng tôi cam kết mang đến những sản phẩm chất lượng nhất, giúp bạn truyền đạt lời chúc mừng và sự tôn trọng đến người nhận.

Hoa Khai Trương Sự Kỳ Vọng và Sự Thành Công
Mỗi bó hoa khai trương đều chứa đựng sự kỳ vọng và sự chúc mừng cho một tương lai đầy thành công và phát triển. Chúng tôi hy vọng rằng mỗi món quà sẽ góp phần tạo ra một bước đi quan trọng và mang lại nhiều cơ hội mới cho doanh nghiệp của người nhận.

Hoa Khai Trương Sự Mừng Mỡ và Sự Gắn Kết
Khi tặng một bó hoa khai trương, bạn không chỉ mừng một sự kiện quan trọng mà còn thể hiện sự gắn kết và sự đồng lòng với người nhận. Chúng tôi mong muốn rằng mỗi bó hoa sẽ mang lại nhiều niềm vui và sự hạnh phúc cho người mà bạn gửi đi lời chúc mừng.

Hoa Khai Trương Sự Chăm Sóc và Sự Động Viên
Hãy đặt hàng ngay hôm nay để gửi đi những lời chúc mừng và sự động viên đến doanh nghiệp mới của bạn hoặc người thân yêu. Chúng tôi cam kết mang đến cho bạn những bó hoa khai trương tươi mới và ý nghĩa nhất, giúp bạn bày tỏ sự chăm sóc và sự ủng hộ đến những người đang bắt đầu một hành trình mới.')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (10, N'Chúc Mừng', 1, N'Hoa Chúc Mừng: Thông Điệp Ngọt Ngào Của Niềm Vui Và Thành Công
Hoa chúc mừng không chỉ là một món quà mang vẻ đẹp rực rỡ mà còn là biểu tượng của những lời chúc tốt đẹp, sự quan tâm và sẻ chia niềm vui trong những khoảnh khắc đáng nhớ. Dù là chúc mừng khai trương, tốt nghiệp, thăng chức hay một cột mốc quan trọng trong cuộc sống, những bó hoa chúc mừng luôn là lựa chọn hoàn hảo để thể hiện tình cảm chân thành.

Hoa Chúc Mừng: Sự Lựa Chọn Ý Nghĩa Cho Mọi Dịp Đặc Biệt
Mỗi dịp chúc mừng đều mang một ý nghĩa riêng và những bó hoa được thiết kế tinh tế sẽ giúp bạn truyền tải những lời chúc mừng một cách trang trọng và cảm động nhất. Hoa chúc mừng không chỉ thể hiện sự tôn trọng, mà còn là lời động viên, khích lệ và đồng hành cùng người nhận trên hành trình thành công.

Hoa Chúc Mừng: Sự Đa Dạng Trong Mỗi Sắc Hoa
Chúng tôi cung cấp nhiều kiểu dáng và màu sắc hoa chúc mừng phù hợp với từng dịp và từng đối tượng. Từ những bó hoa trang trọng cho đối tác, đồng nghiệp đến những thiết kế tươi trẻ, rực rỡ cho bạn bè và người thân – tất cả đều được sắp xếp tỉ mỉ, mang lại sự ấn tượng và cảm xúc khó quên cho người nhận.

Hoa Chúc Mừng: Dịch Vụ Tận Tâm, Chất Lượng Vượt Trội
Chúng tôi hiểu rằng mỗi bó hoa bạn gửi đi đều chứa đựng một câu chuyện và cảm xúc đặc biệt. Vì vậy, đội ngũ nghệ nhân cắm hoa chuyên nghiệp của chúng tôi luôn chăm chút từng chi tiết, đảm bảo mỗi sản phẩm đều hoàn hảo cả về hình thức lẫn ý nghĩa.

Hoa Chúc Mừng: Đặt Hàng Dễ Dàng – Gửi Gắm Niềm Vui Đến Người Thân Yêu
Hãy để chúng tôi thay bạn gửi những lời chúc mừng ngọt ngào và chân thành qua những bó hoa tuyệt đẹp. Đặt hàng hoa chúc mừng ngay hôm nay để mang đến niềm vui bất ngờ cho người thân, bạn bè hoặc đối tác. Chúng tôi cam kết mang đến cho bạn trải nghiệm mua sắm hoa trực tuyến dễ dàng, nhanh chóng và đầy cảm xúc.')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (11, N'Chia Buồn', 1, N'Hoa Chia Buồn: Biểu Tượng của Sự An Ủi và Sự Đồng Cảm
Hoa chia buồn không chỉ đơn giản là một món quà mà còn là biểu tượng của sự an ủi và sự đồng cảm với người mất. Tại cửa hàng hoa của chúng tôi, chúng tôi cung cấp những bó hoa chia buồn ý nghĩa và đẹp mắt, giúp bạn truyền đạt lời chia buồn sâu sắc và chân thành nhất.

Hoa Chia Buồn Sự Chia Sẻ và Sự Động Viên
Bằng cách tặng một bó hoa chia buồn, bạn không chỉ chia sẻ nỗi đau và nỗi buồn với gia đình và bạn bè của người mất mà còn thể hiện sự động viên và ủng hộ trong thời gian khó khăn. Chúng tôi cam kết mang đến những sản phẩm chất lượng nhất, giúp bạn bày tỏ sự chân thành và sự đồng cảm đến những người trong nỗi đau.

Hoa Chia Buồn Sự Tôn Trọng và Sự Tri Ân
Mỗi bó hoa chia buồn đều chứa đựng sự tôn trọng và sự tri ân đối với người đã ra đi. Chúng tôi tin rằng mỗi món quà sẽ mang lại sự an ủi và sự chia sẻ cho gia đình và bạn bè trong thời gian đau buồn.

Hoa Chia Buồn - Sự Ấm Áp và Sự Hiểu Biết
Khi gửi đi một bó hoa chia buồn, bạn không chỉ mang lại sự ấm áp mà còn thể hiện sự hiểu biết và sự gần gũi với nỗi đau của người nhận. Chúng tôi mong muốn rằng mỗi bó hoa sẽ mang lại sự an lòng và sự yên bình trong những khoảnh khắc khó khăn.

Hoa Chia Buồn - Sự Thương Xót và Sự Hy Vọng
Mỗi bó hoa chia buồn là một lời thể hiện sự thương xót và sự hy vọng vào một tương lai tốt đẹp hơn. Chúng tôi hy vọng rằng mỗi bó hoa sẽ giúp gia đình và bạn bè vượt qua nỗi đau mất mát và tìm thấy sự bình yên và hy vọng trong trái tim.

Hoa Chia Buồn - Sự Cảm Ơn và Sự Kính Trọng
Hãy đặt hàng ngay hôm nay để gửi đi những lời chia buồn sâu sắc và ý nghĩa đến gia đình và bạn bè. Chúng tôi cam kết mang đến cho bạn những bó hoa chia buồn tươi mới và ý nghĩa nhất, giúp bạn bày tỏ sự cảm ơn và sự kính trọng đến những người đã ra đi.')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (12, N'Cảm Ơn', 1, N'Món Quà để Nói Lời Cảm Ơn: Biểu Tượng của Sự Tri Ân và Sự Quan Tâm
Món quà để nói lời cảm ơn không chỉ là một vật phẩm đơn giản mà còn là biểu tượng của sự tri ân và sự quan tâm đến người nhận. Tại cửa hàng quà tặng của chúng tôi, chúng tôi tự hào mang đến những lựa chọn đa dạng và ý nghĩa, giúp bạn bày tỏ lòng biết ơn một cách đặc biệt và tinh tế.

Món Quà để Nói Lời Cảm Ơn: Sự Lựa Chọn Tốt Nhất Cho Một Biểu Hiện Sâu Sắc của Tình Cảm
Món quà để nói lời cảm ơn là một cách tuyệt vời để thể hiện sự quý trọng và lòng biết ơn đối với người khác. Chúng tôi tin rằng mỗi món quà được lựa chọn với tâm huyết sẽ mang lại niềm vui và hạnh phúc cho người nhận.

Món Quà để Nói Lời Cảm Ơn: Sự Tôn Vinh và Sự Chăm Sóc
Món quà để nói lời cảm ơn không chỉ là biểu hiện của sự tôn vinh mà còn là sự chăm sóc và quan tâm đến người nhận. Chúng tôi mong muốn rằng mỗi món quà sẽ mang lại sự ấm áp và niềm vui cho người mà bạn muốn gửi đi lời cảm ơn.

Món Quà để Nói Lời Cảm Ơn: Sự Tình Cảm và Sự Ý Nghĩa
Mỗi món quà được trao đi không chỉ là một vật phẩm mà còn là một cách tuyệt vời để thể hiện sự tình cảm và ý nghĩa của bạn dành cho người nhận. Chúng tôi cam kết mang đến những món quà ý nghĩa và độc đáo, giúp bạn bày tỏ tình cảm một cách đặc biệt và chân thành.

Món Quà để Nói Lời Cảm Ơn: Sự Chúc Mừng và Sự Trân Trọng
Món quà để nói lời cảm ơn là một lời chúc mừng và sự trân trọng đối với những đóng góp và hỗ trợ của người khác trong cuộc sống của bạn. Hãy để chúng tôi giúp bạn chọn ra một món quà đặc biệt và ý nghĩa nhất để bày tỏ lòng biết ơn của bạn một cách đầy ý nghĩa.')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (13, N'Lãng Mạn', 1, N'Hoa Yêu Thương Biểu Tượng của Tình Cảm và Sự Quan Tâm
Hoa yêu thương không chỉ là một món quà đẹp mắt mà còn là biểu tượng của tình cảm và sự quan tâm đối với người nhận. Tại cửa hàng hoa của chúng tôi, chúng tôi tự hào cung cấp những bó hoa yêu thương tươi mới và ý nghĩa, giúp bạn truyền đi những thông điệp yêu thương đặc biệt.

Hoa Yêu Thương, Sự Lựa Chọn Tốt Nhất Cho Một Dịp Đặc Biệt
Bó hoa yêu thương không chỉ là một cách thể hiện tình cảm mà còn là dấu hiệu của sự quan tâm và biểu lộ tình yêu. Mỗi bó hoa được chọn lựa với sự cẩn thận và tâm huyết, mang lại niềm vui và hạnh phúc không ngờ cho người nhận trong mọi dịp đặc biệt.

Hoa Yêu Thương, Sự Phong Phú và Đa Dạng của Sự Lựa Chọn
Với sự đa dạng về loại hoa và màu sắc, chúng tôi cam kết mang đến cho bạn những lựa chọn hoa yêu thương phong phú và đa dạng. Từ những bó hoa lãng mạn và tinh tế đến những bó hoa sáng tạo và ấn tượng, chúng tôi sẽ giúp bạn tìm ra bó hoa hoàn hảo nhất để truyền đi tình yêu thương của bạn.

Hoa Yêu Thương, Sự Hài Lòng Của Bạn Là Ưu Tiên Hàng Đầu
Chúng tôi luôn đặt sự hài lòng của bạn lên hàng đầu. Mỗi bó hoa của chúng tôi được chăm sóc và thiết kế với tình yêu và tâm huyết để đảm bảo rằng bạn sẽ nhận được sản phẩm tốt nhất và dịch vụ tốt nhất từ chúng tôi.

Hoa Yêu Thương, Đặt Hàng Ngay Hôm Nay để Tạo Ra Một Dịp Đặc Biệt Không Thể Quên
Hãy đặt hàng ngay hôm nay để truyền đi những thông điệp yêu thương đặc biệt và tạo ra một dịp đặc biệt không thể quên. Chúng tôi cam kết mang lại cho bạn trải nghiệm mua sắm hoa trực tuyến tuyệt vời nhất với sản phẩm chất lượng và dịch vụ chu đáo.')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (14, N'Ngày Kỉ Niệm', 1, N'Quà Kỷ Niệm Ngày Cưới Biểu Tượng của Tình Yêu và Sự Gắn Kết
Quà kỷ niệm ngày cưới không chỉ là một món quà đơn giản mà còn là biểu tượng của tình yêu và sự gắn kết giữa hai người. Tại cửa hàng quà tặng của chúng tôi, chúng tôi tự hào cung cấp những sản phẩm kỷ niệm ngày cưới độc đáo và ý nghĩa, giúp bạn thể hiện tình cảm và sự quan tâm đặc biệt đối với bạn đời.

Quà Kỷ Niệm Ngày Cưới Sự Lựa Chọn Tốt Nhất Cho Một Ngày Đặc Biệt
Quà kỷ niệm ngày cưới không chỉ là cách thể hiện sự quan tâm mà còn là dấu hiệu của sự tinh tế và biểu lộ tình cảm. Mỗi sản phẩm được lựa chọn với sự cẩn thận và tâm huyết, mang lại niềm vui và hạnh phúc không ngờ cho người nhận trong ngày kỷ niệm đặc biệt của họ.

Quà Kỷ Niệm Ngày Cưới Sự Phong Phú và Đa Dạng của Sự Lựa Chọn
Với sự đa dạng về loại sản phẩm và phong cách, chúng tôi cam kết mang đến cho bạn những lựa chọn quà kỷ niệm ngày cưới phong phú và đa dạng. Từ những món quà lãng mạn và thú vị đến những món quà sáng tạo và độc đáo, chúng tôi sẽ giúp bạn tìm ra sản phẩm phản ánh tốt nhất về tình cảm của bạn đối với bạn đời.

Quà Kỷ Niệm Ngày Cưới Sự Hài Lòng Của Bạn Là Ưu Tiên Hàng Đầu
Chúng tôi luôn đặt sự hài lòng của bạn lên hàng đầu. Tất cả các sản phẩm và dịch vụ của chúng tôi được thiết kế để đáp ứng và vượt qua kỳ vọng của bạn, từ chất lượng sản phẩm cho đến dịch vụ hỗ trợ sau bán hàng. Hãy để chúng tôi giúp bạn tạo ra những kỷ niệm đẹp và ý nghĩa trong ngày kỷ niệm ngày cưới của bạn.

Quà Kỷ Niệm Ngày Cưới Sự Tư Vấn và Hỗ Trợ Chuyên Nghiệp
Nếu bạn cần sự tư vấn hoặc hỗ trợ trong việc chọn quà kỷ niệm ngày cưới, đừng ngần ngại liên hệ với chúng tôi. Đội ngũ nhân viên tận tâm và chuyên nghiệp của chúng tôi sẽ luôn sẵn lòng hỗ trợ bạn để bạn có thể chọn được một sản phẩm hoàn hảo và ý nghĩa nhất.

Quà Kỷ Niệm Ngày Cưới Đặt Hàng Ngay Hôm Nay để Tạo Ra Một Ngày Đặc Biệt Không Thể Quên
Đừng để bất kỳ kỷ niệm nào trôi qua mà không có một món quà ý nghĩa. Hãy đặt hàng ngay hôm nay để tạo ra một ngày kỷ niệm ngày cưới không thể quên và để bạn đời của bạn biết rằng bạn luôn quan tâm và trân trọng mối quan hệ của bạn.')
INSERT [dbo].[Categories] ([Id], [Name], [ParentCategoryId], [Description]) VALUES (15, N'Tốt Nghiệp', 1, N'Hoa Tốt Nghiệp Biểu Tượng của Sự Hoàn Thành và Bắt Đầu Mới
Hoa tốt nghiệp không chỉ là một bó hoa đơn giản mà còn là biểu tượng của sự hoàn thành và sự bắt đầu mới trong cuộc sống. Đây là một dịp để tôn vinh những nỗ lực và thành tựu của những người đã hoàn thành một phần quan trọng trong hành trình học tập của mình. Tại cửa hàng hoa của chúng tôi, chúng tôi mang đến những bó hoa tốt nghiệp tươi mới và ý nghĩa, giúp gửi đi lời chúc mừng và hy vọng cho tương lai của những người tốt nghiệp.

Hoa Tốt Nghiệp Dấu Hiệu của Thành Công và Sự Tiếp Theo
Hoa tốt nghiệp không chỉ là một biểu tượng của sự thành công mà còn là dấu hiệu của sự tiếp tục phát triển và tiến bộ trong cuộc sống. Đây là thời điểm để nhìn lại những bước tiến và chuẩn bị cho những thách thức mới phía trước. Với mỗi bó hoa được chọn lựa kỹ càng, chúng tôi muốn gửi đi lời chúc mừng và sự khích lệ đến những người đã vượt qua thử thách và sẵn sàng đối mặt với những cơ hội mới.

Hoa Tốt Nghiệp Sự Tôn Vinh và Sự Tiếp Nối
Hoa tốt nghiệp là biểu tượng của sự tôn vinh và sự tiếp nối, kỷ niệm một giai đoạn quan trọng trong cuộc đời của mỗi người. Đây là dịp để cảm ơn những người thầy cô, bạn bè và gia đình đã ủng hộ và khích lệ trong suốt quá trình học tập. Chúng tôi mong muốn rằng mỗi bó hoa tốt nghiệp sẽ truyền đi thông điệp của sự biết ơn và lòng tri ân.

Hoa Tốt Nghiệp Lời Chúc Mừng và Sự Khích Lệ
Khi một người tốt nghiệp, đó không chỉ là một thành tựu cá nhân mà còn là niềm vui và hạnh phúc của gia đình và bạn bè. Mỗi bó hoa tốt nghiệp được gửi đi với những lời chúc mừng và sự khích lệ, gửi đi lòng tin và hy vọng vào tương lai sáng sủa và thành công.

Hoa Tốt Nghiệp Bước Đi Mới với Hy Vọng và Hi vọng Tươi Sáng
Hoa tốt nghiệp đánh dấu bước đi mới trong cuộc đời, với hy vọng và hi vọng tươi sáng cho một tương lai thành công. Đây là lúc để nhìn nhận những thành tựu đã đạt được và sẵn sàng đón nhận những thách thức mới. Chúng tôi hy vọng rằng mỗi bó hoa tốt nghiệp sẽ là nguồn động viên và động lực để tiếp tục phấn đấu và thành công trong những bước tiếp theo của cuộc đời.')
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
SET IDENTITY_INSERT [dbo].[PresentationStyles] ON 

INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (1, N'Bó hoa', 50000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (2, N'Giỏ hoa', 80000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (3, N'Hộp hoa', 70000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (4, N'Lẵng hoa', 100000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (5, N'Bình hoa', 90000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (6, N'Hoa bó cổ điển', 50000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (7, N'Hoa để bàn', 80000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (8, N'Giỏ hoa hiện đại', 80000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (9, N'Hộp hoa nghệ thuật', 70000.00)
INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES (10, N'Lẵng hoa mini', 100000.00)
SET IDENTITY_INSERT [dbo].[PresentationStyles] OFF
GO

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
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (6, N'Công ty TNHH Hoa Nhập Khẩu Eden', N'0966677888', N'contact.edenflowers@gmail.com', N'12 Lý Tự Trọng, Quận Hải Châu, Đà Nẵng', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (7, N'Nhà cung cấp Hoa Tươi Miền Bắc', N'0909988776', N'hoamienbac.co.ltd@gmail.com', N'89 Nguyễn Văn Cừ, Long Biên, Hà Nội', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (8, N'Công ty TNHH GreenFlorist', N'0988123456', N'greenflorist.vn@gmail.com', N'100 Trường Chinh, Q. Tân Bình, TP. HCM', 1)
INSERT [dbo].[Suppliers] ([Id], [Name], [Phone], [Email], [Address], [IsActive]) VALUES (9, N'Công ty TNHH Hoa Tươi Việt Phát', N'0923344556', N'vietphat.flowers.co@gmail.com', N'21 Hoàng Diệu, TP. Nha Trang, Khánh Hòa', 0)
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (1, N'Nụ Cười Em', N'Bó hoa cực kỳ xinh xắn và trong trẻo được gói từ những cành hoa hồng song hỷ, hoa đồng tiền cùng điểm thêm chút tinh khôi từ hoa baby trắng chắc chắn sẽ là món quà tuyệt vời cho mọi dịp!
Bó Hoa Nụ Cười Em (Cơ Bản) gồm: - 5 Bông Hồng Song Hỷ.- 4 Bông Hoa Đồng Tiền.- Hoa Baby.- Hoa Sao Tím.- Hoa và lá trang trí khác.
Bó Hoa Nụ Cười Em (Nâng Cấp) gồm:- 8 Bông Hồng Song Hỷ.- 6 Bông Hoa Đồng Tiền.- Hoa Baby.- Hoa Sao Tím.- Hoa và lá trang trí khác.', CAST(699000.00 AS Decimal(18, 2)), N'/images/85ae2550-16fd-4a8c-8ae9-31eb56a3020c.webp', 5, 0, 5, 0, CAST(N'2025-05-23T01:07:14.5565301' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (2, N'Forever 18 (18 bông hồng)', N'Bó hoa Hồng đỏ đầy lãng mạn là món quà hoàn hảo thay lời muốn nói gửi đến người thương của bạn vào Valentine hoặc ngày kỷ niệm, sinh nhật.
Bó Hoa Hồng Forever 18 - Cơ Bản gồm:
- 18 cành Hoa Hồng.
- Các loại Hoa và Lá khác.
Bó Hoa Hồng Forever 18 - Nâng Cấp gồm:
- 24 cành Hoa Hồng.
- Các loại Hoa và Lá khác.', CAST(599000.00 AS Decimal(18, 2)), N'/images/d7b29ae3-629c-4fd6-9f41-6a4de9f70e66.webp', 5, 0, 5, 0, CAST(N'2025-05-23T01:10:28.8768590' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (3, N'La Vie En Rose', N'Bó hoa mang gam màu pastel nhẹ nhàng đầy trang nhã và duyên dáng với sự kết hợp của hai loại hoa hồng.  Đây sẽ là món quà bất ngờ và hoàn hảo dành tặng người thương, gia đình hoặc bạn bè.
Bó Hoa Hồng La Vie En Rose (Cơ Bản) gồm:
- 20 bông Hoa Hồng.
- Các loại Hoa và Lá khác.
Bó Hoa Hồng La Vie En Rose (Nâng Cấp) gồm:
- 30 bông Hoa Hồng.
- Các loại Hoa và Lá khác.', CAST(729000.00 AS Decimal(18, 2)), N'/images/08b5d6a9-f832-48ef-83f9-c77016055180.webp', 5, 0, 5, 0, CAST(N'2025-05-23T01:13:02.7035927' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (4, N'Dreamcatcher', N'Bó hoa baby hồng dịu dàng sẽ là món quà đầy ý nghĩa dành tặng người thương.
Bó hoa Dreamcatcher (Cơ Bản) gồm:
- Hoa Baby xịt hồng.
Bó hoa Dreamcatcher (Nâng Cấp) gồm:
- Hoa Baby xịt hồng.
- Giấy gói vải tweed.', CAST(499000.00 AS Decimal(18, 2)), N'/images/125c4fed-c0c9-4925-8c47-3e518064922f.webp', 5, 0, 5, 0, CAST(N'2025-05-23T01:15:18.7729131' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (5, N'Đại dương', N'Oceanic - những đóa hoa hồng mang màu biển cả, đong đầy tình yêu thương, gửi gắm đến người yêu thương của bạn!
Bó Hoa Oceanic (Cơ Bản) gồm:
- 15 Bông Hoa Hồng.
- Các loại hoa và lá trang trí khác.
Bó Hoa Oceanic (Nâng Cấp) gồm:
- 22 Bông Hoa Hồng.
- Các loại hoa và lá trang trí khác.', CAST(699000.00 AS Decimal(18, 2)), N'/images/d4c2c124-0c90-4ff4-b53e-0bd8db3040f4.webp', 5, 0, 5, 0, CAST(N'2025-05-23T01:17:23.6001307' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (6, N'Fly Me To The Moon', N'Bó hoa Hồng với gam màu nhã nhặn, thanh lịch và đầy nữ tính sẽ là món quà bất ngờ và hoàn hảo dành tặng người thương, gia đình hoặc bạn bè. 
Bó Hoa Fly Me To The Moon (Cơ Bản) gồm:
- 20 bông Hoa Hồng.
- Các loại Hoa và Lá khác.
Bó Hoa Fly Me To The Moon (Nâng Cấp) gồm:
- 24 Bông Hoa Hồng.
- Hoa Cúc Tana.
- Các loại hoa & lá khác.', CAST(699000.00 AS Decimal(18, 2)), N'/images/e236e5c4-9d8e-41ad-b88c-6d3eda1a3bd6.webp', 5, 0, 5, 0, CAST(N'2025-05-23T01:19:57.3528557' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (7, N'Ngại Ngùng', N'Bó hoa Ngại Ngùng với tone hồng nhẹ nhàng chắc chắn sẽ mang lại niềm vui và sự hạnh phúc cho người nhận, đồng thời tạo nên dấu ấn trong những ngày đặc biệt. Đừng ngần ngại bảy tỏ tình cảm của mình qua món quà dễ thương này bạn nhé!
Bó hoa Ngại Ngùng gồm:
- 18 bông hoa đồng tiền.', CAST(769000.00 AS Decimal(18, 2)), N'/images/029f5bc6-2e29-4d9b-8961-5729e776d003.webp', 5, 0, 5, 0, CAST(N'2025-05-23T01:23:08.0705017' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (8, N'Bubblegum', N'Bó hoa Bubblegum với tone trắng kem mix hồng cam nhẹ nhàng chắc chắn sẽ mang lại niềm vui và sự hạnh phúc cho người nhận, đồng thời tạo nên dấu ấn trong những ngày đặc biệt. Đừng ngần ngại bảy tỏ tình cảm của mình qua món quà dễ thương này bạn nhé!
Bó hoa Bubblegum (Cơ Bản) gồm:
- 3 Cành Hoa Hồng Kem.
- 1 Cành Cát Tường Trắng.
- 1 Cành Cát Tường Hột Gà.
- 2 Cành Cẩm Chướng Đơn Hồng.
- 2 Cành Đồng Tiền Hột Gà.
Bó hoa Bubblegum (Nâng Cấp) gồm:
- 4 Cành Hoa Hồng Kem.
- 3 Cành Cát Tường.
- 3 Cành Cẩm Chướng Đơn Hồng.
- 3 Cành Đồng Tiền Hột Gà.', CAST(699000.00 AS Decimal(18, 2)), N'/images/8c16759d-8260-4f73-bf28-82ae5718cd78.webp', 5, 0, 5, 0, CAST(N'2025-05-23T12:11:19.0458635' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (9, N'Fall For You', N'Bó hoa Hồng đỏ đầy lãng mạn là món quà hoàn hảo thay lời muốn nói gửi đến người thương của bạn vào Valentine hoặc ngày kỷ niệm, sinh nhật.
Bó Hoa Hồng Fall For You (Cơ Bản) gồm:
- 24 cành Hoa Hồng.
- Các loại Hoa và Lá khác.
Bó Hoa Hồng Fall For You (Nâng Cấp) gồm:
- 30 cành Hoa Hồng.
- Các loại Hoa và Lá khác.', CAST(699000.00 AS Decimal(18, 2)), N'/images/6b0e4003-e8e4-4a80-9d6c-52fb9f3e3cb1.webp', 2, 0, 5, 0, CAST(N'2025-05-23T12:18:32.4648229' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (10, N'Summer Delight', N'Sắc cam rực rỡ của những cành hoa hồng David mang lại nguồn năng lượng tích cực và sôi nổi như mùa hè. Cùng lan tỏa nguồn năng lượng thêm yêu đời này đến những người thân yêu trong dịp sinh nhật, chúc mừng,.... với bó hoa Summer Delight này nha!
Bó Hoa Summer Delight (Cơ Bản) gồm:
- 12 Bông Hoa Hồng Cam Spirit.
- Các loại Hoa và Lá khác.
Bó Hoa Summer Delight (Nâng Cấp) gồm:
- 14 Bông Hoa Hồng Cam Spirit.
- Cẩm chướng chùm hồng.
- Các loại hoa và lá trang trí khác.', CAST(749000.00 AS Decimal(18, 2)), N'/images/97c52f73-2497-4367-bb6e-3a8c87961e97.webp', 5, 0, 5, 0, CAST(N'2025-05-23T12:20:39.6492105' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (11, N'Hẹn Thương', N'Nhắn gửi những lời hẹn ước ngọt ngào tới người mình thương với bó hoa hồng siêu lung linh dịu dàng này bạn nha!
Bó Hoa Hẹn Thương - Cơ Bản gồm:
- 10 Bông Hồng David Austin Rose/ Hồng Cam London/ hoặc Hồng Cam Spirit.
- 8 Bông Hồng Kem.
- Hoa và lá trang trí khác.
Bó Hoa Hẹn Thương - Nâng Cấp gồm:
- 20 Bông Hồng David Austin Rose/ Hồng Cam London/ hoặc Hồng Cam Spirit.
- Hoa và lá trang trí khác.', CAST(899000.00 AS Decimal(18, 2)), N'/images/cc11c0bc-0d96-4797-9c46-7808413b24b1.webp', 5, 0, 5, 0, CAST(N'2025-05-23T12:23:00.8588329' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (12, N'Combo Missing You', N'Gửi người thương Combo Missing You thay cho lời yêu thương nhớ!
Combo Missing You gồm:
- Bó Hoa Bán chạy nhất Carla.
- Gấu Bông Đáng Yêu (màu áo ngẫu nhiên).', CAST(1229000.00 AS Decimal(18, 2)), N'/images/587d2f53-e661-41b2-93a2-a906c999d09d.jpg', 5, 0, 5, 0, CAST(N'2025-05-23T12:24:35.7174664' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (13, N'Bó Hoa Rouge Heart', N'Bó Hoa Rouge Heart không chỉ là một món quà tuyệt vời mà còn là biểu tượng của tình yêu và sự quý phái. Những bông hoa được tạo nên với sự chăm sóc tỉ mỉ, từng chi tiết nhỏ đều được làm tỉa tót và sắc nét. Màu sắc rực rỡ, cuốn hút tạo nên vẻ đẹp sang trọng. Bó hoa sáp này không chỉ là một lựa chọn hoàn hảo cho các dịp lễ, kỷ niệm, mà còn làm tăng thêm vẻ đẹp cho không gian sống và làm việc của bạn.
Thông tin Bó Hoa Rouge Heart (36 bông) bao gồm:
- 36-37 bông nhũ đỏ lưới trắng/ đen.
Thông tin Bó Hoa Rouge Heart (50 bông) bao gồm:
- 50 bông nhũ đỏ lưới trắng/ đen.', CAST(999000.00 AS Decimal(18, 2)), N'/images/3d42b123-cdf8-4dab-b217-3ffacfee6983.webp', 2, 0, 5, 0, CAST(N'2025-05-23T12:26:42.0268090' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (14, N'Chớm Nở', N'Hoa hồng kem là biểu tượng của tình yêu và sự đẹp đẽ. Nó có màu sắc chủ yếu là kem hoặc trắng nhạt, tạo nên vẻ đẹp tinh khôi và thanh lịch. Loại hoa này thường được sử dụng trong các dịp lãng mạn như ngày Valentine, kỷ niệm hôn nhân và các dịp quan trọng khác để biểu thị tình yêu, sự trân trọng và sự tôn vinh.
Bó Hoa Hồng Chớm Nở (Cơ Bản) gồm:
- 22 bông Hoa Hồng kem.
- Các loại hoa & lá khác.
Bó Hoa Hồng Chớm Nở (Nâng Cấp) gồm:
- 30 bông Hoa Hồng kem.
- Các loại hoa & lá khác.', CAST(999000.00 AS Decimal(18, 2)), N'/images/55ce9cb8-1af7-474d-9bdd-84caf5c85199.webp', 2, 0, 5, 0, CAST(N'2025-05-23T12:28:47.2158495' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (15, N'Mia', N'Ôm một bó hoa nhỏ, mình muốn ngỏ lời yêu! Còn gì ngọt ngào và đáng yêu hơn một bó hoa được tô điểm từ những cành hồng pastel kết hợp với hồng trắng tinh khôi dành tặng những người thân yêu.
Bó Hoa Mia (Cơ Bản) gồm:
- 12 Bông Hồng Kem.
- 12 Bông Hồng Trắng.
- Hoa Bibi.
- Các loại hoa và lá trang trí khác.
Bó Hoa Mia (Nâng Cấp) gồm:
- 15 Bông Hồng Kem.
- 15 Bông Hồng Trắng.
- Hoa Bibi.
- Các loại hoa và lá trang trí khác.', CAST(799000.00 AS Decimal(18, 2)), N'/images/2cad3221-f1c8-465c-b230-1e2bb078f3a5.jpg', 2, 0, 5, 0, CAST(N'2025-05-23T12:31:28.9431254' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (16, N'Day Dreamer ', N'Bó hoa nhẹ nhàng, mơ mộng với chất liệu chính là Cẩm Tú Cầu, điểm thêm vài nhánh Cúc Mắt Nai xinh xắn. Day Dreamer là lựa chọn hoàn hảo cho ngày Valentine hoặc bất kỳ dịp đặc biệt nào.
Bó Hoa Day Dreamer Cơ Bản gồm:
- 5 bông Cẩm Tú Cầu.
- 3 cành bông Cúc.
Bó Hoa Day Dreamer Nâng Cấp gồm:
- 7 bông Cẩm Tú Cầu.
- 5 cành bông Cúc.', CAST(899000.00 AS Decimal(18, 2)), N'/images/105ad35a-b957-4a45-835f-671ea70224c3.jpg', 5, 0, 5, 0, CAST(N'2025-05-23T12:34:57.6793378' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (17, N'Wood Nymph', N'Wood Nymph - Bó hoa là món quà từ những vị thần rừng Nymph Hy Lạp cổ xưa, với những bông hồng hột gà, hạt ngọc đỏ. Đây là một món quà ý nghĩa, thanh tao để dành tặng cho người thân yêu của bạn!
Bó Hoa Wood Nymph (Cơ Bản) bao gồm:
- 10 Bông Hoa Hồng Hột Gà.
- Chuỗi Ngọc Đỏ.
- Lá Trúc Bách Hợp.
- Các loại hoa và lá trang trí khác.
Bó Hoa Wood Nymph (Nâng Cấp) bao gồm:
- 14 Bông Hoa Hồng Hột Gà.
- Chuỗi Ngọc Đỏ.
- Lá Trúc Bách Hợp.
- Các loại hoa và lá trang trí khác.', CAST(699000.00 AS Decimal(18, 2)), N'/images/939f6297-b2a0-48aa-ac37-286877007494.webp', 4, 1, 5, 0, CAST(N'2025-05-23T12:37:07.4898990' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (18, N'Wood Nymph', N'Wood Nymph - Bó hoa là món quà từ những vị thần rừng Nymph Hy Lạp cổ xưa, với những bông hồng hột gà, hạt ngọc đỏ. Đây là một món quà ý nghĩa, thanh tao để dành tặng cho người thân yêu của bạn!
Bó Hoa Wood Nymph (Cơ Bản) bao gồm:
- 10 Bông Hoa Hồng Hột Gà.
- Chuỗi Ngọc Đỏ.
- Lá Trúc Bách Hợp.
- Các loại hoa và lá trang trí khác.
Bó Hoa Wood Nymph (Nâng Cấp) bao gồm:
- 14 Bông Hoa Hồng Hột Gà.
- Chuỗi Ngọc Đỏ.
- Lá Trúc Bách Hợp.
- Các loại hoa và lá trang trí khác.', CAST(699000.00 AS Decimal(18, 2)), N'/images/0f7048be-6b9d-4ac5-bf43-50453e91b844.webp', 5, 0, 5, 0, CAST(N'2025-05-23T12:37:09.0277260' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (19, N'Lasting Love (99 Bông)', N'Bó Hoa Lasting Love sang trọng và lộng lẫy với 99 bông hoa Hồng đỏ rực rỡ là lựa chọn hoàn hảo gửi đến người thân yêu trong ngày Valentine hoặc bất kỳ dịp đặc biệt nào.
Bó Hoa Lasting Love - Cơ Bản gồm:
- 99 Bông Hồng Đỏ.
Bó Hoa Lasting Love - Nâng Cấp gồm:
- 150 Bông Hồng Đỏ.', CAST(2849000.00 AS Decimal(18, 2)), N'/images/9c442b61-673a-49f0-9e82-35c04b9829c4.webp', 1, 0, 5, 0, CAST(N'2025-05-23T12:38:42.4101046' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (20, N'Take My Heart (101 Bông)', N'Bó Hoa Take My Heart sang trọng và lộng lẫy với những bông hoa Hồng đỏ rực rỡ là lựa chọn hoàn hảo gửi đến người thân yêu trong ngày Valentine hoặc bất kỳ dịp đặc biệt nào.
Bó Hoa Hồng Take My Heart gồm:
- 101 hoa hồng đỏ.
- Hoa bibi.
- Lưới đỏ hoặc lưới đen.', CAST(2299000.00 AS Decimal(18, 2)), N'/images/ce6e98b9-1da4-4f0b-a239-e89b9e9e62b3.webp', 1, 0, 5, 0, CAST(N'2025-05-23T12:40:37.9529493' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (21, N'Bó Hoa Glamorous Blush', N' 

Bó Hoa Glamorous Blush không chỉ là một món quà tuyệt vời mà còn là biểu tượng của tình yêu và sự quý phái. Những bông hoa được tạo nên với sự chăm sóc tỉ mỉ, từng chi tiết nhỏ đều được làm tỉa tót và sắc nét. Màu sắc rực rỡ, cuốn hút tạo nên vẻ đẹp sang trọng. Bó hoa sáp này không chỉ là một lựa chọn hoàn hảo cho các dịp lễ, kỷ niệm, mà còn làm tăng thêm vẻ đẹp cho không gian sống và làm việc của bạn. 
Thông tin Bó Hoa Glamorous Blush bao gồm:
50 bông hoa hồng sáp cao cấp.', CAST(1299000.00 AS Decimal(18, 2)), N'/images/4b15f74b-72ad-45fa-aec4-2180227cf7e7.webp', 2, 0, 5, 0, CAST(N'2025-05-23T12:42:23.6120175' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (22, N'Syrah', N'Ngọt ngào đến mấy cũng không bằng những cành hồng Ohara đỏ dành tặng em! Cùng khiến người thương bất ngờ và hạnh phúc trong mọi dịp đặc biệt với bó hoa siêu lãng mạn Syrah này nha!
Bó Hoa Hồng Ohara Syrah - Cơ Bản gồm:
- 10 Bông Hồng Ohara Đỏ.
- Hoa Cầu Gai Đỏ.
- Các loại hoa và lá trang trí khác.
Bó Hoa Hồng Ohara Syrah - Nâng Cấp gồm:
- 15 Bông Hồng Ohara Đỏ.
- Hoa Cầu Gai Đỏ.
- Các loại hoa và lá trang trí khác.', CAST(599000.00 AS Decimal(18, 2)), N'/images/edad2071-b5fa-4e13-a0e3-ec7d4787cd0f.webp', 5, 0, 5, 0, CAST(N'2025-05-23T12:44:30.6559751' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (23, N'Luôn Bên Em', N'Nhẹ nhàng như nụ cười, thanh khiết như trời mây, bó hoa hồng trắng "Luôn Bên Em" giúp bạn trao đi tâm tư của mình đến người thương!
Bó Hoa Luôn Bên Em (Cơ Bản) gồm:
- 15 Bông Hoa Hồng Trắng.
- Hoa và lá trang trí khác.
Bó Hoa Luôn Bên Em (Nâng Cấp) gồm:
- 24 Bông Hoa Hồng Trắng.
- Hoa và lá trang trí khác.', CAST(589000.00 AS Decimal(18, 2)), N'/images/ef8d4068-94a9-456a-8790-4cb464cb8e1b.webp', 5, 0, 5, 0, CAST(N'2025-05-23T12:46:23.1941508' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (24, N'Serendipity', N'Tận hưởng trọn vẹn sắc hương của mùa hè qua bó hoa cực kỳ nhẹ nhàng Serendipity nha! Sắc nắng, sắc vàng và cả sắc "tích cực" từ những cành hoa hồng, hoa cẩm chướng và hoa đồng tiền sẽ là món quà vô cùng tuyệt vời cho người thân yêu.
Bó Hoa Serendipity gồm:
- 5 Cành Hoa Đồng Tiền Vàng.
- 3 Cành Hoa Hồng Cam.
- 10 Cành Hoa Cẩm Chướng.
- Hoa và lá trang trí khác.', CAST(799000.00 AS Decimal(18, 2)), N'/images/f08d767b-45d6-4fe5-833b-dc17152c2042.jpg', 5, 0, 5, 0, CAST(N'2025-05-23T12:49:00.5905637' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (25, N'Serendipity', N'Tận hưởng trọn vẹn sắc hương của mùa hè qua bó hoa cực kỳ nhẹ nhàng Serendipity nha! Sắc nắng, sắc vàng và cả sắc "tích cực" từ những cành hoa hồng, hoa cẩm chướng và hoa đồng tiền sẽ là món quà vô cùng tuyệt vời cho người thân yêu.
Bó Hoa Serendipity gồm:
- 5 Cành Hoa Đồng Tiền Vàng.
- 3 Cành Hoa Hồng Cam.
- 10 Cành Hoa Cẩm Chướng.
- Hoa và lá trang trí khác.', CAST(799000.00 AS Decimal(18, 2)), N'/images/a4c6c562-74a3-4719-8dcb-398dacbdbead.jpg', 5, 0, 5, 0, CAST(N'2025-05-23T12:49:01.2890750' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (26, N'Say You Do', N'Mỗi cành hoa cát tường, hoa hồng và cúc tana đều xinh đẹp và ngọt ngào tạo nên bó hoa tròn vo ôm trọn vẹn những tình yêu to to gửi đến người bạn thương!
Bó Hoa Say You Do - Cơ Bản gồm:
- 7 Bông Hồng Hột Gà.
- 4 Bông Hoa Hồng Kem.
- 5 Cành Cát Tường Hột Gà.
- Cúc Tana.
- Hoa và lá trang trí khác.
Bó Hoa Say You Do - Nâng Cấp gồm:
- 14 Bông Hồng Hột Gà.
- 8 Bông Hoa Hồng Kem.
- 10 Cành Cát Tường Hột Gà.
- Cúc Tana.
- Hoa và lá trang trí khác.', CAST(849000.00 AS Decimal(18, 2)), N'/images/3422f23b-0b05-4fe2-b2bc-a0f5d63440f0.webp', 4, 0, 5, 0, CAST(N'2025-05-23T12:51:57.1296115' AS DateTime2), NULL, 1, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (27, N'Rose Berry', N'Nằm trong Bộ sưu tập Chào đón Giáng Sinh, Hộp hoa trái cây Rose Berry mang vẻ đẹp ấm áp, lãng mạn từ Hồng Đỏ, cùng sự ngọt ngào và căng tràn sức sống từ quả dâu tây. Với cách cắm hoa và trái cây độc đáo, cùng sự kết hợp màu sắc tinh tế hứa hẹn sẽ là món quà vô cùng bất ngờ cho người bạn thương!
Hộp hoa Rose Berry gồm: 
- Hoa Hồng đỏ.
- Quả Dâu tây.
- Hoa Baby.
- Các loại hoa và lá khác.', CAST(1499000.00 AS Decimal(18, 2)), N'/images/2160f674-6a9a-4bc4-a4d0-6e336b7720a7.jpg', 4, 0, 5, 0, CAST(N'2025-05-23T12:53:40.9028696' AS DateTime2), NULL, 2, 1, 8, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (28, N'Beautiful You', N'Bó hoa hồng đỏ đơn giản được gói rất trẻ trung và thanh lịch là một trong những mẫu Best Seller của chúng tôi. Là lựa chọn hoàn hảo cho ngày Valentine hoặc bất kỳ dịp đặc biệt nào.
Bó Hoa Hồng Beautiful You (Cơ Bản) gồm:
- 12 bông Hoa Hồng đỏ.
- Các loại hoa & lá khác.
Bó Hoa Hồng Beautiful You (Nâng Cấp) gồm:
- 16 bông Hoa Hồng đỏ.
- Các loại hoa & lá khác.', CAST(599000.00 AS Decimal(18, 2)), N'/images/01d936e5-523a-4e27-9238-4e48711d925e.webp', 4, 0, 5, 0, CAST(N'2025-05-23T12:58:18.5304579' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (29, N'Aurora Light', N'Bó hoa xinh xắn và ngọt ngào với sự kết hợp của hoa Hồng và Cẩm chướng. Đây sẽ là món quà bất ngờ và hoàn hảo dành tặng người thương, gia đình hoặc bạn bè.
Bó Hoa Aurora Light Cơ Bản gồm:
- 8 bông Hoa Hồng.
- 5 cành Cẩm Chướng.
- Các loại hoa và lá khác.
Bó Hoa Aurora Light Nâng Cấp gồm:
- 12 Hoa Hồng.
- 7 Cẩm Chướng.
- Các loại hoa và lá khác.', CAST(799000.00 AS Decimal(18, 2)), N'/images/3d8bb0ac-7cc9-4339-967d-237f178dd162.jpg', 4, 0, 5, 0, CAST(N'2025-05-23T13:00:01.4328843' AS DateTime2), NULL, 1, 1, 8, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (30, N'Into The Sun', N'Giỏ hoa đỏ rực Into The Sun sẽ thay lời cầu chúc may mắn của bạn đến người thương.
Giỏ hoa Into The Sun (cắm nửa mặt) gồm:
- 36 Bông Hồng đỏ.
- Các loại hoa và lá khác.', CAST(1749000.00 AS Decimal(18, 2)), N'/images/c0c37bfd-739f-4cdf-b657-9df21cc439ae.webp', 3, 0, 5, 0, CAST(N'2025-05-23T13:02:25.0722892' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (31, N'Into The Sun', N'Giỏ hoa đỏ rực Into The Sun sẽ thay lời cầu chúc may mắn của bạn đến người thương.
Giỏ hoa Into The Sun (cắm nửa mặt) gồm:
- 36 Bông Hồng đỏ.
- Các loại hoa và lá khác.', CAST(1749000.00 AS Decimal(18, 2)), N'/images/2fcadb4d-1fb6-4784-8007-80097a50436d.webp', 3, 0, 5, 0, CAST(N'2025-05-23T13:02:25.8703721' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (32, N'Tự Tình', N'Chất chứa những câu chuyện tình yêu đầy ngọt ngào gửi người mình thương, giỏ hoa Tự Tình biến mỗi khoảnh khắc trở nên thật mộng mơ.
Giỏ Hoa Tự Tình gồm:
- 3 Cành Cúc Mẫu Đơn .
- 6 Bông Hồng Kem.
- 5 Bông Hồng Tím.
- Cúc Thạch Bích Tím.
- Hoa Baby.
- Hoa và lá trang trí khác.', CAST(1549000.00 AS Decimal(18, 2)), N'/images/9a3422b4-d66a-46d9-bfde-741beae114b0.webp', 4, 0, 5, 0, CAST(N'2025-05-23T13:04:49.1652490' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (33, N'Xuân Sắc', N'Hộp hoa gỗ xinh xắn với chất liệu chính là Cúc Mẫu Đơn lạ mắt cùng các loài hoa rực rỡ. Đây sẽ là món quà bất ngờ và hoàn hảo dành tặng người thương, gia đình hoặc bạn bè.
 Hộp Hoa Gỗ Xuân Sắc gồm:
- 4 Cúc Mẫu Đơn.
- Hoa Hồng kem.
- Hoa Cẩm Chướng.
- Hoa Cát Tường.
- Hoa Đồng Tiền.
- Hoa Bibi.
- Các loại hoa và lá khác.', CAST(1899000.00 AS Decimal(18, 2)), N'/images/0392cb62-e8f4-4b10-bcb8-c2065d0d2be3.webp', 4, 0, 5, 0, CAST(N'2025-05-23T13:07:54.2047780' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (34, N'Affluent Season', N'Lộng lẫy và hoành tráng nhất chính là sự kết hợp đầy rực rỡ từ những cành hồng cam cùng với hoa cúc mẫu đơn trong hộp hoa Xuân Sắc Cao Cấp. Đây còn là sự lựa chọn vô cùng phù hợp cho các dịp quan trọng như khai trương, chúc mừng, sinh nhật, đám cưới,....
Hộp Hoa Affluent Season (cắm nửa mặt) gồm:
- 18 Bông Hồng Cam Spirit.
- 10 Cành Cúc Billy Ball.
- 5 Cành Hoa Cúc Mẫu Đơn Cam.
- 10 Cành Cẩm Chướng Chùm Đỏ.
- Hoa Chuỗi Ngọc.
- Lá Đinh Lăng.
- Các loại hoa và lá trang trí khác.
- Banner Decal (lời chúc khách hàng tự chọn) .', CAST(2599000.00 AS Decimal(18, 2)), N'/images/1ebe933c-31ba-4185-b15c-5dee5ace3d5f.jpg', 4, 0, 5, 0, CAST(N'2025-05-23T13:10:03.6680695' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (35, N'Euphoria', N'Hộp Hoa Gỗ Euphoria với 36 cành hoa hồng vàng xinh xắn, rạng rỡ được cắm cao và xoè, do đó vô cùng phù hợp để dành tặng cho người bạn yêu mến vào những dịp đặc biệt như chúc mừng hay khai trương.
Hộp Hoa Gỗ Euphoria (cắm nửa mặt) gồm:
- 32 bông Hoa Hồng.
- Các loại hoa & lá khác.
- Tặng kèm banner (vui lòng ghi nội dung banner tại mục ghi chú trong trang đặt hàng/ thanh toán).', CAST(1949000.00 AS Decimal(18, 2)), N'/images/11ebe86f-52c7-431c-b77d-10641a426fcd.jpg', 3, 0, 5, 0, CAST(N'2025-05-23T13:11:37.7521674' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (36, N'Commencement', N'Kệ hoa cực kì tươi tắn và sang trọng với vẻ đẹp từ những bông hoa hồng nhập khẩu kết hợp với cúc mẫu đơn chắc chắn sẽ giúp cho ngày khai trương thêm lộc phát và may mắn! 
Kệ Hoa Commencement gồm:
- Hoa Hồng Ecuador Đà Lạt.
- Hoa Hồng Cam Spirit.
- Hoa Cát Tường.
- Lá Trầu Bà.
- Hoa Cúc Mẫu Đơn.
- Hoa Thiên Điểu.
- Các loại hoa và lá khác.
- Băng rôn/ banner đính kèm.', CAST(3049000.00 AS Decimal(18, 2)), N'/images/54320034-72e4-4788-a78a-638d02fa96bd.jpg', 3, 0, 5, 0, CAST(N'2025-05-23T13:13:33.1305534' AS DateTime2), NULL, 4, 1, 9, N'["v\u00E0ng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (37, N'Rising Stars', N'Kệ hoa to, tươi tắn và sang trọng với sự kết hợp của các loại hoa màu vàng. Đây sẽ là món quà tặng đầy ý nghĩa thay cho lời chúc mừng trong dịp khai trương hoặc các ngày lễ trọng đại. 
Kệ Hoa Rising Stars gồm:
- 25 Hoa Hồng (màu vàng, hột gà).
- 5 Cành Lan Vũ Nữ.
- 20 Hướng Dương.
- Cúc Mai Vàng, Cúc Calimero Vàng.
- Các loại hoa và lá khác.
- Băng rôn/ banner đính kèm.', CAST(2949000.00 AS Decimal(18, 2)), N'/images/de8ed5f6-2ded-4df0-99ac-397a35fd7ddb.jpg', 3, 0, 5, 0, CAST(N'2025-05-23T13:16:54.3891971' AS DateTime2), NULL, 4, 1, 9, N'["\u0111\u1ECF"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (38, N'Wonderland', N'Giỏ hoa với sự kết hợp của rất nhiều loại hoa lá, vừa sang trọng, lại vừa xinh xắn, hiện đại, phù hợp gửi tặng cho bất kỳ ai, trong bất kỳ dịp nào.
Giỏ Hoa Wonderland gồm:
- 5 Bông Hồng.
- 8 Bông Đồng Tiền.
- 3 Bông Cúc.
- 3 Hướng Dương.
- Các loại hoa và lá khác.', CAST(2499000.00 AS Decimal(18, 2)), N'/images/1656d053-bc9d-404d-a885-d4d961862765.jpg', 3, 0, 5, 0, CAST(N'2025-05-23T13:18:37.7426502' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (39, N'Flaming Heart', N'Hộp hoa siêu to rực rỡ với sự kết hợp của các loại hoa mang tông màu đỏ rực sẽ là món quà bất ngờ và hoàn hảo dành tặng người thương, gia đình hoặc bạn bè, đặc biệt trong những dịp quan trọng như sinh nhật hay khai trương.
Hộp Hoa gỗ Flaming Heart (cắm nửa mặt) gồm:
- 25 Bông Hồng Đỏ.
- 19 Cành Cẩm Chướng.
- Các loại hoa và lá khác.', CAST(1799000.00 AS Decimal(18, 2)), N'/images/307eaf6e-8663-4e02-b204-6d40f80f1875.jpg', 2, 0, 5, 0, CAST(N'2025-05-23T13:20:20.8839966' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (40, N'Flaming Heart', N'Hộp hoa siêu to rực rỡ với sự kết hợp của các loại hoa mang tông màu đỏ rực sẽ là món quà bất ngờ và hoàn hảo dành tặng người thương, gia đình hoặc bạn bè, đặc biệt trong những dịp quan trọng như sinh nhật hay khai trương.
Hộp Hoa gỗ Flaming Heart (cắm nửa mặt) gồm:
- 25 Bông Hồng Đỏ.
- 19 Cành Cẩm Chướng.
- Các loại hoa và lá khác.', CAST(1799000.00 AS Decimal(18, 2)), N'/images/f9e4ab5e-b843-4407-8059-cf8b6f268e77.jpg', 2, 0, 5, 0, CAST(N'2025-05-23T13:21:43.1606149' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (41, N'Immortal', N'Kệ hoa hướng dương Immortal với vẻ đẹp rực rỡ và tỏa sáng từ hoa hướng dương cùng những nhành lan vũ nữ chắc chắn sẽ biến những dịp đặc biệt trở nên thật ý nghĩa!
Kệ Hoa Mini Immortal gồm:
- 11 Cành Hướng Dương.
- 17 Bông Hồng Hột Gà.
- 5 Cành Lan Vũ Nữ.
- Chuỗi Ngọc Đỏ.
- Các loại hoa và lá trang trí khác.
- Băng rôn/ banner đính kèm.', CAST(1849000.00 AS Decimal(18, 2)), N'/images/d8c6bca1-1c4e-421a-a7e3-247235746f7a.jpg', 3, 0, 5, 0, CAST(N'2025-05-23T13:23:39.2264502' AS DateTime2), NULL, 10, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (42, N'Summer Shine', N'Kệ hoa to, tươi tắn và sang trọng với sự kết hợp của nhiều loại hoa. Đây sẽ là món quà tặng đầy ý nghĩa thay cho lời chúc mừng trong dịp khai trương hoặc các ngày lễ trọng đại.
Kệ Hoa Summer Shine gồm:
- 1 Bông Cẩm Tú Cầu.
- 5 Bông Đồng Tiền Hồng.
- 5 Bông Hướng Dương.
- 4 Bông Cẩm Chướng Tím.
- 10 Bông Phi Yến Hồng.
- Lá Bạc.
- Các loại hoa và lá khác.
- Băng rôn/ banner đính kèm.
- Kệ.', CAST(2199000.00 AS Decimal(18, 2)), N'/images/7ff139cc-8a56-4c31-a2f2-c75266398710.jpg', 3, 0, 5, 0, CAST(N'2025-05-23T13:25:35.9051238' AS DateTime2), NULL, 4, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (43, N'Ngàn Lời Yêu', N'Hộp hoa Ngàn Lời Yêu - sang trọng, trang nhã với những cánh hồng kem xen lẽ sắc thắm của những bông hồng Ohara đỏ. Đây sẽ là một món quà ý nghĩa để dành tặng cho những người thân thương của bạn!
Hộp Hoa Ngàn Lời Yêu bao gồm:
- 24 Cành Hoa Hồng Kem.
- 10 Cành Hồng Ohara Đỏ.
- Các loại hoa và lá trang trí khác.', CAST(1049000.00 AS Decimal(18, 2)), N'/images/cb75f696-8db7-4925-99c3-df1ab6b747e2.jpg', 2, 0, 5, 0, CAST(N'2025-05-23T13:27:13.8456710' AS DateTime2), NULL, 2, 1, 9, N'["tr\u1EAFng"]')
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [ImageUrl], [Quantity], [QuantitySold], [LowStockThreshold], [IsNew], [CreatedDate], [DiscountPercentage], [PresentationStyleId], [IsActive], [CategoryId], [Colors]) VALUES (44, N'Jubilant', N'Kệ hoa to, tươi tắn và sang trọng với sự kết hợp của nhiều loại hoa. Đây sẽ là món quà tặng đầy ý nghĩa thay cho lời chúc mừng trong dịp khai trương hoặc các ngày lễ trọng đại.
 Kệ Hoa Jubilant gồm:
- Cẩm Tú Cầu.
- 6 Hoa Đồng Tiền Hồng.
- 15 Cành Cát Tường (hồng và trắng).
- 10 Hoa Hồng Tím.
- Sao Tím.
- Lá Huyết Dụ.
- Các loại hoa và lá khác.
- Băng rôn/ banner đính kèm.', CAST(4099000.00 AS Decimal(18, 2)), N'/images/a169f6d9-4a85-43a7-9263-f86c9de17a9c.jpg', 3, 0, 5, 0, CAST(N'2025-05-23T13:29:29.0576430' AS DateTime2), NULL, 4, 1, 9, N'["\u0111\u1ECF"]')
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[UserAccessLogs] ON 

INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (1, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-22T23:48:06.6303557' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (2, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-22T23:59:36.4356104' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (3, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T00:03:37.1210373' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (4, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T00:05:07.4373381' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (5, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T00:11:05.6811680' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (6, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T00:29:12.4523205' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (7, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T00:58:41.9239467' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (8, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T01:04:57.4552657' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (9, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T01:30:07.9753693' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (10, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T11:59:44.1230338' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (11, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T12:00:34.1542450' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (12, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T12:08:20.8232664' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (13, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T13:29:36.2783424' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (14, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T13:29:49.2938782' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (15, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T13:32:06.3191194' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (16, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T13:35:49.8922210' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (17, N'5931a6df-0bd0-46bc-b1ff-8a70234c5a37', CAST(N'2025-05-23T13:36:36.9149294' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (18, N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', CAST(N'2025-05-23T14:21:51.4512438' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (19, N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', CAST(N'2025-05-23T14:25:46.8923957' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (20, N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', CAST(N'2025-05-23T14:28:10.4591456' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (21, N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', CAST(N'2025-05-23T14:35:24.9184763' AS DateTime2), N'/')
INSERT [dbo].[UserAccessLogs] ([Id], [UserId], [AccessTime], [Url]) VALUES (22, N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', CAST(N'2025-05-23T14:41:11.6008916' AS DateTime2), N'/')
SET IDENTITY_INSERT [dbo].[UserAccessLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[Promotions] ON 

INSERT [dbo].[Promotions] ([Id], [Code], [Description], [DiscountPercentage], [MinimumOrderValue], [StartDate], [EndDate], [IsActive]) VALUES (1, N'BIRTHDAY25', N'Giảm 20% cho đơn hàng sinh nhật', CAST(20.00 AS Decimal(18, 2)), NULL, CAST(N'2025-05-23T00:00:00.0000000' AS DateTime2), CAST(N'2025-05-30T00:00:00.0000000' AS DateTime2), 1)
SET IDENTITY_INSERT [dbo].[Promotions] OFF
GO
INSERT [dbo].[Orders] ([Id], [UserId], [OrderDate], [TotalPrice], [ShippingAddress], [PhoneNumber], [Notes], [OrderStatus], [SenderName], [SenderEmail], [SenderPhoneNumber], [ReceiverName], [ReceiverEmail], [ReceiverPhoneNumber], [IsSenderReceiverSame], [IsAnonymousSender], [PromotionId], [DeliveryDate], [ShippingMethod]) VALUES (N'20250523142359-5593', N'd9275b6e-25ae-486e-b464-f3c1a52ca24c', CAST(N'2025-05-23T14:23:59.3052217' AS DateTime2), CAST(719500.00 AS Decimal(18, 2)), N'Quan1', N'0972350720', N'giao hang', 1, N'Duy khoa', N'dn.duykhoa@gmail.com', N'0972350720', N'Duy khoa', N'dn.duykhoa@gmail.com', N'0972350720', 1, 0, NULL, NULL, N'Standard')
GO
SET IDENTITY_INSERT [dbo].[FlowerTypes] ON 

INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (1, N'Hoa Hồng', 1080, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (2, N'Hoa Hướng Dương', 1883, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (3, N'Hoa Đồng Tiền', 137, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (4, N'Lan Hồ Điệp', 65, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (5, N'Cẩm Chướng', 762, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (6, N'Hoa Cát Tường', 69, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (7, N'Hoa Ly', 120, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (9, N'Hoa Cúc', 172, 1)
INSERT [dbo].[FlowerTypes] ([Id], [Name], [Quantity], [IsActive]) VALUES (10, N'Hoa Cẩm Tú Cầu', 182, 1)
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
SET IDENTITY_INSERT [dbo].[Batches] ON 

INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (1, 1, CAST(1200000.00 AS Decimal(18, 2)), CAST(N'2025-05-20T10:00:00.0000000' AS DateTime2), CAST(N'2025-06-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (2, 2, CAST(2500000.00 AS Decimal(18, 2)), CAST(N'2025-05-21T14:30:00.0000000' AS DateTime2), CAST(N'2025-07-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (3, 3, CAST(2100000.00 AS Decimal(18, 2)), CAST(N'2025-05-22T00:00:00.0000000' AS DateTime2), CAST(N'2025-06-05T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (4, 4, CAST(500000.00 AS Decimal(18, 2)), CAST(N'2025-05-22T00:00:00.0000000' AS DateTime2), CAST(N'2025-07-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (5, 5, CAST(2100000.00 AS Decimal(18, 2)), CAST(N'2025-05-23T00:00:00.0000000' AS DateTime2), CAST(N'2025-06-20T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (6, 6, CAST(950000.00 AS Decimal(18, 2)), CAST(N'2025-05-22T11:20:00.0000000' AS DateTime2), CAST(N'2025-06-15T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (7, 7, CAST(1500000.00 AS Decimal(18, 2)), CAST(N'2025-05-21T00:00:00.0000000' AS DateTime2), CAST(N'2025-07-10T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (8, 8, CAST(10000000.00 AS Decimal(18, 2)), CAST(N'2025-05-22T00:00:00.0000000' AS DateTime2), CAST(N'2025-06-25T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Batches] ([Id], [SupplierId], [UnitPrice], [ImportDate], [ExpiryDate]) VALUES (9, 9, CAST(500000.00 AS Decimal(18, 2)), CAST(N'2025-05-23T00:46:00.0000000' AS DateTime2), CAST(N'2025-06-07T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Batches] OFF
GO
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (1, 1, 500, 0)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (1, 9, 350, 122)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (2, 2, 2000, 1683)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (3, 1, 900, 0)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (3, 3, 200, 0)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (4, 3, 100, 37)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (4, 4, 80, 55)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (5, 1, 700, 331)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (5, 5, 650, 362)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (6, 6, 180, 49)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (7, 1, 600, 49)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (7, 7, 120, 100)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (8, 10, 100, 82)
INSERT [dbo].[BatchFlowerTypes] ([BatchId], [FlowerTypeId], [InitialQuantity], [CurrentQuantity]) VALUES (9, 1, 300, 0)
GO
SET IDENTITY_INSERT [dbo].[InventoryTransactions] ON 

INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (1, NULL, 1, 1, -25, N'Dùng để tạo 5 sản phẩm Nụ Cười Em (5 bông/bó)', CAST(N'2025-05-23T01:07:21.8775732' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (2, NULL, 3, 1, -20, N'Dùng để tạo 5 sản phẩm Nụ Cười Em (4 bông/bó)', CAST(N'2025-05-23T01:07:21.9835431' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (3, NULL, 1, 1, -90, N'Dùng để tạo 5 sản phẩm Forever 18 (18 bông hồng) (18 bông/bó)', CAST(N'2025-05-23T01:10:32.5742833' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (4, NULL, 1, 1, -100, N'Dùng để tạo 5 sản phẩm La Vie En Rose (20 bông/bó)', CAST(N'2025-05-23T01:13:08.3872979' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (5, NULL, 1, 1, -50, N'Dùng để tạo 5 sản phẩm Dreamcatcher (10 bông/bó)', CAST(N'2025-05-23T01:15:22.2180733' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (6, NULL, 1, 1, -75, N'Dùng để tạo 5 sản phẩm Đại dương (15 bông/bó)', CAST(N'2025-05-23T01:17:28.7429877' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (7, NULL, 1, 1, -100, N'Dùng để tạo 5 sản phẩm Fly Me To The Moon (20 bông/bó)', CAST(N'2025-05-23T01:20:01.8756558' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (8, NULL, 3, 1, -90, N'Dùng để tạo 5 sản phẩm Ngại Ngùng (18 bông/bó)', CAST(N'2025-05-23T01:23:11.3558617' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (9, NULL, 1, 1, -15, N'Dùng để tạo 5 sản phẩm Bubblegum (3 bông/bó)', CAST(N'2025-05-23T12:11:36.2693097' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (10, NULL, 6, 1, -10, N'Dùng để tạo 5 sản phẩm Bubblegum (2 bông/bó)', CAST(N'2025-05-23T12:11:36.4685368' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (11, NULL, 5, 1, -10, N'Dùng để tạo 5 sản phẩm Bubblegum (2 bông/bó)', CAST(N'2025-05-23T12:11:36.4787484' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (12, NULL, 3, 1, -10, N'Dùng để tạo 5 sản phẩm Bubblegum (2 bông/bó)', CAST(N'2025-05-23T12:11:36.4850214' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (13, NULL, 1, 0, 900, N'Nhập kho', CAST(N'2025-05-23T12:17:14.9820152' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, 3, 3, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (14, NULL, 1, 1, -48, N'Dùng để tạo 2 sản phẩm Fall For You (24 bông/bó)', CAST(N'2025-05-23T12:18:40.7169010' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (15, NULL, 1, 1, -60, N'Dùng để tạo 5 sản phẩm Summer Delight (12 bông/bó)', CAST(N'2025-05-23T12:20:47.1390184' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (16, NULL, 1, 1, -90, N'Dùng để tạo 5 sản phẩm Hẹn Thương (18 bông/bó)', CAST(N'2025-05-23T12:23:13.3829066' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (17, NULL, 1, 1, -50, N'Dùng để tạo 5 sản phẩm Combo Missing You (10 bông/bó)', CAST(N'2025-05-23T12:24:44.2003849' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (18, NULL, 1, 1, -74, N'Dùng để tạo 2 sản phẩm Bó Hoa Rouge Heart (37 bông/bó)', CAST(N'2025-05-23T12:26:49.9798895' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (19, NULL, 1, 1, -44, N'Dùng để tạo 2 sản phẩm Chớm Nở (22 bông/bó)', CAST(N'2025-05-23T12:28:54.3741422' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (20, NULL, 1, 1, -60, N'Dùng để tạo 2 sản phẩm Mia (30 bông/bó)', CAST(N'2025-05-23T12:31:36.8699178' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (21, NULL, 10, 0, 100, N'Nhập kho', CAST(N'2025-05-23T12:34:01.7922352' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, 8, 8, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (22, NULL, 9, 1, -15, N'Dùng để tạo 5 sản phẩm Day Dreamer  (3 bông/bó)', CAST(N'2025-05-23T12:35:05.6858049' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (23, NULL, 1, 1, -70, N'Dùng để tạo 5 sản phẩm Wood Nymph (14 bông/bó)', CAST(N'2025-05-23T12:37:14.2646842' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (24, NULL, 1, 1, -70, N'Dùng để tạo 5 sản phẩm Wood Nymph (14 bông/bó)', CAST(N'2025-05-23T12:37:15.7666911' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (25, NULL, 1, 1, -99, N'Dùng để tạo 1 sản phẩm Lasting Love (99 Bông) (99 bông/bó)', CAST(N'2025-05-23T12:38:49.8359000' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (26, NULL, 1, 1, -101, N'Dùng để tạo 1 sản phẩm Take My Heart (101 Bông) (101 bông/bó)', CAST(N'2025-05-23T12:40:45.5525192' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (27, NULL, 1, 1, -100, N'Dùng để tạo 2 sản phẩm Bó Hoa Glamorous Blush (50 bông/bó)', CAST(N'2025-05-23T12:42:31.2638770' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (28, NULL, 1, 1, -75, N'Dùng để tạo 5 sản phẩm Syrah (15 bông/bó)', CAST(N'2025-05-23T12:44:37.9929548' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (29, NULL, 1, 1, -75, N'Dùng để tạo 5 sản phẩm Luôn Bên Em (15 bông/bó)', CAST(N'2025-05-23T12:46:30.0937586' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (30, NULL, 3, 1, -25, N'Dùng để tạo 5 sản phẩm Serendipity (5 bông/bó)', CAST(N'2025-05-23T12:49:07.5241959' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (31, NULL, 1, 1, -15, N'Dùng để tạo 5 sản phẩm Serendipity (3 bông/bó)', CAST(N'2025-05-23T12:49:07.5427402' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (32, NULL, 5, 1, -50, N'Dùng để tạo 5 sản phẩm Serendipity (10 bông/bó)', CAST(N'2025-05-23T12:49:07.5467516' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (33, NULL, 3, 1, -25, N'Dùng để tạo 5 sản phẩm Serendipity (5 bông/bó)', CAST(N'2025-05-23T12:49:08.0748498' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (34, NULL, 1, 1, -15, N'Dùng để tạo 5 sản phẩm Serendipity (3 bông/bó)', CAST(N'2025-05-23T12:49:08.0822196' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (35, NULL, 5, 1, -50, N'Dùng để tạo 5 sản phẩm Serendipity (10 bông/bó)', CAST(N'2025-05-23T12:49:08.0889246' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (36, NULL, 1, 1, -56, N'Dùng để tạo 4 sản phẩm Say You Do (14 bông/bó)', CAST(N'2025-05-23T12:52:04.2778982' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (37, NULL, 9, 1, -32, N'Dùng để tạo 4 sản phẩm Say You Do (8 bông/bó)', CAST(N'2025-05-23T12:52:04.2989376' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (38, NULL, 6, 1, -40, N'Dùng để tạo 4 sản phẩm Say You Do (10 bông/bó)', CAST(N'2025-05-23T12:52:04.3021927' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (39, NULL, 1, 1, -60, N'Dùng để tạo 4 sản phẩm Rose Berry (15 bông/bó)', CAST(N'2025-05-23T12:53:47.8877430' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (40, NULL, 1, 0, 600, N'Nhập kho', CAST(N'2025-05-23T12:57:29.0326049' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, 7, 7, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (41, NULL, 1, 1, -48, N'Dùng để tạo 4 sản phẩm Beautiful You (12 bông/bó)', CAST(N'2025-05-23T12:58:24.3549766' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (42, NULL, 1, 1, -32, N'Dùng để tạo 4 sản phẩm Aurora Light (8 bông/bó)', CAST(N'2025-05-23T13:00:14.8930596' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (43, NULL, 5, 1, -20, N'Dùng để tạo 4 sản phẩm Aurora Light (5 bông/bó)', CAST(N'2025-05-23T13:00:14.9154280' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (44, NULL, 1, 1, -108, N'Dùng để tạo 3 sản phẩm Into The Sun (36 bông/bó)', CAST(N'2025-05-23T13:02:32.0421183' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (45, NULL, 1, 1, -108, N'Dùng để tạo 3 sản phẩm Into The Sun (36 bông/bó)', CAST(N'2025-05-23T13:02:32.7533352' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (46, NULL, 1, 1, -20, N'Dùng để tạo 4 sản phẩm Tự Tình (5 bông/bó)', CAST(N'2025-05-23T13:04:52.5788870' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (47, NULL, 9, 1, -20, N'Dùng để tạo 4 sản phẩm Tự Tình (5 bông/bó)', CAST(N'2025-05-23T13:04:52.5953302' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (48, NULL, 1, 1, -20, N'Dùng để tạo 4 sản phẩm Xuân Sắc (5 bông/bó)', CAST(N'2025-05-23T13:06:40.9030436' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (49, NULL, 9, 1, -16, N'Dùng để tạo 4 sản phẩm Xuân Sắc (4 bông/bó)', CAST(N'2025-05-23T13:06:40.9175325' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (50, NULL, 3, 0, 100, N'Nhập kho', CAST(N'2025-05-23T13:07:26.1616563' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, 4, 4, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (51, NULL, 1, 1, -20, N'Dùng để tạo 4 sản phẩm Xuân Sắc (5 bông/bó)', CAST(N'2025-05-23T13:07:57.3882868' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (52, NULL, 9, 1, -16, N'Dùng để tạo 4 sản phẩm Xuân Sắc (4 bông/bó)', CAST(N'2025-05-23T13:07:57.3985706' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (53, NULL, 3, 1, -16, N'Dùng để tạo 4 sản phẩm Xuân Sắc (4 bông/bó)', CAST(N'2025-05-23T13:07:57.4001857' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (54, NULL, 6, 1, -16, N'Dùng để tạo 4 sản phẩm Xuân Sắc (4 bông/bó)', CAST(N'2025-05-23T13:07:57.4096871' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (55, NULL, 1, 1, -72, N'Dùng để tạo 4 sản phẩm Affluent Season (18 bông/bó)', CAST(N'2025-05-23T13:10:07.1373414' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (56, NULL, 9, 1, -40, N'Dùng để tạo 4 sản phẩm Affluent Season (10 bông/bó)', CAST(N'2025-05-23T13:10:07.1545519' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (57, NULL, 5, 1, -40, N'Dùng để tạo 4 sản phẩm Affluent Season (10 bông/bó)', CAST(N'2025-05-23T13:10:07.1570536' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (58, NULL, 1, 1, -96, N'Dùng để tạo 3 sản phẩm Euphoria (32 bông/bó)', CAST(N'2025-05-23T13:11:41.5559558' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (59, NULL, 1, 1, -30, N'Dùng để tạo 3 sản phẩm Commencement (10 bông/bó)', CAST(N'2025-05-23T13:13:36.6089857' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (60, NULL, 9, 1, -30, N'Dùng để tạo 3 sản phẩm Commencement (10 bông/bó)', CAST(N'2025-05-23T13:13:36.6256058' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (61, NULL, 1, 0, 700, N'Nhập kho', CAST(N'2025-05-23T13:16:11.5591511' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, 5, 5, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (62, NULL, 1, 1, -75, N'Dùng để tạo 3 sản phẩm Rising Stars (25 bông/bó)', CAST(N'2025-05-23T13:16:57.6908140' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (63, NULL, 2, 1, -60, N'Dùng để tạo 3 sản phẩm Rising Stars (20 bông/bó)', CAST(N'2025-05-23T13:16:57.7039708' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (64, NULL, 1, 1, -15, N'Dùng để tạo 3 sản phẩm Wonderland (5 bông/bó)', CAST(N'2025-05-23T13:18:41.0790728' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (65, NULL, 3, 1, -24, N'Dùng để tạo 3 sản phẩm Wonderland (8 bông/bó)', CAST(N'2025-05-23T13:18:41.0964145' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (66, NULL, 2, 1, -9, N'Dùng để tạo 3 sản phẩm Wonderland (3 bông/bó)', CAST(N'2025-05-23T13:18:41.0995997' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (67, NULL, 9, 1, -9, N'Dùng để tạo 3 sản phẩm Wonderland (3 bông/bó)', CAST(N'2025-05-23T13:18:41.1022030' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (68, NULL, 1, 1, -50, N'Dùng để tạo 2 sản phẩm Flaming Heart (25 bông/bó)', CAST(N'2025-05-23T13:20:24.6361799' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (69, NULL, 5, 1, -38, N'Dùng để tạo 2 sản phẩm Flaming Heart (19 bông/bó)', CAST(N'2025-05-23T13:20:24.6527839' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (70, NULL, 1, 1, -50, N'Dùng để tạo 2 sản phẩm Flaming Heart (25 bông/bó)', CAST(N'2025-05-23T13:20:26.0246605' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (71, NULL, 5, 0, 400, N'Nhập kho', CAST(N'2025-05-23T13:21:08.7901868' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, 5, 5, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (72, NULL, 1, 1, -50, N'Dùng để tạo 2 sản phẩm Flaming Heart (25 bông/bó)', CAST(N'2025-05-23T13:21:46.4642602' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (73, NULL, 5, 1, -38, N'Dùng để tạo 2 sản phẩm Flaming Heart (19 bông/bó)', CAST(N'2025-05-23T13:21:46.4812924' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (74, NULL, 2, 1, -33, N'Dùng để tạo 3 sản phẩm Immortal (11 bông/bó)', CAST(N'2025-05-23T13:23:42.6711249' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (75, NULL, 1, 1, -51, N'Dùng để tạo 3 sản phẩm Immortal (17 bông/bó)', CAST(N'2025-05-23T13:23:42.6870059' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (76, NULL, 4, 1, -15, N'Dùng để tạo 3 sản phẩm Immortal (5 bông/bó)', CAST(N'2025-05-23T13:23:42.6897241' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (77, NULL, 10, 1, -3, N'Dùng để tạo 3 sản phẩm Summer Shine (1 bông/bó)', CAST(N'2025-05-23T13:25:39.2384540' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (78, NULL, 2, 1, -15, N'Dùng để tạo 3 sản phẩm Summer Shine (5 bông/bó)', CAST(N'2025-05-23T13:25:39.2502869' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (79, NULL, 3, 1, -15, N'Dùng để tạo 3 sản phẩm Summer Shine (5 bông/bó)', CAST(N'2025-05-23T13:25:39.2526983' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (80, NULL, 5, 1, -12, N'Dùng để tạo 3 sản phẩm Summer Shine (4 bông/bó)', CAST(N'2025-05-23T13:25:39.2551660' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (81, NULL, 1, 1, -48, N'Dùng để tạo 2 sản phẩm Ngàn Lời Yêu (24 bông/bó)', CAST(N'2025-05-23T13:27:17.0905144' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (82, NULL, 10, 1, -15, N'Dùng để tạo 3 sản phẩm Jubilant (5 bông/bó)', CAST(N'2025-05-23T13:29:32.3566851' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (83, NULL, 3, 1, -18, N'Dùng để tạo 3 sản phẩm Jubilant (6 bông/bó)', CAST(N'2025-05-23T13:29:32.3729812' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (84, NULL, 6, 1, -45, N'Dùng để tạo 3 sản phẩm Jubilant (15 bông/bó)', CAST(N'2025-05-23T13:29:32.3782082' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[InventoryTransactions] ([Id], [ProductId], [FlowerTypeId], [TransactionType], [Quantity], [Reason], [TransactionDate], [CreatedBy], [UnitPrice], [OrderId], [SupplierId], [BatchId], [AdjustmentType], [Status]) VALUES (85, NULL, 1, 1, -30, N'Dùng để tạo 3 sản phẩm Jubilant (10 bông/bó)', CAST(N'2025-05-23T13:29:32.3807825' AS DateTime2), N'admin', CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[InventoryTransactions] OFF
GO
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 1, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 2, 18)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 3, 20)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 4, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 5, 15)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 6, 20)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 8, 3)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 9, 24)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 10, 12)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 11, 18)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 12, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 13, 37)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 14, 22)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 15, 30)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 17, 14)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 18, 14)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 19, 99)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 20, 101)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 21, 50)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 22, 15)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 23, 15)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 24, 3)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 25, 3)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 26, 14)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 27, 15)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 28, 12)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 29, 8)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 30, 36)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 31, 36)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 32, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 33, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 34, 18)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 35, 32)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 36, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 37, 25)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 38, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 39, 25)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 40, 25)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 41, 17)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 43, 24)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (1, 44, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (2, 37, 20)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (2, 38, 3)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (2, 41, 11)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (2, 42, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 1, 4)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 7, 18)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 8, 2)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 24, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 25, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 33, 4)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 38, 8)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 42, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (3, 44, 6)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (4, 41, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (5, 8, 2)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (5, 24, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (5, 25, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (5, 29, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (5, 34, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (5, 39, 19)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (5, 40, 19)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (5, 42, 4)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (6, 8, 2)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (6, 26, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (6, 33, 4)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (6, 44, 15)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (9, 16, 3)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (9, 26, 8)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (9, 32, 5)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (9, 33, 4)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (9, 34, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (9, 36, 10)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (9, 38, 3)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (10, 42, 1)
INSERT [dbo].[FlowerTypeProducts] ([FlowerTypeId], [ProductId], [Quantity]) VALUES (10, 44, 5)
GO
INSERT [dbo].[PromotionProducts] ([PromotionId], [ProductId]) VALUES (1, 1)
INSERT [dbo].[PromotionProducts] ([PromotionId], [ProductId]) VALUES (1, 3)
INSERT [dbo].[PromotionProducts] ([PromotionId], [ProductId]) VALUES (1, 4)
INSERT [dbo].[PromotionProducts] ([PromotionId], [ProductId]) VALUES (1, 7)
INSERT [dbo].[PromotionProducts] ([PromotionId], [ProductId]) VALUES (1, 15)
INSERT [dbo].[PromotionProducts] ([PromotionId], [ProductId]) VALUES (1, 17)
INSERT [dbo].[PromotionProducts] ([PromotionId], [ProductId]) VALUES (1, 20)
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 

INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (1, N'/images/1c975d02-795e-4269-a5d0-8eb17f5376ca.webp', 1)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (2, N'/images/b752b358-9981-401d-85aa-d9a5678621bf.webp', 1)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (3, N'/images/95983612-d159-4ece-9f28-85109032283a.webp', 2)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (4, N'/images/ea356f4c-fa55-49f1-8241-29e949c66969.webp', 2)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (5, N'/images/233d6cd1-daf4-453d-b84e-6ba906bb496b.webp', 3)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (6, N'/images/a111b02a-4f02-4372-ad4d-feb21024ba03.webp', 3)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (7, N'/images/979b0f55-ba8c-43f2-bae7-67e57b88587a.webp', 3)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (8, N'/images/db6eb624-e7ea-4a07-a2fd-1c611652d0da.webp', 3)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (9, N'/images/973f7ee3-969b-485c-86ca-9109aca749c1.webp', 4)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (10, N'/images/abcfe4c0-7686-4464-8a28-6ee4a4c559c2.webp', 4)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (11, N'/images/72d0981c-b689-476f-8091-9b977e5cdf91.webp', 4)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (12, N'/images/bd15a159-8f23-477c-bf51-e6b691240920.jpg', 5)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (13, N'/images/7b5307fc-35b0-4d52-a64c-a761b7b1c06a.jpg', 5)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (14, N'/images/4589eaaa-d4f6-4905-8f88-f712e9eb62f3.webp', 6)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (15, N'/images/930adee2-c02a-481a-81e0-83302fbc705d.webp', 6)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (16, N'/images/0e5ff47d-5e6a-46d2-bcae-18abff6cdb4f.webp', 7)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (17, N'/images/6582d9dd-463d-4b05-a0e1-15cd4ca7b310.webp', 7)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (18, N'/images/8234445a-04f9-4043-9682-718b6b410812.webp', 7)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (19, N'/images/4a944c33-ac4f-4b6c-944b-e5fe7431ae9e.webp', 7)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (20, N'/images/a3e55c7d-5ae0-4383-ad4e-a548d5674d55.webp', 8)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (21, N'/images/8089b7eb-f5f6-4e60-803f-b47e19acee55.webp', 8)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (22, N'/images/a92ecae8-5dfd-4738-a266-7fc9c5575d96.webp', 8)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (23, N'/images/4d9b223f-23c8-4786-a037-d70d48dbb5e9.webp', 8)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (24, N'/images/a1d1e00c-3349-411d-b817-a783eed7ad9d.webp', 8)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (25, N'/images/6e414a53-4774-4d0e-9982-7d1c16814bde.webp', 9)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (26, N'/images/5b9ffd8b-c24f-4a83-8b1e-dc5119cd895d.webp', 9)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (27, N'/images/1d18500f-1ae4-4635-9f87-680589a2b294.webp', 9)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (28, N'/images/592fc613-59e5-4c1c-8ded-72c2a157877f.webp', 10)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (29, N'/images/d62ad67d-7a53-4a30-bd3e-d8d74e3c2d3d.webp', 10)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (30, N'/images/6a6ff91b-eb5a-4668-9930-456f772e7f77.webp', 10)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (31, N'/images/75be54a8-c1eb-4fba-a0ab-dc3aa536df60.webp', 11)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (32, N'/images/a6bcefe5-deb2-4cbe-b800-539f4a162c37.webp', 11)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (33, N'/images/9173eea1-c2cc-4063-88b3-0c13f0d215e0.webp', 11)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (34, N'/images/b927b8f5-c01c-4113-af6d-71f4729faecb.webp', 11)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (35, N'/images/7c6e6385-8b76-4378-8be6-7a7e427b69fb.jpg', 12)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (36, N'/images/b4a7012b-96bf-4814-9252-eb50f78b5ee7.jpg', 12)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (37, N'/images/508aa6a2-677e-4eec-b1c7-bcdc051b802c.webp', 13)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (38, N'/images/271baae3-4767-45ef-873b-8d578a494dbc.webp', 13)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (39, N'/images/6bc19fa9-08c8-462a-be6f-cc075f72616a.webp', 14)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (40, N'/images/f4f4b65e-f058-4bec-9c84-6e719cd77ea2.webp', 14)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (41, N'/images/4c323a53-0ced-4218-ae4f-dd7a43955577.webp', 14)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (42, N'/images/718aed56-5f83-4f48-be23-689d21bce1d1.jpg', 15)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (43, N'/images/9bf72929-5bcd-4cff-adc2-b23b8e089d21.webp', 15)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (44, N'/images/1285c62a-bab2-4cf1-bf9a-47b0d78c48ef.webp', 15)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (45, N'/images/4c0bcab9-8770-4f99-bf47-ca51845a9126.jpg', 16)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (46, N'/images/a074d525-a03f-4090-8c86-0abc384bd265.jpg', 16)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (47, N'/images/25be2db4-ee05-4cf5-ab44-3af56e1daad9.jpg', 16)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (48, N'/images/4ed66f1c-386f-4f1c-8cef-76acda08a8f7.jpg', 17)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (49, N'/images/561968d7-dd39-4cdc-8a42-052dd58ab226.jpg', 17)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (50, N'/images/9fdfac62-0885-4509-9ba2-4bdc1a24720f.jpg', 18)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (51, N'/images/e23a43d6-a95e-4558-8d0f-77e6351e5d91.jpg', 18)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (52, N'/images/9ce731df-a843-4950-bac8-4e16d2a2af49.webp', 19)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (53, N'/images/0890debd-82c7-4c1c-b67e-4cc25885b9fb.webp', 19)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (54, N'/images/cc9dedcd-59e5-4d0d-943a-130df2a32e8f.webp', 20)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (55, N'/images/0538d107-899b-4e31-a259-f58acda6e03c.webp', 20)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (56, N'/images/308c049d-d4ff-472f-a14c-564bc8859245.webp', 20)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (57, N'/images/0fc99ca4-c3ba-4c40-8978-e17895fad102.webp', 21)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (58, N'/images/55a36e0b-504c-4b71-86c1-a2efd4d59b97.webp', 21)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (59, N'/images/3b1f1889-4d38-45fc-8807-b223d664ca51.webp', 21)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (60, N'/images/d1fad4aa-63d9-46bb-b773-d554167e2df6.jpg', 22)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (61, N'/images/d06fb3f4-ba43-4b0a-8970-a373822ba45a.jpg', 22)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (62, N'/images/90c4214c-7ad3-4ca4-82cb-aa324d7a1912.webp', 23)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (63, N'/images/b8b1413d-f901-4593-873e-14f7bf22eed9.webp', 23)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (64, N'/images/5181e474-cb03-40bf-aae9-6c15a99b2164.webp', 23)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (65, N'/images/e9daddd8-7661-46c6-8600-27378ffeb623.jpg', 24)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (66, N'/images/a8249e8c-2300-4d59-8db1-8d3bde24e859.jpg', 24)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (67, N'/images/08be29ae-509c-4941-bb4e-17454e1c29bd.jpg', 25)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (68, N'/images/d3c38f01-a87a-4622-970b-1165b23c9b57.jpg', 25)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (69, N'/images/43b771e6-390a-4e07-bce7-691713f8bae9.webp', 26)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (70, N'/images/b616a89a-1561-4fcc-a6be-f06bde1b2c92.webp', 26)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (71, N'/images/46cd4ffb-0aac-4f35-8cb1-a7f4a46bf959.webp', 26)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (72, N'/images/91c7a9d5-4e17-4244-b4f9-54476ab48ddf.jpg', 27)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (73, N'/images/c65dc95f-cb10-438c-9ed6-47da99fc2d77.jpg', 27)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (74, N'/images/674534e8-8db6-49c6-8561-ab24be8c4b24.webp', 28)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (75, N'/images/3a8ba1b9-4faf-4801-be48-4535936d91b6.webp', 28)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (76, N'/images/e6520a73-9c85-4af5-9d99-90072466e2ab.webp', 29)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (77, N'/images/6d59abb9-8eca-4576-8707-e0f1dca03e16.webp', 30)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (78, N'/images/dd67a698-be8f-4548-b41b-bb3f74f4302e.webp', 30)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (79, N'/images/fa2c802d-8541-42e2-98de-208845e721e4.webp', 30)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (80, N'/images/6daa4269-276c-46b7-841f-84a1f7b9d0f1.webp', 31)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (81, N'/images/443a425d-fcd6-4c42-a9dc-b84c7f16feb8.webp', 31)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (82, N'/images/88f8c109-88c5-4e35-9582-cfe0b4b16eeb.webp', 31)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (83, N'/images/52aa83c4-620b-4bce-bf0c-f34ded00f41f.webp', 32)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (84, N'/images/2a71a59f-2195-4bed-a368-cbd06666a111.webp', 32)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (85, N'/images/71ab026b-ae4e-4bb8-88e0-359a88ec7438.webp', 32)
-- Fixed: Changed ProductId from non-existent 34 to existing product 33
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (86, N'/images/e9d60f76-148e-443d-893f-c9bd76d010ab.webp', 33)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (87, N'/images/c212eb96-a394-4653-8eae-82807c719c7b.webp', 33)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (88, N'/images/464011d9-eedd-4973-9e93-dc96a7cee440.jpg', 34)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (89, N'/images/2d210b2d-0fd5-48b1-9dcb-20ae1f19550b.jpg', 36)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (90, N'/images/5a3b3bf9-512e-49b8-aaa0-bc6be68faa36.jpg', 37)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (91, N'/images/444895d6-1c48-4afe-a74b-ba92b7095f95.jpg', 37)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (92, N'/images/c7ff9c39-0ab9-4a42-8eeb-421eac7f5671.jpg', 38)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (93, N'/images/2e4df925-80f1-43a2-af6b-2e0867522987.jpg', 39)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (94, N'/images/930f37e8-5422-4c1a-a67d-c9438c1d9a98.jpg', 39)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (95, N'/images/95c59099-87be-4c2f-a7ab-084d08242974.jpg', 40)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (96, N'/images/b75a390b-f995-48b8-87b7-f5276049aff3.jpg', 40)
INSERT [dbo].[ProductImages] ([Id], [Url], [ProductId]) VALUES (97, N'/images/0619f742-8f74-40ba-bf3c-cf600fcfa258.jpg', 43)
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

-- Fixed: Added required DeliveryTime field
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Quantity], [Price], [DeliveryDate], [DeliveryTime]) VALUES (1, N'20250523142359-5593', 17, 1, CAST(699000.00 AS Decimal(18, 2)), NULL, N'Anytime')
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 

INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [PaymentMethod], [PaymentStatus], [PaymentDate]) VALUES (1, N'20250523142359-5593', CAST(719500.00 AS Decimal(18, 2)), N'Vnpay', N'Đã thanh toán', CAST(N'2025-05-23T14:23:59.5897955' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
-- Removed duplicate Shippings insert - Id=1 already exists
-- SET IDENTITY_INSERT [dbo].[Shippings] ON 
-- INSERT [dbo].[Shippings] ([Id], [Price], [Ward], [District], [City]) VALUES (1, CAST(20500.00 AS Decimal(18, 2)), N'Phường 3', N'Thành phố Cao Lãnh', N'Đồng Tháp')
-- SET IDENTITY_INSERT [dbo].[Shippings] OFF
GO
