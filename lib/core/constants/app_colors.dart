import 'package:flutter/material.dart';

/// Color palette for Sukoon app
class AppColors {
  // Primary Colors
  static const Color skyBlue = Color(0xFF87CEEB);
  static const Color lavender = Color(0xFFE6E6FA);
  static const Color pastelGreen = Color(0xFFB4E7CE);
  static const Color peach = Color(0xFFFFDAB9);
  static const Color softWhite = Color(0xFFF8F9FA);
  static const Color charcoal = Color(0xFF36454F);

  // Gradient Colors
  static const List<Color> calmGradient = [
    Color(0xFF87CEEB), // Sky Blue
    Color(0xFFE6E6FA), // Lavender
  ];

  static const List<Color> peacefulGradient = [
    Color(0xFFE6E6FA), // Lavender
    Color(0xFFB4E7CE), // Pastel Green
  ];

  static const List<Color> serenityGradient = [
    Color(0xFFB4E7CE), // Pastel Green
    Color(0xFF87CEEB), // Sky Blue
  ];

  // Emotion Colors
  static const Color emotionCalm = Color(0xFF87CEEB); // Blue
  static const Color emotionNeutral = Color(0xFFFFF9C4); // Yellow
  static const Color emotionStressed = Color(0xFFFFCDD2); // Red

  // Functional Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Emergency
  static const Color emergencyRed = Color(0xFFD32F2F);

  // Text Colors
  static const Color textPrimary = Color(0xFF36454F);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2C);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x4D000000);
}
