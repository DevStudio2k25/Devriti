import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_localizations.dart';

class MoodSelectionCard extends StatelessWidget {
  final int? selectedMood;
  final TextEditingController noteController;
  final Function(int) onMoodSelected;
  final VoidCallback onSave;
  final AppLocalizations l10n;

  const MoodSelectionCard({
    super.key,
    required this.selectedMood,
    required this.noteController,
    required this.onMoodSelected,
    required this.onSave,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: NeumorphicCard(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) {
                  final isSelected = selectedMood == index;
                  final moodColors = [
                    NeumorphicColors.coral,
                    NeumorphicColors.orange,
                    const Color(0xFFFFE08C),
                    NeumorphicColors.mint,
                    NeumorphicColors.blue,
                  ];
                  return GestureDetector(
                    onTap: () => onMoodSelected(index),
                    child: AnimatedScale(
                      scale: isSelected ? 1.15 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? NeumorphicColors.background
                              : NeumorphicColors.card,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: moodColors[index].withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 16,
                                    spreadRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.6),
                                    offset: const Offset(3, 3),
                                    blurRadius: 8,
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    offset: const Offset(2, 2),
                                    blurRadius: 6,
                                  ),
                                ],
                        ),
                        child: Center(
                          child: Text(
                            AppConstants.moodEmojis[index],
                            style: TextStyle(fontSize: isSelected ? 32 : 28),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              if (selectedMood != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        NeumorphicColors.orange.withValues(alpha: 0.2),
                        NeumorphicColors.coral.withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    AppConstants.moodLabels[selectedMood!],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              NeumorphicContainer(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: noteController,
                  style: const TextStyle(
                    color: NeumorphicColors.textPrimary,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    labelText: l10n.addNote,
                    hintText: 'What made you feel this way?',
                    border: InputBorder.none,
                    labelStyle: const TextStyle(
                      color: NeumorphicColors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                    hintStyle: TextStyle(
                      color: NeumorphicColors.textTertiary.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: onSave,
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [NeumorphicColors.orange, NeumorphicColors.coral],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: NeumorphicColors.orange.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.save_rounded,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.saveMood,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
