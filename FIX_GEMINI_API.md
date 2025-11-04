# 🔧 Fix Gemini API Connection Issue

## ❌ Current Problem

Error: `models/gemini-pro is not found for API version v1`

This means the API key needs to be properly enabled.

## ✅ Solution - Enable Generative Language API

### Step 1: Go to Google Cloud Console
1. Open: https://console.cloud.google.com/
2. Sign in with the same Google account you used for the API key

### Step 2: Enable the API
1. Go to: https://console.cloud.google.com/apis/library/generativelanguage.googleapis.com
2. Click **"ENABLE"** button
3. Wait for it to enable (takes 1-2 minutes)

### Step 3: Verify API Key
1. Go to: https://makersuite.google.com/app/apikey
2. Make sure your key is listed
3. If not, create a new one

### Step 4: Test Again
```bash
dart run test_gemini.dart
```

You should see: ✅ SUCCESS!

---

## 🔄 Alternative: Create New API Key

If above doesn't work, create a fresh API key:

### Method 1: Google AI Studio (Recommended)
1. Go to: https://aistudio.google.com/app/apikey
2. Click "Create API Key"
3. Select "Create API key in new project"
4. Copy the new key
5. Replace in `lib/core/config/env_config.dart`

### Method 2: Google Cloud Console
1. Go to: https://console.cloud.google.com/
2. Create new project or select existing
3. Enable "Generative Language API"
4. Go to "Credentials"
5. Create "API Key"
6. Copy and use

---

## 🧪 Quick Test

After enabling API, run:

```bash
# Test the API
dart run test_gemini.dart

# If successful, run the app
flutter run -d chrome
```

---

## 📝 Update API Key

Once you have a working key, update it:

**File:** `lib/core/config/env_config.dart`

```dart
static const String geminiApiKey = 'YOUR_NEW_API_KEY_HERE';
```

---

## ⚠️ Common Issues

### Issue 1: "API key not valid"
**Solution:** Create a new API key

### Issue 2: "Quota exceeded"
**Solution:** Wait 24 hours or upgrade to paid tier

### Issue 3: "API not enabled"
**Solution:** Enable Generative Language API in Cloud Console

### Issue 4: "CORS error" (Web only)
**Solution:** Run on Android/Windows instead, or use proxy

---

## 🎯 Expected Success Output

```
Testing Gemini API with key: AIzaSyDZYD...

Trying model: gemini-1.5-pro
✅ SUCCESS with gemini-1.5-pro!
Response: Hello from Gemini!
```

---

## 💡 Temporary Workaround

While fixing API, you can use the old hardcoded chatbot:

**File:** `lib/presentation/screens/chat/chat_screen.dart`

Replace:
```dart
_chatService = GeminiChatService(
  ChatRepository(),
  EnvConfig.geminiApiKey,
);
```

With:
```dart
_chatService = ChatService(ChatRepository());
```

This will use basic responses until Gemini is fixed.

---

## 📞 Need Help?

1. Check API status: https://status.cloud.google.com/
2. Gemini docs: https://ai.google.dev/docs
3. Create new key: https://aistudio.google.com/app/apikey

---

**Once API is enabled, Gemini will work perfectly! 🎉**
