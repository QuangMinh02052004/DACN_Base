# 🚀 Quick Start - Bloomie AI Chatbot

## Chỉ 3 bước để chạy AI Chatbot!

### Bước 1: Lấy FREE Gemini API Key

1. Truy cập: https://makersuite.google.com/app/apikey
2. Đăng nhập bằng Google account
3. Click **"Create API Key"**
4. Copy API key

### Bước 2: Cấu hình

Mở `appsettings.json` và thay đổi:

```json
"Gemini": {
    "ApiKey": "PASTE_YOUR_API_KEY_HERE",
    "Model": "gemini-2.0-flash-exp"
}
```

### Bước 3: Chạy!

```bash
# Apply migration (chỉ cần chạy 1 lần)
dotnet ef database update --context ApplicationDbContext

# Run project
dotnet run
```

**Xong!** Truy cập http://localhost:5187 và bạn sẽ thấy chatbot icon ở góc phải dưới! 🎉

---

## 💬 Test thử

1. Click vào icon chatbot (góc phải dưới)
2. Nhập: "Gợi ý hoa tặng sinh nhật"
3. AI sẽ trả lời với gợi ý thông minh!

---

## 📖 Tài liệu đầy đủ

Xem [AI_CHATBOT_GUIDE.md](AI_CHATBOT_GUIDE.md) để biết:
- API endpoints
- SignalR hub methods
- Customization
- Troubleshooting
- Production deployment

---

## ⚡ Quick Tips

**Để chatbot thông minh hơn:**
- Mở `/Services/Implementations/GeminiService.cs`
- Sửa `SYSTEM_PROMPT` constant
- Thêm instructions về sản phẩm, giá cả, chính sách

**Để thay đổi màu sắc:**
- Mở `/wwwroot/css/chat-widget.css`
- Tìm `#E91E63` (màu hồng)
- Thay bằng màu bạn thích

**Để xem API docs:**
- Truy cập http://localhost:5187/api/docs
- Test trực tiếp các chat endpoints

---

Chúc bạn thành công! 🌸
