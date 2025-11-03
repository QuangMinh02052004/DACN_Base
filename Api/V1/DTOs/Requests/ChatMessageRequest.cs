using System.ComponentModel.DataAnnotations;

namespace Bloomie.Api.V1.DTOs.Requests
{
    public class ChatMessageRequest
    {
        [Required(ErrorMessage = "Message is required")]
        [MaxLength(2000, ErrorMessage = "Message cannot exceed 2000 characters")]
        public string Message { get; set; } = null!;

        public int? ConversationId { get; set; }
    }

    public class CreateConversationRequest
    {
        [Required]
        [MaxLength(200)]
        public string Title { get; set; } = "New Conversation";

        [Required]
        [MaxLength(2000)]
        public string FirstMessage { get; set; } = null!;
    }

    public class UpdateConversationRequest
    {
        [Required]
        [MaxLength(200)]
        public string Title { get; set; } = null!;
    }
}
