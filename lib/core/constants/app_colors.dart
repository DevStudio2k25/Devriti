import 'package:flutter/material.dart';

/// 🎨 SMART COLOR SYSTEM - Change once, update everywhere!
/// Ek jagah color change karo, poore app mein update ho jayega!
class AppColors {
  // ============ PRIMARY THEME COLORS ============
  static const Color primary = Color(0xFF2196F3); // Main Blue
  static const Color primaryDark = Color(0xFF1976D2); // Darker Blue
  static const Color primaryLight = Color(0xFF64B5F6); // Lighter Blue

  static const Color secondary = Color(0xFF26A69A); // Teal/Green
  static const Color secondaryDark = Color(0xFF00897B);
  static const Color secondaryLight = Color(0xFF4DB6AC);

  static const Color accent = Color(0xFF7E57C2); // Purple
  static const Color accentLight = Color(0xFF9575CD);

  // ============ BACKGROUND COLORS ============
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFF0F0F0);

  // ============ TEXT COLORS ============
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ============ STATUS COLORS ============
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // ============ SPECIAL COLORS ============
  static const Color emergency = Color(0xFFD32F2F);
  static const Color calm = Color(0xFF64B5F6);
  static const Color neutral = Color(0xFFFFF9C4);
  static const Color stressed = Color(0xFFFFCDD2);

  // ============ UTILITY COLORS ============
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);

  // ============ LEGACY SUPPORT (purane code ke liye) ============
  static const Color skyBlue = primary;
  static const Color deepBlue = primaryDark;
  static const Color pastelGreen = secondary;
  static const Color lavender = accent;
  static const Color peach = Color(0xFFFF7043);
  static const Color mint = Color(0xFF4DB6AC);
  static const Color softWhite = background;
  static const Color charcoal = Color(0xFF2C3E50);
  static const Color backgroundLight = background;
  static const Color cardLight = surface;
  static const Color emotionCalm = calm;
  static const Color emotionNeutral = neutral;
  static const Color emotionStressed = stressed;
  static const Color emergencyRed = emergency;
  static const Color shadowLight = shadow;
  static const Color shadowDark = Color(0x4D000000);

  // ============ GRADIENTS ============
  static const List<Color> calmGradient = [primary, primaryLight];
  static const List<Color> peacefulGradient = [accent, accentLight];
  static const List<Color> serenityGradient = [secondary, secondaryLight];
}
