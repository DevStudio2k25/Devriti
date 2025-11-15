import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/config/env_config.dart';
import '../models/message_model.dart';
import '../chat_repository.dart';
import '../services/gemini_chat_service.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/floating_chat_input.dart';
import '../widgets/chat_menu_sheet.dart';
import 'chat_history_screen.dart';
import '../chat_history_repository.dart';

/// Modern Neumorphic Chat Screen with 3D Depth
class ChatScreen extends StatefulWidget {
  final String? sessionId; // Optional session ID to load existing chat

  const ChatScreen({super.key, this.sessionId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final List<MessageModel> _messages = [];
  bool _isTyping = false;
  String? _latestAIMessageId; // Track latest AI message for typing animation
  final Set<String> _animatedMessageIds =
      {}; // Track which messages have been animated
  late GeminiChatService _chatService;
  late AnimationController _animationController;
  String? _currentSessionId; // Track current session
  String? _currentChatTitle; // Track current chat title

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
    _initializeChat();

    // Listen to keyboard changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    // This helps maintain scroll position
  }

  Future<void> _initializeChat() async {
    print('🎬 [CHAT] Initializing chat screen with Gemini AI');

    final repository = ChatRepository();
    await repository.init();

    print('✅ [CHAT] Repository initialized');

    _chatService = GeminiChatService(repository, EnvConfig.geminiApiKey);

    final historyRepo = ChatHistoryRepository();
    await historyRepo.init();
    final prefs = await SharedPreferences.getInstance();

    // Check if we should load existing session or create new one
    if (widget.sessionId != null) {
      // Load existing session (passed from history/menu)
      _currentSessionId = widget.sessionId;
      print('✅ [CHAT] Loading existing session: $_currentSessionId');
      await _loadSessionMessages();
      // Save as current session
      await prefs.setString('current_session_id', _currentSessionId!);
    } else {
      // Try to load last session from SharedPreferences
      final lastSessionId = prefs.getString('current_session_id');
      if (lastSessionId != null) {
        // Check if session still exists
        final sessions = await historyRepo.getAllSessions();
        final sessionExists = sessions.any((s) => s.id == lastSessionId);

        if (sessionExists) {
          _currentSessionId = lastSessionId;
          print('✅ [CHAT] Resuming last session: $_currentSessionId');
          await _loadSessionMessages();
          return;
        }
      }

      // Create new session if no valid last session
      final session = await historyRepo.createSession();
      _currentSessionId = session.id;
      print('✅ [CHAT] New session created: $_currentSessionId');
      await prefs.setString('current_session_id', _currentSessionId!);
      _addWelcomeMessage();
    }
  }

  Future<void> _loadSessionMessages() async {
    final historyRepo = ChatHistoryRepository();
    await historyRepo.init();

    if (_currentSessionId != null) {
      final messages = await historyRepo.getSessionMessages(_currentSessionId!);
      if (messages.isNotEmpty && mounted) {
        setState(() {
          _messages.addAll(messages);
          // Set title from first user message
          final firstUserMsg = messages.firstWhere(
            (m) => m.isUser,
            orElse: () => messages.first,
          );
          _currentChatTitle = firstUserMsg.text.length > 30
              ? '${firstUserMsg.text.substring(0, 30)}...'
              : firstUserMsg.text;
        });
        print('✅ [CHAT] Loaded ${messages.length} messages from session');
      }
    }
  }

  Future<void> _addWelcomeMessage() async {
    // Check if welcome message already shown
    final prefs = await SharedPreferences.getInstance();
    final welcomeShown = prefs.getBool('welcome_shown') ?? false;

    if (!welcomeShown) {
      final welcomeMessage = MessageModel(
        id: 'welcome_${DateTime.now().millisecondsSinceEpoch}',
        text: "Hi! ✨ Main DEVRITI hoon, aapka companion. Kaise hain aap? 💗",
        messageType: MessageType.ai.index,
        timestamp: DateTime.now(),
        emotionState: EmotionState.calm.index,
      );
      setState(() {
        _messages.add(welcomeMessage);
      });

      // Save welcome message to session
      if (_currentSessionId != null) {
        final historyRepo = ChatHistoryRepository();
        await historyRepo.addMessageToSession(
          _currentSessionId!,
          welcomeMessage,
        );
      }

      // Mark welcome as shown
      await prefs.setBool('welcome_shown', true);
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final text = _messageController.text.trim();
    _messageController.clear();

    // Step 1: Add user message immediately
    final userMessage = MessageModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      messageType: MessageType.user.index,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      // Update chat title from first user message
      if (_currentChatTitle == null || _currentChatTitle == 'New Chat') {
        _currentChatTitle = text.length > 30
            ? '${text.substring(0, 30)}...'
            : text;
      }
    });

    // Save user message to session
    if (_currentSessionId != null) {
      final historyRepo = ChatHistoryRepository();
      await historyRepo.addMessageToSession(_currentSessionId!, userMessage);
    }

    _scrollToBottom(immediate: true); // Immediate scroll for user message

    // Step 2: Show typing indicator
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _isTyping = true;
    });
    _scrollToBottom(immediate: true); // Keep at bottom for typing indicator

    try {
      print('📤 [CHAT] Sending message to Gemini: $text');

      // Step 3: Call API and get AI response directly
      final aiResponse = await _chatService.sendMessage(text);

      print('📥 [CHAT] AI response received');

      // Step 4: Wait 2 seconds for realistic delay
      await Future.delayed(const Duration(seconds: 2));

      // Step 5: Hide typing and add AI response with animation
      setState(() {
        _messages.add(aiResponse);
        _latestAIMessageId = aiResponse.id; // Mark for typing animation
        _isTyping = false;
      });

      // Save AI response to session
      if (_currentSessionId != null) {
        final historyRepo = ChatHistoryRepository();
        await historyRepo.addMessageToSession(_currentSessionId!, aiResponse);
      }

      _scrollToBottom();
    } catch (e) {
      print('❌ [CHAT] Error in _sendMessage: $e');

      // Wait 2 seconds even on error
      await Future.delayed(const Duration(seconds: 2));

      final errorMessage = MessageModel(
        id: 'error_${DateTime.now().millisecondsSinceEpoch}',
        text:
            "Yaar, mujhe abhi connect karne mein problem aa rahi hai. But tension mat lo, main yahan hoon. Chalo breathing exercise try karte hain? 💗",
        messageType: MessageType.ai.index,
        timestamp: DateTime.now(),
        emotionState: EmotionState.neutral.index,
        suggestions: ['🫁 Breathing exercise', '🧘 Self-care tools'],
      );

      setState(() {
        _messages.add(errorMessage);
        _latestAIMessageId = errorMessage.id; // Mark for typing animation
        _isTyping = false;
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom({bool immediate = false}) {
    if (immediate) {
      // Immediate scroll for user messages (reverse list = 0)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    } else {
      // Animated scroll for AI responses (reverse list = 0)
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _showChatMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ChatMenuSheet(
        onNewChat: _handleNewChat,
        onClearAll: _handleClearAll,
        onAboutAI: _handleAboutAI,
        onViewHistory: _handleViewHistory,
        currentSessionId: _currentSessionId,
        currentChatTitle: _currentChatTitle,
      ),
    );
  }

  void _handleNewChat() async {
    // Create new session
    final historyRepo = ChatHistoryRepository();
    await historyRepo.init();
    final session = await historyRepo.createSession();
    _currentSessionId = session.id;

    // Save as current session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_session_id', _currentSessionId!);

    setState(() {
      _messages.clear();
      _currentChatTitle = null; // Reset title
      _animatedMessageIds.clear(); // Clear animated messages
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New chat started'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleClearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: NeumorphicColors.getBackground(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Clear All Chats?',
          style: TextStyle(
            color: NeumorphicColors.getTextPrimary(context),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This will delete all your chat history and take you back to home.',
          style: TextStyle(
            color: NeumorphicColors.getTextSecondary(context),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: NeumorphicColors.getTextSecondary(context),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final scaffoldMessenger = ScaffoldMessenger.of(context);

              navigator.pop(); // Close dialog

              // Show loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) =>
                    const Center(child: CircularProgressIndicator()),
              );

              try {
                // Clear all sessions and messages
                final historyRepo = ChatHistoryRepository();
                await historyRepo.init();
                await historyRepo.clearAllHistory();

                // Clear current session from SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('current_session_id');

                await Future.delayed(const Duration(milliseconds: 500));

                // Close loading dialog
                if (mounted) navigator.pop();

                // Show snackbar
                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text('All chats cleared'),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 1),
                  ),
                );

                // Go back to home
                await Future.delayed(const Duration(milliseconds: 300));
                if (mounted) {
                  navigator.popUntil((route) => route.isFirst);
                }
              } catch (e) {
                print('Error clearing chats: $e');
                if (mounted) {
                  navigator.pop(); // Close loading
                  navigator.popUntil((route) => route.isFirst);
                }
              }
            },
            child: const Text(
              'Clear All',
              style: TextStyle(
                color: NeumorphicColors.coral,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleViewHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChatHistoryScreen()),
    );
  }

  void _handleAboutAI() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: NeumorphicColors.getBackground(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [NeumorphicColors.mint, NeumorphicColors.blue],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.psychology_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'About DEVRITI AI',
              style: TextStyle(
                color: NeumorphicColors.getTextPrimary(context),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'DEVRITI AI is your mental health companion powered by advanced AI. It provides instant support, listens to your concerns, and offers helpful suggestions - all in a safe, private, and judgment-free space.',
          style: TextStyle(
            color: NeumorphicColors.getTextSecondary(context),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: NeumorphicColors.mint,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
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

    // Auto scroll when keyboard opens (reverse list = 0)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });

    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(context, l10n),
            // Chat Messages
            Expanded(
              child: FadeTransition(
                opacity: _animationController,
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  padding: const EdgeInsets.all(12),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Typing indicator at top (index 0 in reverse list)
                    if (index == 0 && _isTyping) {
                      return const TypingIndicator();
                    }

                    // Calculate actual message index
                    final messageIndex = _isTyping
                        ? _messages.length -
                              index // Skip typing indicator
                        : _messages.length - 1 - index;

                    if (messageIndex < 0 || messageIndex >= _messages.length) {
                      return const SizedBox.shrink();
                    }

                    final message = _messages[messageIndex];
                    // Only animate if it's the latest AI message and hasn't been animated yet
                    final shouldAnimate =
                        message.id == _latestAIMessageId &&
                        !message.isUser &&
                        !_animatedMessageIds.contains(message.id);

                    // Mark as animated after first render
                    if (shouldAnimate) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            _animatedMessageIds.add(message.id);
                          });
                        }
                      });
                    }

                    return ChatBubble(
                      message: message,
                      showTypingAnimation: shouldAnimate,
                      onTextUpdate: () {
                        // Scroll as text is being typed
                        if (shouldAnimate) {
                          _scrollToBottom(immediate: false);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            // Input Field - Connected to bottom
            FloatingChatInput(
              controller: _messageController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    return Container(
      color: NeumorphicColors.getBackground(context),
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Back Button
                  _buildBackButton(context),
                  const SizedBox(width: 12),
                  // Avatar
                  _buildAvatar(),
                  const SizedBox(width: 12),
                  // Name and Status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAIName(),
                        const SizedBox(height: 4),
                        _buildOnlineStatus(),
                      ],
                    ),
                  ),
                  // Menu Button
                  _buildMenuButton(),
                ],
              ),
            ),
          ),
          // Divider
          Container(
            height: 1,
            color: NeumorphicColors.getTextTertiary(
              context,
            ).withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: NeumorphicColors.getCard(context),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.7),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: NeumorphicColors.getTextPrimary(context),
          size: 20,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [NeumorphicColors.mint, NeumorphicColors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: NeumorphicColors.mint.withValues(alpha: 0.3),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Icon(
        Icons.psychology_rounded,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Widget _buildAIName() {
    return const Text(
      'DEVRITI AI',
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: NeumorphicColors.textPrimary,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildOnlineStatus() {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: NeumorphicColors.mint,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: NeumorphicColors.mint,
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          'Online',
          style: TextStyle(
            fontSize: 12,
            color: NeumorphicColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton() {
    return GestureDetector(
      onTap: () {
        _showChatMenu();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: NeumorphicColors.getCard(context),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.7),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Icon(
          Icons.more_vert_rounded,
          color: NeumorphicColors.getTextPrimary(context),
          size: 20,
        ),
      ),
    );
  }
}
