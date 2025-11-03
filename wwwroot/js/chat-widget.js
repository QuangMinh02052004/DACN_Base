// Bloomie AI Chat Widget
class BloomieChat {
    constructor() {
        this.connection = null;
        this.isConnected = false;
        this.currentConversationId = null;
        this.conversations = [];
        this.isTyping = false;

        this.init();
    }

    init() {
        this.setupElements();
        this.setupEventListeners();
        this.setupSignalR();
    }

    setupElements() {
        // Main elements
        this.widget = document.getElementById('bloomie-chat-widget');
        this.toggleBtn = document.getElementById('chat-toggle-btn');
        this.chatWindow = document.getElementById('chat-window');
        this.messagesContainer = document.getElementById('chat-messages');
        this.chatForm = document.getElementById('chat-form');
        this.chatInput = document.getElementById('chat-input');
        this.sendBtn = document.getElementById('chat-send-btn');
        this.minimizeBtn = document.getElementById('chat-minimize-btn');
        this.typingIndicator = document.getElementById('typing-indicator');
        this.conversationsList = document.getElementById('conversations-list');
        this.newConversationBtn = document.getElementById('new-conversation-btn');
        this.chatIcon = this.toggleBtn.querySelector('.chat-icon');
        this.closeIcon = this.toggleBtn.querySelector('.close-icon');
    }

    setupEventListeners() {
        // Toggle chat window
        this.toggleBtn.addEventListener('click', () => this.toggleChat());

        // Minimize chat
        this.minimizeBtn.addEventListener('click', () => this.toggleChat());

        // Send message
        this.chatForm.addEventListener('submit', (e) => {
            e.preventDefault();
            this.sendMessage();
        });

        // New conversation
        this.newConversationBtn.addEventListener('click', () => this.startNewConversation());

        // Quick hint buttons
        document.querySelectorAll('.hint-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const message = btn.getAttribute('data-message');
                this.chatInput.value = message;
                this.sendMessage();
            });
        });

        // Auto-resize input
        this.chatInput.addEventListener('input', () => {
            this.sendBtn.disabled = !this.chatInput.value.trim();
        });
    }

    async setupSignalR() {
        try {
            // Get JWT token from cookie or localStorage
            const token = this.getAuthToken();

            if (!token) {
                console.warn('User not authenticated. Chat will use REST API only.');
                this.isConnected = false;
                return;
            }

            // Build SignalR connection
            this.connection = new signalR.HubConnectionBuilder()
                .withUrl('/chatHub', {
                    accessTokenFactory: () => token
                })
                .withAutomaticReconnect()
                .build();

            // Handle incoming messages
            this.connection.on('ReceiveMessage', (message) => {
                this.addMessage(message.content, message.role, message.createdAt);
            });

            // Handle streaming chunks
            this.connection.on('ReceiveChunk', (chunk) => {
                this.appendToLastMessage(chunk);
            });

            // Handle typing indicators
            this.connection.on('TypingStart', () => {
                this.showTypingIndicator();
            });

            this.connection.on('TypingEnd', () => {
                this.hideTypingIndicator();
            });

            // Handle conversation title updates
            this.connection.on('ConversationTitleUpdated', (data) => {
                this.currentConversationId = data.conversationId;
                this.loadConversations();
            });

            // Handle conversations list
            this.connection.on('ConversationsList', (conversations) => {
                this.conversations = conversations;
                this.renderConversations();
            });

            // Handle messages list
            this.connection.on('MessagesList', (messages) => {
                this.renderMessages(messages);
            });

            // Handle conversation deletion
            this.connection.on('ConversationDeleted', (conversationId) => {
                this.conversations = this.conversations.filter(c => c.id !== conversationId);
                this.renderConversations();
                if (this.currentConversationId === conversationId) {
                    this.startNewConversation();
                }
            });

            // Handle errors
            this.connection.on('Error', (error) => {
                console.error('SignalR Error:', error);
                this.showError(error);
            });

            // Start connection
            await this.connection.start();
            this.isConnected = true;
            console.log('SignalR Connected!');

            // Load conversations
            await this.loadConversations();

        } catch (error) {
            console.error('SignalR Connection Error:', error);
            this.isConnected = false;
            // Fallback to REST API
        }
    }

    getAuthToken() {
        // Try to get token from localStorage first
        let token = localStorage.getItem('jwt_token');

        // If not found, try to get from cookie
        if (!token) {
            const cookies = document.cookie.split(';');
            for (let cookie of cookies) {
                const [name, value] = cookie.trim().split('=');
                if (name === 'jwt_token' || name === 'auth_token') {
                    token = value;
                    break;
                }
            }
        }

        return token;
    }

    toggleChat() {
        const isOpen = this.chatWindow.style.display !== 'none';

        if (isOpen) {
            this.chatWindow.style.display = 'none';
            this.chatIcon.style.display = 'block';
            this.closeIcon.style.display = 'none';
        } else {
            this.chatWindow.style.display = 'flex';
            this.chatIcon.style.display = 'none';
            this.closeIcon.style.display = 'block';
            this.chatInput.focus();

            // Load conversations if not loaded yet
            if (this.conversations.length === 0 && this.isConnected) {
                this.loadConversations();
            }
        }
    }

    async loadConversations() {
        try {
            if (this.isConnected && this.connection) {
                await this.connection.invoke('GetConversations');
            } else {
                // Use REST API
                const response = await fetch('/api/v1/chat/conversations', {
                    headers: {
                        'Authorization': `Bearer ${this.getAuthToken()}`
                    }
                });

                if (response.ok) {
                    const result = await response.json();
                    this.conversations = result.data || [];
                    this.renderConversations();
                }
            }
        } catch (error) {
            console.error('Error loading conversations:', error);
        }
    }

    renderConversations() {
        if (this.conversations.length === 0) {
            this.conversationsList.innerHTML = '<div class="no-conversations">Chưa có cuộc trò chuyện nào</div>';
            return;
        }

        this.conversationsList.innerHTML = this.conversations.map(conv => `
            <div class="conversation-item ${conv.id === this.currentConversationId ? 'active' : ''}"
                 data-conversation-id="${conv.id}">
                <div class="conversation-content">
                    <h6>${this.escapeHtml(conv.title)}</h6>
                    ${conv.lastMessage ? `<p>${this.escapeHtml(conv.lastMessage.content)}</p>` : ''}
                </div>
                <div class="conversation-meta">
                    <span class="conversation-time">${this.formatTime(conv.updatedAt)}</span>
                    <button class="delete-conversation-btn" data-conversation-id="${conv.id}" title="Xóa">
                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M4 4l8 8m0-8l-8 8"/>
                        </svg>
                    </button>
                </div>
            </div>
        `).join('');

        // Add click handlers
        document.querySelectorAll('.conversation-item').forEach(item => {
            item.addEventListener('click', (e) => {
                if (!e.target.closest('.delete-conversation-btn')) {
                    const conversationId = parseInt(item.getAttribute('data-conversation-id'));
                    this.loadConversation(conversationId);
                }
            });
        });

        // Add delete handlers
        document.querySelectorAll('.delete-conversation-btn').forEach(btn => {
            btn.addEventListener('click', async (e) => {
                e.stopPropagation();
                const conversationId = parseInt(btn.getAttribute('data-conversation-id'));
                await this.deleteConversation(conversationId);
            });
        });
    }

    async loadConversation(conversationId) {
        try {
            this.currentConversationId = conversationId;

            if (this.isConnected && this.connection) {
                await this.connection.invoke('GetMessages', conversationId);
            } else {
                // Use REST API
                const response = await fetch(`/api/v1/chat/conversations/${conversationId}`, {
                    headers: {
                        'Authorization': `Bearer ${this.getAuthToken()}`
                    }
                });

                if (response.ok) {
                    const result = await response.json();
                    this.renderMessages(result.data.messages);
                }
            }

            this.renderConversations(); // Update active state
        } catch (error) {
            console.error('Error loading conversation:', error);
        }
    }

    async deleteConversation(conversationId) {
        if (!confirm('Bạn có chắc muốn xóa cuộc trò chuyện này?')) {
            return;
        }

        try {
            if (this.isConnected && this.connection) {
                await this.connection.invoke('DeleteConversation', conversationId);
            } else {
                // Use REST API
                const response = await fetch(`/api/v1/chat/conversations/${conversationId}`, {
                    method: 'DELETE',
                    headers: {
                        'Authorization': `Bearer ${this.getAuthToken()}`
                    }
                });

                if (response.ok) {
                    this.conversations = this.conversations.filter(c => c.id !== conversationId);
                    this.renderConversations();
                    if (this.currentConversationId === conversationId) {
                        this.startNewConversation();
                    }
                }
            }
        } catch (error) {
            console.error('Error deleting conversation:', error);
        }
    }

    renderMessages(messages) {
        // Clear welcome message
        this.messagesContainer.innerHTML = '';

        messages.forEach(msg => {
            this.addMessage(msg.content, msg.role, msg.createdAt, false);
        });

        this.scrollToBottom();
    }

    startNewConversation() {
        this.currentConversationId = null;
        this.messagesContainer.innerHTML = `
            <div class="welcome-message">
                <div class="welcome-icon">🌸</div>
                <h3>Cuộc trò chuyện mới</h3>
                <p>Bạn muốn tôi giúp gì?</p>
            </div>
        `;
        this.renderConversations();
        this.chatInput.focus();
    }

    async sendMessage() {
        const message = this.chatInput.value.trim();

        if (!message || this.isTyping) {
            return;
        }

        // Clear input
        this.chatInput.value = '';
        this.sendBtn.disabled = true;

        // Add user message to UI
        this.addMessage(message, 'user');

        try {
            if (this.isConnected && this.connection) {
                // Use SignalR
                await this.connection.invoke('SendMessage', message, this.currentConversationId);
            } else {
                // Use REST API
                const response = await fetch('/api/v1/chat/messages', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${this.getAuthToken()}`
                    },
                    body: JSON.stringify({
                        message: message,
                        conversationId: this.currentConversationId
                    })
                });

                if (response.ok) {
                    const result = await response.json();

                    // Check if response has expected structure
                    if (result && result.success && result.data) {
                        this.currentConversationId = result.data.conversationId;
                        this.addMessage(result.data.assistantMessage.content, 'assistant');
                        await this.loadConversations();
                    } else {
                        console.error('Unexpected response structure:', result);
                        this.showError(result?.message || 'Lỗi không xác định');
                    }
                } else {
                    // Try to get error message from response
                    try {
                        const errorResult = await response.json();
                        console.error('API Error:', errorResult);
                        this.showError(errorResult?.message || 'Không thể gửi tin nhắn. Vui lòng thử lại.');
                    } catch {
                        this.showError('Không thể gửi tin nhắn. Vui lòng thử lại.');
                    }
                }
            }
        } catch (error) {
            console.error('Error sending message:', error);
            this.showError('Đã xảy ra lỗi khi gửi tin nhắn.');
        }
    }

    addMessage(content, role, timestamp = null, scrollToBottom = true) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `chat-message ${role}-message`;

        const time = timestamp ? new Date(timestamp) : new Date();
        const timeStr = this.formatTime(time);

        messageDiv.innerHTML = `
            <div class="message-content">
                ${this.formatMessageContent(content)}
            </div>
            <div class="message-time">${timeStr}</div>
        `;

        this.messagesContainer.appendChild(messageDiv);

        if (scrollToBottom) {
            this.scrollToBottom();
        }

        return messageDiv;
    }

    appendToLastMessage(chunk) {
        const lastMessage = this.messagesContainer.querySelector('.assistant-message:last-child .message-content');
        if (lastMessage) {
            lastMessage.innerHTML += this.escapeHtml(chunk);
            this.scrollToBottom();
        }
    }

    formatMessageContent(content) {
        // Convert markdown-like formatting to HTML
        let formatted = this.escapeHtml(content);

        // Bold: **text** -> <strong>text</strong>
        formatted = formatted.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');

        // Italic: *text* -> <em>text</em>
        formatted = formatted.replace(/\*(.*?)\*/g, '<em>$1</em>');

        // Line breaks
        formatted = formatted.replace(/\n/g, '<br>');

        return formatted;
    }

    showTypingIndicator() {
        this.isTyping = true;
        this.typingIndicator.style.display = 'flex';
        this.scrollToBottom();
    }

    hideTypingIndicator() {
        this.isTyping = false;
        this.typingIndicator.style.display = 'none';
    }

    showError(message) {
        const errorDiv = document.createElement('div');
        errorDiv.className = 'chat-message error-message';
        errorDiv.innerHTML = `
            <div class="message-content">
                ❌ ${this.escapeHtml(message)}
            </div>
        `;
        this.messagesContainer.appendChild(errorDiv);
        this.scrollToBottom();
    }

    scrollToBottom() {
        setTimeout(() => {
            this.messagesContainer.scrollTop = this.messagesContainer.scrollHeight;
        }, 100);
    }

    formatTime(date) {
        if (typeof date === 'string') {
            date = new Date(date);
        }

        const now = new Date();
        const diff = now - date;
        const minutes = Math.floor(diff / 60000);
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);

        if (minutes < 1) return 'Vừa xong';
        if (minutes < 60) return `${minutes} phút trước`;
        if (hours < 24) return `${hours} giờ trước`;
        if (days < 7) return `${days} ngày trước`;

        return date.toLocaleDateString('vi-VN');
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}

// Initialize chat when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    window.bloomieChat = new BloomieChat();
});
