using Bloomie.Models;
using Bloomie.Models.Entities;

namespace Bloomie.Services.Interfaces
{
    public interface IAIChatService
    {
        /// <summary>
        /// Send a message to the AI and get a response
        /// </summary>
        /// <param name="userMessage">The user's message</param>
        /// <param name="conversationHistory">Previous messages in the conversation for context</param>
        /// <returns>AI's response</returns>
        Task<string> GetResponseAsync(string userMessage, List<ChatMessage>? conversationHistory = null);

        /// <summary>
        /// Stream a response from the AI (for real-time typing effect)
        /// </summary>
        /// <param name="userMessage">The user's message</param>
        /// <param name="conversationHistory">Previous messages in the conversation for context</param>
        /// <param name="onChunkReceived">Callback for each chunk of text received</param>
        /// <returns>Complete AI response</returns>
        Task<string> StreamResponseAsync(
            string userMessage,
            List<ChatMessage>? conversationHistory = null,
            Action<string>? onChunkReceived = null);

        /// <summary>
        /// Generate a title for a conversation based on the first message
        /// </summary>
        Task<string> GenerateConversationTitleAsync(string firstMessage);

        /// <summary>
        /// Get product recommendations based on user query
        /// </summary>
        Task<string> GetProductRecommendationAsync(string query, List<Product>? availableProducts = null);
    }
}
