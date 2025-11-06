import 'package:flutter/material.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

/// App localizations delegate
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': appLocalizationsEn,
    'hi': appLocalizationsHi,
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Common
  String get appName => translate('app_name');
  String get appTagline => translate('app_tagline');
  String get ok => translate('ok');
  String get cancel => translate('cancel');
  String get save => translate('save');
  String get delete => translate('delete');
  String get edit => translate('edit');
  String get close => translate('close');
  String get yes => translate('yes');
  String get no => translate('no');
  String get loading => translate('loading');
  String get error => translate('error');
  String get success => translate('success');

  // Onboarding
  String get getStarted => translate('get_started');
  String get chooseLanguage => translate('choose_language');
  String get english => translate('english');
  String get hindi => translate('hindi');

  // Auth
  String get login => translate('login');
  String get signup => translate('signup');
  String get email => translate('email');
  String get password => translate('password');
  String get continueAsGuest => translate('continue_as_guest');
  String get signInWithGoogle => translate('sign_in_with_google');
  String get name => translate('name');
  String get ageGroup => translate('age_group');
  String get emergencyContact => translate('emergency_contact');
  String get logout => translate('logout');

  // Home
  String get home => translate('home');
  String get hello => translate('hello');
  String get howAreYouFeeling => translate('how_are_you_feeling');
  String get chatNow => translate('chat_now');
  String get trackMood => translate('track_mood');
  String get selfCareTools => translate('self_care_tools');
  String get consultDoctor => translate('consult_doctor');
  String get emergencyHelp => translate('emergency_help');

  // Chat
  String get chat => translate('chat');
  String get typeMessage => translate('type_message');
  String get sukoonIsTyping => translate('sukoon_is_typing');
  String get talkToDoctor => translate('talk_to_doctor');

  // Mood Tracker
  String get moodTracker => translate('mood_tracker');
  String get howDoYouFeel => translate('how_do_you_feel');
  String get addNote => translate('add_note');
  String get saveMood => translate('save_mood');
  String get moodHistory => translate('mood_history');
  String get thisWeek => translate('this_week');

  // Self Care
  String get selfCare => translate('self_care');
  String get relaxSounds => translate('relax_sounds');
  String get breathingExercise => translate('breathing_exercise');
  String get myJournal => translate('my_journal');
  String get sleepCorner => translate('sleep_corner');
  String get inhale => translate('inhale');
  String get hold => translate('hold');
  String get exhale => translate('exhale');

  // Doctor Connect
  String get findHelpNearYou => translate('find_help_near_you');
  String get call => translate('call');
  String get bookOnline => translate('book_online');
  String get counsellor => translate('counsellor');
  String get psychiatrist => translate('psychiatrist');
  String get helpline => translate('helpline');
  String get reachingOutIsStrength => translate('reaching_out_is_strength');

  // Emergency
  String get emergency => translate('emergency');
  String get sos => translate('sos');
  String get callEmergencyContact => translate('call_emergency_contact');
  String get shareLocation => translate('share_location');
  String get mentalHealthHelplines => translate('mental_health_helplines');
  String get iNeedHelpNow => translate('i_need_help_now');

  // Reports
  String get reports => translate('reports');
  String get moodTrend => translate('mood_trend');
  String get generateReport => translate('generate_report');
  String get progress => translate('progress');
  String get selfCareSessions => translate('self_care_sessions');

  // Additional Features
  String get resources => translate('resources');
  String get journal => translate('journal');
  String get exercises => translate('exercises');

  // Settings
  String get settings => translate('settings');
  String get profile => translate('profile');
  String get darkMode => translate('dark_mode');
  String get lightMode => translate('light_mode');
  String get language => translate('language');
  String get privacy => translate('privacy');
  String get deleteData => translate('delete_data');
  String get exportData => translate('export_data');
  String get aboutSukoon => translate('about_sukoon');

  // Quotes
  String get quote1 => translate('quote_1');
  String get quote2 => translate('quote_2');
  String get quote3 => translate('quote_3');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
