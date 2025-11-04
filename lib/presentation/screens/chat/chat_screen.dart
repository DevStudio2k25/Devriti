import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/config/env_config.dart';
import '../../../data/models/message_model.dart';
import '../../../data/repositories/chat_repository.dart';
import '../../../domain/services/gemini_chat_service.dart';
import '../../widgets/chat/chat_bubble.dart';
import '../../widgets/chat/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final List<MessageModel> _messages = [];
  bool _isTyping = false;
  late GeminiChatService _chatService; // Using Gemini AI!

  @override
  void initState() {
    super.initState();
    // Using Gemini AI for intelligent responses
    _chatService = GeminiChatService(ChatRepository(), EnvConfig.geminiApiKey);
    _loadMessageHistory();
    _addWelcomeMessage();
  }

  Future<void> _loadMessageHistory() async {
    try {
      final history = await _chatService.getMessageHistory();
      if (history.isNotEmpty && mounted) {
        setState(() {
          _messages.addAll(history);
        });
      }
    } catch (e) {
      // Ignore errors on first load
    }
  }

  void _addWelcomeMessage() {
    final welcomeMessage = MessageModel(
      id: 'welcome',
      text:
          "Namaste! 🙏 I'm DEVRITI, your mental health companion powered by AI. I'm here to listen and support you - no login needed, completely private. How are you feeling today?",
      messageType: MessageType.ai.index,
      timestamp: DateTime.now(),
      emotionState: EmotionState.calm.index,
    );
    setState(() {
      _messages.add(welcomeMessage);
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final text = _messageController.text.trim();
    _messageController.clear();

    setState(() {
      _isTyping = true;
    });

    try {
      // Send message to Gemini and get response
      await _chatService.sendMessage(text);

      // Load updated message history
      final history = await _chatService.getMessageHistory();

      setState(() {
        _messages.clear();
        _messages.addAll(history);
        _isTyping = false;
      });

      _scrollToBottom();
    } catch (e) {
      // Fallback response if Gemini fails
      final userMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        messageType: MessageType.user.index,
        timestamp: DateTime.now(),
      );

      final errorMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text:
            "I'm having trouble connecting right now. But I'm here for you. Would you like to try a breathing exercise?",
        messageType: MessageType.ai.index,
        timestamp: DateTime.now(),
        emotionState: EmotionState.neutral.index,
        suggestions: ['Try breathing exercise', 'Explore self-care'],
      );

      setState(() {
        _messages.add(userMessage);
        _messages.add(errorMessage);
        _isTyping = false;
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _chatService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chat),
        actions: [
          IconButton(
            icon: const Icon(Icons.medical_services),
            onPressed: () {
              Navigator.pushNamed(context, '/doctor-connect');
            },
            tooltip: l10n.talkToDoctor,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return const TypingIndicator();
                }
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: l10n.typeMessage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusLarge,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
