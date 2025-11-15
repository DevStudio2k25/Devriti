import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: NeumorphicCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Your Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: NeumorphicColors.getTextPrimary(context),
              ),
            ),
            const SizedBox(height: 24),

            // Progress Ring
            GlowingProgressRing(
              progress: 0.75,
              size: 180,
              colors: const [NeumorphicColors.blue, NeumorphicColors.blue],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '75%',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.getTextPrimary(context),
                    ),
                  ),
                  Text(
                    'Complete',
                    style: TextStyle(
                      fontSize: 13,
                      color: NeumorphicColors.getTextSecondary(context),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Message
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: NeumorphicColors.blue.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "You're doing great! Keep it up! 💪",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: NeumorphicColors.getTextPrimary(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
