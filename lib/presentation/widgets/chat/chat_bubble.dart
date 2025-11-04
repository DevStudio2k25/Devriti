import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../data/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  Color _getEmotionColor() {
    if (message.emotion == null) return AppColors.emotionNeutral;
    switch (message.emotion!) {
      case EmotionState.calm:
        return AppColors.emotionCalm;
      case EmotionState.neutral:
        return AppColors.emotionNeutral;
      case EmotionState.stressed:
        return AppColors.emotionStressed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == MessageType.user;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: AppColors.skyBlue,
              child: const Icon(Icons.favorite, color: Colors.white, size: 20),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isUser ? AppColors.skyBlue : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppSpacing.radiusMedium),
                  topRight: const Radius.circular(AppSpacing.radiusMedium),
                  bottomLeft: Radius.circular(
                    isUser ? AppSpacing.radiusMedium : 0,
                  ),
                  bottomRight: Radius.circular(
                    isUser ? 0 : AppSpacing.radiusMedium,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  if (!isUser && message.emotion != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _getEmotionColor(),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: AppSpacing.sm),
            const CircleAvatar(
              backgroundColor: AppColors.pastelGreen,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ],
        ],
      ),
    );
  }
}
