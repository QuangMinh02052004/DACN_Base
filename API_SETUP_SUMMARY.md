# Tóm tắt - Cấu trúc API đã được tạo

## ✅ Đã hoàn thành

### 1. Cấu trúc thư mục API

Đã tạo thư mục [Api/V1/](Api/V1/) với cấu trúc:
```
Api/
├── V1/
│   ├── Controllers/         # 4 API Controllers
│   │   ├── AuthController.cs
│   │   ├── ProductsController.cs
│   │   ├── OrdersController.cs
│   │   └── CartController.cs
│   ├── DTOs/
│   │   ├── Requests/       # Request DTOs
│   │   │   ├── AuthRequests.cs
│   │   │   ├── ProductRequests.cs
│   │   │   ├── OrderRequests.cs
│   │   │   └── CartRequests.cs
│   │   └── Responses/      # Response DTOs
│   │       ├── ApiResponse.cs
│   │       ├── ProductDto.cs
│   │       ├── OrderDto.cs
│   │       ├── AuthDto.cs
│   │       ├── CategoryDto.cs
│   │       └── CartDto.cs
│   ├── Helpers/
│   │   └── JwtHelper.cs    # JWT token generation & validation
│   └── Filters/
│       └── ApiExceptionFilter.cs  # Global exception handling
└── README.md              # API Documentation
```

### 2. NuGet Packages đã cài đặt

```xml
<PackageReference Include="Microsoft.AspNetCore.Authentication.JwtBearer" Version="8.0.11" />
<PackageReference Include="Swashbuckle.AspNetCore" Version="6.9.0" />
```

### 3. Cấu hình đã thêm

#### [Program.cs](Program.cs:18-19)
- ✅ JWT Authentication với Bearer scheme
- ✅ Swagger/OpenAPI configuration
- ✅ CORS policy (AllowSpecificOrigins & AllowAll)
- ✅ API Controllers với attribute routing
- ✅ Global exception filter (ApiExceptionFilter)
- ✅ JSON serialization options (ReferenceHandler, IgnoreCycles)

#### [appsettings.json](appsettings.json:51-57)
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

### 4. API Controllers đã tạo

#### AuthController
- ✅ POST `/api/v1/auth/login` - Đăng nhập
- ✅ POST `/api/v1/auth/register` - Đăng ký
- ✅ GET `/api/v1/auth/me` - Thông tin user hiện tại
- ✅ POST `/api/v1/auth/logout` - Đăng xuất
- ✅ POST `/api/v1/auth/change-password` - Đổi mật khẩu

#### ProductsController
- ✅ GET `/api/v1/products` - Danh sách products (pagination, filter)
- ✅ GET `/api/v1/products/{id}` - Chi tiết product
- ⚠️ POST `/api/v1/products` - Tạo product (cần implement)
- ⚠️ PUT `/api/v1/products/{id}` - Cập nhật product (cần implement)
- ✅ DELETE `/api/v1/products/{id}` - Xóa product
- ⚠️ POST `/api/v1/products/{id}/ratings` - Đánh giá (cần implement)
- ⚠️ POST `/api/v1/products/search-by-image` - Tìm kiếm bằng ảnh (cần implement)

#### OrdersController
- ✅ GET `/api/v1/orders` - Orders của user
- ✅ GET `/api/v1/orders/all` - Tất cả orders (Admin/Staff)
- ✅ GET `/api/v1/orders/{id}` - Chi tiết order
- ⚠️ POST `/api/v1/orders` - Tạo order (cần implement)
- ⚠️ PATCH `/api/v1/orders/{id}/status` - Cập nhật status (cần implement)
- ⚠️ POST `/api/v1/orders/{id}/cancel` - Hủy order (cần implement)

#### CartController ⚠️
- ⚠️ Cần điều chỉnh hoàn toàn (xem mục "Cần điều chỉnh" bên dưới)

---

## ⚠️ Cần điều chỉnh

### 1. CartController - VẤN ĐỀ QUAN TRỌNG

**Vấn đề:** CartController hiện tại sử dụng ApplicationDbContext để truy vấn `ShoppingCart` và `CartItem`, nhưng trong codebase của bạn:
- `ShoppingCart` và `CartItem` là **in-memory models** (không có DbSet trong ApplicationDbContext)
- Chúng được lưu trong **Session**, không phải database

**Giải pháp:**

#### Tùy chọn 1: Sử dụng Session-based Cart (như hiện tại)

Sửa [Api/V1/Controllers/CartController.cs](Api/V1/Controllers/CartController.cs) để sử dụng Session:

```csharp
private ShoppingCart GetCart()
{
    var cart = HttpContext.Session.GetObjectFromJson<ShoppingCart>("Cart");
    if (cart == null)
    {
        cart = new ShoppingCart { UserId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "" };
        HttpContext.Session.SetObjectAsJson("Cart", cart);
    }
    return cart;
}

private void SaveCart(ShoppingCart cart)
{
    HttpContext.Session.SetObjectAsJson("Cart", cart);
}
```

#### Tùy chọn 2: Tạo database tables cho Cart (khuyến nghị cho API)

1. Thêm DbSet vào [Data/ApplicationDbContext.cs](Data/ApplicationDbContext.cs):
```csharp
public DbSet<ShoppingCart> ShoppingCarts { get; set; }
public DbSet<CartItem> CartItems { get; set; }
```

2. Cập nhật entities [Models/Entities/ShoppingCart.cs](Models/Entities/ShoppingCart.cs) và [Models/Entities/CartItem.cs](Models/Entities/CartItem.cs):
```csharp
// ShoppingCart.cs
public class ShoppingCart
{
    public int CartId { get; set; }  // Primary Key
    public string UserId { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public List<CartItem> CartItems { get; set; } = new();
}

// CartItem.cs
public class CartItem
{
    public int CartItemId { get; set; }  // Primary Key
    public int CartId { get; set; }      // Foreign Key
    public ShoppingCart Cart { get; set; }  // Navigation property
    public int ProductId { get; set; }
    public Product Product { get; set; }  // Navigation property
    public int Quantity { get; set; }
    public DateTime AddedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    // ... other properties
}
```

3. Tạo migration:
```bash
dotnet ef migrations add AddShoppingCartTables
dotnet ef database update
```

### 2. Service Methods cần implement

Một số API endpoints cần bổ sung methods trong Services:

#### IProductService
```csharp
Task<Product> CreateProductAsync(CreateProductRequest request);
Task<Product> UpdateProductAsync(int id, UpdateProductRequest request);
Task CreateRatingAsync(int productId, string userId, CreateRatingRequest request);
Task<List<Product>> SearchByImageAsync(IFormFile image);
```

#### IOrderService
```csharp
Task<List<Order>> GetAllOrdersAsync();  // For admin
Task<Order> CreateOrderAsync(string userId, CreateOrderRequest request);
Task<Order> UpdateOrderStatusAsync(int orderId, string status, string notes, string changedBy);
Task<bool> CancelOrderAsync(int orderId, string userId);
```

### 3. Swagger XML Documentation (Tùy chọn)

Để enable XML comments trong Swagger, thêm vào [Bloomie.csproj](Bloomie.csproj):

```xml
<PropertyGroup>
  <GenerateDocumentationFile>true</GenerateDocumentationFile>
  <NoWarn>$(NoWarn);1591</NoWarn>
</PropertyGroup>
```

### 4. Các endpoints còn TODO

Các endpoints được đánh dấu `StatusCode(501)` trong controllers:
- ✅ Đã có logic outline
- ❌ Cần implement business logic

---

## 🚀 Cách sử dụng

### 1. Chạy ứng dụng

```bash
dotnet run
```

### 2. Truy cập Swagger UI

Mở trình duyệt:
- **Swagger UI:** http://localhost:5187/api/docs
- **API Base URL:** http://localhost:5187/api/v1/

### 3. Test API

#### Đăng nhập để lấy token:
```bash
curl -X POST http://localhost:5187/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "userNameOrEmail": "admin@bloomie.com",
    "password": "Admin@123"
  }'
```

#### Sử dụng token:
```bash
curl -X GET http://localhost:5187/api/v1/products \
  -H "Authorization: Bearer <your-token-here>"
```

### 4. Test với Swagger UI

1. Vào http://localhost:5187/api/docs
2. Click vào `POST /api/v1/auth/login`
3. Click "Try it out"
4. Nhập credentials:
   ```json
   {
     "userNameOrEmail": "admin@bloomie.com",
     "password": "Admin@123"
   }
   ```
5. Copy token từ response
6. Click nút "Authorize" ở góc phải trên
7. Nhập: `Bearer <token>`
8. Bây giờ bạn có thể test các endpoints khác

---

## 📝 Lưu ý bảo mật

### Production Checklist

1. **JWT SecretKey:**
   ```bash
   # Tạo secret key mạnh
   openssl rand -base64 64

   # Lưu vào environment variable
   export Jwt__SecretKey="<generated-key>"
   ```

2. **HTTPS:**
   - Trong production, set `options.RequireHttpsMetadata = true` trong JWT config
   - Enable HTTPS trong [appsettings.Production.json](appsettings.Production.json)

3. **CORS:**
   - Chỉ allow origins cụ thể, không dùng "AllowAll" trong production
   - Update origins trong [Program.cs](Program.cs:130-140)

4. **Rate Limiting:**
   - Implement rate limiting cho API endpoints
   - Sử dụng AspNetCoreRateLimit package

5. **API Versioning:**
   - Hiện tại đang ở V1
   - Khi có breaking changes, tạo V2

---

## 📚 Tài liệu tham khảo

- [API Documentation](Api/README.md)
- [Swagger UI](http://localhost:5187/api/docs) (khi chạy app)
- [JWT Authentication](https://jwt.io/)
- [ASP.NET Core Web API](https://docs.microsoft.com/en-us/aspnet/core/web-api/)

---

## 🔧 Troubleshooting

### Build errors về ShoppingCart/CartItem

**Lỗi:**
```
error CS1061: 'ApplicationDbContext' does not contain a definition for 'ShoppingCarts'
```

**Giải pháp:**
Xem mục "Cần điều chỉnh" > "CartController" ở trên

### CORS errors

**Lỗi:** Browser console hiện "CORS policy blocked"

**Giải pháp:**
1. Thêm origin của frontend vào CORS policy trong [Program.cs](Program.cs:130-140)
2. Đảm bảo CORS middleware được gọi trước Authentication

### 401 Unauthorized

**Nguyên nhân:** Token expired hoặc invalid

**Giải pháp:**
1. Đăng nhập lại để lấy token mới
2. Kiểm tra header: `Authorization: Bearer <token>`
3. Verify token tại https://jwt.io

---

## 🎯 Next Steps

1. ✅ Đọc [API Documentation](Api/README.md)
2. ⚠️ Quyết định strategy cho Cart (Session vs Database)
3. ⚠️ Implement các service methods còn thiếu
4. ⚠️ Tạo migrations nếu chọn database-based cart
5. ✅ Test tất cả endpoints qua Swagger UI
6. ✅ Update frontend để sử dụng API endpoints

---

## 📞 Hỗ trợ

Nếu cần hỗ trợ:
1. Đọc [Api/README.md](Api/README.md)
2. Check Swagger documentation tại /api/docs
3. Review source code trong [Api/V1/Controllers/](Api/V1/Controllers/)
