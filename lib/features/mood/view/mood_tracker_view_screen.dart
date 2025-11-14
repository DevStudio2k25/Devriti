import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../core/widgets/neumorphic_widgets.dart';
import '../../../core/localization/app_localizations.dart';
import '../models/mood_entry_model.dart';
import '../widgets/mood_app_bar.dart';
import '../widgets/mood_header.dart';
import '../widgets/mood_selection_card.dart';
import '../widgets/mood_history_header.dart';
import '../widgets/mood_history_list.dart';
import '../widgets/empty_mood_state.dart';

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
      backgroundColor: NeumorphicColors.background,
      appBar: MoodAppBar(l10n: l10n),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          MoodHeader(l10n: l10n),
          MoodSelectionCard(
            selectedMood: _selectedMood,
            noteController: _noteController,
            onMoodSelected: (mood) => setState(() => _selectedMood = mood),
            onSave: _saveMood,
            l10n: l10n,
          ),
          MoodHistoryHeader(l10n: l10n),
          if (_moodHistory.isEmpty)
            const EmptyMoodState()
          else
            MoodHistoryList(moodHistory: _moodHistory),
        ],
      ),
    );
  }
}
