using System;
using System.Collections.Generic;

namespace Bloomie.Models.Entities;

public partial class ChatMessage
{
    public int Id { get; set; }

    public int ConversationId { get; set; }

    public string Role { get; set; } = null!;

    public string Content { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public string? Metadata { get; set; }

    public virtual ChatConversation Conversation { get; set; } = null!;
}
