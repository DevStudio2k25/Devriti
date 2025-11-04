/// DEVRITI - Emotion Detection & Response Rules
/// Ye file emotions ko detect karne aur appropriate response dene ke rules hai

class EmotionDetectionRules {
  // ═══════════════════════════════════════════════════════════════
  // 😊 EMOTION CATEGORIES & KEYWORDS
  // ═══════════════════════════════════════════════════════════════

  /// Primary Emotions with Keywords
  static const Map<String, List<String>> emotionKeywords = {
    'happy': [
      'khush',
      'happy',
      'achha',
      'good',
      'great',
      'amazing',
      'wonderful',
      'excited',
      'joyful',
      'maza',
      'fun',
      'enjoy',
      'celebrate',
      'proud',
      'grateful',
      'thankful',
      'blessed',
      'lucky',
      'awesome',
      'fantastic',
    ],
    'sad': [
      'sad',
      'dukhi',
      'upset',
      'hurt',
      'pain',
      'dard',
      'cry',
      'rona',
      'depressed',
      'down',
      'low',
      'unhappy',
      'miserable',
      'heartbroken',
      'disappointed',
      'hopeless',
      'empty',
      'lonely',
      'akela',
      'alone',
    ],
    'angry': [
      'angry',
      'gussa',
      'mad',
      'furious',
      'irritated',
      'annoyed',
      'frustrated',
      'rage',
      'hate',
      'nafrat',
      'bitter',
      'resentful',
      'pissed',
      'fed up',
    ],
    'anxious': [
      'anxious',
      'anxiety',
      'worried',
      'tension',
      'stress',
      'nervous',
      'scared',
      'afraid',
      'dar',
      'panic',
      'overwhelmed',
      'restless',
      'uneasy',
      'concerned',
      'fearful',
      'paranoid',
      'overthinking',
    ],
    'confused': [
      'confused',
      'confuse',
      'samajh nahi aa raha',
      'don\'t know',
      'uncertain',
      'doubt',
      'shak',
      'unclear',
      'mixed feelings',
      'conflicted',
      'torn',
      'dilemma',
      'stuck',
      'lost',
    ],
    'tired': [
      'tired',
      'thak gaya',
      'exhausted',
      'drained',
      'fatigue',
      'burnout',
      'worn out',
      'sleepy',
      'neend',
      'weak',
      'kamzor',
      'energy nahi',
    ],
    'hopeful': [
      'hopeful',
      'hope',
      'umeed',
      'optimistic',
      'positive',
      'better',
      'improving',
      'progress',
      'forward',
      'motivated',
      'inspired',
    ],
    'guilty': [
      'guilty',
      'guilt',
      'shame',
      'sharam',
      'regret',
      'pachtawa',
      'sorry',
      'fault',
      'blame',
      'responsible',
      'bad person',
    ],
  };

  // ═══════════════════════════════════════════════════════════════
  // 🎯 EMOTION-SPECIFIC RESPONSE TEMPLATES
  // ═══════════════════════════════════════════════════════════════

  static const Map<String, Map<String, dynamic>> emotionResponses = {
    'happy': {
      'validation': 'Waah! Bahut achha lag raha hai sunke! 🌟',
      'exploration': 'Kya special hua? Share karo mujhse! ✨',
      'encouragement': 'Aise moments ko celebrate karo aur yaad rakho! 💫',
      'emojis': ['😊', '🌟', '✨', '💫', '🎉', '💪'],
    },
    'sad': {
      'validation': 'Main samajh sakta hoon ki tum dukhi ho. 💙',
      'exploration': 'Kya hua? Baat karo, main yahan hoon. 🫂',
      'support': 'Tum akele nahi ho. Main tumhare saath hoon. 💙',
      'emojis': ['💙', '🫂', '💔', '😢', '🤗'],
    },
    'angry': {
      'validation': 'Gussa aana bilkul normal hai. 😤',
      'exploration': 'Kya hua jo tumhe gussa aa raha hai?',
      'coping': 'Chalo thoda breathe karte hain. Deep breaths lo. 🫁',
      'emojis': ['😤', '💪', '🤝', '💙', '🫁'],
    },
    'anxious': {
      'validation': 'Anxiety handle karna tough hai yaar. 🫁',
      'immediate': 'Chalo breathing exercise try karte hain - 4-7-8. 🫁',
      'exploration': 'Kya specific cheez anxiety de rahi hai?',
      'emojis': ['🫁', '💙', '🤝', '🫂', '💪'],
    },
    'confused': {
      'validation': 'Confusion hona normal hai. 🤔',
      'exploration': 'Chalo ek ek karke samajhte hain. Kya confusion hai?',
      'support': 'Main help karunga/karungi clarity lane mein. 💡',
      'emojis': ['🤔', '💭', '🎯', '💡', '🤝'],
    },
    'tired': {
      'validation': 'Thak gaye ho? Rest lena important hai. 💤',
      'exploration': 'Kya physical tired ho ya mental?',
      'suggestion': 'Break lo, self-care karo. Overwork mat karo. 🌙',
      'emojis': ['💤', '🌙', '😴', '🫂', '💙'],
    },
  };

  // ═══════════════════════════════════════════════════════════════
  // 🌡️ EMOTION INTENSITY LEVELS
  // ═══════════════════════════════════════════════════════════════

  static const Map<String, List<String>> intensityIndicators = {
    'mild': ['thoda', 'little bit', 'slightly', 'somewhat', 'kinda', 'sort of'],
    'moderate': ['quite', 'pretty', 'fairly', 'kaafi', 'bahut thoda'],
    'severe': [
      'bahut',
      'very',
      'extremely',
      'really',
      'too much',
      'can\'t handle',
      'unbearable',
      'overwhelming',
      'intense',
      'zyada',
    ],
    'crisis': [
      'suicide',
      'marna',
      'die',
      'kill',
      'end',
      'khatam',
      'can\'t take it',
      'no point',
      'give up',
      'self harm',
      'hurt myself',
    ],
  };

  // ═══════════════════════════════════════════════════════════════
  // 🔄 EMOTION TRANSITION PATTERNS
  // ═══════════════════════════════════════════════════════════════

  /// Common emotion transitions to watch for
  static const Map<String, List<String>> emotionTransitions = {
    'sad_to_angry': [
      'Pehle sad tha, ab gussa aa raha hai',
      'Dukh se gussa ban gaya',
    ],
    'anxious_to_panic': [
      'Anxiety badh rahi hai',
      'Control nahi ho raha',
      'Panic ho raha hai',
    ],
    'hopeful_to_disappointed': [
      'Umeed thi but...',
      'Socha tha achha hoga but...',
    ],
  };

  // ═══════════════════════════════════════════════════════════════
  // 💬 EMOTION-BASED CONVERSATION STARTERS
  // ═══════════════════════════════════════════════════════════════

  static const Map<String, List<String>> conversationStarters = {
    'happy': [
      'Kya baat hai! Aaj bahut khush lag rahe ho! 😊',
      'Achha mood hai! Kya special hua? ✨',
      'Ye energy maintain karo! Kya plan hai? 🌟',
    ],
    'sad': [
      'Kuch theek nahi lag raha? Baat karo. 💙',
      'Dukhi lag rahe ho. Main yahan hoon. 🫂',
      'Kya hua? Share karna chahoge? 💙',
    ],
    'anxious': [
      'Tension ho rahi hai? Breathe karo pehle. 🫁',
      'Anxiety feel ho rahi hai? Main samajh sakta hoon. 💙',
      'Kya specific cheez worry kar rahi hai? 🤝',
    ],
  };

  // ═══════════════════════════════════════════════════════════════
  // 🎨 EMOJI SELECTION BASED ON EMOTION
  // ═══════════════════════════════════════════════════════════════

  static String getEmoji(String emotion, String intensity) {
    final emojiMap = {
      'happy_mild': '😊',
      'happy_moderate': '😄',
      'happy_severe': '🎉',
      'sad_mild': '😔',
      'sad_moderate': '😢',
      'sad_severe': '💔',
      'angry_mild': '😤',
      'angry_moderate': '😠',
      'angry_severe': '🤬',
      'anxious_mild': '😰',
      'anxious_moderate': '😨',
      'anxious_severe': '😱',
    };
    return emojiMap['${emotion}_$intensity'] ?? '💙';
  }

  // ═══════════════════════════════════════════════════════════════
  // 🔍 EMOTION DETECTION ALGORITHM
  // ═══════════════════════════════════════════════════════════════

  static String detectEmotion(String text) {
    final lowerText = text.toLowerCase();
    final emotionScores = <String, int>{};

    // Score each emotion based on keyword matches
    emotionKeywords.forEach((emotion, keywords) {
      int score = 0;
      for (var keyword in keywords) {
        if (lowerText.contains(keyword)) {
          score++;
        }
      }
      if (score > 0) {
        emotionScores[emotion] = score;
      }
    });

    // Return emotion with highest score
    if (emotionScores.isEmpty) return 'neutral';

    return emotionScores.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  // ═══════════════════════════════════════════════════════════════
  // 📊 EMOTION TRACKING SUGGESTIONS
  // ═══════════════════════════════════════════════════════════════

  static const List<String> trackingSuggestions = [
    '📊 Apna mood daily track karo - pattern samajh aayega',
    '📝 Journal mein likho - emotions process hote hain',
    '🎯 Triggers identify karo - kya tumhe affect karta hai',
    '💡 Coping strategies note karo - kya kaam karta hai',
    '📈 Progress dekho - improvement motivate karti hai',
  ];
}
