import 'package:hive/hive.dart';
import '../models/message_model.dart';
import '../../core/constants/app_constants.dart';

class ChatRepository {
  late Box<MessageModel> _chatBox;

  Future<void> init() async {
    _chatBox = await Hive.openBox<MessageModel>(AppConstants.boxChat);
  }

  Future<void> saveMessage(MessageModel message) async {
    await _chatBox.add(message);
  }

  Future<List<MessageModel>> getAllMessages() async {
    return _chatBox.values.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  Future<void> clearMessages() async {
    await _chatBox.clear();
  }
}
