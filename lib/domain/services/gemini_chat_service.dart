import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_repository.dart';

/// Gemini AI powered chat service for mental health support
class GeminiChatService {
  final ChatRepository _chatRepository;
  final _messageController = StreamController<MessageModel>.broadcast();
  final _uuid = const Uuid();
  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  GeminiChatService(this._chatRepository, String apiKey) {
    // Initialize Gemini model
    _model = GenerativeModel(
      model: 'gemini-2.0-flash-exp',
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
    _chatSession = _model.startChat(
      history: [
        Content.text(
          '''You are Sukoon, a compassionate AI mental health companion. Your role is to:
1. Listen empathetically and validate feelings
2. Provide emotional support and encouragement
3. Suggest coping strategies and self-care activities
4. Recognize crisis situations and recommend professional help
5. Be culturally sensitive (support both English and Hindi)
6. Never diagnose or prescribe medication
7. Keep responses concise (2-3 sentences)
8. Use warm, friendly language

If someone expresses suicidal thoughts or severe distress, immediately suggest:
- Calling emergency helpline: 9152987821 (AASRA)
- Talking to a mental health professional
- Reaching out to a trusted friend or family member

Remember: You're a supportive friend, not a therapist.''',
        ),
      ],
    );
  }

  Stream<MessageModel> get messageStream => _messageController.stream;

  /// Send message and get AI response
  Future<MessageModel> sendMessage(String text) async {
    try {
      // Create user message
      final userMessage = MessageModel(
        id: _uuid.v4(),
        text: text,
        messageType: MessageType.user.index,
        timestamp: DateTime.now(),
      );

      await _chatRepository.saveMessage(userMessage);
      _messageController.add(userMessage);

      // Get Gemini response
      final response = await _chatSession.sendMessage(Content.text(text));
      final aiText =
          response.text ?? 'I\'m here to listen. Please tell me more.';

      // Analyze emotion from user text
      final emotion = _analyzeEmotion(text);

      // Create AI message
      final aiMessage = MessageModel(
        id: _uuid.v4(),
        text: aiText,
        messageType: MessageType.ai.index,
        timestamp: DateTime.now(),
        emotionState: emotion.index,
        suggestions: _getSuggestions(emotion, text),
      );

      await _chatRepository.saveMessage(aiMessage);
      _messageController.add(aiMessage);

      return aiMessage;
    } catch (e) {
      // Fallback response if API fails
      final fallbackMessage = MessageModel(
        id: _uuid.v4(),
        text:
            'I\'m having trouble connecting right now. But I\'m here for you. Would you like to try a breathing exercise or explore self-care tools?',
        messageType: MessageType.ai.index,
        timestamp: DateTime.now(),
        emotionState: EmotionState.neutral.index,
        suggestions: ['Try breathing exercise', 'Explore self-care'],
      );

      await _chatRepository.saveMessage(fallbackMessage);
      _messageController.add(fallbackMessage);

      return fallbackMessage;
    }
  }

  /// Analyze emotion from text
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
        lowerText.contains('die')) {
      return [
        '🆘 Call AASRA: 9152987821',
        'Talk to a doctor now',
        'Emergency helpline',
      ];
    }

    // Context-based suggestions
    switch (emotion) {
      case EmotionState.stressed:
        if (lowerText.contains('sleep') || lowerText.contains('tired')) {
          return [
            '🌙 Try sleep meditation',
            '🫁 Breathing exercise',
            '📞 Talk to a counselor',
          ];
        } else if (lowerText.contains('anxious') ||
            lowerText.contains('worry')) {
          return [
            '🫁 5-minute breathing',
            '🎵 Calming sounds',
            '📝 Write in journal',
          ];
        }
        return [
          '🫁 Try breathing exercise',
          '🎵 Listen to calming sounds',
          '📞 Talk to a professional',
        ];

      case EmotionState.calm:
        return [
          '📊 Track your mood',
          '📝 Write in journal',
          '🎯 Set a wellness goal',
        ];

      case EmotionState.neutral:
        return [
          '🧘 Explore self-care tools',
          '📊 Track your mood',
          '📖 Read wellness tips',
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
