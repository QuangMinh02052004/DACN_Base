# 🤖 Hướng dẫn sử dụng AI Chatbot - Bloomie

## 📋 Tổng quan

Bloomie AI Chatbot là trợ lý ảo thông minh được tích hợp hoàn toàn vào website Bloomie. Chatbot sử dụng **Google Gemini AI** (miễn phí) để tư vấn khách hàng về sản phẩm hoa, hỗ trợ đặt hàng, và trả lời các câu hỏi thường gặp.

### ✨ Tính năng

- ✅ **Real-time Chat** với SignalR (typing indicator, streaming responses)
- ✅ **Conversation History** - Lưu lại lịch sử trò chuyện
- ✅ **Context Awareness** - AI nhớ ngữ cảnh cuộc trò chuyện
- ✅ **Product Recommendations** - Gợi ý sản phẩm thông minh
- ✅ **Beautiful UI** - Giao diện chat đẹp, responsive
- ✅ **Auto-generate Titles** - Tự động tạo tiêu đề cho cuộc trò chuyện
- ✅ **Quick Hints** - Các gợi ý câu hỏi nhanh

---

## 🚀 Cài đặt & Chạy

### Bước 1: Cấu hình Gemini API Key

1. Lấy FREE API key từ Google AI Studio:
   ```
   https://makersuite.google.com/app/apikey
   ```

2. Mở `appsettings.json` và cập nhật:
   ```json
   "Gemini": {
       "ApiKey": "YOUR_ACTUAL_API_KEY_HERE",
       "Model": "gemini-2.0-flash-exp"
   }
   ```

### Bước 2: Migration Database

Migration đã được tạo sẵn. Chỉ cần chạy:

```bash
dotnet ef database update --context ApplicationDbContext
```

Lệnh này sẽ tạo 2 tables mới:
- `ChatConversations` - Lưu cuộc trò chuyện
- `ChatMessages` - Lưu tin nhắn

### Bước 3: Chạy Project

```bash
dotnet run
```

Truy cập: `http://localhost:5187`

Chatbot widget sẽ tự động hiển thị ở góc phải dưới màn hình! 🎉

---

## 📐 Kiến trúc

### Backend Components

```
Api/V1/Controllers/
  └── ChatController.cs           # REST API endpoints

Models/
  ├── ChatConversation.cs         # Model cuộc trò chuyện
  └── ChatMessage.cs              # Model tin nhắn

Services/
  ├── Interfaces/
  │   └── IAIChatService.cs       # Interface cho AI service
  └── Implementations/
      └── GeminiService.cs        # Google Gemini implementation

Hubs/
  └── ChatHub.cs                  # SignalR hub cho real-time chat

Api/V1/DTOs/
  ├── Requests/
  │   └── ChatMessageRequest.cs
  └── Responses/
      └── ChatResponses.cs
```

### Frontend Components

```
Views/Shared/
  └── _ChatWidget.cshtml            # Chat widget UI

wwwroot/
  ├── js/
  │   └── chat-widget.js            # Chat logic & SignalR client
  └── css/
      └── chat-widget.css           # Chat styles
```

### Database Schema

```sql
ChatConversations
├── Id (int, PK)
├── UserId (string, FK → AspNetUsers)
├── Title (string)
├── CreatedAt (datetime)
├── UpdatedAt (datetime)
└── IsActive (bool)

ChatMessages
├── Id (int, PK)
├── ConversationId (int, FK → ChatConversations)
├── Role (string) -- 'user' or 'assistant'
├── Content (text)
├── CreatedAt (datetime)
└── Metadata (string, nullable)
```

---

## 🔌 API Endpoints

### 1. Get All Conversations
```http
GET /api/v1/chat/conversations
Authorization: Bearer {jwt_token}
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "title": "Hoa sinh nhật",
      "createdAt": "2025-11-03T10:00:00Z",
      "updatedAt": "2025-11-03T10:05:00Z",
      "isActive": true,
      "messageCount": 6,
      "lastMessage": {
        "content": "Tôi khuyên bạn nên chọn...",
        "createdAt": "2025-11-03T10:05:00Z"
      }
    }
  ]
}
```

### 2. Get Conversation Detail
```http
GET /api/v1/chat/conversations/{id}
Authorization: Bearer {jwt_token}
```

### 3. Create New Conversation
```http
POST /api/v1/chat/conversations
Authorization: Bearer {jwt_token}
Content-Type: application/json

{
  "title": "Cuộc trò chuyện mới",
  "firstMessage": "Gợi ý hoa tặng sinh nhật"
}
```

### 4. Send Message
```http
POST /api/v1/chat/messages
Authorization: Bearer {jwt_token}
Content-Type: application/json

{
  "message": "Hoa nào phù hợp cho Valentine?",
  "conversationId": 1  // Optional, null để tạo conversation mới
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "conversationId": 1,
    "userMessage": {
      "id": 10,
      "content": "Hoa nào phù hợp cho Valentine?",
      "role": "user",
      "createdAt": "2025-11-03T10:10:00Z"
    },
    "assistantMessage": {
      "id": 11,
      "content": "Cho Valentine, tôi khuyên bạn nên chọn hoa hồng đỏ...",
      "role": "assistant",
      "createdAt": "2025-11-03T10:10:05Z"
    }
  }
}
```

### 5. Update Conversation Title
```http
PUT /api/v1/chat/conversations/{id}
Authorization: Bearer {jwt_token}
Content-Type: application/json

{
  "title": "Tư vấn hoa Valentine"
}
```

### 6. Delete Conversation
```http
DELETE /api/v1/chat/conversations/{id}
Authorization: Bearer {jwt_token}
```

### 7. Product Recommendation
```http
POST /api/v1/chat/product-recommendation
Authorization: Bearer {jwt_token}
Content-Type: application/json

{
  "message": "Tôi cần hoa giá dưới 500k"
}
```

---

## 🔄 SignalR Hub Methods

### Client → Server

**1. SendMessage**
```javascript
await connection.invoke('SendMessage', userMessage, conversationId);
```

**2. GetConversations**
```javascript
await connection.invoke('GetConversations');
```

**3. GetMessages**
```javascript
await connection.invoke('GetMessages', conversationId);
```

**4. DeleteConversation**
```javascript
await connection.invoke('DeleteConversation', conversationId);
```

### Server → Client

**1. ReceiveMessage** - Nhận tin nhắn hoàn chỉnh
```javascript
connection.on('ReceiveMessage', (message) => {
  // message: { id, conversationId, role, content, createdAt }
});
```

**2. ReceiveChunk** - Nhận từng phần text (streaming)
```javascript
connection.on('ReceiveChunk', (chunk) => {
  // chunk: string
});
```

**3. TypingStart / TypingEnd** - Trạng thái đang gõ
```javascript
connection.on('TypingStart', () => { /* Show typing indicator */ });
connection.on('TypingEnd', () => { /* Hide typing indicator */ });
```

**4. ConversationTitleUpdated** - Cập nhật tiêu đề
```javascript
connection.on('ConversationTitleUpdated', (data) => {
  // data: { conversationId, title }
});
```

**5. ConversationsList** - Danh sách cuộc trò chuyện
```javascript
connection.on('ConversationsList', (conversations) => {
  // conversations: array of conversation objects
});
```

**6. MessagesList** - Danh sách tin nhắn
```javascript
connection.on('MessagesList', (messages) => {
  // messages: array of message objects
});
```

**7. Error** - Thông báo lỗi
```javascript
connection.on('Error', (error) => {
  // error: string
});
```

---

## 🎨 Tùy chỉnh UI

### Thay đổi màu sắc

Mở `/wwwroot/css/chat-widget.css` và thay đổi:

```css
/* Màu chính */
.chat-toggle-btn {
    background: linear-gradient(135deg, #E91E63 0%, #C2185B 100%);
}

/* Màu tin nhắn của user */
.user-message .message-content {
    background: #E91E63;
    color: white;
}

/* Màu tin nhắn của bot */
.assistant-message .message-content {
    background: #F5F5F5;
    color: #212121;
}
```

### Thay đổi System Prompt

Mở `/Services/Implementations/GeminiService.cs` và sửa constant `SYSTEM_PROMPT`:

```csharp
private const string SYSTEM_PROMPT = @"
Bạn là trợ lý ảo của Bloomie...
[Tùy chỉnh vai trò, phong cách, hướng dẫn cho AI]
";
```

### Thay đổi vị trí widget

Mở `/wwwroot/css/chat-widget.css`:

```css
.bloomie-chat-widget {
    position: fixed;
    bottom: 20px;    /* Thay đổi vị trí dọc */
    right: 20px;     /* Thay đổi vị trí ngang */
}
```

---

## 🧪 Testing

### Test REST API với Swagger

1. Truy cập: `http://localhost:5187/api/docs`
2. Đăng nhập để lấy JWT token từ `/api/v1/auth/login`
3. Click "Authorize" và nhập token
4. Test các endpoints `/api/v1/chat/*`

### Test SignalR Connection

Mở Browser Console (F12) và chạy:

```javascript
// Check if connection is active
window.bloomieChat.isConnected  // Should return true

// Send test message
window.bloomieChat.sendMessage("Hello AI!");

// Check conversations
window.bloomieChat.conversations  // Array of conversations
```

### Test Database

```sql
-- Kiểm tra conversations
SELECT * FROM ChatConversations WHERE UserId = 'your-user-id';

-- Kiểm tra messages
SELECT * FROM ChatMessages WHERE ConversationId = 1;

-- Xem conversation với messages
SELECT
    c.Title,
    m.Role,
    m.Content,
    m.CreatedAt
FROM ChatConversations c
JOIN ChatMessages m ON c.Id = m.ConversationId
WHERE c.UserId = 'your-user-id'
ORDER BY m.CreatedAt;
```

---

## 🔧 Troubleshooting

### 1. Chatbot không hiển thị

**Nguyên nhân:** _ChatWidget.cshtml chưa được include trong _Layout.cshtml

**Giải pháp:** Kiểm tra file `/Views/Shared/_Layout.cshtml` có dòng:
```html
<partial name="_ChatWidget" />
```

### 2. Lỗi "Gemini API Key not configured"

**Nguyên nhân:** API key chưa được cấu hình

**Giải pháp:**
- Lấy API key miễn phí từ https://makersuite.google.com/app/apikey
- Cập nhật trong `appsettings.json`

### 3. SignalR không kết nối được

**Nguyên nhân:** User chưa đăng nhập hoặc JWT token không hợp lệ

**Giải pháp:**
- Đảm bảo user đã đăng nhập
- Check token trong localStorage hoặc cookie
- Kiểm tra endpoint `/chatHub` đã được map trong `Program.cs`:
  ```csharp
  endpoints.MapHub<ChatHub>("/chatHub");
  ```

### 4. Migration lỗi

**Nguyên nhân:** Database connection string sai

**Giải pháp:**
- Kiểm tra `ConnectionStrings:DefaultConnection` trong `appsettings.json`
- Đảm bảo SQL Server đang chạy
- Retry migration:
  ```bash
  dotnet ef database update --context ApplicationDbContext
  ```

### 5. Chat widget bị che khuất bởi elements khác

**Giải pháp:** Tăng z-index trong CSS:
```css
.bloomie-chat-widget {
    z-index: 99999 !important;
}
```

---

## 📱 Mobile App Integration (Flutter)

Tính năng chatbot này có thể integrate vào Flutter app. Cần implement:

1. **SignalR Client cho Flutter:**
   ```yaml
   dependencies:
     signalr_netcore: ^1.3.3
   ```

2. **Connect to ChatHub:**
   ```dart
   final connection = HubConnectionBuilder()
       .withUrl('http://10.0.2.2:5187/chatHub',
           options: HttpConnectionOptions(
               accessTokenFactory: () async => await getToken(),
           ))
       .build();

   await connection.start();
   ```

3. **Send/Receive Messages:**
   ```dart
   // Send
   await connection.invoke('SendMessage',
       args: [message, conversationId]);

   // Receive
   connection.on('ReceiveMessage', (message) {
       setState(() { messages.add(message); });
   });
   ```

Chi tiết xem `FLUTTER_AI_CHATBOT_GUIDE.md` (sẽ tạo riêng nếu cần).

---

## 🎯 Best Practices

### 1. API Key Security

**❌ KHÔNG BAO GIỜ:**
- Commit API key vào Git
- Share API key publicly
- Hardcode API key trong code

**✅ NÊN:**
- Lưu API key trong `appsettings.json` (add vào `.gitignore`)
- Sử dụng Environment Variables cho production
- Rotate API key định kỳ

### 2. Rate Limiting

Google Gemini Free tier có giới hạn:
- **60 requests/minute**
- **1500 requests/day**

Để tránh vượt quota:
- Implement client-side debouncing (đã có trong chat-widget.js)
- Cache responses nếu có thể
- Monitor usage tại https://makersuite.google.com

### 3. Error Handling

Luôn handle errors gracefully:

```javascript
try {
    await connection.invoke('SendMessage', message);
} catch (error) {
    // Show user-friendly message
    showError('Không thể gửi tin nhắn. Vui lòng thử lại.');
    console.error(error);
}
```

### 4. Conversation Management

- Auto-delete conversations cũ (>30 ngày không active)
- Limit số messages per conversation (prevent token overflow)
- Implement pagination cho message history

---

## 📊 Analytics & Monitoring

### Logging

Tất cả AI requests được log tại `GeminiService.cs`:

```csharp
_logger.LogInformation("AI Request: {Message}", userMessage);
_logger.LogInformation("AI Response: {Response}", aiResponse);
_logger.LogError(ex, "Error calling Gemini API");
```

### Metrics to Track

- Number of conversations created per day
- Average messages per conversation
- AI response time
- Error rate
- Most common user queries

### Database Queries for Analytics

```sql
-- Conversations created today
SELECT COUNT(*) FROM ChatConversations
WHERE CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE);

-- Average messages per conversation
SELECT AVG(MessageCount) FROM (
    SELECT ConversationId, COUNT(*) as MessageCount
    FROM ChatMessages
    GROUP BY ConversationId
) AS Stats;

-- Top 10 active users
SELECT TOP 10 UserId, COUNT(*) as ConversationCount
FROM ChatConversations
GROUP BY UserId
ORDER BY ConversationCount DESC;
```

---

## 🚀 Production Deployment

### 1. Update appsettings.Production.json

```json
{
  "Gemini": {
    "ApiKey": "${GEMINI_API_KEY}",  // From environment variable
    "Model": "gemini-2.0-flash-exp"
  },
  "ConnectionStrings": {
    "DefaultConnection": "${DATABASE_CONNECTION_STRING}"
  }
}
```

### 2. Environment Variables

Set trên hosting platform (Azure, AWS, etc.):

```bash
GEMINI_API_KEY=your_production_api_key
DATABASE_CONNECTION_STRING=your_production_db_connection
ASPNETCORE_ENVIRONMENT=Production
```

### 3. Enable HTTPS

Trong `Program.cs`:

```csharp
options.RequireHttpsMetadata = true; // Change from false
```

### 4. CORS Configuration

Update allowed origins:

```csharp
options.AddPolicy("AllowSpecificOrigins", policy =>
{
    policy.WithOrigins(
        "https://yourdomain.com",
        "https://www.yourdomain.com"
    )
    .AllowAnyMethod()
    .AllowAnyHeader()
    .AllowCredentials();
});
```

---

## 📚 Tài liệu liên quan

- [START_PROJECT.md](START_PROJECT.md) - Hướng dẫn chạy toàn bộ project
- [API_SETUP_SUMMARY.md](API_SETUP_SUMMARY.md) - Tổng quan về API
- [FLUTTER_INTEGRATION_GUIDE.md](FLUTTER_INTEGRATION_GUIDE.md) - Tích hợp Flutter
- [Google Gemini API Docs](https://ai.google.dev/docs)
- [SignalR Documentation](https://learn.microsoft.com/en-us/aspnet/core/signalr/)

---

## ❓ FAQ

**Q: Tại sao chọn Gemini thay vì ChatGPT?**

A: Gemini 2.0 Flash hoàn toàn MIỄN PHÍ với quota cao (1500 requests/day), trong khi ChatGPT API tốn phí từ request đầu tiên.

**Q: Chat history được lưu bao lâu?**

A: Vĩnh viễn trong database. Bạn có thể implement auto-delete cho conversations cũ nếu muốn.

**Q: Có thể thay Gemini bằng Claude hay GPT không?**

A: Có! Chỉ cần implement `IAIChatService` với provider khác:
- `ClaudeService` - Anthropic Claude
- `OpenAIService` - ChatGPT
- `AzureOpenAIService` - Azure OpenAI

**Q: Chatbot có thể truy cập database sản phẩm không?**

A: Có! Method `GetProductRecommendationAsync` đã truyền danh sách sản phẩm vào context của AI.

**Q: Làm sao để chatbot chỉ hiện cho user đã đăng nhập?**

A: Chatbot đã require authentication. SignalR Hub có attribute `[Authorize]`, nên chỉ authenticated users mới kết nối được.

---

## 🎉 Kết luận

Bloomie AI Chatbot là một tính năng hoàn chỉnh, production-ready, có thể deploy ngay.

**Điểm mạnh:**
- ✅ FREE AI (Google Gemini)
- ✅ Real-time với SignalR
- ✅ Beautiful responsive UI
- ✅ Complete API & Hub
- ✅ Database integration
- ✅ Context-aware conversations

**Bước tiếp theo:**
1. Lấy Gemini API key
2. Update appsettings.json
3. Run migration
4. Test thử chatbot
5. Tùy chỉnh system prompt theo nhu cầu

Chúc bạn thành công! 🚀🌸

---

**Developed with ❤️ for Bloomie**
