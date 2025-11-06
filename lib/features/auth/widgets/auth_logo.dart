import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Reusable Logo Widget for Auth Pages
class AuthLogo extends StatelessWidget {
  final double size;
  final IconData icon;
  final Color? color;

  const AuthLogo({
    super.key,
    this.size = 100,
    this.icon = Icons.favorite_rounded,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.3),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: color != null
              ? [color!, color!]
              : [AppColors.primary, AppColors.primaryDark],
        ),
        boxShadow: [
          BoxShadow(
            color: (color ?? AppColors.primary).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, size: size * 0.5, color: AppColors.textWhite),
    );
  }
}
