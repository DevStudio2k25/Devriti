import 'package:flutter/material.dart';
import '../../../../core/widgets/neumorphic_widgets.dart';

class ProfileActionButtonsWidget extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onLogoutPressed;

  const ProfileActionButtonsWidget({
    super.key,
    required this.onEditPressed,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.edit_outlined,
            label: 'Edit Profile',
            gradient: const [
              NeumorphicColors.purple,
              NeumorphicColors.purpleLight,
            ],
            onTap: onEditPressed,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.logout_outlined,
            label: 'Logout',
            gradient: const [NeumorphicColors.coral, Color(0xFFFF6B6B)],
            onTap: onLogoutPressed,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
