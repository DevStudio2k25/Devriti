import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../../core/constants/app_constants.dart';

class AuthRepository {
  late Box<UserModel> _userBox;
  late SharedPreferences _prefs;

  Future<void> init() async {
    _userBox = await Hive.openBox<UserModel>(AppConstants.boxUser);
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUser(UserModel user) async {
    await _userBox.put('current_user', user);
    await _prefs.setString(AppConstants.keyUserId, user.id);
    await _prefs.setBool(AppConstants.keyIsGuest, user.isGuest);
  }

  UserModel? getCurrentUser() {
    return _userBox.get('current_user');
  }

  Future<void> deleteUser() async {
    await _userBox.delete('current_user');
    await _prefs.remove(AppConstants.keyUserId);
    await _prefs.remove(AppConstants.keyIsGuest);
  }

  bool isLoggedIn() {
    return _prefs.getString(AppConstants.keyUserId) != null;
  }

  bool isGuest() {
    return _prefs.getBool(AppConstants.keyIsGuest) ?? false;
  }
}
