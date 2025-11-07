using System;
using System.Collections.Generic;
using Bloomie.Data;

namespace Bloomie.Models.Entities;

public partial class ChatConversation
{
    public int Id { get; set; }

    public string UserId { get; set; } = null!;

    public string? AspNetUserId { get; set; } // For compatibility with scaffolded entities

    public string Title { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime UpdatedAt { get; set; }

    public bool IsActive { get; set; }

    public virtual ICollection<ChatMessage> ChatMessages { get; set; } = new List<ChatMessage>();

    public virtual ApplicationUser? User { get; set; } // Changed from AspNetUser to ApplicationUser
}
