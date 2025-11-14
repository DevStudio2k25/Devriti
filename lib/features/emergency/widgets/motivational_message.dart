import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class MotivationalMessage extends StatelessWidget {
  const MotivationalMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: NeumorphicContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: NeumorphicColors.teal.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: NeumorphicColors.coral,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'You Are Not Alone',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your feelings are valid. Reaching out for help is a sign of strength, not weakness. There are people who care about you and want to help.',
                style: TextStyle(
                  fontSize: 14,
                  color: NeumorphicColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
