using System.ComponentModel.DataAnnotations;

namespace Bloomie.Api.V1.DTOs.Requests;

/// <summary>
/// Request DTO cho login
/// </summary>
public class LoginRequest
{
    [Required(ErrorMessage = "Email hoặc username là bắt buộc")]
    public string UserNameOrEmail { get; set; } = string.Empty;

    [Required(ErrorMessage = "Mật khẩu là bắt buộc")]
    [DataType(DataType.Password)]
    public string Password { get; set; } = string.Empty;

    public bool RememberMe { get; set; } = false;
}

/// <summary>
/// Request DTO cho register
/// </summary>
public class RegisterRequest
{
    [Required(ErrorMessage = "Username là bắt buộc")]
    [StringLength(50, MinimumLength = 3, ErrorMessage = "Username phải từ 3-50 ký tự")]
    public string UserName { get; set; } = string.Empty;

    [Required(ErrorMessage = "Email là bắt buộc")]
    [EmailAddress(ErrorMessage = "Email không hợp lệ")]
    public string Email { get; set; } = string.Empty;

    [Required(ErrorMessage = "Mật khẩu là bắt buộc")]
    [StringLength(100, MinimumLength = 6, ErrorMessage = "Mật khẩu phải từ 6-100 ký tự")]
    [DataType(DataType.Password)]
    public string Password { get; set; } = string.Empty;

    [Required(ErrorMessage = "Xác nhận mật khẩu là bắt buộc")]
    [Compare("Password", ErrorMessage = "Mật khẩu không khớp")]
    [DataType(DataType.Password)]
    public string ConfirmPassword { get; set; } = string.Empty;

    [Phone(ErrorMessage = "Số điện thoại không hợp lệ")]
    public string? PhoneNumber { get; set; }

    public string? FullName { get; set; }
}

/// <summary>
/// Request DTO cho password reset
/// </summary>
public class ForgotPasswordRequest
{
    [Required(ErrorMessage = "Email là bắt buộc")]
    [EmailAddress(ErrorMessage = "Email không hợp lệ")]
    public string Email { get; set; } = string.Empty;
}

/// <summary>
/// Request DTO cho change password
/// </summary>
public class ChangePasswordRequest
{
    [Required(ErrorMessage = "Mật khẩu hiện tại là bắt buộc")]
    [DataType(DataType.Password)]
    public string CurrentPassword { get; set; } = string.Empty;

    [Required(ErrorMessage = "Mật khẩu mới là bắt buộc")]
    [StringLength(100, MinimumLength = 6, ErrorMessage = "Mật khẩu phải từ 6-100 ký tự")]
    [DataType(DataType.Password)]
    public string NewPassword { get; set; } = string.Empty;

    [Required(ErrorMessage = "Xác nhận mật khẩu là bắt buộc")]
    [Compare("NewPassword", ErrorMessage = "Mật khẩu không khớp")]
    [DataType(DataType.Password)]
    public string ConfirmPassword { get; set; } = string.Empty;
}

/// <summary>
/// Request DTO cho refresh token
/// </summary>
public class RefreshTokenRequest
{
    [Required(ErrorMessage = "Token là bắt buộc")]
    public string Token { get; set; } = string.Empty;

    [Required(ErrorMessage = "Refresh token là bắt buộc")]
    public string RefreshToken { get; set; } = string.Empty;
}
