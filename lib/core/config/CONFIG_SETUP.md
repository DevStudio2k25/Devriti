# 🔧 Configuration Setup Guide

## ⚠️ IMPORTANT: API Keys Setup

### Step 1: Copy Example File
```bash
cp env_config.example.dart env_config.dart
```

### Step 2: Add Your API Key
Open `env_config.dart` and replace:
```dart
static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';
```

With your actual key:
```dart
static const String geminiApiKey = 'AIzaSy...your-actual-key';
```

### Step 3: Get Gemini API Key
1. Visit: https://makersuite.google.com/app/apikey
2. Create new API key
3. Copy and paste in `env_config.dart`

---

## 🔒 Security

### Files in .gitignore:
- ✅ `env_config.dart` - Contains API keys (NEVER commit!)
- ✅ `.env` files - Environment variables
- ❌ `env_config.example.dart` - Template (safe to commit)

### Files NOT in .gitignore (Safe to commit):
- ✅ `gemini_rules/` folder - All rule files
- ✅ `CONFIG_SETUP.md` - This guide
- ✅ `env_config.example.dart` - Template without keys

---

## 📂 Config Folder Structure

```
lib/core/config/
├── env_config.dart              ← 🔒 IGNORED (your API keys)
├── env_config.example.dart      ← ✅ COMMITTED (template)
├── CONFIG_SETUP.md              ← ✅ COMMITTED (this file)
│
└── gemini_rules/                ← ✅ COMMITTED (all rules)
    ├── 00_INDEX.md
    ├── README.md
    ├── gemini_rules.dart
    ├── 01_system_prompt.dart
    ├── 02_conversation_rules.dart
    ├── 03_advanced_rules.dart
    ├── 04_emotion_detection_rules.dart
    └── 05_crisis_intervention_rules.dart
```

---

## ✅ Verification

Check if setup is correct:

```bash
# This should show env_config.dart
ls lib/core/config/env_config.dart

# This should NOT show env_config.dart (only example)
git ls-files | grep env_config
```

Expected output:
```
lib/core/config/env_config.example.dart  ← Only example should be tracked
```

---

## 🚨 If You Accidentally Committed API Key

If you already committed `env_config.dart` with API key:

1. **Remove from git tracking:**
   ```bash
   git rm --cached lib/core/config/env_config.dart
   git commit -m "Remove env_config.dart from tracking"
   git push
   ```

2. **Regenerate API key:**
   - Go to Google AI Studio
   - Delete old key
   - Create new key
   - Update in your local `env_config.dart`

3. **Verify it's ignored:**
   ```bash
   git status
   # Should NOT show env_config.dart
   ```

---

## 💡 For Team Members

When cloning the repo:

1. Clone repo
2. Copy example file:
   ```bash
   cp lib/core/config/env_config.example.dart lib/core/config/env_config.dart
   ```
3. Add your own API key in `env_config.dart`
4. Never commit `env_config.dart`!

---

## 🔍 Why This Setup?

### ✅ Benefits:
- API keys stay private
- Each developer uses their own key
- No accidental key leaks
- Easy setup for new team members
- Rules and configs are version controlled

### ❌ Without This:
- API keys exposed on GitHub
- Security risk
- Keys can be stolen
- Need to regenerate keys frequently

---

**Remember:** `env_config.dart` is in `.gitignore` - it will NEVER be committed! 🔒
