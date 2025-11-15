import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';

class EmergencyAppBar extends StatelessWidget {
  final AppLocalizations l10n;
  final bool showBackButton;

  const EmergencyAppBar({
    super.key,
    required this.l10n,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: NeumorphicColors.background,
      elevation: 0,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.pop(context),
              ),
            )
          : const SizedBox.shrink(),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicContainer(
              width: 36,
              height: 36,
              child: const Icon(
                Icons.emergency_rounded,
                color: NeumorphicColors.coral,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.emergency,
              style: const TextStyle(
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
