import 'package:hive/hive.dart';
import 'models/chat_session_model.dart';
import 'models/message_model.dart';
import '../../core/constants/app_constants.dart';

class ChatHistoryRepository {
  Box<ChatSessionModel>? _sessionBox;
  Box<MessageModel>? _messageBox;

  Future<void> init() async {
    try {
      print('📦 [HISTORY] Opening Hive boxes...');
      _sessionBox = await Hive.openBox<ChatSessionModel>('chat_sessions');
      _messageBox = await Hive.openBox<MessageModel>(AppConstants.boxChat);
      print('✅ [HISTORY] Boxes opened successfully');
    } catch (e) {
      print('❌ [HISTORY] Error opening boxes: $e');
      rethrow;
    }
  }

  // Create new chat session
  Future<ChatSessionModel> createSession() async {
    if (_sessionBox == null) await init();

    final session = ChatSessionModel(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      title: 'New Chat',
      createdAt: DateTime.now(),
      lastMessageAt: DateTime.now(),
      messageIds: [],
    );

    await _sessionBox!.put(session.id, session);
    print('✅ [HISTORY] Created new session: ${session.id}');
    return session;
  }

  // Get all sessions sorted by last message time
  Future<List<ChatSessionModel>> getAllSessions() async {
    if (_sessionBox == null) await init();

    final sessions = _sessionBox!.values.toList();
    sessions.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    return sessions;
  }

  // Get messages for a specific session
  Future<List<MessageModel>> getSessionMessages(String sessionId) async {
    if (_sessionBox == null || _messageBox == null) await init();

    final session = _sessionBox!.get(sessionId);
    if (session == null) return [];

    final messages = <MessageModel>[];
    for (final msgId in session.messageIds) {
      final msg = _messageBox!.values.firstWhere(
        (m) => m.id == msgId,
        orElse: () => MessageModel(
          id: '',
          text: '',
          messageType: 0,
          timestamp: DateTime.now(),
        ),
      );
      if (msg.id.isNotEmpty) messages.add(msg);
    }

    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return messages;
  }

  // Add message to session
  Future<void> addMessageToSession(
    String sessionId,
    MessageModel message,
  ) async {
    if (_sessionBox == null || _messageBox == null) await init();

    // Save message
    await _messageBox!.put(message.id, message);

    // Update session
    final session = _sessionBox!.get(sessionId);
    if (session != null) {
      final updatedSession = session.copyWith(
        lastMessageAt: DateTime.now(),
        messageIds: [...session.messageIds, message.id],
        title: session.messageIds.isEmpty
            ? _generateTitle(message.text)
            : session.title,
      );
      await _sessionBox!.put(sessionId, updatedSession);
    }
  }

  // Delete session
  Future<void> deleteSession(String sessionId) async {
    if (_sessionBox == null || _messageBox == null) await init();

    final session = _sessionBox!.get(sessionId);
    if (session != null) {
      // Delete all messages in session
      for (final msgId in session.messageIds) {
        final msg = _messageBox!.values.firstWhere(
          (m) => m.id == msgId,
          orElse: () => MessageModel(
            id: '',
            text: '',
            messageType: 0,
            timestamp: DateTime.now(),
          ),
        );
        if (msg.id.isNotEmpty) {
          await _messageBox!.delete(msg.key);
        }
      }
      // Delete session
      await _sessionBox!.delete(sessionId);
    }
  }

  // Clear all history
  Future<void> clearAllHistory() async {
    if (_sessionBox == null || _messageBox == null) await init();
    await _sessionBox!.clear();
    await _messageBox!.clear();
  }

  String _generateTitle(String firstMessage) {
    if (firstMessage.length > 30) {
      return '${firstMessage.substring(0, 30)}...';
    }
    return firstMessage;
  }
}
