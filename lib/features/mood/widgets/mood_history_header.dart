import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';

class MoodHistoryHeader extends StatelessWidget {
  final AppLocalizations l10n;

  const MoodHistoryHeader({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Row(
          children: [
            NeumorphicContainer(
              width: 40,
              height: 40,
              child: const Icon(
                Icons.history_rounded,
                color: NeumorphicColors.orange,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Mood History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: NeumorphicColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
