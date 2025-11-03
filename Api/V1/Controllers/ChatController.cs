using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Bloomie.Api.V1.DTOs.Requests;
using Bloomie.Api.V1.DTOs.Responses;
using Bloomie.Api.V1.Helpers;
using Bloomie.Data;
using Bloomie.Models;
using Bloomie.Services.Interfaces;
using System.Security.Claims;

namespace Bloomie.Api.V1.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    [Authorize]
    public class ChatController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IAIChatService _aiChatService;
        private readonly ILogger<ChatController> _logger;

        public ChatController(
            ApplicationDbContext context,
            IAIChatService aiChatService,
            ILogger<ChatController> logger)
        {
            _context = context;
            _aiChatService = aiChatService;
            _logger = logger;
        }

        private string GetUserId()
        {
            // Try ClaimTypes.NameIdentifier first (for JWT)
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            _logger.LogInformation("GetUserId: ClaimTypes.NameIdentifier = {UserId}", userId ?? "null");

            // Validate userId exists in database
            if (!string.IsNullOrEmpty(userId))
            {
                var userExists = _context.Users.Any(u => u.Id == userId);
                if (!userExists)
                {
                    _logger.LogWarning("GetUserId: UserId {UserId} from claims does NOT exist in database. Session may be stale.", userId);
                    userId = null; // Reset to try alternative methods
                }
            }

            // If not found or invalid, try to get from username/email and lookup in database
            if (string.IsNullOrEmpty(userId))
            {
                var userName = User.Identity?.Name;
                _logger.LogInformation("GetUserId: User.Identity.Name = {UserName}", userName ?? "null");

                if (!string.IsNullOrEmpty(userName))
                {
                    var user = _context.Users.FirstOrDefault(u => u.UserName == userName || u.Email == userName);
                    if (user != null)
                    {
                        _logger.LogInformation("GetUserId: Found user in database with Id = {UserId}", user.Id);
                        return user.Id;
                    }
                    else
                    {
                        _logger.LogWarning("GetUserId: User {UserName} not found in database", userName);
                    }
                }
            }

            if (string.IsNullOrEmpty(userId))
            {
                _logger.LogError("GetUserId: User not authenticated or session expired. Please logout and login again.");
                throw new UnauthorizedAccessException("User not authenticated or session expired. Please logout and login again.");
            }

            _logger.LogInformation("GetUserId: Returning userId = {UserId}", userId);
            return userId;
        }

        /// <summary>
        /// Get all conversations for the current user
        /// </summary>
        [HttpGet("conversations")]
        public async Task<ActionResult<ApiResponse<List<ChatConversationResponse>>>> GetConversations()
        {
            try
            {
                var userId = GetUserId();

                var conversations = await _context.ChatConversations
                    .Where(c => c.UserId == userId && c.IsActive)
                    .Include(c => c.Messages)
                    .OrderByDescending(c => c.UpdatedAt)
                    .Select(c => new ChatConversationResponse
                    {
                        Id = c.Id,
                        Title = c.Title,
                        CreatedAt = c.CreatedAt,
                        UpdatedAt = c.UpdatedAt,
                        IsActive = c.IsActive,
                        MessageCount = c.Messages.Count,
                        LastMessage = c.Messages
                            .OrderByDescending(m => m.CreatedAt)
                            .Select(m => new ChatMessageResponse
                            {
                                Id = m.Id,
                                ConversationId = m.ConversationId,
                                Role = m.Role,
                                Content = m.Content.Length > 100 ? m.Content.Substring(0, 100) + "..." : m.Content,
                                CreatedAt = m.CreatedAt
                            })
                            .FirstOrDefault()
                    })
                    .ToListAsync();

                return ApiResponse<List<ChatConversationResponse>>.SuccessResponse(conversations);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting conversations");
                return ApiResponse<List<ChatConversationResponse>>.ErrorResponse("Failed to get conversations");
            }
        }

        /// <summary>
        /// Get a specific conversation with all messages
        /// </summary>
        [HttpGet("conversations/{id}")]
        public async Task<ActionResult<ApiResponse<ChatConversationDetailResponse>>> GetConversation(int id)
        {
            try
            {
                var userId = GetUserId();

                var conversation = await _context.ChatConversations
                    .Where(c => c.Id == id && c.UserId == userId)
                    .Include(c => c.Messages)
                    .Select(c => new ChatConversationDetailResponse
                    {
                        Id = c.Id,
                        Title = c.Title,
                        CreatedAt = c.CreatedAt,
                        UpdatedAt = c.UpdatedAt,
                        IsActive = c.IsActive,
                        Messages = c.Messages
                            .OrderBy(m => m.CreatedAt)
                            .Select(m => new ChatMessageResponse
                            {
                                Id = m.Id,
                                ConversationId = m.ConversationId,
                                Role = m.Role,
                                Content = m.Content,
                                CreatedAt = m.CreatedAt
                            })
                            .ToList()
                    })
                    .FirstOrDefaultAsync();

                if (conversation == null)
                {
                    return NotFound(ApiResponse<ChatConversationDetailResponse>.ErrorResponse("Conversation not found"));
                }

                return ApiResponse<ChatConversationDetailResponse>.SuccessResponse(conversation);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting conversation {ConversationId}", id);
                return ApiResponse<ChatConversationDetailResponse>.ErrorResponse("Failed to get conversation");
            }
        }

        /// <summary>
        /// Create a new conversation
        /// </summary>
        [HttpPost("conversations")]
        public async Task<ActionResult<ApiResponse<ChatConversationDetailResponse>>> CreateConversation(
            [FromBody] CreateConversationRequest request)
        {
            try
            {
                var userId = GetUserId();

                // Create conversation
                var conversation = new ChatConversation
                {
                    UserId = userId,
                    Title = request.Title,
                    CreatedAt = DateTime.UtcNow,
                    UpdatedAt = DateTime.UtcNow
                };

                _context.ChatConversations.Add(conversation);
                await _context.SaveChangesAsync();

                // Add first user message
                var userMessage = new ChatMessage
                {
                    ConversationId = conversation.Id,
                    Role = "user",
                    Content = request.FirstMessage,
                    CreatedAt = DateTime.UtcNow
                };

                _context.ChatMessages.Add(userMessage);
                await _context.SaveChangesAsync();

                // Get AI response
                var aiResponse = await _aiChatService.GetResponseAsync(request.FirstMessage);

                // Add AI message
                var aiMessage = new ChatMessage
                {
                    ConversationId = conversation.Id,
                    Role = "assistant",
                    Content = aiResponse,
                    CreatedAt = DateTime.UtcNow
                };

                _context.ChatMessages.Add(aiMessage);

                // Auto-generate title if default
                if (conversation.Title == "New Conversation")
                {
                    var generatedTitle = await _aiChatService.GenerateConversationTitleAsync(request.FirstMessage);
                    conversation.Title = generatedTitle;
                }

                conversation.UpdatedAt = DateTime.UtcNow;
                await _context.SaveChangesAsync();

                var response = new ChatConversationDetailResponse
                {
                    Id = conversation.Id,
                    Title = conversation.Title,
                    CreatedAt = conversation.CreatedAt,
                    UpdatedAt = conversation.UpdatedAt,
                    IsActive = conversation.IsActive,
                    Messages = new List<ChatMessageResponse>
                    {
                        new ChatMessageResponse
                        {
                            Id = userMessage.Id,
                            ConversationId = userMessage.ConversationId,
                            Role = userMessage.Role,
                            Content = userMessage.Content,
                            CreatedAt = userMessage.CreatedAt
                        },
                        new ChatMessageResponse
                        {
                            Id = aiMessage.Id,
                            ConversationId = aiMessage.ConversationId,
                            Role = aiMessage.Role,
                            Content = aiMessage.Content,
                            CreatedAt = aiMessage.CreatedAt
                        }
                    }
                };

                return ApiResponse<ChatConversationDetailResponse>.SuccessResponse(response, "Conversation created successfully");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error creating conversation");
                return ApiResponse<ChatConversationDetailResponse>.ErrorResponse("Failed to create conversation");
            }
        }

        /// <summary>
        /// Send a message in a conversation
        /// </summary>
        [HttpPost("messages")]
        public async Task<ActionResult<ApiResponse<SendMessageResponse>>> SendMessage(
            [FromBody] ChatMessageRequest request)
        {
            try
            {
                var userId = GetUserId();

                // Get or create conversation
                ChatConversation? conversation = null;

                if (request.ConversationId.HasValue)
                {
                    conversation = await _context.ChatConversations
                        .Include(c => c.Messages)
                        .FirstOrDefaultAsync(c => c.Id == request.ConversationId.Value && c.UserId == userId);

                    if (conversation == null)
                    {
                        return NotFound(ApiResponse<SendMessageResponse>.ErrorResponse("Conversation not found"));
                    }
                }
                else
                {
                    // Create new conversation
                    conversation = new ChatConversation
                    {
                        UserId = userId,
                        Title = "New Conversation",
                        CreatedAt = DateTime.UtcNow,
                        UpdatedAt = DateTime.UtcNow
                    };

                    _context.ChatConversations.Add(conversation);
                    await _context.SaveChangesAsync();
                }

                // Add user message
                var userMessage = new ChatMessage
                {
                    ConversationId = conversation.Id,
                    Role = "user",
                    Content = request.Message,
                    CreatedAt = DateTime.UtcNow
                };

                _context.ChatMessages.Add(userMessage);
                await _context.SaveChangesAsync();

                // Get conversation history for context
                var history = await _context.ChatMessages
                    .Where(m => m.ConversationId == conversation.Id)
                    .OrderBy(m => m.CreatedAt)
                    .ToListAsync();

                // Get AI response
                var aiResponse = await _aiChatService.GetResponseAsync(request.Message, history);

                // Add AI message
                var aiMessage = new ChatMessage
                {
                    ConversationId = conversation.Id,
                    Role = "assistant",
                    Content = aiResponse,
                    CreatedAt = DateTime.UtcNow
                };

                _context.ChatMessages.Add(aiMessage);

                // Auto-generate title if this is the first message
                if (conversation.Title == "New Conversation" && !request.ConversationId.HasValue)
                {
                    var generatedTitle = await _aiChatService.GenerateConversationTitleAsync(request.Message);
                    conversation.Title = generatedTitle;
                }

                conversation.UpdatedAt = DateTime.UtcNow;
                await _context.SaveChangesAsync();

                var response = new SendMessageResponse
                {
                    ConversationId = conversation.Id,
                    UserMessage = new ChatMessageResponse
                    {
                        Id = userMessage.Id,
                        ConversationId = userMessage.ConversationId,
                        Role = userMessage.Role,
                        Content = userMessage.Content,
                        CreatedAt = userMessage.CreatedAt
                    },
                    AssistantMessage = new ChatMessageResponse
                    {
                        Id = aiMessage.Id,
                        ConversationId = aiMessage.ConversationId,
                        Role = aiMessage.Role,
                        Content = aiMessage.Content,
                        CreatedAt = aiMessage.CreatedAt
                    }
                };

                return ApiResponse<SendMessageResponse>.SuccessResponse(response, "Message sent successfully");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error sending message");
                return ApiResponse<SendMessageResponse>.ErrorResponse("Failed to send message");
            }
        }

        /// <summary>
        /// Update conversation title
        /// </summary>
        [HttpPut("conversations/{id}")]
        public async Task<ActionResult<ApiResponse<ChatConversationResponse>>> UpdateConversation(
            int id,
            [FromBody] UpdateConversationRequest request)
        {
            try
            {
                var userId = GetUserId();

                var conversation = await _context.ChatConversations
                    .Include(c => c.Messages)
                    .FirstOrDefaultAsync(c => c.Id == id && c.UserId == userId);

                if (conversation == null)
                {
                    return NotFound(ApiResponse<ChatConversationResponse>.ErrorResponse("Conversation not found"));
                }

                conversation.Title = request.Title;
                conversation.UpdatedAt = DateTime.UtcNow;

                await _context.SaveChangesAsync();

                var response = new ChatConversationResponse
                {
                    Id = conversation.Id,
                    Title = conversation.Title,
                    CreatedAt = conversation.CreatedAt,
                    UpdatedAt = conversation.UpdatedAt,
                    IsActive = conversation.IsActive,
                    MessageCount = conversation.Messages.Count
                };

                return ApiResponse<ChatConversationResponse>.SuccessResponse(response, "Conversation updated successfully");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating conversation {ConversationId}", id);
                return ApiResponse<ChatConversationResponse>.ErrorResponse("Failed to update conversation");
            }
        }

        /// <summary>
        /// Delete (deactivate) a conversation
        /// </summary>
        [HttpDelete("conversations/{id}")]
        public async Task<ActionResult<ApiResponse<object>>> DeleteConversation(int id)
        {
            try
            {
                var userId = GetUserId();

                var conversation = await _context.ChatConversations
                    .FirstOrDefaultAsync(c => c.Id == id && c.UserId == userId);

                if (conversation == null)
                {
                    return NotFound(ApiResponse<object>.ErrorResponse("Conversation not found"));
                }

                conversation.IsActive = false;
                conversation.UpdatedAt = DateTime.UtcNow;

                await _context.SaveChangesAsync();

                return ApiResponse<object>.SuccessResponse(null, "Conversation deleted successfully");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting conversation {ConversationId}", id);
                return ApiResponse<object>.ErrorResponse("Failed to delete conversation");
            }
        }

        /// <summary>
        /// Get product recommendations based on query
        /// </summary>
        [HttpPost("product-recommendation")]
        public async Task<ActionResult<ApiResponse<string>>> GetProductRecommendation(
            [FromBody] ChatMessageRequest request)
        {
            try
            {
                // Get some products for context (limit to 10 popular products)
                var products = await _context.Products
                    .Where(p => p.Quantity > 0)
                    .OrderByDescending(p => p.Id) // You can change this to order by popularity
                    .Take(10)
                    .ToListAsync();

                var recommendation = await _aiChatService.GetProductRecommendationAsync(request.Message, products);

                return ApiResponse<string>.SuccessResponse(recommendation);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting product recommendation");
                return ApiResponse<string>.ErrorResponse("Failed to get product recommendation");
            }
        }
    }
}
