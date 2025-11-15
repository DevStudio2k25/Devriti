import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/relax_sounds_tab.dart';
import '../widgets/breathing_exercise_tab.dart';

/// Modern Neumorphic Self Care Screen with 3D Depth
class SelfCareScreen extends StatelessWidget {
  final bool showBackButton;

  const SelfCareScreen({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: NeumorphicContainer(
                  padding: const EdgeInsets.all(3),
                  child: TabBar(
                    indicator: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [NeumorphicColors.mint, NeumorphicColors.blue],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: NeumorphicColors.mint.withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: NeumorphicColors.textSecondary,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    tabs: [
                      Tab(
                        icon: const Icon(Icons.music_note_rounded, size: 18),
                        text: l10n.relaxSounds,
                        height: 42,
                      ),
                      Tab(
                        icon: const Icon(Icons.air_rounded, size: 18),
                        text: l10n.breathingExercise,
                        height: 42,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [RelaxSoundsTab(), BreathingExerciseTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
