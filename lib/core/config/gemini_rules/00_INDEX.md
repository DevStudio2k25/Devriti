# 📚 DEVRITI - Gemini AI Rules Directory

Ye folder mein saare Gemini AI ke rules organized hain. Har file ek specific purpose ke liye hai.

---

## 📂 File Structure

```
gemini_rules/
├── 00_INDEX.md                          ← Ye file (overview)
├── README.md                             ← Detailed documentation
├── gemini_rules.dart                     ← Main export file
│
├── 01_system_prompt.dart                 ← Core system prompt
├── 02_conversation_rules.dart            ← Basic conversation rules
├── 03_advanced_rules.dart                ← Advanced therapeutic techniques
├── 04_emotion_detection_rules.dart       ← Emotion detection & responses
└── 05_crisis_intervention_rules.dart     ← Crisis protocols
```

---

## 🎯 Quick Guide

### Kaunsi File Kab Use Karein?

| File | Purpose | Kab Edit Karein |
|------|---------|----------------|
| **01_system_prompt.dart** | Main personality & behavior | Language, tone, style change karna ho |
| **02_conversation_rules.dart** | Basic responses | Common situations ke responses add/edit |
| **03_advanced_rules.dart** | Therapeutic techniques | CBT, DBT techniques add karne ho |
| **04_emotion_detection_rules.dart** | Emotion handling | Naye emotions ya keywords add karne ho |
| **05_crisis_intervention_rules.dart** | Emergency protocols | Crisis handling improve karna ho |

---

## 🔧 How to Use

### Import All Rules:
```dart
import 'package:ksnh/core/config/gemini_rules/gemini_rules.dart';
```

### Use System Prompt:
```dart
final prompt = GeminiSystemPrompt.prompt;
```

### Check Crisis:
```dart
if (GeminiRulesManager.isCrisisMessage(userText)) {
  // Handle crisis
}
```

### Detect Emotion:
```dart
final emotion = GeminiRulesManager.detectEmotion(userText);
final response = GeminiRulesManager.getEmotionResponse(emotion);
```

---

## ➕ Adding New Rules

### Step 1: Create New File
```
06_your_new_rules.dart
```

### Step 2: Define Rules Class
```dart
class YourNewRules {
  static const Map<String, String> yourRules = {
    'key': 'value',
  };
}
```

### Step 3: Export in gemini_rules.dart
```dart
export '06_your_new_rules.dart';
```

### Step 4: Add to Manager (if needed)
```dart
static Map<String, dynamic> getYourRules() {
  return YourNewRules.yourRules;
}
```

---

## 📝 File Details

### 01_system_prompt.dart
**Purpose:** Core AI personality
**Contains:**
- Identity & role definition
- Language rules (Hinglish)
- Emoji usage rules
- Friend-like behavior guidelines
- Gender detection rules
- Response examples

**Edit When:**
- Personality change chahiye
- Language style change karna ho
- New behavioral rules add karne ho

---

### 02_conversation_rules.dart
**Purpose:** Common conversation patterns
**Contains:**
- Emotion-specific responses (sad, happy, anxious, etc.)
- Greeting responses
- Helpline numbers
- Tone guidelines
- Response templates

**Edit When:**
- Naye emotions add karne ho
- Response templates improve karne ho
- Helpline numbers update karne ho

---

### 03_advanced_rules.dart
**Purpose:** Professional therapeutic techniques
**Contains:**
- CBT techniques
- DBT skills
- Panic attack protocol
- Relationship conflict resolution
- Motivational interviewing
- Psychoeducation

**Edit When:**
- Naye therapeutic techniques add karne ho
- Existing techniques improve karne ho
- Professional protocols update karne ho

---

### 04_emotion_detection_rules.dart
**Purpose:** Emotion recognition & response
**Contains:**
- Emotion keywords (happy, sad, angry, etc.)
- Intensity levels (mild, moderate, severe)
- Emotion-specific templates
- Emoji selection rules
- Tracking suggestions

**Edit When:**
- Naye emotions detect karne ho
- Keywords expand karne ho
- Response templates improve karne ho

---

### 05_crisis_intervention_rules.dart
**Purpose:** Emergency situation handling
**Contains:**
- Suicide keywords
- Self-harm indicators
- Emergency helplines
- Crisis response protocol
- Safety planning
- De-escalation techniques
- Risk assessment

**Edit When:**
- Crisis protocols update karne ho
- Helpline numbers change ho
- Safety procedures improve karne ho

---

## 🎨 Best Practices

### ✅ DO:
- Har file mein clear comments likho
- Examples provide karo
- Hinglish mein likho (jaise users baat karte hain)
- Test karo changes ko
- Version history maintain karo

### ❌ DON'T:
- Multiple files mein same rules mat rakho
- Pure English mat use karo
- Crisis protocols ko casually mat lo
- Bina testing ke deploy mat karo

---

## 🔄 Version Control

Har major change ke baad version note karo:

```dart
/// Version: 2.0
/// Date: 2025-11-04
/// Changes:
/// - Added gender detection
/// - Improved crisis protocols
/// - Enhanced emotion detection
```

---

## 🧪 Testing New Rules

1. **Local Testing:**
   ```dart
   // Test specific rule
   final response = ConversationRules.sadnessResponses['sad'];
   print(response);
   ```

2. **Integration Testing:**
   - App mein test karo
   - Different scenarios try karo
   - Edge cases check karo

3. **User Testing:**
   - Real users se feedback lo
   - Improvements note karo
   - Iterate karo

---

## 📞 Support & Questions

Agar koi confusion hai:
1. README.md padho (detailed guide)
2. Code comments dekho
3. Examples follow karo
4. Test karo pehle

---

## 🌟 Future Additions

Ye files add kar sakte ho:

- `06_cultural_context_rules.dart` - Indian cultural nuances
- `07_age_specific_rules.dart` - Teenagers, adults, elderly
- `08_language_specific_rules.dart` - Hindi, English variations
- `09_personality_variants.dart` - Different AI personalities
- `10_seasonal_rules.dart` - Festival, exam season specific

---

**Remember:** Ye rules Gemini AI ka brain hain. Carefully edit karo! 🧠💙

**Last Updated:** November 4, 2025
**Version:** 2.0
