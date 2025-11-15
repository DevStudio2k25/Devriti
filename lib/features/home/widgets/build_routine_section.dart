import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class BuildRoutineSection extends StatelessWidget {
  const BuildRoutineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Build Your Routine 🌱',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: NeumorphicColors.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 16),
          _buildRoutineItem(
            context,
            icon: Icons.edit_calendar_rounded,
            title: 'Morning Journal',
            subtitle: 'Start your day with reflection',
            color: NeumorphicColors.mint,
          ),
          const SizedBox(height: 12),
          _buildRoutineItem(
            context,
            icon: Icons.lightbulb_rounded,
            title: 'Mindful Moment',
            subtitle: 'Take a 5-minute pause',
            color: NeumorphicColors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/routine');
      },
      child: NeumorphicCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.getTextPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: NeumorphicColors.getTextSecondary(context),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: NeumorphicColors.getCard(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_rounded,
                color: NeumorphicColors.getTextSecondary(context),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
