import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../chat_history_repository.dart';
import '../models/chat_session_model.dart';
import '../view/chat_view_screen.dart';

class ChatMenuSheet extends StatefulWidget {
  final VoidCallback onNewChat;
  final VoidCallback onClearAll;
  final VoidCallback onAboutAI;
  final VoidCallback onViewHistory;
  final String? currentSessionId;
  final String? currentChatTitle;

  const ChatMenuSheet({
    super.key,
    required this.onNewChat,
    required this.onClearAll,
    required this.onAboutAI,
    required this.onViewHistory,
    this.currentSessionId,
    this.currentChatTitle,
  });

  @override
  State<ChatMenuSheet> createState() => _ChatMenuSheetState();
}

class _ChatMenuSheetState extends State<ChatMenuSheet> {
  List<ChatSessionModel> _recentSessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentSessions();
  }

  Future<void> _loadRecentSessions() async {
    final historyRepo = ChatHistoryRepository();
    await historyRepo.init();
    final allSessions = await historyRepo.getAllSessions();

    // Filter out current session and get top 3 recent
    final otherSessions = allSessions
        .where((s) => s.id != widget.currentSessionId)
        .take(3)
        .toList();

    setState(() {
      _recentSessions = otherSessions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NeumorphicColors.getBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: NeumorphicColors.getTextTertiary(
                  context,
                ).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
                      Icons.chat_bubble_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Chat Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.getTextPrimary(context),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Current Chat Section
            _buildSectionTitle(context, 'Current Chat'),
            const SizedBox(height: 8),
            _buildCurrentChatItem(context),

            const SizedBox(height: 20),

            // Recent Chats Section
            _buildSectionTitle(context, 'Recent Chats'),
            const SizedBox(height: 8),
            _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                : _recentSessions.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'No recent chats',
                      style: TextStyle(
                        fontSize: 14,
                        color: NeumorphicColors.getTextSecondary(context),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : Column(
                    children: _recentSessions
                        .map(
                          (session) => _buildRecentChatItem(context, session),
                        )
                        .toList(),
                  ),

            const SizedBox(height: 24),

            // Divider
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: NeumorphicColors.getTextTertiary(
                context,
              ).withValues(alpha: 0.1),
            ),

            const SizedBox(height: 16),

            // Menu Options
            _buildMenuOption(
              context,
              icon: Icons.history_rounded,
              title: 'Chat History',
              color: NeumorphicColors.blue,
              onTap: () {
                Navigator.pop(context);
                widget.onViewHistory();
              },
            ),
            _buildMenuOption(
              context,
              icon: Icons.add_circle_outline_rounded,
              title: 'New Chat',
              color: NeumorphicColors.mint,
              onTap: () {
                Navigator.pop(context);
                widget.onNewChat();
              },
            ),
            _buildMenuOption(
              context,
              icon: Icons.delete_outline_rounded,
              title: 'Clear All Chats',
              color: NeumorphicColors.coral,
              onTap: () {
                Navigator.pop(context);
                widget.onClearAll();
              },
            ),
            _buildMenuOption(
              context,
              icon: Icons.info_outline_rounded,
              title: 'About AI',
              color: NeumorphicColors.blue,
              onTap: () {
                Navigator.pop(context);
                widget.onAboutAI();
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: NeumorphicColors.getTextSecondary(context),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentChatItem(BuildContext context) {
    final title = widget.currentChatTitle ?? 'Current Chat';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeumorphicCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: NeumorphicColors.mint.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.chat_rounded,
                color: NeumorphicColors.mint,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: NeumorphicColors.getTextPrimary(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Active now',
                    style: TextStyle(
                      fontSize: 12,
                      color: NeumorphicColors.getTextSecondary(context),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.check_circle_rounded,
              color: NeumorphicColors.mint,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentChatItem(BuildContext context, ChatSessionModel session) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: InkWell(
        onTap: () {
          // Open this session
          Navigator.pop(context); // Close menu
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(sessionId: session.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: NeumorphicColors.getCard(context).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: NeumorphicColors.blue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: NeumorphicColors.blue,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: NeumorphicColors.getTextPrimary(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatDate(session.lastMessageAt),
                      style: TextStyle(
                        fontSize: 11,
                        color: NeumorphicColors.getTextSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: NeumorphicColors.getTextTertiary(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: NeumorphicColors.getTextPrimary(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
