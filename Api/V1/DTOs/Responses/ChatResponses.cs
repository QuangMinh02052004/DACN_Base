namespace Bloomie.Api.V1.DTOs.Responses
{
    public class ChatMessageResponse
    {
        public int Id { get; set; }
        public int ConversationId { get; set; }
        public string Role { get; set; } = null!;
        public string Content { get; set; } = null!;
        public DateTime CreatedAt { get; set; }
    }

    public class ChatConversationResponse
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public bool IsActive { get; set; }
        public ChatMessageResponse? LastMessage { get; set; }
        public int MessageCount { get; set; }
    }

    public class ChatConversationDetailResponse
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public bool IsActive { get; set; }
        public List<ChatMessageResponse> Messages { get; set; } = new();
    }

    public class SendMessageResponse
    {
        public ChatMessageResponse UserMessage { get; set; } = null!;
        public ChatMessageResponse AssistantMessage { get; set; } = null!;
        public int ConversationId { get; set; }
    }
}
