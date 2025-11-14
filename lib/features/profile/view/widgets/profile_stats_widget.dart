import 'package:flutter/material.dart';
import '../../../../core/widgets/neumorphic_widgets.dart';
import '../../../auth/models/user_profile_model.dart';

class ProfileStatsWidget extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileStatsWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.calendar_today_outlined,
            label: 'Age',
            value: '${profile.age ?? 0}',
            color: NeumorphicColors.blue,
            delay: 0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.favorite_outline_rounded,
            label: 'Streak',
            value: '15',
            color: NeumorphicColors.coral,
            delay: 100,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.emoji_events_outlined,
            label: 'Points',
            value: '240',
            color: NeumorphicColors.orange,
            delay: 200,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutBack,
      builder: (context, animValue, child) {
        return Transform.scale(scale: animValue, child: child);
      },
      child: NeumorphicCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            NeumorphicContainer(
              width: 48,
              height: 48,
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
              style: const TextStyle(
                fontSize: 12,
                color: NeumorphicColors.textTertiary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
