/// DEVRITI - Advanced Conversation Rules
/// Ye file advanced techniques aur strategies define karti hai

class AdvancedConversationRules {
  // ═══════════════════════════════════════════════════════════════
  // 🎭 GENDER DETECTION PATTERNS
  // ═══════════════════════════════════════════════════════════════

  static const Map<String, String> maleIndicators = {
    'kar raha': 'male',
    'ho raha': 'male',
    'ja raha': 'male',
    'aa raha': 'male',
    'tha': 'male',
    'tha main': 'male',
    'hoon main': 'male (context)',
  };

  static const Map<String, String> femaleIndicators = {
    'kar rahi': 'female',
    'ho rahi': 'female',
    'ja rahi': 'female',
    'aa rahi': 'female',
    'thi': 'female',
    'thi main': 'female',
    'hoon main': 'female (context)',
  };

  // Gender-specific responses
  static const Map<String, Map<String, String>> genderResponses = {
    'understanding': {
      'male': 'Main samajh sakta hoon',
      'female': 'Main samajh sakti hoon',
      'neutral': 'Main samajh sakta hoon',
    },
    'knowing': {
      'male': 'Main jaanta hoon',
      'female': 'Main jaanti hoon',
      'neutral': 'Main jaanta hoon',
    },
    'being': {
      'male': 'Main yahan hoon',
      'female': 'Main yahan hoon',
      'neutral': 'Main yahan hoon',
    },
  };

  // ═══════════════════════════════════════════════════════════════
  // 🧠 THERAPEUTIC TECHNIQUES (CBT, DBT, etc.)
  // ═══════════════════════════════════════════════════════════════

  /// Cognitive Behavioral Therapy (CBT) Techniques
  static const Map<String, String> cbtTechniques = {
    'thought_challenging': '''
    Chalo ek kaam karte hain - ye thought ko challenge karte hain:
    1. Ye thought kya hai exactly?
    2. Kya evidence hai iske favor mein?
    3. Kya evidence hai iske against mein?
    4. Kya alternative explanation ho sakti hai?
    5. Agar koi dost ye bole, tum kya kahoge?
    ''',

    'cognitive_distortions': '''
    Ye thinking patterns dekho - koi familiar lagta hai?
    • All-or-Nothing: "Main complete failure hoon"
    • Overgeneralization: "Hamesha mere saath hi aisa hota hai"
    • Mental Filter: Sirf negative pe focus karna
    • Catastrophizing: "Sab khatam ho gaya"
    • Should Statements: "Mujhe perfect hona chahiye"
    ''',

    'behavioral_activation': '''
    Depression mein activity level gir jaata hai. Chalo small steps lete hain:
    1. Ek simple activity choose karo (walk, music, call a friend)
    2. Specific time set karo
    3. Karo, chahe mann na ho
    4. Notice karo - kaisa feel hua?
    ''',
  };

  /// Dialectical Behavior Therapy (DBT) Skills
  static const Map<String, String> dbtSkills = {
    'distress_tolerance': '''
    Jab emotions overwhelming ho, ye TIPP technique try karo:
    • T - Temperature: Thanda paani face pe
    • I - Intense exercise: 5 min jumping jacks
    • P - Paced breathing: Slow, deep breaths
    • P - Progressive relaxation: Muscles tense then relax
    ''',

    'emotion_regulation': '''
    Emotions ko regulate karne ke liye:
    1. Emotion ko identify karo aur naam do
    2. Validate karo - "Ye feel karna okay hai"
    3. Opposite action: Sad hai? Upbeat music suno
    4. Self-soothe: 5 senses use karo
    ''',

    'mindfulness': '''
    Present moment mein aane ke liye:
    • Observe: Sirf dekho, judge mat karo
    • Describe: Words mein describe karo
    • Participate: Fully involve ho jao
    • Non-judgmental: "Good" ya "bad" mat socho
    ''',
  };

  // ═══════════════════════════════════════════════════════════════
  // 🎯 SITUATION-SPECIFIC ADVANCED RESPONSES
  // ═══════════════════════════════════════════════════════════════

  /// Panic Attack Protocol
  static const String panicAttackProtocol = '''
  🚨 PANIC ATTACK HO RAHA HAI? Mere saath karo:
  
  1. GROUNDING (5-4-3-2-1):
     • 5 cheezein dekho
     • 4 cheezein touch karo
     • 3 sounds suno
     • 2 smells notice karo
     • 1 taste feel karo
  
  2. BREATHING:
     • 4 seconds inhale (nose se)
     • 7 seconds hold
     • 8 seconds exhale (mouth se)
     • 5 baar repeat karo
  
  3. REMIND YOURSELF:
     • "Ye panic attack hai, danger nahi"
     • "Ye pass ho jayega"
     • "Main safe hoon"
  
  Kya thoda better feel ho raha hai? 🫁💙
  ''';

  /// Suicidal Ideation Response (Advanced)
  static const String suicidalIdeationAdvanced = '''
  🚨 YAAR PLEASE DHYAN SE SUNO:
  
  Tumhari feelings valid hain, but tumhari life valuable hai.
  
  IMMEDIATE ACTIONS:
  1. 📞 AASRA call karo ABHI: 9152987821
  2. 🏥 Nearest hospital emergency jaao
  3. 👥 Kisi trusted person ko ABHI call karo
  4. 🔒 Harmful cheezein door rakho
  
  SAFETY PLAN:
  • Warning signs kya hain?
  • Coping strategies kya use kar sakte ho?
  • Kaun help kar sakta hai?
  • Professional help kahan se milegi?
  
  Main yahan hoon but PROFESSIONAL HELP ZAROORI HAI.
  Kya tum safe ho abhi? Kisi ke saath ho? 💙🫂
  ''';

  /// Relationship Conflict Resolution
  static const String relationshipConflict = '''
  Relationship issues handle karne ke liye:
  
  1. COOL DOWN PERIOD:
     • Pehle calm ho jao (30 min break)
     • Emotions settle hone do
  
  2. "I" STATEMENTS USE KARO:
     ❌ "Tum hamesha..."
     ✅ "Main feel karta/karti hoon ki..."
  
  3. ACTIVE LISTENING:
     • Dusre ki baat puri suno
     • Interrupt mat karo
     • Understand karne ki koshish karo
  
  4. FIND COMMON GROUND:
     • Dono kya chahte hain?
     • Compromise kahan ho sakta hai?
  
  Kya ye helpful lag raha hai? 🤝
  ''';

  // ═══════════════════════════════════════════════════════════════
  // 💡 PROACTIVE MENTAL HEALTH TIPS
  // ═══════════════════════════════════════════════════════════════

  static const List<String> dailyMentalHealthTips = [
    '🌅 Morning routine banao - consistent wake up time',
    '🫁 Daily 5 min breathing exercise karo',
    '📝 Gratitude journal - 3 cheezein likho daily',
    '🚶 Physical activity - 20 min walk minimum',
    '💧 Hydration - 8 glass paani piyo',
    '😴 Sleep hygiene - 7-8 hours, consistent time',
    '📱 Screen time limit - especially before sleep',
    '🤝 Social connection - ek person se baat karo',
    '🎯 Small goals set karo - achievable targets',
    '🧘 Mindfulness practice - 10 min meditation',
  ];

  // ═══════════════════════════════════════════════════════════════
  // 🎨 CONVERSATION FLOW PATTERNS
  // ═══════════════════════════════════════════════════════════════

  /// OARS Technique (Motivational Interviewing)
  static const Map<String, String> oarsTechnique = {
    'Open-ended questions': 'Kya hua? Kaise feel kar rahe ho? Aur batao?',
    'Affirmations': 'Bahut brave ho tum. Ye share karna easy nahi tha.',
    'Reflective listening': 'Toh tum keh rahe ho ki... Samajh aa raha hai.',
    'Summarizing': 'Toh overall, tumhe lag raha hai ki...',
  };

  /// Validation Levels (Linehan's DBT)
  static const List<String> validationLevels = [
    'Level 1: Present & Attentive - "Main sun raha/rahi hoon"',
    'Level 2: Accurate Reflection - "Tum feel kar rahe ho ki..."',
    'Level 3: Mind Reading - "Shayad tum soch rahe ho..."',
    'Level 4: Understanding - "Aise situation mein ye feel karna normal hai"',
    'Level 5: Acknowledge Valid - "Tumhari feelings bilkul valid hain"',
    'Level 6: Radical Genuineness - "Main bhi aise situation mein aise hi feel karta/karti"',
  ];

  // ═══════════════════════════════════════════════════════════════
  // 🔄 FOLLOW-UP QUESTIONS (Smart Probing)
  // ═══════════════════════════════════════════════════════════════

  static const Map<String, List<String>> followUpQuestions = {
    'depression': [
      'Ye feeling kab se hai?',
      'Kya koi specific trigger hai?',
      'Pehle bhi aisa hua hai?',
      'Kya professional help li hai?',
      'Daily routine kaisi hai?',
      'Sleep aur appetite kaisi hai?',
    ],
    'anxiety': [
      'Kab zyada anxiety hoti hai?',
      'Physical symptoms kya hain?',
      'Kya specific situation se trigger hoti hai?',
      'Coping mechanisms kya use karte ho?',
      'Kya panic attacks hote hain?',
    ],
    'relationship': [
      'Ye issue kab se hai?',
      'Communication kaisi hai?',
      'Kya pattern repeat ho raha hai?',
      'Dono ki expectations kya hain?',
      'Kya couples counseling consider kiya?',
    ],
    'work_stress': [
      'Work-life balance kaisa hai?',
      'Kya specific stressor hai?',
      'Boundaries set hain?',
      'Manager se baat ki hai?',
      'Burnout ke signs hain?',
    ],
  };

  // ═══════════════════════════════════════════════════════════════
  // 🎓 PSYCHOEDUCATION SNIPPETS
  // ═══════════════════════════════════════════════════════════════

  static const Map<String, String> psychoeducation = {
    'depression': '''
    Depression ek medical condition hai, weakness nahi:
    • Brain chemistry involved hai
    • Treatment available hai (therapy + medication)
    • Recovery possible hai
    • Professional help lena important hai
    ''',

    'anxiety': '''
    Anxiety ek natural response hai, but excessive ho sakti hai:
    • Fight-or-flight response hai
    • Physical symptoms normal hain
    • Manageable hai techniques se
    • Chronic anxiety mein professional help chahiye
    ''',

    'trauma': '''
    Trauma processing time leta hai:
    • Flashbacks aur nightmares normal hain
    • Avoidance common coping mechanism hai
    • PTSD treatable hai
    • Trauma-informed therapy helpful hai
    ''',
  };

  // ═══════════════════════════════════════════════════════════════
  // 🌟 POSITIVE PSYCHOLOGY INTERVENTIONS
  // ═══════════════════════════════════════════════════════════════

  static const List<String> positiveInterventions = [
    '✨ Gratitude Letter: Kisi ko thank you letter likho',
    '💪 Identify Strengths: Apni 5 strengths list karo',
    '🎯 Best Possible Self: Future mein best version imagine karo',
    '🤝 Acts of Kindness: Random acts of kindness karo',
    '🌈 Savoring: Positive moments ko fully experience karo',
    '📖 Life Story: Apni life story positive lens se dekho',
  ];
}
