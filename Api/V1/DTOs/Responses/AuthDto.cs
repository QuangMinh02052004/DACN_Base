namespace Bloomie.Api.V1.DTOs.Responses;

/// <summary>
/// DTO cho authentication response
/// </summary>
public class AuthResponseDto
{
    public bool Success { get; set; }
    public string? Message { get; set; }
    public string? Token { get; set; }
    public string? RefreshToken { get; set; }
    public DateTime? ExpiresAt { get; set; }
    public UserDto? User { get; set; }
}

/// <summary>
/// DTO cho User info
/// </summary>
public class UserDto
{
    public string UserId { get; set; } = string.Empty;
    public string UserName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? FullName { get; set; }
    public string? PhoneNumber { get; set; }
    public string? Avatar { get; set; }
    public List<string> Roles { get; set; } = new();
    public DateTime? CreatedAt { get; set; }
}

/// <summary>
/// DTO cho User profile
/// </summary>
public class UserProfileDto : UserDto
{
    public string? Address { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string? Gender { get; set; }
    public int TotalOrders { get; set; }
    public int TotalLikes { get; set; }
    public bool EmailConfirmed { get; set; }
    public bool PhoneNumberConfirmed { get; set; }
    public bool TwoFactorEnabled { get; set; }
}
