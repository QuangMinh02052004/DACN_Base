using Bloomie.Api.V1.DTOs.Responses;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace Bloomie.Api.V1.Filters;

/// <summary>
/// Global exception filter cho API endpoints
/// </summary>
public class ApiExceptionFilter : IExceptionFilter
{
    private readonly ILogger<ApiExceptionFilter> _logger;

    public ApiExceptionFilter(ILogger<ApiExceptionFilter> logger)
    {
        _logger = logger;
    }

    public void OnException(ExceptionContext context)
    {
        _logger.LogError(context.Exception, "API Exception occurred");

        var response = ApiResponse<object>.ErrorResponse(
            "Đã xảy ra lỗi khi xử lý yêu cầu",
            new List<string> { context.Exception.Message }
        );

        context.Result = new ObjectResult(response)
        {
            StatusCode = context.Exception switch
            {
                UnauthorizedAccessException => StatusCodes.Status401Unauthorized,
                ArgumentException => StatusCodes.Status400BadRequest,
                KeyNotFoundException => StatusCodes.Status404NotFound,
                _ => StatusCodes.Status500InternalServerError
            }
        };

        context.ExceptionHandled = true;
    }
}
