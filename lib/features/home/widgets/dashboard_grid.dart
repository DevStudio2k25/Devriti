import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Dashboard',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: NeumorphicColors.getTextPrimary(context),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDashboardCard(
                  context,
                  icon: Icons.calendar_today_rounded,
                  title: 'Daily Routine',
                  color: NeumorphicColors.mint,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDashboardCard(
                  context,
                  icon: Icons.insights_rounded,
                  title: 'Trigger Insights',
                  color: NeumorphicColors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDashboardCard(
                  context,
                  icon: Icons.self_improvement_rounded,
                  title: 'Meditation',
                  color: NeumorphicColors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDashboardCard(
                  context,
                  icon: Icons.air_rounded,
                  title: 'Breathing',
                  color: NeumorphicColors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return NeumorphicCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: NeumorphicColors.getTextPrimary(context),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
