import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../chat_history_repository.dart';
import '../models/chat_session_model.dart';
import 'chat_view_screen.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final _historyRepo = ChatHistoryRepository();
  List<ChatSessionModel> _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    setState(() => _isLoading = true);
    await _historyRepo.init();
    final sessions = await _historyRepo.getAllSessions();
    setState(() {
      _sessions = sessions;
      _isLoading = false;
    });
  }

  Future<void> _deleteSession(String sessionId) async {
    await _historyRepo.deleteSession(sessionId);
    _loadSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: AppBar(
        backgroundColor: NeumorphicColors.getBackground(context),
        elevation: 0,
        title: const Text(
          'Chat History',
          style: TextStyle(
            color: NeumorphicColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: NeumorphicColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_sessions.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.delete_sweep,
                color: NeumorphicColors.coral,
              ),
              onPressed: _showClearAllDialog,
              tooltip: 'Clear All',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _sessions.isEmpty
          ? _buildEmptyState()
          : _buildSessionList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatScreen()),
          ).then((_) => _loadSessions());
        },
        backgroundColor: NeumorphicColors.mint,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: NeumorphicColors.getTextTertiary(context),
          ),
          const SizedBox(height: 16),
          Text(
            'No chat history yet',
            style: TextStyle(
              fontSize: 18,
              color: NeumorphicColors.getTextSecondary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _sessions.length,
      itemBuilder: (context, index) {
        final session = _sessions[index];
        return _buildSessionCard(session);
      },
    );
  }

  Widget _buildSessionCard(ChatSessionModel session) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: NeumorphicColors.getCard(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [NeumorphicColors.mint, NeumorphicColors.blue],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.chat, color: Colors.white),
        ),
        title: Text(
          session.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: NeumorphicColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          _formatDate(session.lastMessageAt),
          style: TextStyle(
            fontSize: 12,
            color: NeumorphicColors.getTextSecondary(context),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: NeumorphicColors.coral),
          onPressed: () => _showDeleteDialog(session),
        ),
        onTap: () {
          // Open chat with this session
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(sessionId: session.id),
            ),
          ).then((_) => _loadSessions());
        },
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: NeumorphicColors.getBackground(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Clear All History?',
          style: TextStyle(color: NeumorphicColors.textPrimary),
        ),
        content: const Text(
          'This will delete all chat sessions and take you back to home.',
          style: TextStyle(color: NeumorphicColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog

              // Clear all
              await _historyRepo.clearAllHistory();

              // Show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All chats cleared'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );

              // Go back to home
              await Future.delayed(const Duration(milliseconds: 500));
              if (mounted) {
                Navigator.pop(context); // Close history screen
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

  void _showDeleteDialog(ChatSessionModel session) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: NeumorphicColors.getBackground(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Chat?',
          style: TextStyle(color: NeumorphicColors.textPrimary),
        ),
        content: const Text(
          'This will permanently delete this chat session.',
          style: TextStyle(color: NeumorphicColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteSession(session.id);

              // If no sessions left, go back to home
              if (_sessions.isEmpty && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All chats deleted'),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 1),
                  ),
                );
                await Future.delayed(const Duration(milliseconds: 500));
                if (mounted) {
                  Navigator.pop(context); // Go back to home
                }
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: NeumorphicColors.coral),
            ),
          ),
        ],
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
}
