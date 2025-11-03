using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Bloomie.Models
{
    public class ChatMessage
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int ConversationId { get; set; }

        [ForeignKey("ConversationId")]
        public virtual ChatConversation Conversation { get; set; } = null!;

        [Required]
        [MaxLength(10)]
        public string Role { get; set; } = null!; // "user" or "assistant"

        [Required]
        public string Content { get; set; } = null!;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        // Optional: Store metadata like tokens used, model version, etc.
        public string? Metadata { get; set; }
    }
}
