import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/widgets/neumorphic_widgets.dart';

class BreathingExerciseTab extends StatefulWidget {
  const BreathingExerciseTab({super.key});

  @override
  State<BreathingExerciseTab> createState() => _BreathingExerciseTabState();
}

class _BreathingExerciseTabState extends State<BreathingExerciseTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isRunning = false;
  String _phase = 'Inhale';
  int _breathCount = 0;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {
        _progress = _controller.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
        if (mounted) {
          setState(() => _phase = 'Exhale');
        }
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
        if (mounted) {
          setState(() {
            _phase = 'Inhale';
            _breathCount++;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleBreathing() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _breathCount = 0;
        _phase = 'Inhale';
        _progress = 0.0;
        _controller.forward();
      } else {
        _controller.stop();
        _controller.reset();
        _progress = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Deep Breathing',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: NeumorphicColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Follow the progress ring to breathe deeply',
              style: TextStyle(
                fontSize: 15,
                color: NeumorphicColors.textSecondary.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildProgressRing(),
            const SizedBox(height: 40),
            if (_isRunning)
              NeumorphicCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.favorite_rounded,
                      color: NeumorphicColors.coral,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Breaths: $_breathCount',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: NeumorphicColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: _toggleBreathing,
              child: Container(
                width: 200,
                height: 56,
                decoration: BoxDecoration(
                  gradient: _isRunning
                      ? const LinearGradient(
                          colors: [NeumorphicColors.coral, Color(0xFFE51A1A)],
                        )
                      : const LinearGradient(
                          colors: [
                            NeumorphicColors.mint,
                            NeumorphicColors.blue,
                          ],
                        ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (_isRunning
                                  ? NeumorphicColors.coral
                                  : NeumorphicColors.mint)
                              .withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isRunning
                          ? Icons.stop_rounded
                          : Icons.play_arrow_rounded,
                      size: 28,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isRunning ? 'Stop' : 'Start',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            NeumorphicCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_rounded,
                    color: NeumorphicColors.orange,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tip: Practice for 5 minutes daily to reduce stress',
                      style: TextStyle(
                        fontSize: 13,
                        color: NeumorphicColors.textSecondary.withValues(
                          alpha: 0.9,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRing() {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: NeumorphicColors.mint.withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
          // Inner neumorphic circle
          NeumorphicContainer(
            width: 200,
            height: 200,
            isCircle: true,
            child: Container(),
          ),
          // Progress ring
          CustomPaint(
            size: const Size(210, 210),
            painter: _BreathingProgressPainter(progress: _progress),
          ),
          // Center content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _phase == 'Inhale'
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                color: NeumorphicColors.mint,
                size: 40,
              ),
              const SizedBox(height: 12),
              Text(
                _phase,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: NeumorphicColors.textPrimary,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(_progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 16,
                  color: NeumorphicColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BreathingProgressPainter extends CustomPainter {
  final double progress;

  _BreathingProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 12.0;

    // Background track
    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress > 0) {
      // Progress gradient
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + (2 * math.pi * progress),
        colors: const [Color(0xFF00CDB7), Color(0xFF7FB8FF), Color(0xFF8B7FFF)],
        stops: const [0.0, 0.5, 1.0],
      );

      // Outer glow
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

      // Main progress
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
  bool shouldRepaint(_BreathingProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
