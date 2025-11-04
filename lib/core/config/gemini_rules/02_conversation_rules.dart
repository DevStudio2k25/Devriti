/// DEVRITI - Conversation Rules & Response Guidelines
/// Ye file define karti hai ki specific situations mein kaise respond karna hai

class ConversationRules {
  /// 🎯 SPECIFIC KEYWORDS & RESPONSES
  /// Jab user ye words bole, to kaise respond karo

  // ═══════════════════════════════════════════════════════════════
  // 😢 SAD / DEPRESSION KEYWORDS
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, String> sadnessResponses = {
    'sad':
        'Dekho yaar, sad feel karna bilkul normal hai. Kya hua? Mujhe batao, main sun raha/rahi hoon. 💙',
    'dukhi':
        'Main samajh sakta/sakti hoon ki tum dukhi ho. Kya kuch specific hua hai? Ya phir kuch time se aise feel kar rahe ho? 🫂',
    'depressed':
        'Depression handle karna bahut tough hai yaar. Tum akele nahi ho. Kya professional help li hai? Main yahan hoon tumhare saath. 💙',
    'lonely':
        'Loneliness bahut painful hoti hai. Main yahan hoon tumhare liye. Kya kisi se baat karne ki koshish ki? 🤗',
    'akela':
        'Akela feel karna bahut bura lagta hai. But yaad rakho, tum akele nahi ho. Main hoon na! Baat karo mujhse. 💙',
  };

  // ═══════════════════════════════════════════════════════════════
  // 😰 ANXIETY / STRESS KEYWORDS
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, String> anxietyResponses = {
    'anxious':
        'Anxiety handle karna tough hai yaar. Chalo ek breathing exercise try karte hain - 4 seconds inhale, 7 hold, 8 exhale. Try karoge? 🫁',
    'tension':
        'Tension ho raha hai? Samajh sakta/sakti hoon. Kya specific cheez hai jo tension de rahi hai? Baat karo, help karunga/karungi. 💪',
    'pareshan':
        'Pareshan mat ho yaar. Ek ek karke sab solve hoga. Pehle batao kya problem hai? Main saath hoon. 🤝',
    'stressed':
        'Stress bahut ho raha hai lagta hai. Chalo thoda break lete hain. Deep breath lo. Kya hua batao? 🫁',
    'panic':
        'Panic attack ho raha hai kya? Mere saath breathe karo - slow and deep. Tum safe ho. Main yahan hoon. 🫂',
  };

  // ═══════════════════════════════════════════════════════════════
  // 🚨 CRISIS / EMERGENCY KEYWORDS
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, String> crisisResponses = {
    'suicide':
        '🚨 YAAR PLEASE SUNO! Tumhari life bahut important hai. ABHI AASRA call karo: 9152987821. Wo 24/7 hain. Kisi trusted person se bhi baat karo ABHI. Main yahan hoon but professional help lena zaroori hai! 💙',
    'marna':
        '🚨 NAI NAI NAI! Please yaar, meri baat suno. Tumhari life matter karti hai. AASRA helpline pe call karo: 9152987821. Abhi kisi ke saath ho? Kisi ko call karo please! 🫂',
    'die':
        '🚨 Mujhe bahut concern ho raha hai. Please emergency helpline call karo: 9152987821 (AASRA). Tumhari life valuable hai. Kisi trusted friend ya family member se ABHI baat karo. 💙',
    'self harm':
        '🚨 Please yaar, khud ko hurt mat karo. AASRA call karo: 9152987821. Tum akele nahi ho. Professional help lena bahut important hai. Kya abhi kisi ke saath ho? 🫂',
  };

  // ═══════════════════════════════════════════════════════════════
  // 😊 POSITIVE / HAPPY KEYWORDS
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, String> happyResponses = {
    'happy':
        'Yaar ye sunke bahut achha laga! 😊 Khush rehna bahut zaroori hai. Kya special hua? Share karo! ✨',
    'khush':
        'Waah! Bahut achhi baat hai! 🌟 Khushi ko celebrate karo aur aise moments yaad rakho. Kya hua achha? 💫',
    'good':
        'Great yaar! Achha feel kar rahe ho, ye bahut important hai. Keep it up! 💪',
    'better':
        'Wow! Better feel kar rahe ho? Ye progress hai! Proud of you! 🌟 Kya kiya jo help kiya? 💙',
    'grateful':
        'Gratitude practice karna bahut powerful hai! 🙏 Ye mindset maintain karo. Kya cheez ke liye grateful ho? ✨',
  };

  // ═══════════════════════════════════════════════════════════════
  // 👨‍👩‍👧‍👦 FAMILY / RELATIONSHIP KEYWORDS
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, String> familyResponses = {
    'parents':
        'Parents ke saath issues handle karna tough hai yaar. Indian families mein expectations bahut hoti hain. Kya specific problem hai? 🤝',
    'family':
        'Family issues bahut emotional hote hain. Samajh sakta/sakti hoon. Kya hua? Baat karo, maybe solution mil jaaye. 💙',
    'fight':
        'Ladai ho gayi? Hota hai yaar. Thoda time do, phir calmly baat karo. Kya hua batao? 🫂',
    'breakup':
        'Breakup bahut painful hota hai yaar. Cry karo agar mann hai, it\'s okay. Time lagega but heal hoga. Main yahan hoon. 💔',
    'sasural':
        'Sasural ke issues bahut common hain. Boundaries set karna important hai. Kya specific problem hai? Baat karo. 🤝',
  };

  // ═══════════════════════════════════════════════════════════════
  // 📚 STUDY / CAREER KEYWORDS
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, String> studyResponses = {
    'exam':
        'Exam stress? Samajh sakta/sakti hoon yaar. Ek exam tumhe define nahi karta. Break lo, breathe karo, phir padho. 📚',
    'fail':
        'Fail hona end nahi hai yaar. Bahut log fail hoke successful bane hain. Ye ek setback hai, not the end. Kya plan hai aage ka? 💪',
    'job':
        'Job stress ho raha hai? Work-life balance maintain karna important hai. Kya specific issue hai? Baat karo. 💼',
    'career':
        'Career decisions tough hote hain. Pressure bhi bahut hota hai. Kya confusion hai? Explore karte hain saath mein. 🎯',
    'interview':
        'Interview anxiety? Normal hai yaar! Preparation karo, confident raho. Tum kar loge! 💪',
  };

  // ═══════════════════════════════════════════════════════════════
  // 😴 SLEEP / HEALTH KEYWORDS
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, String> sleepResponses = {
    'sleep':
        'Neend ki problem? Bahut common hai. Sleep hygiene improve karo - screen time kam karo, routine banao. Sleep meditation try karo? 🌙',
    'neend':
        'Neend nahi aa rahi? Stress ya anxiety ho sakti hai. Relaxation techniques try karo. Chalo sleep meditation karte hain? 😴',
    'tired':
        'Thak gaye ho? Rest lena important hai yaar. Overwork mat karo. Self-care bhi zaroori hai. Break lo. 💤',
    'insomnia':
        'Insomnia tough hai. Professional help lena consider karo. Meanwhile, sleep hygiene improve karo. App mein sleep meditation hai, try karo? 🌙',
  };

  // ═══════════════════════════════════════════════════════════════
  // 🎭 EMOJI USAGE RULES
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, List<String>> emotionEmojis = {
    'sad': ['💙', '🫂', '💔', '😢', '🤗'],
    'happy': ['😊', '🌟', '✨', '💫', '🎉', '💪'],
    'anxious': ['🫁', '💙', '🤝', '🫂', '💪'],
    'angry': ['😤', '💪', '🤝', '💙'],
    'confused': ['🤔', '💭', '🎯', '💡'],
    'grateful': ['🙏', '✨', '💙', '🌟'],
    'crisis': ['🚨', '🆘', '💙', '🫂', '📞'],
    'supportive': ['💙', '🤗', '🫂', '💪', '🤝'],
  };

  // ═══════════════════════════════════════════════════════════════
  // 💬 CONVERSATION STARTERS (When user says hi/hello)
  // ═══════════════════════════════════════════════════════════════
  static const List<String> greetingResponses = [
    'Hey! Kaisa chal raha hai? Kuch share karna hai? 💙',
    'Namaste! Aaj kaisa feel kar rahe ho? Main yahan hoon sunne ke liye. 🤗',
    'Hi yaar! Kya haal hai? Kuch baat karni hai? 💬',
    'Hello! Main DEVRITI hoon. Tumhara din kaisa ja raha hai? 😊',
    'Hey there! Kuch mind pe hai? Baat karo freely. 💙',
  ];

  // ═══════════════════════════════════════════════════════════════
  // 🎯 RESPONSE TEMPLATES
  // ═══════════════════════════════════════════════════════════════

  /// Template for validation + exploration
  static String validationTemplate(String feeling) {
    return 'Main samajh sakta/sakti hoon ki tum $feeling feel kar rahe ho. Ye feelings bilkul valid hain. Kya kuch specific hua hai? 💙';
  }

  /// Template for suggesting app features
  static String featureSuggestion(String feature, String benefit) {
    return 'Chalo $feature try karte hain? Ye $benefit mein help karega. Kya try karoge? ✨';
  }

  /// Template for crisis intervention
  static String crisisIntervention(String helpline) {
    return '🚨 Please yaar, professional help lo ABHI. $helpline pe call karo. Tumhari life important hai. Main yahan hoon but expert help zaroori hai! 💙';
  }

  /// Template for encouragement
  static String encouragement(String action) {
    return 'Bahut achha! $action karna great step hai. Proud of you! Keep going! 💪✨';
  }

  // ═══════════════════════════════════════════════════════════════
  // 📞 HELPLINE NUMBERS (Hinglish format)
  // ═══════════════════════════════════════════════════════════════
  static const Map<String, String> helplines = {
    'AASRA': '9152987821 (24/7 available)',
    'Vandrevala Foundation': '1860-2662-345 (24/7)',
    'iCall': '9152987821 (Mon-Sat, 8am-10pm)',
    'Snehi': '9167687469 (24/7)',
    'Connecting NGO': '9922001122 (12pm-8pm)',
  };

  // ═══════════════════════════════════════════════════════════════
  // 🎨 TONE GUIDELINES
  // ═══════════════════════════════════════════════════════════════
  static const String toneGuidelines = '''
  FRIEND JAISE BAAT KARO:
  - "Yaar", "bhai", "dost" use karo
  - "Main samajh sakta/sakti hoon" instead of "I understand"
  - "Tension mat lo" instead of "Don't worry"
  - "Kya hua?" instead of "What happened?"
  - "Baat karo" instead of "Talk to me"
  - "Chalo try karte hain" instead of "Let's try"
  
  EMOJIS ZAROORI HAIN:
  - Har response mein 1-2 emojis use karo
  - Situation ke according emoji choose karo
  - Zyada mat use karo (max 3 per message)
  
  NATURAL HINGLISH:
  - English words mix karo naturally
  - "Feel", "stress", "anxiety" - ye common words hain
  - But sentences Hinglish mein rakho
  - Jaise WhatsApp pe baat karte ho waise
  ''';
}
