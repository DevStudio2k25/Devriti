import 'package:hive/hive.dart';
import '../models/mood_entry_model.dart';
import '../../core/constants/app_constants.dart';

class MoodRepository {
  late Box<MoodEntryModel> _moodBox;

  Future<void> init() async {
    _moodBox = await Hive.openBox<MoodEntryModel>(AppConstants.boxMood);
  }

  Future<void> saveMoodEntry(MoodEntryModel entry) async {
    await _moodBox.put(entry.id, entry);
  }

  Future<List<MoodEntryModel>> getAllMoodEntries() async {
    return _moodBox.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<List<MoodEntryModel>> getMoodEntriesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return _moodBox.values
        .where(
          (entry) =>
              entry.timestamp.isAfter(start) && entry.timestamp.isBefore(end),
        )
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> deleteMoodEntry(String id) async {
    await _moodBox.delete(id);
  }

  Future<void> clearAllMoodEntries() async {
    await _moodBox.clear();
  }
}
