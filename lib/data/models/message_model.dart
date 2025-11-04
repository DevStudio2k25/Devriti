import 'package:hive/hive.dart';

part 'message_model.g.dart';

enum MessageType { user, ai, system }

enum EmotionState { calm, neutral, stressed }

@HiveType(typeId: 1)
class MessageModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final int messageType; // 0: user, 1: ai, 2: system

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final int? emotionState; // 0: calm, 1: neutral, 2: stressed

  @HiveField(5)
  final List<String>? suggestions;

  MessageModel({
    required this.id,
    required this.text,
    required this.messageType,
    required this.timestamp,
    this.emotionState,
    this.suggestions,
  });

  MessageType get type => MessageType.values[messageType];
  EmotionState? get emotion =>
      emotionState != null ? EmotionState.values[emotionState!] : null;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      text: json['text'] as String,
      messageType: json['messageType'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      emotionState: json['emotionState'] as int?,
      suggestions: (json['suggestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'messageType': messageType,
      'timestamp': timestamp.toIso8601String(),
      'emotionState': emotionState,
      'suggestions': suggestions,
    };
  }
}
