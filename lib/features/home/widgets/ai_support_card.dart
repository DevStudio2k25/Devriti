import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class AISupportCard extends StatelessWidget {
  const AISupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/chat'),
        child: NeumorphicCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Top Row - Icon and Title
              Row(
                children: [
                  // Lottie Animation Placeholder
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          NeumorphicColors.purple.withValues(alpha: 0.2),
                          NeumorphicColors.blue.withValues(alpha: 0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Lottie.asset(
                      'assets/animations/ai_chat.json',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback icon if Lottie not found
                        return Icon(
                          Icons.psychology_rounded,
                          size: 36,
                          color: NeumorphicColors.purple,
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Title and Status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'AI Support',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: NeumorphicColors.getTextPrimary(context),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    NeumorphicColors.mint,
                                    NeumorphicColors.blue,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                '24/7',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: NeumorphicColors.mint,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Online Now',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: NeumorphicColors.getTextSecondary(
                                  context,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Description
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: NeumorphicColors.purple.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: NeumorphicColors.purple.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Your safe space to talk. Share your thoughts and feelings with our AI companion 💜',
                  style: TextStyle(
                    fontSize: 13,
                    color: NeumorphicColors.getTextSecondary(context),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // Start Chat Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NeumorphicColors.purple, NeumorphicColors.blue],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: NeumorphicColors.purple.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Start Conversation',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
