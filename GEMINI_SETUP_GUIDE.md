# 🤖 Gemini AI Integration Guide

## Why Gemini for Sukoon?

### ✅ Benefits
1. **Free Tier Available** - 60 requests per minute
2. **Mental Health Aware** - Trained on empathetic conversations
3. **Multilingual** - Supports English & Hindi
4. **Context Retention** - Remembers conversation history
5. **Safety Features** - Built-in content filtering
6. **No Server Needed** - Direct API calls from app

### 🆚 Comparison

| Feature | Current (Hardcoded) | Gemini AI |
|---------|-------------------|-----------|
| Response Quality | Basic keywords | Natural, contextual |
| Language Support | Limited | English + Hindi |
| Context Awareness | None | Full conversation |
| Personalization | No | Yes |
| Crisis Detection | Basic | Advanced |
| Cost | Free | Free (60 req/min) |

## 🚀 Setup Steps

### Step 1: Get Gemini API Key

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in with Google account
3. Click "Create API Key"
4. Copy the API key

### Step 2: Add API Key to App

**Option A: Environment Variable (Recommended)**

Create `.env` file in project root:
```env
GEMINI_API_KEY=your_api_key_here
```

Update `lib/core/config/env_config.dart`:
```dart
class EnvConfig {
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'YOUR_API_KEY_HERE', // For development only
  );
}
```

**Option B: Direct in Code (For Testing)**

Update `lib/core/config/env_config.dart`:
```dart
class EnvConfig {
  static const String geminiApiKey = 'YOUR_API_KEY_HERE';
}
```

⚠️ **Never commit API keys to Git!**

### Step 3: Install Dependencies

```bash
flutter pub get
```

### Step 4: Update Chat Screen

Replace `ChatService` with `GeminiChatService` in chat screen:

```dart
// In lib/presentation/screens/chat/chat_screen.dart
import '../../../domain/services/gemini_chat_service.dart';

// Initialize in initState:
_chatService = GeminiChatService(
  ChatRepository(),
  EnvConfig.geminiApiKey,
);
```

### Step 5: Test the Integration

1. Run the app
2. Go to Chat screen
3. Send a message like "I'm feeling anxious"
4. You should get an empathetic AI response!

## 📱 Usage Examples

### Example Conversations

**User:** "I'm feeling really stressed about work"
**Sukoon (Gemini):** "I hear you - work stress can be overwhelming. It's important to take breaks. Have you tried any relaxation techniques today? Even 5 minutes of deep breathing can help."

**User:** "मुझे बहुत अकेलापन महसूस हो रहा है" (I'm feeling very lonely)
**Sukoon (Gemini):** "अकेलापन महसूस करना बहुत मुश्किल है। आप अकेले नहीं हैं। क्या आप किसी दोस्त या परिवार के सदस्य से बात करना चाहेंगे?"

**User:** "I can't sleep at night"
**Sukoon (Gemini):** "Sleep troubles can be really frustrating. Let's try some calming techniques. Would you like to try our sleep meditation or listen to relaxing sounds?"

## 🔒 Safety Features

### Built-in Protections

1. **Crisis Detection** - Identifies suicidal thoughts
2. **Immediate Help** - Suggests emergency helplines
3. **Content Filtering** - Blocks harmful content
4. **Professional Referral** - Recommends doctors when needed

### Crisis Response Example

**User:** "I don't want to live anymore"
**Sukoon (Gemini):** "I'm really concerned about you. Please reach out for immediate help:
- Call AASRA: 9152987821 (24/7)
- Talk to a mental health professional
- Tell someone you trust

Your life matters. Help is available."

## 💰 Cost & Limits

### Free Tier (Gemini Pro)
- **60 requests per minute**
- **1,500 requests per day**
- **1 million tokens per month**

For Sukoon app:
- Average conversation: 10-20 messages
- Daily active users: Can support 100+ users easily
- Cost: **FREE** for most use cases

### If You Need More
- Gemini Pro: $0.00025 per 1K characters
- Very affordable even at scale

## 🛠️ Advanced Configuration

### Custom System Prompt

Edit in `gemini_chat_service.dart`:
```dart
_chatSession = _model.startChat(history: [
  Content.text('''Your custom prompt here...'''),
]);
```

### Adjust Response Style

```dart
generationConfig: GenerationConfig(
  temperature: 0.7,  // 0.0 = focused, 1.0 = creative
  topK: 40,          // Diversity of responses
  topP: 0.95,        // Nucleus sampling
  maxOutputTokens: 1024, // Response length
),
```

### Add More Languages

The model already supports:
- English
- Hindi
- Hinglish (mix)
- 100+ other languages

## 🧪 Testing

### Test Cases

1. **Normal conversation**
   - "How are you?"
   - Expected: Friendly greeting

2. **Stress detection**
   - "I'm feeling anxious"
   - Expected: Empathetic response + suggestions

3. **Crisis detection**
   - "I want to end it all"
   - Expected: Emergency helpline + immediate help

4. **Hindi support**
   - "मुझे मदद चाहिए"
   - Expected: Hindi response

5. **Fallback handling**
   - Disconnect internet
   - Expected: Graceful fallback message

## 📊 Monitoring

### Track Usage

Add analytics in `gemini_chat_service.dart`:
```dart
// Log API calls
print('Gemini API call at ${DateTime.now()}');

// Track response time
final startTime = DateTime.now();
final response = await _chatSession.sendMessage(Content.text(text));
final duration = DateTime.now().difference(startTime);
print('Response time: ${duration.inMilliseconds}ms');
```

## 🔄 Migration from Old Service

### Before (Hardcoded)
```dart
final chatService = ChatService(ChatRepository());
```

### After (Gemini)
```dart
final chatService = GeminiChatService(
  ChatRepository(),
  EnvConfig.geminiApiKey,
);
```

That's it! Same interface, better responses! 🎉

## 🆘 Troubleshooting

### Issue: "API key not valid"
**Solution:** Check if API key is correct and enabled

### Issue: "Quota exceeded"
**Solution:** Wait for quota reset or upgrade plan

### Issue: "Network error"
**Solution:** Check internet connection, implement retry logic

### Issue: "Response blocked by safety"
**Solution:** Adjust safety settings or rephrase prompt

## 📚 Resources

- [Gemini API Docs](https://ai.google.dev/docs)
- [Flutter Package](https://pub.dev/packages/google_generative_ai)
- [Best Practices](https://ai.google.dev/docs/best_practices)
- [Safety Settings](https://ai.google.dev/docs/safety_setting_gemini)

## ✅ Checklist

- [ ] Get Gemini API key
- [ ] Add to env_config.dart
- [ ] Run `flutter pub get`
- [ ] Update chat screen to use GeminiChatService
- [ ] Test with sample messages
- [ ] Test crisis detection
- [ ] Test Hindi support
- [ ] Add error handling
- [ ] Monitor usage

## 🎯 Next Steps

1. **Start with Gemini** - Better user experience
2. **Monitor usage** - Track API calls
3. **Collect feedback** - Improve prompts
4. **Add features** - Voice input, image analysis
5. **Scale up** - Upgrade if needed

**Recommendation: Use Gemini AI for production! 🚀**
