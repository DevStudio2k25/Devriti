import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/config/env_config.dart';
import '../models/message_model.dart';
import '../chat_repository.dart';
import '../services/gemini_chat_service.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/typing_indicator.dart';

/// Modern Neumorphic Chat Screen with 3D Depth
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final List<MessageModel> _messages = [];
  bool _isTyping = false;
  late GeminiChatService _chatService;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    print('🎬 [CHAT] Initializing chat screen with Gemini AI');

    final repository = ChatRepository();
    await repository.init();

    print('✅ [CHAT] Repository initialized');

    _chatService = GeminiChatService(repository, EnvConfig.geminiApiKey);

    await _loadMessageHistory();
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
          "Namaste! 🙏 Main DEVRITI hoon, tumhara mental health companion. Main yahan hoon tumhari baat sunne aur support karne ke liye - koi login nahi chahiye, completely private. Aaj kaisa feel kar rahe ho? Kuch share karna chahoge? 💙",
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
      print('📤 [CHAT] Sending message to Gemini: $text');

      await _chatService.sendMessage(text);

      print('📥 [CHAT] Message sent, loading history...');

      final history = await _chatService.getMessageHistory();

      print('📋 [CHAT] History loaded: ${history.length} messages');

      setState(() {
        _messages.clear();
        _messages.addAll(history);
        _isTyping = false;
      });

      _scrollToBottom();
    } catch (e) {
      print('❌ [CHAT] Error in _sendMessage: $e');

      final userMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        messageType: MessageType.user.index,
        timestamp: DateTime.now(),
      );

      final errorMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text:
            "Yaar, mujhe abhi connect karne mein problem aa rahi hai. But tension mat lo, main yahan hoon. Chalo breathing exercise try karte hain? 💙",
        messageType: MessageType.ai.index,
        timestamp: DateTime.now(),
        emotionState: EmotionState.neutral.index,
        suggestions: ['🫁 Breathing exercise', '🧘 Self-care tools'],
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      body: FadeTransition(
        opacity: _animationController,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(context, l10n),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(20),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isTyping) {
                      return const TypingIndicator();
                    }
                    return ChatBubble(message: _messages[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildInputField(l10n),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, AppLocalizations l10n) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: NeumorphicColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicContainer(
              width: 40,
              height: 40,
              isCircle: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.mint, NeumorphicColors.blue],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.chat,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.textPrimary,
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.circle, color: NeumorphicColors.mint, size: 8),
                    SizedBox(width: 6),
                    Text(
                      'AI Online',
                      style: TextStyle(
                        fontSize: 11,
                        color: NeumorphicColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeumorphicButton(
            icon: Icons.medical_services_rounded,
            onTap: () => Navigator.pushNamed(context, '/doctor-connect'),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildInputField(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NeumorphicColors.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 20,
            offset: const Offset(0, -4),
            spreadRadius: -2,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: NeumorphicContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(
                    color: NeumorphicColors.textPrimary,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.typeMessage,
                    hintStyle: TextStyle(
                      color: NeumorphicColors.textTertiary.withValues(
                        alpha: 0.6,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.mint, NeumorphicColors.blue],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: NeumorphicColors.mint.withValues(alpha: 0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
