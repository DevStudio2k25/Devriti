import 'package:flutter/material.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/auth/profile_setup_screen.dart';
import '../../features/auth/widgets/auth_wrapper.dart';
import '../../features/home/main_screen.dart';
import '../../features/chat/view/chat_view_screen.dart';
import '../../features/routine/daily_routine_screen.dart';
import '../../features/self_care/view/self_care_screen.dart';
import '../../features/doctor/view/doctor_connect_view_screen.dart';
import '../../features/emergency/view/emergency_view_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features/profile/view/profile_view_screen.dart';
import '../../features/icon/icon_preview.dart';

/// App routes
class AppRoutes {
  // Splash route
  static const String splash = '/splash';

  // Auth routes
  static const String auth = '/auth';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String profileSetup = '/profile-setup';

  // App routes
  static const String home = '/';
  static const String chat = '/chat';
  static const String dailyRoutine = '/daily-routine';
  static const String selfCare = '/self-care';
  static const String doctorConnect = '/doctor-connect';
  static const String emergency = '/emergency';
  static const String reports = '/reports';
  static const String profile = '/profile';
  static const String iconPreview = '/icon-preview';
}

/// App Router for navigation
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash route
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      // Auth routes
      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const AuthWrapper());
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
      case AppRoutes.dailyRoutine:
        return MaterialPageRoute(
          builder: (_) => const DailyRoutineScreen(showBackButton: true),
        );
      case AppRoutes.selfCare:
        return MaterialPageRoute(
          builder: (_) => const SelfCareScreen(showBackButton: true),
        );
      case AppRoutes.doctorConnect:
        return MaterialPageRoute(
          builder: (_) => const DoctorConnectScreen(showBackButton: true),
        );
      case AppRoutes.emergency:
        return MaterialPageRoute(
          builder: (_) => const EmergencyScreen(showBackButton: true),
        );
      case AppRoutes.reports:
        return MaterialPageRoute(
          builder: (_) => const ReportsScreen(showBackButton: true),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileViewScreen(showBackButton: true),
        );
      case AppRoutes.iconPreview:
        return MaterialPageRoute(builder: (_) => const IconPreviewPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
