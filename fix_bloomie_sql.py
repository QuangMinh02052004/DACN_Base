#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script để fix file Bloomie (1).sql:
- Thêm BasePrice vào PresentationStyles
- Thêm FlowerTypes và Suppliers
"""

import re
import sys

def main():
    print("🔧 Đang đọc file Bloomie (1).sql...")

    try:
        # Đọc file với nhiều encodings khác nhau
        content = None
        for encoding in ['utf-16-le', 'utf-16', 'utf-8', 'latin-1']:
            try:
                with open('Bloomie (1).sql', 'r', encoding=encoding) as f:
                    content = f.read()
                print(f"✅ Đọc file thành công với encoding: {encoding}")
                break
            except:
                continue

        if not content:
            print("❌ Không thể đọc file!")
            return 1

        print(f"📊 File size: {len(content)} characters")

        # Đếm số lượng INSERT statements
        categories_count = len(re.findall(r'INSERT.*Categories', content, re.IGNORECASE))
        presentations_count = len(re.findall(r'INSERT.*PresentationStyles', content, re.IGNORECASE))
        products_count = len(re.findall(r'INSERT.*Products', content, re.IGNORECASE))

        print(f"\n📈 Thống kê dữ liệu trong file:")
        print(f"   - Categories: {categories_count} records")
        print(f"   - PresentationStyles: {presentations_count} records")
        print(f"   - Products: {products_count} records")

        # Fix PresentationStyles - thêm BasePrice
        print("\n🔧 Đang fix PresentationStyles (thêm BasePrice)...")

        # Map từng ID với giá BasePrice phù hợp
        baseprice_map = {
            1: 50000,   # Bó hoa
            2: 80000,   # Giỏ hoa
            3: 70000,   # Hộp hoa
            4: 100000,  # Lẵng hoa
            5: 90000,   # Bình hoa
            6: 50000,   # Hoa bó cổ điển
            7: 80000,   # Hoa để bàn
            8: 80000,   # Giỏ hoa hiện đại
            9: 70000,   # Hộp hoa nghệ thuật
            10: 100000  # Lẵng hoa mini
        }

        # Pattern để tìm INSERT PresentationStyles
        # Ví dụ: INSERT [dbo].[PresentationStyles] ([Id], [Name]) VALUES (1, N'Bó hoa')
        pattern = r'INSERT\s+\[dbo\]\.\[PresentationStyles\]\s+\(\[Id\],\s+\[Name\]\)\s+VALUES\s+\((\d+),\s+(N\'[^\']+\')\)'

        def replace_presentation(match):
            id_val = int(match.group(1))
            name_val = match.group(2)
            baseprice = baseprice_map.get(id_val, 60000)  # Default 60000
            return f'INSERT [dbo].[PresentationStyles] ([Id], [Name], [BasePrice]) VALUES ({id_val}, {name_val}, {baseprice}.00)'

        content_fixed = re.sub(pattern, replace_presentation, content, flags=re.IGNORECASE)

        # Thêm FlowerTypes và Suppliers
        print("🌸 Đang thêm FlowerTypes và Suppliers...")

        # Tìm vị trí để chèn (sau PresentationStyles OFF)
        insert_pos = content_fixed.find('SET IDENTITY_INSERT [dbo].[PresentationStyles] OFF')
        if insert_pos == -1:
            print("⚠️ Không tìm thấy vị trí để chèn FlowerTypes/Suppliers")
        else:
            # Di chuyển đến cuối dòng
            insert_pos = content_fixed.find('\n', insert_pos) + 1
            if content_fixed[insert_pos:insert_pos+2] == 'GO':
                insert_pos = content_fixed.find('\n', insert_pos) + 1

            flowertypes_sql = """
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
"""

            content_fixed = content_fixed[:insert_pos] + flowertypes_sql + content_fixed[insert_pos:]
            print("✅ Đã thêm FlowerTypes (9 records) và Suppliers (8 records)")

        # Ghi file mới
        output_file = 'BLOOMIE_FIXED.sql'
        print(f"\n💾 Đang ghi file mới: {output_file}...")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(content_fixed)

        print(f"✅ Hoàn tất! File đã được lưu: {output_file}")

        # Thống kê file mới
        presentations_fixed = len(re.findall(r'INSERT.*PresentationStyles.*BasePrice', content_fixed))
        flowertypes_new = len(re.findall(r'INSERT.*FlowerTypes', content_fixed))
        suppliers_new = len(re.findall(r'INSERT.*Suppliers', content_fixed))

        print(f"\n📊 Thống kê file mới:")
        print(f"   - Categories: {categories_count} records")
        print(f"   - PresentationStyles (đã fix): {presentations_fixed} records")
        print(f"   - FlowerTypes (mới): {flowertypes_new} records")
        print(f"   - Suppliers (mới): {suppliers_new} records")
        print(f"   - Products: {products_count} records")

        return 0

    except Exception as e:
        print(f"❌ Lỗi: {str(e)}")
        import traceback
        traceback.print_exc()
        return 1

if __name__ == '__main__':
    sys.exit(main())
