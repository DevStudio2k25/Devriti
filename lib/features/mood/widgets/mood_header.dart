import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';

class MoodHeader extends StatelessWidget {
  final AppLocalizations l10n;

  const MoodHeader({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.howDoYouFeel,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: NeumorphicColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your emotions daily 📊',
              style: TextStyle(
                fontSize: 15,
                color: NeumorphicColors.textSecondary.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
