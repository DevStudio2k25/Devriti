import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class EmptyMoodState extends StatelessWidget {
  const EmptyMoodState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              NeumorphicContainer(
                width: 100,
                height: 100,
                isCircle: true,
                child: const Icon(
                  Icons.mood_outlined,
                  size: 50,
                  color: NeumorphicColors.textTertiary,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No mood entries yet',
                style: TextStyle(
                  color: NeumorphicColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start tracking your mood today!',
                style: TextStyle(
                  color: NeumorphicColors.textTertiary.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
