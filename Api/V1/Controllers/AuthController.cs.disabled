using Bloomie.Api.V1.DTOs.Requests;
using Bloomie.Api.V1.DTOs.Responses;
using Bloomie.Api.V1.Helpers;
using Bloomie.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Bloomie.Api.V1.Controllers;

/// <summary>
/// API Controller cho Authentication và Authorization
/// </summary>
[ApiController]
[Route("api/v1/[controller]")]
[Produces("application/json")]
public class AuthController : ControllerBase
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly SignInManager<ApplicationUser> _signInManager;
    private readonly JwtHelper _jwtHelper;
    private readonly ILogger<AuthController> _logger;

    public AuthController(
        UserManager<ApplicationUser> userManager,
        SignInManager<ApplicationUser> signInManager,
        JwtHelper jwtHelper,
        ILogger<AuthController> logger)
    {
        _userManager = userManager;
        _signInManager = signInManager;
        _jwtHelper = jwtHelper;
        _logger = logger;
    }

    /// <summary>
    /// Đăng nhập
    /// </summary>
    [HttpPost("login")]
    [AllowAnonymous]
    public async Task<ActionResult<ApiResponse<AuthResponseDto>>> Login([FromBody] LoginRequest request)
    {
        try
        {
            // Tìm user theo email hoặc username
            var user = await _userManager.FindByEmailAsync(request.UserNameOrEmail)
                ?? await _userManager.FindByNameAsync(request.UserNameOrEmail);

            if (user == null)
            {
                return Ok(ApiResponse<AuthResponseDto>.ErrorResponse("Tên đăng nhập hoặc mật khẩu không đúng"));
            }

            var result = await _signInManager.CheckPasswordSignInAsync(user, request.Password, lockoutOnFailure: true);

            if (!result.Succeeded)
            {
                if (result.IsLockedOut)
                {
                    return Ok(ApiResponse<AuthResponseDto>.ErrorResponse("Tài khoản đã bị khóa do đăng nhập sai nhiều lần"));
                }
                return Ok(ApiResponse<AuthResponseDto>.ErrorResponse("Tên đăng nhập hoặc mật khẩu không đúng"));
            }

            // Lấy roles của user
            var roles = await _userManager.GetRolesAsync(user);

            // Tạo JWT token
            var token = _jwtHelper.GenerateAccessToken(user.Id, user.UserName!, user.Email!, roles.ToList());
            var refreshToken = _jwtHelper.GenerateRefreshToken();

            // Lưu refresh token vào database (nếu có table RefreshToken)
            // TODO: Implement refresh token storage

            var authResponse = new AuthResponseDto
            {
                Success = true,
                Message = "Đăng nhập thành công",
                Token = token,
                RefreshToken = refreshToken,
                ExpiresAt = DateTime.UtcNow.AddMinutes(60),
                User = new UserDto
                {
                    UserId = user.Id,
                    UserName = user.UserName!,
                    Email = user.Email!,
                    FullName = user.FullName,
                    PhoneNumber = user.PhoneNumber,
                    Roles = roles.ToList()
                }
            };

            return Ok(ApiResponse<AuthResponseDto>.SuccessResponse(authResponse, "Đăng nhập thành công"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during login");
            return StatusCode(500, ApiResponse<AuthResponseDto>.ErrorResponse("Đã xảy ra lỗi khi đăng nhập"));
        }
    }

    /// <summary>
    /// Đăng ký tài khoản mới
    /// </summary>
    [HttpPost("register")]
    [AllowAnonymous]
    public async Task<ActionResult<ApiResponse<AuthResponseDto>>> Register([FromBody] RegisterRequest request)
    {
        try
        {
            // Kiểm tra email đã tồn tại chưa
            var existingUser = await _userManager.FindByEmailAsync(request.Email);
            if (existingUser != null)
            {
                return Ok(ApiResponse<AuthResponseDto>.ErrorResponse("Email đã được sử dụng"));
            }

            // Kiểm tra username đã tồn tại chưa
            existingUser = await _userManager.FindByNameAsync(request.UserName);
            if (existingUser != null)
            {
                return Ok(ApiResponse<AuthResponseDto>.ErrorResponse("Username đã được sử dụng"));
            }

            // Tạo user mới
            var user = new ApplicationUser
            {
                UserName = request.UserName,
                Email = request.Email,
                FullName = request.FullName,
                PhoneNumber = request.PhoneNumber,
                Token = Guid.NewGuid().ToString()
            };

            var result = await _userManager.CreateAsync(user, request.Password);

            if (!result.Succeeded)
            {
                var errors = result.Errors.Select(e => e.Description).ToList();
                return Ok(ApiResponse<AuthResponseDto>.ErrorResponse("Đăng ký thất bại", errors));
            }

            // Thêm role User mặc định
            await _userManager.AddToRoleAsync(user, "User");

            // Tạo token và trả về
            var roles = new List<string> { "User" };
            var token = _jwtHelper.GenerateAccessToken(user.Id, user.UserName, user.Email, roles);
            var refreshToken = _jwtHelper.GenerateRefreshToken();

            var authResponse = new AuthResponseDto
            {
                Success = true,
                Message = "Đăng ký thành công",
                Token = token,
                RefreshToken = refreshToken,
                ExpiresAt = DateTime.UtcNow.AddMinutes(60),
                User = new UserDto
                {
                    UserId = user.Id,
                    UserName = user.UserName,
                    Email = user.Email,
                    FullName = user.FullName,
                    PhoneNumber = user.PhoneNumber,
                    Roles = roles
                }
            };

            return Ok(ApiResponse<AuthResponseDto>.SuccessResponse(authResponse, "Đăng ký thành công"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during registration");
            return StatusCode(500, ApiResponse<AuthResponseDto>.ErrorResponse("Đã xảy ra lỗi khi đăng ký"));
        }
    }

    /// <summary>
    /// Lấy thông tin user hiện tại
    /// </summary>
    [HttpGet("me")]
    [Authorize]
    public async Task<ActionResult<ApiResponse<UserProfileDto>>> GetCurrentUser()
    {
        try
        {
            var userId = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(ApiResponse<UserProfileDto>.ErrorResponse("Unauthorized"));
            }

            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return NotFound(ApiResponse<UserProfileDto>.ErrorResponse("User not found"));
            }

            var roles = await _userManager.GetRolesAsync(user);

            var userProfile = new UserProfileDto
            {
                UserId = user.Id,
                UserName = user.UserName!,
                Email = user.Email!,
                FullName = user.FullName,
                PhoneNumber = user.PhoneNumber,
                Roles = roles.ToList(),
                EmailConfirmed = user.EmailConfirmed,
                PhoneNumberConfirmed = user.PhoneNumberConfirmed,
                TwoFactorEnabled = user.TwoFactorEnabled
            };

            return Ok(ApiResponse<UserProfileDto>.SuccessResponse(userProfile));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting current user");
            return StatusCode(500, ApiResponse<UserProfileDto>.ErrorResponse("Đã xảy ra lỗi"));
        }
    }

    /// <summary>
    /// Đăng xuất
    /// </summary>
    [HttpPost("logout")]
    [Authorize]
    public async Task<ActionResult<ApiResponse<object>>> Logout()
    {
        try
        {
            await _signInManager.SignOutAsync();
            // TODO: Revoke refresh token from database
            return Ok(ApiResponse<object>.SuccessResponse(null, "Đăng xuất thành công"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error during logout");
            return StatusCode(500, ApiResponse<object>.ErrorResponse("Đã xảy ra lỗi khi đăng xuất"));
        }
    }

    /// <summary>
    /// Đổi mật khẩu
    /// </summary>
    [HttpPost("change-password")]
    [Authorize]
    public async Task<ActionResult<ApiResponse<object>>> ChangePassword([FromBody] ChangePasswordRequest request)
    {
        try
        {
            var userId = User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(ApiResponse<object>.ErrorResponse("Unauthorized"));
            }

            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return NotFound(ApiResponse<object>.ErrorResponse("User not found"));
            }

            var result = await _userManager.ChangePasswordAsync(user, request.CurrentPassword, request.NewPassword);

            if (!result.Succeeded)
            {
                var errors = result.Errors.Select(e => e.Description).ToList();
                return Ok(ApiResponse<object>.ErrorResponse("Đổi mật khẩu thất bại", errors));
            }

            return Ok(ApiResponse<object>.SuccessResponse(null, "Đổi mật khẩu thành công"));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error changing password");
            return StatusCode(500, ApiResponse<object>.ErrorResponse("Đã xảy ra lỗi khi đổi mật khẩu"));
        }
    }
}
