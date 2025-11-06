import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/localization/app_localizations.dart';
import 'models/mood_entry_model.dart';
import 'widgets/custom_button.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  int? _selectedMood;
  final _noteController = TextEditingController();
  final _uuid = const Uuid();
  final List<MoodEntryModel> _moodHistory = [];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveMood() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a mood')));
      return;
    }

    final entry = MoodEntryModel(
      id: _uuid.v4(),
      moodLevel: _selectedMood!,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      timestamp: DateTime.now(),
    );

    setState(() {
      _moodHistory.insert(0, entry);
      _selectedMood = null;
      _noteController.clear();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Mood saved successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.moodTracker),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.howDoYouFeel,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                final isSelected = _selectedMood == index;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedMood = index);
                  },
                  child: AnimatedScale(
                    scale: isSelected ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.skyBlue.withValues(alpha: 0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.skyBlue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          AppConstants.moodEmojis[index],
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            if (_selectedMood != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(
                AppConstants.moodLabels[_selectedMood!],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.xxl),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: l10n.addNote,
                hintText: 'What made you feel this way?',
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: AppSpacing.xl),
            CustomButton(
              text: l10n.saveMood,
              onPressed: _saveMood,
              backgroundColor: AppColors.pastelGreen,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            Text(
              l10n.moodHistory,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_moodHistory.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxl),
                  child: Text(
                    'No mood entries yet',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _moodHistory.length,
                itemBuilder: (context, index) {
                  final entry = _moodHistory[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: ListTile(
                      leading: Text(
                        entry.moodEmoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                      title: Text(entry.moodLabel),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (entry.note != null) ...[
                            const SizedBox(height: 4),
                            Text(entry.note!),
                          ],
                          const SizedBox(height: 4),
                          Text(
                            '${entry.timestamp.day}/${entry.timestamp.month}/${entry.timestamp.year} at ${entry.timestamp.hour}:${entry.timestamp.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
