import 'package:hive/hive.dart';
import 'models/mood_entry_model.dart';
import '../../core/constants/app_constants.dart';

class MoodRepository {
  Box<MoodEntryModel>? _moodBox;

  Future<void> init() async {
    _moodBox = await Hive.openBox<MoodEntryModel>(AppConstants.boxMood);
  }

  Future<void> saveMoodEntry(MoodEntryModel entry) async {
    if (_moodBox == null) await init();
    await _moodBox!.put(entry.id, entry);
  }

  Future<List<MoodEntryModel>> getAllMoodEntries() async {
    if (_moodBox == null) await init();
    return _moodBox!.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<List<MoodEntryModel>> getMoodEntriesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    if (_moodBox == null) await init();
    return _moodBox!.values
        .where(
          (entry) =>
              entry.timestamp.isAfter(start) && entry.timestamp.isBefore(end),
        )
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> deleteMoodEntry(String id) async {
    if (_moodBox == null) await init();
    await _moodBox!.delete(id);
  }

  Future<void> clearAllMoodEntries() async {
    if (_moodBox == null) await init();
    await _moodBox!.clear();
  }
}
