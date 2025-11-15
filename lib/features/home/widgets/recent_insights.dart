import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

class RecentInsights extends StatelessWidget {
  const RecentInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Your Recent Insights',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: NeumorphicColors.getTextPrimary(context),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildInsightCard(
                context,
                icon: Icons.bedtime_rounded,
                title: 'Sleep & Mood',
                subtitle: 'Connection',
                color: NeumorphicColors.blue,
              ),
              const SizedBox(width: 12),
              _buildInsightCard(
                context,
                icon: Icons.groups_rounded,
                title: 'Social',
                subtitle: 'Interaction',
                color: NeumorphicColors.mint,
              ),
              const SizedBox(width: 12),
              _buildInsightCard(
                context,
                icon: Icons.local_cafe_rounded,
                title: "Caffeine's",
                subtitle: 'Impact',
                color: NeumorphicColors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: NeumorphicColors.getCard(context),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const Spacer(),
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
    );
  }
}
