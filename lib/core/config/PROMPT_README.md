# Gemini System Prompt Configuration

## 📄 File: `gemini_system_prompt.dart`

Ye file control karti hai ki DEVRITI AI kaise behave karega, kaise baat karega, aur users ko kaise respond karega.

---

## 🎯 Kya Hai Is File Mein?

Is file mein ek **system prompt** hai jo Gemini AI ko instructions deta hai:
- Personality kya honi chahiye
- Language kaunsi use karni hai (PURE HINGLISH)
- Kaise respond karna hai
- Crisis situations mein kya karna hai
- App features kaise suggest karne hain

---

## ✏️ Kaise Edit Karein?

### 1. File Open Karo:
```
lib/core/config/gemini_system_prompt.dart
```

### 2. `prompt` String Edit Karo:
```dart
static const String prompt = '''
  // Yahan apni instructions likho
''';
```

### 3. Changes Save Karo aur App Restart Karo

---

## 🔧 Kya Kya Change Kar Sakte Ho?

### ✅ Language Style:
```dart
// Current: Pure Hinglish
"Main samajh sakta hoon ki tum stressed feel kar rahe ho"

// Agar English chahiye:
"I understand that you are feeling stressed"

// Agar Pure Hindi chahiye:
"मैं समझ सकता हूँ कि आप तनाव महसूस कर रहे हैं"
```

### ✅ Response Length:
```dart
// Current: 3-5 sentences
- Length: 3-5 sentences (detailed but overwhelming nahi)

// Agar short chahiye:
- Length: 1-2 sentences (quick and concise)

// Agar detailed chahiye:
- Length: 5-7 sentences (comprehensive guidance)
```

### ✅ Personality/Tone:
```dart
// Current: Professional + Friendly
Tone: Warm, professional, non-judgmental, hopeful

// Agar casual chahiye:
Tone: Very casual, like a close friend, use slang

// Agar formal chahiye:
Tone: Formal, respectful, professional counselor
```

### ✅ Crisis Helpline Numbers:
```dart
// Current:
AASRA (9152987821)
Vandrevala Foundation (1860-2662-345)

// Add more:
iCall (9152987821)
Snehi (9167687469)
```

### ✅ App Features Mention:
```dart
// Add new features:
- "Try our new meditation feature"
- "Check out community support groups"
```

---

## 📝 Common Modifications

### 1. Change Language to Pure English:
```dart
🚨 LANGUAGE RULE:
- ✅ Use clear, simple English
- ✅ Avoid complex medical terms
- ✅ Be conversational but professional
```

### 2. Make Responses Shorter:
```dart
📝 RESPONSE KAISE DENA HAI:
- Length: 1-2 sentences (quick and to the point)
- Keep it simple and actionable
```

### 3. Add More Emojis:
```dart
- Use: Emojis frequently (💙 🌟 ✨ 🫂 🤗) for warmth and connection
```

### 4. Change Personality:
```dart
🎯 TUMHARA IDENTITY:
- Style: Very casual friend, like talking to bestie
- Tone: Super friendly, use "yaar", "bro", "dude"
```

---

## 🚨 Important Rules (DON'T CHANGE):

### ❌ Never Remove These:
1. **Crisis Protocol** - Suicide/self-harm handling
2. **No Medical Diagnosis** - AI cannot diagnose
3. **No Medication Advice** - AI cannot prescribe
4. **Emergency Numbers** - Always keep helplines

### ✅ Always Keep:
- Empathy and validation
- Non-judgmental approach
- Cultural sensitivity
- Professional boundaries

---

## 🧪 Testing Changes

After editing the prompt:

1. **Restart App** (Hot reload won't work)
2. **Test Different Scenarios:**
   - Happy mood: "Aaj bahut khush hoon"
   - Sad mood: "Bahut sad feel ho raha hai"
   - Crisis: "Marna chahta hoon" (test crisis protocol)
   - Casual: "Kya haal hai?"

3. **Check Console Logs:**
   - Look for Gemini responses
   - Verify language is correct
   - Check if suggestions are appropriate

---

## 📊 Examples of Different Prompts

### Example 1: Casual Friend Style
```dart
static const String prompt = '''
Tum DEVRITI ho, user ka best friend jo mental health ke baare mein jaanta hai.
Bilkul casual baat karo, jaise dost se baat karte hain.
"Yaar", "bro", "dude" use kar sakte ho.
Responses short rakho - 1-2 lines max.
Emojis zyada use karo 😊💪🔥
''';
```

### Example 2: Professional Counselor Style
```dart
static const String prompt = '''
You are DEVRITI, a professional mental health counselor.
Maintain professional boundaries while being empathetic.
Use evidence-based therapeutic techniques.
Responses should be 4-6 sentences with clear guidance.
Avoid casual language, maintain professional tone.
''';
```

### Example 3: Motivational Coach Style
```dart
static const String prompt = '''
Tum DEVRITI ho, ek motivational coach aur mental wellness expert.
Har response mein positivity aur hope honi chahiye.
Users ko inspire karo, motivate karo.
Success stories aur positive affirmations use karo.
Energy aur enthusiasm dikhao! 🔥💪
''';
```

---

## 🔄 Version History

Keep track of major changes:

```
v1.0 - Initial prompt (English + Hindi)
v2.0 - Pure Hinglish implementation
v2.1 - Added more crisis keywords
v2.2 - Enhanced app feature integration
```

---

## 💡 Tips for Writing Good Prompts

1. **Be Specific**: Clear instructions = better responses
2. **Give Examples**: Show AI how to respond
3. **Set Boundaries**: Tell what NOT to do
4. **Test Thoroughly**: Try edge cases
5. **Iterate**: Keep improving based on user feedback

---

## 🆘 Troubleshooting

### Problem: AI not responding in Hinglish
**Solution:** Make language rule more explicit, add more examples

### Problem: Responses too long
**Solution:** Reduce sentence count in guidelines

### Problem: Not suggesting app features
**Solution:** Add more emphasis on feature integration

### Problem: Too formal/casual
**Solution:** Adjust tone guidelines

---

## 📞 Support

Agar koi issue hai prompt ke saath:
1. Check console logs for errors
2. Verify Gemini API key is working
3. Test with simple messages first
4. Gradually add complexity

---

**Remember:** System prompt is the brain of your AI. Isko carefully edit karo! 🧠💙
