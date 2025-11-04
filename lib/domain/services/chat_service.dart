import 'dart:async';
import 'package:uuid/uuid.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/chat_repository.dart';

class ChatService {
  final ChatRepository _chatRepository;
  final _messageController = StreamController<MessageModel>.broadcast();
  final _uuid = const Uuid();

  ChatService(this._chatRepository);

  Stream<MessageModel> get messageStream => _messageController.stream;

  Future<MessageModel> sendMessage(String text) async {
    // Create user message
    final userMessage = MessageModel(
      id: _uuid.v4(),
      text: text,
      messageType: MessageType.user.index,
      timestamp: DateTime.now(),
    );

    await _chatRepository.saveMessage(userMessage);
    _messageController.add(userMessage);

    // Analyze emotion
    final emotion = _analyzeEmotion(text);

    // Generate AI response
    await Future.delayed(const Duration(seconds: 1)); // Simulate typing
    final aiResponse = _generateResponse(text, emotion);

    final aiMessage = MessageModel(
      id: _uuid.v4(),
      text: aiResponse,
      messageType: MessageType.ai.index,
      timestamp: DateTime.now(),
      emotionState: emotion.index,
      suggestions: _getSuggestions(emotion, text),
    );

    await _chatRepository.saveMessage(aiMessage);
    _messageController.add(aiMessage);

    return aiMessage;
  }

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
      'lonely',
      'lost',
      'hurt',
      'pain',
      'cry',
      'stress',
      'panic',
      'overwhelmed',
      // Hindi
      'dukhi',
      'pareshan',
      'dar',
      'akela',
      'tension',
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
      // Hindi
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

  String _generateResponse(String userText, EmotionState emotion) {
    final lowerText = userText.toLowerCase();

    // Crisis detection
    if (lowerText.contains('suicide') ||
        lowerText.contains('kill') ||
        lowerText.contains('die') ||
        lowerText.contains('end my life')) {
      return "I'm really concerned about what you're sharing. Please reach out for immediate help:\n\n🆘 AASRA: 9152987821 (24/7)\n🆘 Vandrevala: 1860-2662-345\n\nYour life matters. Please talk to someone right now.";
    }

    // Context-specific responses
    if (lowerText.contains('exam') ||
        lowerText.contains('test') ||
        lowerText.contains('study')) {
      return "Exam stress is completely normal! Remember:\n• Take short breaks while studying\n• Practice deep breathing\n• One exam doesn't define you\n\nWould you like to try a 5-minute relaxation exercise?";
    }

    if (lowerText.contains('work') ||
        lowerText.contains('job') ||
        lowerText.contains('boss')) {
      return "Work stress can be overwhelming. It's important to:\n• Set clear boundaries\n• Take regular breaks\n• Talk to someone if it's affecting your health\n\nYour wellbeing comes first!";
    }

    if (lowerText.contains('sleep') ||
        lowerText.contains('insomnia') ||
        lowerText.contains('can\'t sleep')) {
      return "Sleep troubles can be really frustrating. Let's try:\n• Sleep meditation tonight\n• Avoid screens 1 hour before bed\n• Keep a consistent sleep schedule\n\nWould you like to try our sleep meditation?";
    }

    if (lowerText.contains('friend') ||
        lowerText.contains('relationship') ||
        lowerText.contains('fight')) {
      return "Relationship conflicts can be painful. It's okay to feel upset. Sometimes taking space helps both people calm down. When ready, honest communication can help resolve things. Want to talk about it?";
    }

    if (lowerText.contains('family') ||
        lowerText.contains('parents') ||
        lowerText.contains('home')) {
      return "Family issues can be really challenging. Remember, it's okay to have boundaries and take care of yourself. Would you like to talk more about what's happening?";
    }

    if (lowerText.contains('lonely') ||
        lowerText.contains('alone') ||
        lowerText.contains('akela')) {
      return "Feeling lonely is really hard. You're not alone - I'm here with you. Have you thought about:\n• Reaching out to an old friend?\n• Joining a community group?\n• Talking to a counselor?\n\nWhat would feel most comfortable for you?";
    }

    // Hindi responses
    if (lowerText.contains('dukhi') || lowerText.contains('pareshan')) {
      return "मुझे सुनकर दुख हुआ। क्या आप मुझे बताना चाहेंगे कि क्या हुआ? आप अकेले नहीं हैं, मैं यहाँ आपकी मदद के लिए हूँ।";
    }

    if (lowerText.contains('tension') || lowerText.contains('stress')) {
      return "तनाव होना बिल्कुल सामान्य है। चलिए कुछ आसान तरीके try करते हैं:\n• गहरी सांस लें\n• थोड़ा टहलें\n• किसी से बात करें\n\nक्या आप breathing exercise try करना चाहेंगे?";
    }

    // Emotion-based responses
    switch (emotion) {
      case EmotionState.stressed:
        return "I hear you - what you're feeling is valid. It's okay to not be okay sometimes. Would you like to:\n• Try a breathing exercise?\n• Listen to calming sounds?\n• Talk to a professional?\n\nI'm here for you.";
      case EmotionState.calm:
        return "I'm glad you're feeling good! 😊 Keep taking care of yourself. Is there anything you'd like to talk about or any wellness goals you want to set?";
      case EmotionState.neutral:
        return "I'm here to listen without judgment. Take your time and share whatever feels right. What's been on your mind lately?";
    }
  }

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
    if (lowerText.contains('sleep')) {
      return [
        '🌙 Try sleep meditation',
        '🫁 Breathing exercise',
        '📖 Sleep tips',
      ];
    }

    if (lowerText.contains('anxious') || lowerText.contains('anxiety')) {
      return [
        '🫁 5-minute breathing',
        '🎵 Calming sounds',
        '📝 Write in journal',
      ];
    }

    if (lowerText.contains('work') || lowerText.contains('exam')) {
      return ['🫁 Quick relaxation', '☕ Take a break', '📞 Talk to someone'];
    }

    // Emotion-based suggestions
    switch (emotion) {
      case EmotionState.stressed:
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

  Future<List<MessageModel>> getMessageHistory() async {
    return await _chatRepository.getAllMessages();
  }

  void dispose() {
    _messageController.close();
  }
}
