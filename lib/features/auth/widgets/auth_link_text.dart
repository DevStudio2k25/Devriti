import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Reusable Link Text Widget for Auth Pages (e.g., "Don't have account? Sign Up")
class AuthLinkText extends StatelessWidget {
  final String normalText;
  final String linkText;
  final VoidCallback onTap;

  const AuthLinkText({
    super.key,
    required this.normalText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          normalText,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4),
          ),
          child: Text(
            linkText,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
