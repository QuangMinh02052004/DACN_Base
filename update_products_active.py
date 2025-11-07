"""
Script để update tất cả products thành IsActive = true
Sử dụng khi đã import SQL nhưng products không hiển thị
"""

import pyodbc

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
    print("Đang kết nối đến database...")
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()

    # Kiểm tra số products hiện có
    cursor.execute("SELECT COUNT(*) FROM Products")
    total = cursor.fetchone()[0]
    print(f"Tổng số products trong database: {total}")

    # Kiểm tra products active
    cursor.execute("SELECT COUNT(*) FROM Products WHERE IsActive = 1")
    active = cursor.fetchone()[0]
    print(f"Số products đang active: {active}")

    # Kiểm tra products có ImageUrl
    cursor.execute("SELECT COUNT(*) FROM Products WHERE ImageUrl IS NOT NULL AND ImageUrl != ''")
    with_image = cursor.fetchone()[0]
    print(f"Số products có ImageUrl: {with_image}")

    if total > 0 and active < total:
        print(f"\nCó {total - active} products chưa active.")
        response = input("Bạn có muốn set tất cả products thành IsActive = 1? (y/n): ")

        if response.lower() == 'y':
            cursor.execute("UPDATE Products SET IsActive = 1")
            conn.commit()
            print(f"✅ Đã update {cursor.rowcount} products thành active!")
    elif total == 0:
        print("\n⚠️ Database chưa có products. Vui lòng import SQL file trước!")
    else:
        print("\n✅ Tất cả products đã active!")

    cursor.close()
    conn.close()

except Exception as e:
    print(f"❌ Lỗi: {e}")
    print("\nGợi ý:")
    print("1. Cài đặt pyodbc: pip3 install pyodbc")
    print("2. Kiểm tra SQL Server đang chạy")
    print("3. Kiểm tra connection string")
