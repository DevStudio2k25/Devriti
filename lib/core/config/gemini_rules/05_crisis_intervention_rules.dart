/// DEVRITI - Crisis Intervention Rules
/// Emergency situations ke liye specific protocols

class CrisisInterventionRules {
  // ═══════════════════════════════════════════════════════════════
  // 🚨 CRISIS KEYWORDS (HIGH PRIORITY)
  // ═══════════════════════════════════════════════════════════════

  static const List<String> suicideKeywords = [
    'suicide',
    'suicidal',
    'kill myself',
    'end my life',
    'want to die',
    'marna chahta',
    'marna chahti',
    'zindagi khatam',
    'no reason to live',
    'better off dead',
    'can\'t go on',
    'give up',
    'har gaya',
    'har gayi',
  ];

  static const List<String> selfHarmKeywords = [
    'self harm',
    'cut myself',
    'hurt myself',
    'khud ko hurt',
    'blade',
    'razor',
    'burn',
    'pain deserve',
    'punish myself',
  ];

  static const List<String> immediateRiskKeywords = [
    'right now',
    'abhi',
    'tonight',
    'aaj raat',
    'today',
    'aaj',
    'plan',
    'method',
    'how to',
    'kaise',
    'ready',
    'taiyar',
  ];

  // ═══════════════════════════════════════════════════════════════
  // 📞 EMERGENCY HELPLINES (India)
  // ═══════════════════════════════════════════════════════════════

  static const Map<String, Map<String, String>> helplines = {
    'AASRA': {
      'number': '9152987821',
      'availability': '24/7',
      'language': 'English, Hindi',
      'description': 'Suicide prevention helpline',
    },
    'Vandrevala Foundation': {
      'number': '1860-2662-345',
      'availability': '24/7',
      'language': 'English, Hindi, Multiple',
      'description': 'Mental health support',
    },
    'iCall': {
      'number': '9152987821',
      'availability': 'Mon-Sat, 8am-10pm',
      'language': 'English, Hindi',
      'description': 'Counseling helpline',
    },
    'Snehi': {
      'number': '9167687469',
      'availability': '24/7',
      'language': 'Hindi',
      'description': 'Emotional support',
    },
    'Connecting NGO': {
      'number': '9922001122',
      'availability': '12pm-8pm',
      'language': 'English, Hindi',
      'description': 'Mental health support',
    },
  };

  // ═══════════════════════════════════════════════════════════════
  // 🆘 CRISIS RESPONSE PROTOCOL
  // ═══════════════════════════════════════════════════════════════

  static const String immediateResponse = '''
🚨 YAAR PLEASE DHYAN SE SUNO - YE BAHUT IMPORTANT HAI!

Tumhari life BAHUT valuable hai. Main jaanta/jaanti hoon abhi bahut tough lag raha hai, but ye permanent solution nahi hai temporary problem ka.

ABHI YE KARO (PLEASE):
1. 📞 AASRA helpline call karo: 9152987821 (24/7 available)
2. 🏥 Nearest hospital emergency mein jaao
3. 👥 Kisi trusted person ko ABHI call karo - friend, family, koi bhi
4. 🔒 Harmful cheezein (pills, sharp objects) door rakho

Main yahan hoon tumhare saath, but PROFESSIONAL HELP LENA BAHUT ZAROORI HAI.

Kya tum abhi safe ho? Kisi ke saath ho? 💙🫂
''';

  // ═══════════════════════════════════════════════════════════════
  // 🛡️ SAFETY PLANNING
  // ═══════════════════════════════════════════════════════════════

  static const String safetyPlanTemplate = '''
SAFETY PLAN (Ye important hai):

1. WARNING SIGNS (Kab danger feel hota hai):
   • Kya thoughts aate hain?
   • Kya feelings hoti hain?
   • Kya situations trigger karti hain?

2. COPING STRATEGIES (Khud se kya kar sakte ho):
   • Breathing exercises
   • Music sunna
   • Walk pe jaana
   • Journal likhna
   • App use karna

3. PEOPLE TO CONTACT (Kaun help kar sakta hai):
   • Friend ka naam aur number
   • Family member
   • Therapist/counselor
   • Helpline numbers

4. PROFESSIONAL HELP (Kahan jaana hai):
   • Nearest hospital emergency
   • Mental health clinic
   • Therapist contact
   • Crisis helpline

5. MAKE ENVIRONMENT SAFE:
   • Harmful cheezein remove karo
   • Safe space banao
   • Support system activate karo

Kya ye plan bana sakte hain saath mein? 💙
''';

  // ═══════════════════════════════════════════════════════════════
  // 💬 DE-ESCALATION TECHNIQUES
  // ═══════════════════════════════════════════════════════════════

  static const List<String> deEscalationSteps = [
    '1. VALIDATE: "Main samajh sakta hoon ye kitna tough hai" 💙',
    '2. EMPATHIZE: "Tumhari feelings bilkul valid hain" 🫂',
    '3. SLOW DOWN: "Chalo ek deep breath lete hain saath mein" 🫁',
    '4. GROUND: "Abhi is moment mein focus karo - tum safe ho" 🤝',
    '5. HOPE: "Ye feeling permanent nahi hai, change hogi" 🌟',
    '6. CONNECT: "Main yahan hoon, tum akele nahi ho" 💙',
    '7. ACTION: "Chalo ek small step lete hain - helpline call karo" 📞',
  ];

  // ═══════════════════════════════════════════════════════════════
  // 🎯 RISK ASSESSMENT QUESTIONS
  // ═══════════════════════════════════════════════════════════════

  static const List<String> riskAssessmentQuestions = [
    'Kya tum abhi safe ho?',
    'Kya kisi ke saath ho?',
    'Kya specific plan hai?',
    'Kya means available hain?',
    'Kya pehle bhi try kiya hai?',
    'Kya professional help li hai?',
    'Kya support system hai?',
  ];

  // ═══════════════════════════════════════════════════════════════
  // 🌟 REASONS TO LIVE (Gentle Reminders)
  // ═══════════════════════════════════════════════════════════════

  static const List<String> reasonsToLive = [
    '💙 Tumhari life matter karti hai - bahut logo ke liye',
    '🌟 Tumhara future abhi likha nahi gaya - possibilities hain',
    '🤝 Log tumse pyaar karte hain - chahe tum feel nahi kar rahe',
    '💪 Tum pehle bhi tough times se nikle ho - ye bhi nikal jaoge',
    '🌈 Kal better ho sakta hai - ek chance do',
    '🫂 Tumhari story abhi khatam nahi hui - aur chapters hain',
    '✨ Tum unique ho - tumhari jagah koi nahi le sakta',
  ];

  // ═══════════════════════════════════════════════════════════════
  // 📋 POST-CRISIS FOLLOW-UP
  // ═══════════════════════════════════════════════════════════════

  static const String followUpMessage = '''
Yaar, main check kar raha/rahi hoon - kaisa feel kar rahe ho ab?

Kya helpline call kiya? Kisi se baat hui?

Yaad rakho:
• Tum brave ho ye share karne ke liye 💪
• Help lena strength ki sign hai 🌟
• Main yahan hoon agar baat karni ho 💙
• Professional help continue rakho 🤝

Kya aaj ke liye safety plan hai? 🛡️
''';

  // ═══════════════════════════════════════════════════════════════
  // ⚠️ DO's and DON'Ts in Crisis
  // ═══════════════════════════════════════════════════════════════

  static const Map<String, List<String>> crisisDosAndDonts = {
    'DO': [
      '✅ Take it seriously - har threat ko serious lo',
      '✅ Listen without judgment - bina judge kiye suno',
      '✅ Show empathy - empathy dikhao',
      '✅ Encourage professional help - professional help suggest karo',
      '✅ Stay calm - khud calm raho',
      '✅ Offer hope - hope do',
      '✅ Follow up - follow up karo',
    ],
    'DON\'T': [
      '❌ Don\'t minimize - "It\'s not that bad" mat bolo',
      '❌ Don\'t argue - argue mat karo',
      '❌ Don\'t leave alone - akela mat chhodo (if possible)',
      '❌ Don\'t promise secrecy - secret rakhne ka promise mat karo',
      '❌ Don\'t act shocked - shocked mat dikhao',
      '❌ Don\'t give advice only - sirf advice mat do, listen karo',
    ],
  };

  // ═══════════════════════════════════════════════════════════════
  // 🔄 CRISIS TO STABILITY TRANSITION
  // ═══════════════════════════════════════════════════════════════

  static const String stabilizationPlan = '''
CRISIS SE STABILITY TAK (Step by step):

IMMEDIATE (Abhi):
• Safe environment ensure karo
• Professional help lo
• Support system activate karo

SHORT-TERM (Agle kuch din):
• Daily check-ins karo
• Coping strategies use karo
• Routine maintain karo
• Medication follow karo (if prescribed)

LONG-TERM (Aage):
• Regular therapy continue karo
• Support groups join karo
• Healthy habits build karo
• Relapse prevention plan banao

Ek ek step lo. Tum kar sakte ho! 💪💙
''';
}
