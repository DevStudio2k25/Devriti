import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';

class MoodAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppLocalizations l10n;

  const MoodAppBar({super.key, required this.l10n});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: NeumorphicColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          NeumorphicContainer(
            width: 40,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [NeumorphicColors.orange, NeumorphicColors.coral],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mood_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            l10n.moodTracker,
            style: const TextStyle(
              color: NeumorphicColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
