import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Reusable Neumorphic Widgets Library
/// Soft dark UI with 3D depth effects

class NeumorphicContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final bool isCircle;
  final double borderRadius;
  final Color? backgroundColor;

  const NeumorphicContainer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.child,
    this.isCircle = false,
    this.borderRadius = 20,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2A2F38),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            offset: const Offset(4, 4),
            blurRadius: 12,
            spreadRadius: -2,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.03),
            offset: const Offset(-4, -4),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: child,
    );
  }
}

class NeumorphicButton extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Gradient? gradient;

  const NeumorphicButton({
    super.key,
    this.icon,
    this.label,
    required this.onTap,
    this.width,
    this.height,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 44,
        height: height ?? 44,
        decoration: BoxDecoration(
          gradient: gradient,
          color: gradient == null ? (color ?? const Color(0xFF2A2F38)) : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              offset: const Offset(4, 4),
              blurRadius: 12,
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.03),
              offset: const Offset(-4, -4),
              blurRadius: 12,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: Colors.white, size: 22)
              : Text(
                  label ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const NeumorphicCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2F38),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              offset: const Offset(4, 4),
              blurRadius: 12,
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.03),
              offset: const Offset(-4, -4),
              blurRadius: 12,
              spreadRadius: -2,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class NeumorphicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;

  const NeumorphicAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A1D23),
      elevation: 0,
      leading: leadingIcon != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                icon: leadingIcon,
                onTap: onLeadingPressed ?? () => Navigator.pop(context),
              ),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFE8EDF3),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class GlowingProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final List<Color> colors;
  final Widget? child;

  const GlowingProgressRing({
    super.key,
    required this.progress,
    this.size = 180,
    this.colors = const [
      Color(0xFF7FDFB1),
      Color(0xFF7FB8FF),
      Color(0xFF8B7FFF),
    ],
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: progress),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors.first.withValues(alpha: 0.3),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
              NeumorphicContainer(
                width: size - 20,
                height: size - 20,
                isCircle: true,
                child: Container(),
              ),
              CustomPaint(
                size: Size(size - 10, size - 10),
                painter: _ProgressRingPainter(progress: value, colors: colors),
              ),
              if (child != null) child!,
            ],
          ),
        );
      },
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final List<Color> colors;

  _ProgressRingPainter({required this.progress, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 12.0;

    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + (2 * math.pi * progress),
        colors: colors,
      );

      final glowPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 6
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        glowPaint,
      );

      final progressPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class NeumorphicColors {
  static const background = Color(0xFF1A1D23);
  static const card = Color(0xFF2A2F38);
  static const textPrimary = Color(0xFFE8EDF3);
  static const textSecondary = Color(0xFF9BA5B4);
  static const textTertiary = Color(0xFF6D737A);

  static const purple = Color(0xFF8B7FFF);
  static const purpleLight = Color(0xFFB8A8FF);
  static const mint = Color(0xFF7FDFB1);
  static const teal = Color(0xFF00CDB7);
  static const blue = Color(0xFF7FB8FF);
  static const orange = Color(0xFFFFB88C);
  static const coral = Color(0xFFFF9B9B);
  static const lavender = Color(0xFFB8A8FF);
}
