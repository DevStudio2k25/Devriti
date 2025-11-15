import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.trending_up_rounded,
              label: 'Progress',
              value: '75%',
              color: NeumorphicColors.mint,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.calendar_today_rounded,
              label: 'Days',
              value: '30',
              color: NeumorphicColors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              context,
              icon: Icons.star_rounded,
              label: 'Score',
              value: '8.5',
              color: NeumorphicColors.purple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return NeumorphicCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          NeumorphicContainer(
            width: 48,
            height: 48,
            isCircle: true,
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: NeumorphicColors.getTextSecondary(context),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
