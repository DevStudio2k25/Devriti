import 'package:hive/hive.dart';

part 'mood_entry_model.g.dart';

@HiveType(typeId: 2)
class MoodEntryModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int moodLevel; // 0-4 (😄 😊 😐 😔 😢)

  @HiveField(2)
  final String? note;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final List<String>? tags;

  MoodEntryModel({
    required this.id,
    required this.moodLevel,
    this.note,
    required this.timestamp,
    this.tags,
  });

  String get moodEmoji {
    const emojis = ['😄', '😊', '😐', '😔', '😢'];
    return emojis[moodLevel.clamp(0, 4)];
  }

  String get moodLabel {
    const labels = ['Very Happy', 'Happy', 'Neutral', 'Sad', 'Very Sad'];
    return labels[moodLevel.clamp(0, 4)];
  }

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MoodEntryModel(
      id: json['id'] as String,
      moodLevel: json['moodLevel'] as int,
      note: json['note'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moodLevel': moodLevel,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
      'tags': tags,
    };
  }
}
