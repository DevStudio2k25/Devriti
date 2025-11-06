import 'package:flutter/material.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/auth/profile_setup_screen.dart';
import '../../features/home/main_screen.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/mood/mood_tracker_screen.dart';
import '../../features/self_care/self_care_screen.dart';
import '../../features/doctor/doctor_connect_screen.dart';
import '../../features/emergency/emergency_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features/profile/profile_view_screen.dart';

/// App routes
class AppRoutes {
  // Auth routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String profileSetup = '/profile-setup';

  // App routes
  static const String home = '/';
  static const String chat = '/chat';
  static const String moodTracker = '/mood-tracker';
  static const String selfCare = '/self-care';
  static const String doctorConnect = '/doctor-connect';
  static const String emergency = '/emergency';
  static const String reports = '/reports';
  static const String profile = '/profile';
}

/// App Router for navigation
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth routes
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.profileSetup:
        final args = settings.arguments as Map<String, String>?;
        return MaterialPageRoute(
          builder: (_) => ProfileSetupScreen(signupData: args),
        );

      // App routes
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
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
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileViewScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
