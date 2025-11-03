using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Bloomie.Data;
using Bloomie.Models;
using Bloomie.Services.Interfaces;
using System.Security.Claims;

namespace Bloomie.Hubs
{
    [Authorize]
    public class ChatHub : Hub
    {
        private readonly ApplicationDbContext _context;
        private readonly IAIChatService _aiChatService;
        private readonly ILogger<ChatHub> _logger;

        public ChatHub(
            ApplicationDbContext context,
            IAIChatService aiChatService,
            ILogger<ChatHub> logger)
        {
            _context = context;
            _aiChatService = aiChatService;
            _logger = logger;
        }

        private string GetUserId()
        {
            return Context.User?.FindFirstValue(ClaimTypes.NameIdentifier)
                ?? throw new HubException("User not authenticated");
        }

        public override async Task OnConnectedAsync()
        {
            var userId = GetUserId();
            await Groups.AddToGroupAsync(Context.ConnectionId, $"user_{userId}");
            _logger.LogInformation("User {UserId} connected to chat hub", userId);
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception? exception)
        {
            var userId = GetUserId();
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, $"user_{userId}");
            _logger.LogInformation("User {UserId} disconnected from chat hub", userId);
            await base.OnDisconnectedAsync(exception);
        }

        /// <summary>
        /// Send a message and get AI response in real-time
        /// </summary>
        public async Task SendMessage(string message, int? conversationId = null)
        {
            try
            {
                var userId = GetUserId();

                // Get or create conversation
                ChatConversation? conversation = null;

                if (conversationId.HasValue)
                {
                    conversation = await _context.ChatConversations
                        .Include(c => c.Messages)
                        .FirstOrDefaultAsync(c => c.Id == conversationId.Value && c.UserId == userId);

                    if (conversation == null)
                    {
                        await Clients.Caller.SendAsync("Error", "Conversation not found");
                        return;
                    }
                }
                else
                {
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

                // Save user message
                var userMessage = new ChatMessage
                {
                    ConversationId = conversation.Id,
                    Role = "user",
                    Content = message,
                    CreatedAt = DateTime.UtcNow
                };

                _context.ChatMessages.Add(userMessage);
                await _context.SaveChangesAsync();

                // Send user message to client
                await Clients.Caller.SendAsync("ReceiveMessage", new
                {
                    id = userMessage.Id,
                    conversationId = conversation.Id,
                    role = "user",
                    content = message,
                    createdAt = userMessage.CreatedAt
                });

                // Get conversation history
                var history = await _context.ChatMessages
                    .Where(m => m.ConversationId == conversation.Id)
                    .OrderBy(m => m.CreatedAt)
                    .ToListAsync();

                // Start streaming AI response
                await Clients.Caller.SendAsync("TypingStart");

                var fullResponse = new System.Text.StringBuilder();

                // Stream response
                var aiResponse = await _aiChatService.StreamResponseAsync(
                    message,
                    history,
                    chunk =>
                    {
                        // Send each chunk to the client
                        Clients.Caller.SendAsync("ReceiveChunk", chunk).Wait();
                        fullResponse.Append(chunk);
                    });

                await Clients.Caller.SendAsync("TypingEnd");

                // Save AI message
                var aiMessage = new ChatMessage
                {
                    ConversationId = conversation.Id,
                    Role = "assistant",
                    Content = fullResponse.ToString(),
                    CreatedAt = DateTime.UtcNow
                };

                _context.ChatMessages.Add(aiMessage);

                // Auto-generate title if this is the first message
                if (conversation.Title == "New Conversation" && !conversationId.HasValue)
                {
                    var generatedTitle = await _aiChatService.GenerateConversationTitleAsync(message);
                    conversation.Title = generatedTitle;

                    // Notify client about title update
                    await Clients.Caller.SendAsync("ConversationTitleUpdated", new
                    {
                        conversationId = conversation.Id,
                        title = generatedTitle
                    });
                }

                conversation.UpdatedAt = DateTime.UtcNow;
                await _context.SaveChangesAsync();

                // Send complete AI message to client
                await Clients.Caller.SendAsync("ReceiveMessage", new
                {
                    id = aiMessage.Id,
                    conversationId = conversation.Id,
                    role = "assistant",
                    content = fullResponse.ToString(),
                    createdAt = aiMessage.CreatedAt
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error sending message via SignalR");
                await Clients.Caller.SendAsync("Error", "Failed to send message");
            }
        }

        /// <summary>
        /// Get all conversations for the user
        /// </summary>
        public async Task GetConversations()
        {
            try
            {
                var userId = GetUserId();

                var conversations = await _context.ChatConversations
                    .Where(c => c.UserId == userId && c.IsActive)
                    .Include(c => c.Messages)
                    .OrderByDescending(c => c.UpdatedAt)
                    .Select(c => new
                    {
                        id = c.Id,
                        title = c.Title,
                        createdAt = c.CreatedAt,
                        updatedAt = c.UpdatedAt,
                        messageCount = c.Messages.Count,
                        lastMessage = c.Messages
                            .OrderByDescending(m => m.CreatedAt)
                            .Select(m => new
                            {
                                content = m.Content.Length > 100 ? m.Content.Substring(0, 100) + "..." : m.Content,
                                createdAt = m.CreatedAt
                            })
                            .FirstOrDefault()
                    })
                    .ToListAsync();

                await Clients.Caller.SendAsync("ConversationsList", conversations);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting conversations via SignalR");
                await Clients.Caller.SendAsync("Error", "Failed to get conversations");
            }
        }

        /// <summary>
        /// Get messages for a specific conversation
        /// </summary>
        public async Task GetMessages(int conversationId)
        {
            try
            {
                var userId = GetUserId();

                var conversation = await _context.ChatConversations
                    .Include(c => c.Messages)
                    .FirstOrDefaultAsync(c => c.Id == conversationId && c.UserId == userId);

                if (conversation == null)
                {
                    await Clients.Caller.SendAsync("Error", "Conversation not found");
                    return;
                }

                var messages = conversation.Messages
                    .OrderBy(m => m.CreatedAt)
                    .Select(m => new
                    {
                        id = m.Id,
                        conversationId = m.ConversationId,
                        role = m.Role,
                        content = m.Content,
                        createdAt = m.CreatedAt
                    })
                    .ToList();

                await Clients.Caller.SendAsync("MessagesList", messages);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error getting messages via SignalR");
                await Clients.Caller.SendAsync("Error", "Failed to get messages");
            }
        }

        /// <summary>
        /// Delete a conversation
        /// </summary>
        public async Task DeleteConversation(int conversationId)
        {
            try
            {
                var userId = GetUserId();

                var conversation = await _context.ChatConversations
                    .FirstOrDefaultAsync(c => c.Id == conversationId && c.UserId == userId);

                if (conversation == null)
                {
                    await Clients.Caller.SendAsync("Error", "Conversation not found");
                    return;
                }

                conversation.IsActive = false;
                conversation.UpdatedAt = DateTime.UtcNow;
                await _context.SaveChangesAsync();

                await Clients.Caller.SendAsync("ConversationDeleted", conversationId);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting conversation via SignalR");
                await Clients.Caller.SendAsync("Error", "Failed to delete conversation");
            }
        }
    }
}
