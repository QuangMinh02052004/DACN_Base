using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;
using Bloomie.Data;
using Bloomie.Services.Implementations;
using Bloomie.Services.Interfaces;
using Bloomie.Models.Entities;
using Bloomie.Areas.Admin.Models;
using Bloomie.Middleware;
using Bloomie.Models.Momo;
using Bloomie.Api.V1.Helpers;
using Bloomie.Api.V1.Filters;
using OfficeOpenXml;
using Python.Runtime;
using Bloomie.Hubs;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSignalR(); // Thư viện cho phép giao tiếp thời gian thực

// Connect MomoAPI
builder.Services.Configure<MomoOptionModel>(builder.Configuration.GetSection("MomoAPI"));
builder.Services.AddScoped<IMomoService, MomoService>();

// Cấu hình logging
builder.Services.AddLogging(logging =>
{
    logging.ClearProviders();
    logging.AddConsole(); // Ghi log ra console
    logging.AddDebug();   // Ghi log ra debug output (Visual Studio)
});

// Cấu hình Email Service
builder.Services.AddTransient<IEmailService, EmailService>();

// Cấu hình Session và Cache
builder.Services.AddDistributedMemoryCache();
builder.Services.AddHttpClient();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

// Cấu hình Controllers và Views
builder.Services.AddControllersWithViews();

// Cấu hình API Controllers
builder.Services.AddControllers(options =>
{
    options.Filters.Add<ApiExceptionFilter>();
})
.AddJsonOptions(options =>
{
    options.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles;
    options.JsonSerializerOptions.DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingNull;
});

// Cấu hình Swagger/OpenAPI
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Bloomie API",
        Version = "v1",
        Description = "API cho hệ thống bán hoa Bloomie",
        Contact = new OpenApiContact
        {
            Name = "Bloomie Team",
            Email = "support@bloomie.com"
        }
    });

    // Cấu hình JWT Authentication cho Swagger
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header sử dụng Bearer scheme. \r\n\r\n Nhập 'Bearer' [space] và sau đó nhập token.\r\n\r\nVí dụ: \"Bearer 12345abcdef\"",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                },
                Scheme = "oauth2",
                Name = "Bearer",
                In = ParameterLocation.Header
            },
            new List<string>()
        }
    });

    // Thêm XML comments nếu có
    var xmlFile = $"{System.Reflection.Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    if (File.Exists(xmlPath))
    {
        c.IncludeXmlComments(xmlPath);
    }
});

// Cấu hình CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });

    options.AddPolicy("AllowSpecificOrigins", policy =>
    {
        policy.WithOrigins(
            "http://localhost:3000",
            "http://localhost:5173",
            "http://localhost:4200"
        )
        .AllowAnyMethod()
        .AllowAnyHeader()
        .AllowCredentials();
    });
});

//builder.Services.AddControllers()
//    .AddApplicationPart(typeof(Bloomie.Areas.Admin.Controllers.NotificationsController).Assembly);

// Cấu hình Database
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddIdentity<ApplicationUser, IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>().AddDefaultTokenProviders();

builder.Services.Configure<IdentityOptions>(options =>
{
    // Password settings.
    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 8;
    options.Password.RequiredUniqueChars = 1;

    // Lockout settings.
    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(60);
    options.Lockout.MaxFailedAccessAttempts = 5;
    options.Lockout.AllowedForNewUsers = true;

    // User settings.
    options.User.AllowedUserNameCharacters =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._@+";
    options.User.RequireUniqueEmail = false;
});

builder.Services.ConfigureApplicationCookie(options =>
{
    // Cookie settings
    options.Cookie.HttpOnly = true;
    options.ExpireTimeSpan = TimeSpan.FromMinutes(30);

    options.LoginPath = "/Account/Login";
    options.AccessDeniedPath = "/Account/AccessDenied";
    options.SlidingExpiration = true;
});

// Cấu hình JWT Authentication cho API
var jwtSecretKey = builder.Configuration["Jwt:SecretKey"] ?? "YourSuperSecretKeyThatIsAtLeast32CharactersLong!!!";
var jwtIssuer = builder.Configuration["Jwt:Issuer"] ?? "BloomieAPI";
var jwtAudience = builder.Configuration["Jwt:Audience"] ?? "BloomieClient";

builder.Services.AddScoped<JwtHelper>();

// Cấu hình xác thực qua Google, Facebook, Twitter và JWT
builder.Services.AddAuthentication(options =>
{
    // Giữ Cookie làm default scheme cho MVC
    options.DefaultScheme = CookieAuthenticationDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;
})
.AddCookie(CookieAuthenticationDefaults.AuthenticationScheme)
.AddJwtBearer(JwtBearerDefaults.AuthenticationScheme, options =>
{
    options.SaveToken = true;
    options.RequireHttpsMetadata = false; // Set true trong production
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtIssuer,
        ValidAudience = jwtAudience,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSecretKey)),
        ClockSkew = TimeSpan.Zero
    };

    // Cho phép JWT token từ query string (cho SignalR)
    options.Events = new JwtBearerEvents
    {
        OnMessageReceived = context =>
        {
            var accessToken = context.Request.Query["access_token"];
            var path = context.HttpContext.Request.Path;
            if (!string.IsNullOrEmpty(accessToken) &&
                (path.StartsWithSegments("/notificationHub") || path.StartsWithSegments("/chatHub")))
            {
                context.Token = accessToken;
            }
            return Task.CompletedTask;
        }
    };
})
.AddGoogle(GoogleDefaults.AuthenticationScheme, options =>
{
    options.ClientId = builder.Configuration.GetSection("GoogleKeys:ClientId").Value;
    options.ClientSecret = builder.Configuration.GetSection("GoogleKeys:ClientSecret").Value;
}).AddFacebook(facebookOptions =>
{
    facebookOptions.AppId = builder.Configuration.GetSection("FacebookKeys:AppId").Value;
    facebookOptions.AppSecret = builder.Configuration.GetSection("FacebookKeys:AppSecret").Value;
    facebookOptions.SignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;

    // Xử lý lỗi ngay trong middleware
    facebookOptions.Events.OnRemoteFailure = context =>
    {
        context.Response.Redirect("/Account/Login?info=" + Uri.EscapeDataString("B?n ?ă h?y ??ng nh?p b?ng Facebook."));
        context.HandleResponse(); // Ngăn middleware tiếp tục xử lý
        return Task.CompletedTask;
    };
}).AddTwitter(twitterOptions =>
{
    twitterOptions.ConsumerKey = builder.Configuration.GetSection("TwitterKeys:ClientId").Value;
    twitterOptions.ConsumerSecret = builder.Configuration.GetSection("TwitterKeys:ClientSecret").Value;
}); ;

// Câus hình Data Protection
builder.Services.AddDataProtection()
    .PersistKeysToFileSystem(new DirectoryInfo(Path.Combine(Directory.GetCurrentDirectory(), "DataProtectionKeys")))
    .SetApplicationName("BloomieApp");


// Cấu hình GHN API
builder.Services.AddHttpClient("GHN", client =>
{
    client.BaseAddress = new Uri(builder.Configuration["GHN:BaseUrl"]);
    client.DefaultRequestHeaders.Add("Token", builder.Configuration["GHN:ApiToken"]);
});
builder.Services.AddScoped<IGHNService, GHNService>();

builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<ICategoryService, CategoryService>();
builder.Services.AddScoped<IPromotionService, PromotionService>();
builder.Services.AddScoped<IInventoryService, InventoryService>();
builder.Services.AddScoped<IOrderService, OrderService>();
builder.Services.AddScoped<IPaymentService, PaymentService>();
builder.Services.AddScoped<ICustomArrangementService, CustomArrangementService>();

// Cấu hình HttpClient cho GeminiService
builder.Services.AddHttpClient("GeminiClient", client =>
{
    client.Timeout = TimeSpan.FromMinutes(5); // AI API có thể mất thời gian
});

// Đăng ký AI Chat Service
builder.Services.AddScoped<IAIChatService, GeminiService>();

// Cấu hình HttpClient cho Image Similarity Service
builder.Services.AddHttpClient<IImageSimilarityService, ImageSimilarityService>(client =>
{
    client.Timeout = TimeSpan.FromMinutes(2);
});

// Cấu hình Excel (EPPlus)
ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

// Connect VNPay API
builder.Services.AddScoped<IVnPayService, VnPayService>();

var app = builder.Build();

// Tạo roles và admin account
using (var scope = app.Services.CreateScope())
{
    var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();
    var userManager = scope.ServiceProvider.GetRequiredService<UserManager<ApplicationUser>>();

    // Tạo roles
    string[] roles = new[] { "Admin", "User", "Manager", "Staff" };
    foreach (var role in roles)
    {
        if (!await roleManager.RoleExistsAsync(role))
        {
            await roleManager.CreateAsync(new IdentityRole { Name = role, NormalizedName = role.ToUpper() });
        }
    }

    // Tạo admin account
    string adminEmail = "admin@bloomie.com";
    string adminPassword = "Admin@123";
    string adminUserName = "admin";
    string adminFullName = "Administrator";

    var adminUser = await userManager.FindByEmailAsync(adminEmail);
    if (adminUser == null)
    {
        adminUser = new ApplicationUser
        {
            UserName = adminUserName,
            Email = adminEmail,
            FullName = adminFullName,
            RoleId = (await roleManager.FindByNameAsync("Admin"))?.Id, // Gán RoleId của Admin
            Token = Guid.NewGuid().ToString() // Gán giá trị Token ngẫu nhiên
        };
        var result = await userManager.CreateAsync(adminUser, adminPassword);
        if (result.Succeeded)
        {
            await userManager.AddToRoleAsync(adminUser, "Admin");
        }
    }
}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Bloomie API V1");
        c.RoutePrefix = "api/docs"; // Swagger UI sẽ có tại /api/docs
        c.DocumentTitle = "Bloomie API Documentation";
    });
}
else
{
    app.UseExceptionHandler("/Home/Error");
}

// Enable CORS
app.UseCors("AllowSpecificOrigins"); // Hoặc "AllowAll" nếu muốn cho phép tất cả

app.UseStaticFiles();
app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();
app.UseSession();

// Đăng ký middleware để ghi log truy cập người dùng
app.UseUserAccessLogging();

app.UseEndpoints(endpoints =>
{
    endpoints.MapHub<NotificationHub>("/notificationHub");
    endpoints.MapHub<ChatHub>("/chatHub");

    // API routes (sử dụng attribute routing)
    endpoints.MapControllers();

    // MVC routes
    endpoints.MapControllerRoute(
        name: "areas",
        pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}");
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=Home}/{action=Index}/{id?}");
});

//app.MapAreaControllerRoute(
//    name: "admin",
//    areaName: "Admin",
//    pattern: "Admin/{controller=Home}/{action=Index}/{id?}");
//app.MapControllers();

//app.MapRazorPages();
//app.MapControllerRoute(
//    name: "default",
//    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();