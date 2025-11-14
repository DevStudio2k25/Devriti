import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../models/mood_entry_model.dart';

class MoodHistoryList extends StatelessWidget {
  final List<MoodEntryModel> moodHistory;

  const MoodHistoryList({super.key, required this.moodHistory});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final entry = moodHistory[index];
          final moodColors = [
            NeumorphicColors.coral,
            NeumorphicColors.orange,
            const Color(0xFFFFE08C),
            NeumorphicColors.mint,
            NeumorphicColors.blue,
          ];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: NeumorphicCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NeumorphicContainer(
                    width: 50,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            moodColors[entry.moodLevel],
                            moodColors[entry.moodLevel].withValues(alpha: 0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          entry.moodEmoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.moodLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: NeumorphicColors.textPrimary,
                          ),
                        ),
                        if (entry.note != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            entry.note!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: NeumorphicColors.textSecondary,
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: NeumorphicColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${entry.timestamp.day}/${entry.timestamp.month}/${entry.timestamp.year} at ${entry.timestamp.hour}:${entry.timestamp.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: NeumorphicColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }, childCount: moodHistory.length),
      ),
    );
  }
}
