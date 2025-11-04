# ⚠️ Temporary Fix - Use Basic Chatbot

## Problem
Gemini API key needs "Generative Language API" to be enabled in Google Cloud Console.

## Quick Solution (2 minutes)

### Use the basic chatbot while we fix Gemini:

**File:** `lib/presentation/screens/chat/chat_screen.dart`

**Find this (around line 20):**
```dart
import '../../../domain/services/gemini_chat_service.dart';
```

**Replace with:**
```dart
import '../../../domain/services/chat_service.dart';
```

**Find this (around line 30):**
```dart
late GeminiChatService _chatService;
```

**Replace with:**
```dart
late ChatService _chatService;
```

**Find this (around line 35):**
```dart
_chatService = GeminiChatService(
  ChatRepository(),
  EnvConfig.geminiApiKey,
);
```

**Replace with:**
```dart
_chatService = ChatService(ChatRepository());
```

Now the app will work with basic responses!

---

## To Enable Gemini (Proper Fix)

### Step 1: Enable API in Google Cloud
1. Go to: https://console.cloud.google.com/
2. Select project "Sukoon" (project number: 507587728560)
3. Go to: https://console.cloud.google.com/apis/library/generativelanguage.googleapis.com
4. Click **"ENABLE"**
5. Wait 1-2 minutes

### Step 2: Revert the Changes
Once API is enabled, undo the changes above to use Gemini again.

### Step 3: Test
```bash
dart run test_gemini.dart
```

Should show: ✅ SUCCESS!

---

## Why This Happened

New API keys from Google AI Studio need the "Generative Language API" to be manually enabled in Google Cloud Console. It's not automatic.

---

**For now, use the basic chatbot. It works fine for testing! 👍**
