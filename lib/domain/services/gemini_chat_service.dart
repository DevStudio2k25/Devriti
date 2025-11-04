import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_repository.dart';
import '../../core/config/gemini_rules/gemini_rules.dart';

/// Gemini AI powered chat service for mental health support
class GeminiChatService {
  final ChatRepository _chatRepository;
  final _messageController = StreamController<MessageModel>.broadcast();
  final _uuid = const Uuid();
  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  GeminiChatService(this._chatRepository, String apiKey) {
    // ignore: avoid_print
    print(
      '🚀 [GEMINI] Initializing Gemini 2.0 Flash with API key: ${apiKey.substring(0, 20)}...',
    );

    // Initialize Gemini model
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 1024,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      ],
    );

    // Start chat session with mental health context
    // System prompt is loaded from separate file for easy editing
    _chatSession = _model.startChat(
      history: [Content.text(GeminiSystemPrompt.prompt)],
    );
  }

  Stream<MessageModel> get messageStream => _messageController.stream;

  /// Send message and get AI response (Using ALL rules!)
  Future<MessageModel> sendMessage(String text) async {
    try {
      // ignore: avoid_print
      print('🔵 [GEMINI] Sending message: $text');

      // ═══════════════════════════════════════════════════════════
      // STEP 1: Check for CRISIS first (highest priority)
      // ═══════════════════════════════════════════════════════════
      if (GeminiRulesManager.isCrisisMessage(text)) {
        // ignore: avoid_print
        print('🚨 [GEMINI] CRISIS DETECTED! Using crisis protocol');

        final userMessage = MessageModel(
          id: _uuid.v4(),
          text: text,
          messageType: MessageType.user.index,
          timestamp: DateTime.now(),
        );
        await _chatRepository.saveMessage(userMessage);
        _messageController.add(userMessage);

        // Use crisis intervention protocol
        final crisisMessage = MessageModel(
          id: _uuid.v4(),
          text: CrisisInterventionRules.immediateResponse,
          messageType: MessageType.ai.index,
          timestamp: DateTime.now(),
          emotionState: EmotionState.stressed.index,
          suggestions: [
            '🆘 AASRA call karo: 9152987821',
            '🏥 Hospital emergency jaao',
            '👥 Kisi ko abhi call karo',
          ],
        );

        await _chatRepository.saveMessage(crisisMessage);
        _messageController.add(crisisMessage);
        return crisisMessage;
      }

      // ═══════════════════════════════════════════════════════════
      // STEP 2: Detect emotion using advanced rules
      // ═══════════════════════════════════════════════════════════
      final detectedEmotion = EmotionDetectionRules.detectEmotion(text);
      // ignore: avoid_print
      print('😊 [GEMINI] Detected emotion: $detectedEmotion');

      // Create user message
      final userMessage = MessageModel(
        id: _uuid.v4(),
        text: text,
        messageType: MessageType.user.index,
        timestamp: DateTime.now(),
      );

      await _chatRepository.saveMessage(userMessage);
      _messageController.add(userMessage);

      // ignore: avoid_print
      print('🔵 [GEMINI] Waiting for Gemini response...');

      // ═══════════════════════════════════════════════════════════
      // STEP 3: Get Gemini response
      // ═══════════════════════════════════════════════════════════
      final response = await _chatSession.sendMessage(Content.text(text));
      final aiText =
          response.text ?? 'Yaar, main yahan hoon. Baat karo mujhse. 💙';

      // ignore: avoid_print
      print('✅ [GEMINI] Response received: $aiText');

      // ═══════════════════════════════════════════════════════════
      // STEP 4: Get enhanced suggestions using all rules
      // ═══════════════════════════════════════════════════════════
      final suggestions = _getEnhancedSuggestions(detectedEmotion, text);

      // ═══════════════════════════════════════════════════════════
      // STEP 5: Map emotion to EmotionState enum
      // ═══════════════════════════════════════════════════════════
      final emotionState = _mapEmotionToState(detectedEmotion);

      // Create AI message
      final aiMessage = MessageModel(
        id: _uuid.v4(),
        text: aiText,
        messageType: MessageType.ai.index,
        timestamp: DateTime.now(),
        emotionState: emotionState.index,
        suggestions: suggestions,
      );

      await _chatRepository.saveMessage(aiMessage);
      _messageController.add(aiMessage);

      // ignore: avoid_print
      print('✅ [GEMINI] Message saved with emotion: $detectedEmotion');

      return aiMessage;
    } catch (e) {
      // ignore: avoid_print
      print('❌ [GEMINI] Error: $e');

      // Fallback response if API fails
      final fallbackMessage = MessageModel(
        id: _uuid.v4(),
        text:
            'Yaar, mujhe abhi connect karne mein thodi problem aa rahi hai. But main yahan hoon tumhare liye. Kya tum breathing exercise try karna chahoge ya self-care tools explore karoge? 💙',
        messageType: MessageType.ai.index,
        timestamp: DateTime.now(),
        emotionState: EmotionState.neutral.index,
        suggestions: [
          '🫁 Breathing exercise karo',
          '🧘 Self-care explore karo',
        ],
      );

      await _chatRepository.saveMessage(fallbackMessage);
      _messageController.add(fallbackMessage);

      return fallbackMessage;
    }
  }

  /// Map detected emotion to EmotionState enum
  EmotionState _mapEmotionToState(String emotion) {
    switch (emotion) {
      case 'happy':
      case 'hopeful':
      case 'grateful':
        return EmotionState.calm;
      case 'sad':
      case 'depressed':
      case 'lonely':
      case 'tired':
      case 'guilty':
        return EmotionState.stressed;
      case 'angry':
      case 'frustrated':
        return EmotionState.stressed;
      case 'anxious':
      case 'worried':
      case 'panic':
        return EmotionState.stressed;
      case 'confused':
      default:
        return EmotionState.neutral;
    }
  }

  /// Get enhanced suggestions using ALL rule files
  List<String> _getEnhancedSuggestions(String emotion, String userText) {
    final lowerText = userText.toLowerCase();

    // Check for specific keywords from conversation rules

    // Sleep related
    if (lowerText.contains('sleep') ||
        lowerText.contains('neend') ||
        lowerText.contains('tired') ||
        lowerText.contains('thak')) {
      return [
        '🌙 Sleep meditation try karo',
        '🫁 Breathing exercise karo',
        '📝 Sleep journal likho',
      ];
    }

    // Anxiety related
    if (lowerText.contains('anxious') ||
        lowerText.contains('anxiety') ||
        lowerText.contains('tension') ||
        lowerText.contains('pareshan')) {
      return [
        '🫁 5-minute breathing karo',
        '🎵 Calming sounds suno',
        '📝 Journal mein likho',
      ];
    }

    // Family/relationship issues
    if (lowerText.contains('family') ||
        lowerText.contains('parents') ||
        lowerText.contains('fight') ||
        lowerText.contains('ladai')) {
      return [
        '🤝 Calmly baat karo',
        '📝 Feelings likho',
        '📞 Counselor se baat karo',
      ];
    }

    // Study/exam stress
    if (lowerText.contains('exam') ||
        lowerText.contains('study') ||
        lowerText.contains('fail') ||
        lowerText.contains('padhai')) {
      return [
        '📚 Break lo, phir padho',
        '🫁 Stress relief exercise',
        '🎯 Study plan banao',
      ];
    }

    // Emotion-based suggestions from rules
    switch (emotion) {
      case 'sad':
      case 'depressed':
        return [
          '📝 Journal mein feelings likho',
          '🎵 Favorite music suno',
          '📞 Kisi se baat karo',
        ];

      case 'happy':
        return [
          '📊 Mood track karo',
          '📝 Gratitude journal likho',
          '🎯 Wellness goal set karo',
        ];

      case 'angry':
        return [
          '🫁 Deep breathing karo',
          '🚶 Walk pe jaao',
          '📝 Anger journal likho',
        ];

      case 'anxious':
        return [
          '🫁 4-7-8 breathing try karo',
          '🎵 Calming sounds suno',
          '📞 Professional help lo',
        ];

      case 'confused':
        return [
          '📝 Pros-cons list banao',
          '🤝 Kisi se discuss karo',
          '🧘 Clarity meditation karo',
        ];

      default:
        return [
          '🧘 Self-care tools explore karo',
          '📊 Mood track karo',
          '📖 Wellness tips padho',
        ];
    }
  }

  /// OLD METHOD - Now using EmotionDetectionRules.detectEmotion()
  /// Keeping for backward compatibility
  EmotionState _analyzeEmotion(String text) {
    final lowerText = text.toLowerCase();

    // Crisis keywords - highest priority
    final crisisKeywords = [
      'suicide',
      'kill myself',
      'end my life',
      'want to die',
      'no reason to live',
    ];

    // Distress keywords
    final distressKeywords = [
      'sad',
      'depressed',
      'anxious',
      'worried',
      'scared',
      'afraid',
      'hopeless',
      'alone',
      'lost',
      'hurt',
      'pain',
      'cry',
      'upset',
      'stressed',
      'overwhelmed',
      // Hindi keywords
      'dukhi',
      'pareshan',
      'dar',
      'akela',
      'rona',
    ];

    // Calm keywords
    final calmKeywords = [
      'happy',
      'good',
      'great',
      'fine',
      'okay',
      'better',
      'peaceful',
      'calm',
      'relaxed',
      'thankful',
      'grateful',
      // Hindi keywords
      'khush',
      'achha',
      'theek',
      'shanti',
    ];

    if (crisisKeywords.any((keyword) => lowerText.contains(keyword))) {
      return EmotionState.stressed; // Crisis level
    } else if (distressKeywords.any((keyword) => lowerText.contains(keyword))) {
      return EmotionState.stressed;
    } else if (calmKeywords.any((keyword) => lowerText.contains(keyword))) {
      return EmotionState.calm;
    }

    return EmotionState.neutral;
  }

  /// Get contextual suggestions
  List<String> _getSuggestions(EmotionState emotion, String userText) {
    final lowerText = userText.toLowerCase();

    // Crisis suggestions
    if (lowerText.contains('suicide') ||
        lowerText.contains('kill') ||
        lowerText.contains('die') ||
        lowerText.contains('marna') ||
        lowerText.contains('khatam')) {
      return [
        '🆘 AASRA call karo: 9152987821',
        'Doctor se abhi baat karo',
        'Emergency helpline',
      ];
    }

    // Context-based suggestions
    switch (emotion) {
      case EmotionState.stressed:
        if (lowerText.contains('sleep') ||
            lowerText.contains('tired') ||
            lowerText.contains('neend')) {
          return [
            '🌙 Sleep meditation try karo',
            '🫁 Breathing exercise karo',
            '📞 Counselor se baat karo',
          ];
        } else if (lowerText.contains('anxious') ||
            lowerText.contains('worry') ||
            lowerText.contains('tension') ||
            lowerText.contains('pareshan')) {
          return [
            '🫁 5-minute breathing karo',
            '🎵 Calming sounds suno',
            '📝 Journal mein likho',
          ];
        }
        return [
          '🫁 Breathing exercise try karo',
          '🎵 Calming sounds suno',
          '📞 Professional se baat karo',
        ];

      case EmotionState.calm:
        return [
          '📊 Mood track karo',
          '📝 Journal mein likho',
          '🎯 Wellness goal set karo',
        ];

      case EmotionState.neutral:
        return [
          '🧘 Self-care tools explore karo',
          '📊 Mood track karo',
          '📖 Wellness tips padho',
        ];
    }
  }

  /// Get message history
  Future<List<MessageModel>> getMessageHistory() async {
    return await _chatRepository.getAllMessages();
  }

  /// Clear chat history
  Future<void> clearHistory() async {
    await _chatRepository.clearMessages();
  }

  /// Dispose resources
  void dispose() {
    _messageController.close();
  }
}
