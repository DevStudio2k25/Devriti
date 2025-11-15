import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class InsightsCard extends StatelessWidget {
  const InsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: NeumorphicCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NeumorphicContainer(
                  width: 40,
                  height: 40,
                  isCircle: true,
                  child: Icon(
                    Icons.lightbulb_rounded,
                    color: NeumorphicColors.orange,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Insights',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.getTextPrimary(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildInsightItem(
              context,
              emoji: '🎯',
              label: 'Most Active',
              value: 'Morning Sessions',
              color: NeumorphicColors.purple,
            ),
            const SizedBox(height: 12),

            _buildInsightItem(
              context,
              emoji: '📈',
              label: 'Best Streak',
              value: '7 Days',
              color: NeumorphicColors.mint,
            ),
            const SizedBox(height: 12),

            _buildInsightItem(
              context,
              emoji: '⏰',
              label: 'Peak Time',
              value: '8-10 AM',
              color: NeumorphicColors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem(
    BuildContext context, {
    required String emoji,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: NeumorphicColors.getTextSecondary(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.getTextPrimary(context),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: color),
        ],
      ),
    );
  }
}
