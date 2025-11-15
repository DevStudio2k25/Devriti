import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../models/message_model.dart';
import 'typing_text_animation.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool showTypingAnimation;
  final VoidCallback? onTextUpdate;

  const ChatBubble({
    super.key,
    required this.message,
    this.showTypingAnimation = false,
    this.onTextUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 6,
          bottom: 6,
          left: isUser ? 60 : 12,
          right: isUser ? 12 : 60,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isUser
              ? const LinearGradient(
                  colors: [
                    Color(0xFFFFB6C1), // Light pink
                    Color(0xFFFFD4E5), // Lighter pink
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [
                    NeumorphicColors.mint,
                    Color(0xFF7FFFD4), // Aquamarine
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isUser
                ? const Radius.circular(20)
                : const Radius.circular(4),
            bottomRight: isUser
                ? const Radius.circular(4)
                : const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: showTypingAnimation && !isUser
            ? TypingTextAnimation(
                text: message.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  height: 1.4,
                ),
                onTextUpdate: onTextUpdate,
              )
            : Text(
                message.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
      ),
    );
  }
}
