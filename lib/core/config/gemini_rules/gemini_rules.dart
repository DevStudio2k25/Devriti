/// DEVRITI - Gemini Rules Index
/// Ye file saari rule files ko export karti hai
///
/// Usage:
/// import 'package:ksnh/core/config/gemini_rules/gemini_rules.dart';

// Import all rule files first
import '01_system_prompt.dart';
import '02_conversation_rules.dart';
import '03_advanced_rules.dart';
import '04_emotion_detection_rules.dart';
import '05_crisis_intervention_rules.dart';

// Then export them for external use
export '01_system_prompt.dart';
export '02_conversation_rules.dart';
export '03_advanced_rules.dart';
export '04_emotion_detection_rules.dart';
export '05_crisis_intervention_rules.dart';

/// Gemini Rules Manager
/// Sab rules ko ek jagah manage karne ke liye
class GeminiRulesManager {
  /// Get complete system prompt with all rules
  static String getCompletePrompt() {
    // Import from 01_system_prompt.dart
    return GeminiSystemPrompt.prompt;
  }

  /// Get conversation rules
  static Map<String, dynamic> getConversationRules() {
    return {
      'greetings': ConversationRules.greetingResponses,
      'sadness': ConversationRules.sadnessResponses,
      'anxiety': ConversationRules.anxietyResponses,
      'crisis': ConversationRules.crisisResponses,
      'happy': ConversationRules.happyResponses,
      'family': ConversationRules.familyResponses,
      'study': ConversationRules.studyResponses,
      'sleep': ConversationRules.sleepResponses,
      'helplines': ConversationRules.helplines,
    };
  }

  /// Get advanced therapeutic techniques
  static Map<String, dynamic> getAdvancedTechniques() {
    return {
      'cbt': AdvancedConversationRules.cbtTechniques,
      'dbt': AdvancedConversationRules.dbtSkills,
      'panic_protocol': AdvancedConversationRules.panicAttackProtocol,
      'suicide_protocol': AdvancedConversationRules.suicidalIdeationAdvanced,
      'relationship': AdvancedConversationRules.relationshipConflict,
      'follow_ups': AdvancedConversationRules.followUpQuestions,
    };
  }

  /// Get emotion detection rules
  static Map<String, dynamic> getEmotionRules() {
    return {
      'keywords': EmotionDetectionRules.emotionKeywords,
      'responses': EmotionDetectionRules.emotionResponses,
      'intensity': EmotionDetectionRules.intensityIndicators,
      'transitions': EmotionDetectionRules.emotionTransitions,
    };
  }

  /// Get crisis intervention protocols
  static Map<String, dynamic> getCrisisProtocols() {
    return {
      'suicide_keywords': CrisisInterventionRules.suicideKeywords,
      'self_harm_keywords': CrisisInterventionRules.selfHarmKeywords,
      'helplines': CrisisInterventionRules.helplines,
      'immediate_response': CrisisInterventionRules.immediateResponse,
      'safety_plan': CrisisInterventionRules.safetyPlanTemplate,
      'de_escalation': CrisisInterventionRules.deEscalationSteps,
    };
  }

  /// Check if message contains crisis keywords
  static bool isCrisisMessage(String text) {
    final lowerText = text.toLowerCase();

    // Check suicide keywords
    for (var keyword in CrisisInterventionRules.suicideKeywords) {
      if (lowerText.contains(keyword.toLowerCase())) {
        return true;
      }
    }

    // Check self-harm keywords
    for (var keyword in CrisisInterventionRules.selfHarmKeywords) {
      if (lowerText.contains(keyword.toLowerCase())) {
        return true;
      }
    }

    return false;
  }

  /// Detect emotion from text
  static String detectEmotion(String text) {
    return EmotionDetectionRules.detectEmotion(text);
  }

  /// Get appropriate response based on emotion
  static Map<String, dynamic>? getEmotionResponse(String emotion) {
    return EmotionDetectionRules.emotionResponses[emotion];
  }
}
