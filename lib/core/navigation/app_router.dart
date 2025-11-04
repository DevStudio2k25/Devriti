import 'package:flutter/material.dart';
import '../../presentation/screens/onboarding/welcome_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/chat/chat_screen.dart';
import '../../presentation/screens/mood/mood_tracker_screen.dart';
import '../../presentation/screens/self_care/self_care_screen.dart';
import '../../presentation/screens/doctor/doctor_connect_screen.dart';
import '../../presentation/screens/emergency/emergency_screen.dart';
import '../../presentation/screens/reports/reports_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';

/// App routes
class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String moodTracker = '/mood-tracker';
  static const String selfCare = '/self-care';
  static const String doctorConnect = '/doctor-connect';
  static const String emergency = '/emergency';
  static const String reports = '/reports';
  static const String settings = '/settings';
}

/// App Router for navigation
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case AppRoutes.moodTracker:
        return MaterialPageRoute(builder: (_) => const MoodTrackerScreen());
      case AppRoutes.selfCare:
        return MaterialPageRoute(builder: (_) => const SelfCareScreen());
      case AppRoutes.doctorConnect:
        return MaterialPageRoute(builder: (_) => const DoctorConnectScreen());
      case AppRoutes.emergency:
        return MaterialPageRoute(builder: (_) => const EmergencyScreen());
      case AppRoutes.reports:
        return MaterialPageRoute(builder: (_) => const ReportsScreen());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
