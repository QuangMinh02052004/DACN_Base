# Bloomie API Documentation

## Tổng quan

Bloomie API là RESTful API cho hệ thống bán hoa trực tuyến, hỗ trợ quản lý sản phẩm, đơn hàng, giỏ hàng và xác thực người dùng.

## Cấu trúc thư mục

```
Api/
├── V1/
│   ├── Controllers/         # API Controllers
│   │   ├── AuthController.cs
│   │   ├── ProductsController.cs
│   │   ├── OrdersController.cs
│   │   └── CartController.cs
│   ├── DTOs/               # Data Transfer Objects
│   │   ├── Requests/       # Request DTOs
│   │   └── Responses/      # Response DTOs
│   ├── Helpers/            # Helper classes
│   │   └── JwtHelper.cs
│   └── Filters/            # Action Filters
│       └── ApiExceptionFilter.cs
└── README.md
```

## Bắt đầu

### 1. Cài đặt dependencies

Đảm bảo project đã cài đặt các NuGet packages sau:

```bash
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer
dotnet add package Swashbuckle.AspNetCore
dotnet add package Microsoft.IdentityModel.Tokens
dotnet add package System.IdentityModel.Tokens.Jwt
```

### 2. Cấu hình appsettings.json

File [appsettings.json](../appsettings.json) đã được cấu hình với JWT settings:

```json
{
  "Jwt": {
    "SecretKey": "YourSuperSecretKeyThatIsAtLeast32CharactersLong!!!ChangeMeInProduction",
    "Issuer": "BloomieAPI",
    "Audience": "BloomieClient",
    "TokenExpiryMinutes": 60,
    "RefreshTokenExpiryDays": 7
  }
}
```

**⚠️ Quan trọng:** Trong production, hãy thay đổi `SecretKey` thành một chuỗi bí mật mạnh và lưu trong environment variables.

### 3. Chạy ứng dụng

```bash
dotnet run
```

### 4. Truy cập Swagger UI

Mở trình duyệt và truy cập:
- **Swagger UI:** http://localhost:5187/api/docs
- **Swagger JSON:** http://localhost:5187/swagger/v1/swagger.json

## Authentication

API sử dụng JWT (JSON Web Token) để xác thực.

### Đăng ký tài khoản

```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "userName": "user123",
  "email": "user@example.com",
  "password": "Password@123",
  "confirmPassword": "Password@123",
  "fullName": "Nguyen Van A",
  "phoneNumber": "0901234567"
}
```

### Đăng nhập

```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "userNameOrEmail": "user@example.com",
  "password": "Password@123",
  "rememberMe": false
}
```

**Response:**

```json
{
  "success": true,
  "message": "Đăng nhập thành công",
  "data": {
    "success": true,
    "message": "Đăng nhập thành công",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "base64encodedrefreshtoken",
    "expiresAt": "2024-01-01T12:00:00Z",
    "user": {
      "userId": "123",
      "userName": "user123",
      "email": "user@example.com",
      "fullName": "Nguyen Van A",
      "roles": ["User"]
    }
  }
}
```

### Sử dụng Token

Thêm token vào header của mỗi request:

```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

## API Endpoints

### Auth Controller (`/api/v1/auth`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/register` | Đăng ký tài khoản mới | No |
| POST | `/login` | Đăng nhập | No |
| GET | `/me` | Lấy thông tin user hiện tại | Yes |
| POST | `/logout` | Đăng xuất | Yes |
| POST | `/change-password` | Đổi mật khẩu | Yes |

### Products Controller (`/api/v1/products`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | Lấy danh sách products với filter/pagination | No |
| GET | `/{id}` | Lấy chi tiết product | No |
| POST | `/` | Tạo product mới | Yes (Admin/Manager) |
| PUT | `/{id}` | Cập nhật product | Yes (Admin/Manager) |
| DELETE | `/{id}` | Xóa product | Yes (Admin) |
| POST | `/{id}/ratings` | Đánh giá product | Yes |
| POST | `/search-by-image` | Tìm kiếm bằng hình ảnh | No |

### Orders Controller (`/api/v1/orders`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | Lấy orders của user hiện tại | Yes |
| GET | `/all` | Lấy tất cả orders (Admin/Staff) | Yes (Admin/Staff) |
| GET | `/{id}` | Lấy chi tiết order | Yes |
| POST | `/` | Tạo order mới | Yes |
| PATCH | `/{id}/status` | Cập nhật trạng thái order | Yes (Admin/Staff) |
| POST | `/{id}/cancel` | Hủy order | Yes |

### Cart Controller (`/api/v1/cart`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | Lấy giỏ hàng hiện tại | Yes |
| POST | `/items` | Thêm sản phẩm vào giỏ | Yes |
| PUT | `/items/{itemId}` | Cập nhật số lượng item | Yes |
| DELETE | `/items/{itemId}` | Xóa item khỏi giỏ | Yes |
| DELETE | `/` | Xóa toàn bộ giỏ hàng | Yes |

## Request/Response Examples

### Lấy danh sách products với filter

```http
GET /api/v1/products?keyword=hoa&categoryId=1&minPrice=100000&maxPrice=500000&page=1&pageSize=20
```

**Response:**

```json
{
  "success": true,
  "message": "Lấy danh sách sản phẩm thành công",
  "data": [
    {
      "productId": 1,
      "productName": "Hoa Hồng Đỏ",
      "price": 200000,
      "discountedPrice": 180000,
      "stockQuantity": 50,
      "isAvailable": true,
      "categoryName": "Hoa Tươi",
      "primaryImage": "/images/products/rose.jpg",
      "averageRating": 4.5,
      "totalRatings": 10
    }
  ],
  "meta": {
    "currentPage": 1,
    "pageSize": 20,
    "totalPages": 5,
    "totalCount": 100,
    "hasPrevious": false,
    "hasNext": true
  }
}
```

### Thêm sản phẩm vào giỏ hàng

```http
POST /api/v1/cart/items
Authorization: Bearer <token>
Content-Type: application/json

{
  "productId": 1,
  "quantity": 2
}
```

### Tạo đơn hàng mới

```http
POST /api/v1/orders
Authorization: Bearer <token>
Content-Type: application/json

{
  "customerName": "Nguyen Van A",
  "customerPhone": "0901234567",
  "shippingAddress": "123 Nguyen Trai, Q1, TP.HCM",
  "paymentMethod": "COD",
  "notes": "Giao hàng giờ hành chính",
  "items": [
    {
      "productId": 1,
      "quantity": 2
    }
  ]
}
```

## Error Handling

Tất cả các API endpoints đều trả về response theo format chuẩn:

### Success Response

```json
{
  "success": true,
  "message": "Thành công",
  "data": { ... },
  "meta": { ... }
}
```

### Error Response

```json
{
  "success": false,
  "message": "Lỗi xảy ra",
  "errors": [
    "Chi tiết lỗi 1",
    "Chi tiết lỗi 2"
  ]
}
```

### HTTP Status Codes

| Code | Description |
|------|-------------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Internal Server Error |

## CORS Configuration

API đã được cấu hình CORS để chấp nhận requests từ:
- http://localhost:3000 (React)
- http://localhost:5173 (Vite)
- http://localhost:4200 (Angular)

Để thêm origin khác, cập nhật [Program.cs](../Program.cs):

```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins", policy =>
    {
        policy.WithOrigins(
            "http://localhost:3000",
            "http://your-frontend-url.com"
        )
        .AllowAnyMethod()
        .AllowAnyHeader()
        .AllowCredentials();
    });
});
```

## Testing với cURL

### Đăng nhập

```bash
curl -X POST http://localhost:5187/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "userNameOrEmail": "admin@bloomie.com",
    "password": "Admin@123"
  }'
```

### Lấy products

```bash
curl -X GET "http://localhost:5187/api/v1/products?page=1&pageSize=10"
```

### Lấy giỏ hàng (với authentication)

```bash
curl -X GET http://localhost:5187/api/v1/cart \
  -H "Authorization: Bearer <your-token>"
```

## Best Practices

1. **Security:**
   - Luôn sử dụng HTTPS trong production
   - Thay đổi JWT SecretKey trong production
   - Lưu sensitive data trong environment variables
   - Implement rate limiting cho API endpoints

2. **Performance:**
   - Sử dụng pagination cho danh sách lớn
   - Cache response khi có thể
   - Optimize database queries

3. **Versioning:**
   - API hiện tại là V1 (`/api/v1/`)
   - Khi cần breaking changes, tạo V2 (`/api/v2/`)

4. **Documentation:**
   - Luôn cập nhật Swagger comments
   - Document các thay đổi trong CHANGELOG

## Troubleshooting

### 401 Unauthorized

- Kiểm tra token có hợp lệ không
- Kiểm tra token có expired không
- Kiểm tra header Authorization có đúng format không

### 403 Forbidden

- User không có quyền truy cập endpoint này
- Kiểm tra roles của user

### CORS Error

- Thêm origin của frontend vào CORS policy
- Kiểm tra CORS middleware trong [Program.cs](../Program.cs)

## Liên hệ

Nếu có câu hỏi hoặc vấn đề, vui lòng liên hệ:
- Email: support@bloomie.com
- Team: Bloomie Development Team
