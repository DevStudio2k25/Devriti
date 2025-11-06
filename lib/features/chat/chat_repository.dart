import 'package:hive/hive.dart';
import 'models/message_model.dart';
import '../../core/constants/app_constants.dart';

class ChatRepository {
  Box<MessageModel>? _chatBox;

  Future<void> init() async {
    try {
      // ignore: avoid_print
      print('📦 [REPO] Opening Hive box: ${AppConstants.boxChat}');
      _chatBox = await Hive.openBox<MessageModel>(AppConstants.boxChat);
      // ignore: avoid_print
      print('✅ [REPO] Hive box opened successfully');
    } catch (e) {
      // ignore: avoid_print
      print('❌ [REPO] Error opening Hive box: $e');
      rethrow;
    }
  }

  Future<void> saveMessage(MessageModel message) async {
    if (_chatBox == null) {
      // ignore: avoid_print
      print('⚠️ [REPO] Box not initialized, initializing now...');
      await init();
    }
    await _chatBox!.add(message);
  }

  Future<List<MessageModel>> getAllMessages() async {
    if (_chatBox == null) {
      // ignore: avoid_print
      print('⚠️ [REPO] Box not initialized, initializing now...');
      await init();
    }
    return _chatBox!.values.toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  Future<void> clearMessages() async {
    if (_chatBox == null) {
      // ignore: avoid_print
      print('⚠️ [REPO] Box not initialized, initializing now...');
      await init();
    }
    await _chatBox!.clear();
  }
}
