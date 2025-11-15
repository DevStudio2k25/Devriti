import 'package:hive/hive.dart';

part 'chat_session_model.g.dart';

@HiveType(typeId: 2)
class ChatSessionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final DateTime lastMessageAt;

  @HiveField(4)
  final List<String> messageIds; // References to messages

  ChatSessionModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastMessageAt,
    required this.messageIds,
  });

  ChatSessionModel copyWith({
    String? title,
    DateTime? lastMessageAt,
    List<String>? messageIds,
  }) {
    return ChatSessionModel(
      id: id,
      title: title ?? this.title,
      createdAt: createdAt,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      messageIds: messageIds ?? this.messageIds,
    );
  }
}
