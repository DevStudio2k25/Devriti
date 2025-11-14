import 'package:flutter/material.dart';
import '../../../../core/widgets/neumorphic_widgets.dart';
import '../../../auth/models/user_profile_model.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileHeaderWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return NeumorphicCard(
      child: Row(
        children: [
          // Avatar
          NeumorphicContainer(
            width: 80,
            height: 80,
            isCircle: true,
            child: Center(
              child: Text(
                profile.name?.substring(0, 1).toUpperCase() ?? 'U',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.purple,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Name & Profession
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name ?? 'User',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  profile.profession ?? 'User Profile',
                  style: const TextStyle(
                    fontSize: 14,
                    color: NeumorphicColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        NeumorphicColors.mint.withValues(alpha: 0.3),
                        NeumorphicColors.blue.withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: 16,
                        color: NeumorphicColors.mint,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Verified',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: NeumorphicColors.mint,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
