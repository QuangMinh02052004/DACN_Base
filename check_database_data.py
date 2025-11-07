#!/usr/bin/env python3
"""
Kiểm tra dữ liệu trong database Bloomie
"""

import pyodbc

def main():
    # Connection string
    conn_str = (
        "DRIVER={ODBC Driver 18 for SQL Server};"
        "SERVER=localhost,1433;"
        "DATABASE=Bloomie;"
        "UID=sa;"
        "PWD=Minhlion02052004;"
        "TrustServerCertificate=yes;"
    )

    try:
        print("🔌 Đang kết nối database...")
        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()

        # Kiểm tra số lượng records
        print("\n📊 THỐNG KÊ DỮ LIỆU TRONG DATABASE:\n")

        tables = [
            'Categories',
            'PresentationStyles',
            'FlowerTypes',
            'Suppliers',
            'Products',
            'AspNetUsers',
            'AspNetRoles'
        ]

        for table in tables:
            cursor.execute(f"SELECT COUNT(*) FROM {table}")
            count = cursor.fetchone()[0]
            print(f"   {table:25s}: {count:4d} records")

        # Kiểm tra PresentationStyles có BasePrice không
        print("\n📋 PRESENTATION STYLES (kiểm tra BasePrice):\n")
        cursor.execute("SELECT TOP 5 Id, Name, BasePrice FROM PresentationStyles")
        rows = cursor.fetchall()
        for row in rows:
            print(f"   ID {row[0]:2d}: {row[1]:30s} - BasePrice: {row[2]:,.0f} VND")

        # Kiểm tra FlowerTypes có UnitPrice không
        print("\n🌸 FLOWER TYPES (kiểm tra UnitPrice):\n")
        cursor.execute("SELECT TOP 5 Id, Name, UnitPrice FROM FlowerTypes")
        rows = cursor.fetchall()
        for row in rows:
            unit_price = row[2] if row[2] else 0
            print(f"   ID {row[0]:2d}: {row[1]:30s} - UnitPrice: {unit_price:,.0f} VND")

        # Kiểm tra Products
        print("\n🛍️  PRODUCTS (TOP 5):\n")
        cursor.execute("""
            SELECT TOP 5
                Id,
                Name,
                Price,
                CategoryId,
                PresentationStyleId,
                IsActive,
                CASE WHEN ImageUrl IS NULL THEN 'NULL' ELSE 'OK' END as ImageUrl
            FROM Products
        """)
        rows = cursor.fetchall()
        for row in rows:
            print(f"   ID {row[0]:3d}: {row[1][:40]:40s} - {row[2]:>10,.0f} VND - Cat:{row[3]:2d} PS:{row[4]:2d} Active:{row[5]} Img:{row[6]}")

        cursor.close()
        conn.close()

        print("\n✅ Kiểm tra hoàn tất!")

    except Exception as e:
        print(f"\n❌ Lỗi: {str(e)}")
        import traceback
        traceback.print_exc()
        return 1

    return 0

if __name__ == '__main__':
    import sys
    sys.exit(main())
