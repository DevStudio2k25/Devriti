import 'package:flutter/material.dart';

/// Animated heart widget as fallback for Lottie animation
class AnimatedHeart extends StatefulWidget {
  final double size;
  final Color color;

  const AnimatedHeart({super.key, this.size = 100, this.color = Colors.red});

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Pulse effect
            Opacity(
              opacity: 1 - _pulseAnimation.value,
              child: Transform.scale(
                scale: 1 + (_pulseAnimation.value * 0.5),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.color.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            // Heart icon
            Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(
                Icons.favorite_rounded,
                size: widget.size * 0.6,
                color: widget.color,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Custom heart painter for more detailed heart shape
class HeartPainter extends CustomPainter {
  final Color color;
  final double progress;

  HeartPainter({required this.color, this.progress = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final width = size.width;
    final height = size.height;

    // Draw heart shape
    path.moveTo(width / 2, height * 0.35);

    // Left curve
    path.cubicTo(
      width * 0.2,
      height * 0.1,
      -width * 0.25,
      height * 0.6,
      width / 2,
      height,
    );

    // Right curve
    path.moveTo(width / 2, height * 0.35);
    path.cubicTo(
      width * 0.8,
      height * 0.1,
      width * 1.25,
      height * 0.6,
      width / 2,
      height,
    );

    canvas.save();
    canvas.scale(progress);
    canvas.translate(width / 2 * (1 - progress), height / 2 * (1 - progress));
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(HeartPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
