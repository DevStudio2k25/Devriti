import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

/// Provider for managing app language
class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  late SharedPreferences _prefs;

  Locale get locale => _locale;
  String get languageCode => _locale.languageCode;

  /// Initialize language from storage
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final savedLanguage = _prefs.getString(AppConstants.keyLanguage);
    if (savedLanguage != null) {
      _locale = Locale(savedLanguage);
      notifyListeners();
    }
  }

  /// Change language
  Future<void> changeLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    await _prefs.setString(AppConstants.keyLanguage, languageCode);
    notifyListeners();
  }

  /// Toggle between English and Hindi
  Future<void> toggleLanguage() async {
    final newLanguage = _locale.languageCode == 'en' ? 'hi' : 'en';
    await changeLanguage(newLanguage);
  }
}
