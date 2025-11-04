/// App-wide constants for DEVRITI Mental Health App
class AppConstants {
  // App Info
  static const String appName = 'DEVRITI';
  static const String appTagline = "You're not alone — DEVRITI is here for you";
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyFirstLaunch = 'first_launch';
  static const String keyLanguage = 'language';
  static const String keyThemeMode = 'theme_mode';
  static const String keyUserId = 'user_id';
  static const String keyIsGuest = 'is_guest';

  // Hive Box Names
  static const String boxUser = 'user_box';
  static const String boxMood = 'mood_box';
  static const String boxChat = 'chat_box';
  static const String boxJournal = 'journal_box';
  static const String boxSelfCare = 'selfcare_box';
  static const String boxSettings = 'settings_box';

  // API Endpoints (placeholder)
  static const String baseUrl = 'https://api.devriti.app';
  static const String apiVersion = 'v1';

  // Timing Constants
  static const int splashDuration = 2000; // milliseconds
  static const int animationDuration = 300; // milliseconds
  static const int typingIndicatorDelay = 1000; // milliseconds

  // Mood Levels
  static const List<String> moodEmojis = ['😄', '😊', '😐', '😔', '😢'];
  static const List<String> moodLabels = [
    'Very Happy',
    'Happy',
    'Neutral',
    'Sad',
    'Very Sad',
  ];

  // Emergency Helplines (India)
  static const Map<String, String> helplines = {
    'AASRA': '9820466726',
    'Snehi': '9167687469',
    'Vandrevala Foundation': '18602662345',
    'iCall': '9152987821',
    'Connecting NGO': '9922001122',
  };

  // Breathing Exercise Patterns
  static const Map<String, List<int>> breathingPatterns = {
    '4-7-8': [4, 7, 8], // Inhale, Hold, Exhale (seconds)
    'Box Breathing': [4, 4, 4, 4], // Inhale, Hold, Exhale, Hold
    'Simple': [3, 3, 3], // Inhale, Hold, Exhale
  };

  // Inspirational Quotes
  static const List<String> quotes = [
    "It's okay to take a break sometimes.",
    "You are stronger than you think.",
    "Every day is a new beginning.",
    "Your mental health matters.",
    "Be kind to yourself.",
    "Progress, not perfection.",
    "You are not alone in this journey.",
    "Healing is not linear.",
    "Take it one day at a time.",
    "You deserve peace and happiness.",
  ];

  // Age Groups
  static const List<String> ageGroups = [
    '13-17',
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55-64',
    '65+',
  ];
}
