import 'package:flutter/material.dart';

/// Animated Mascot Character with Waving Hand
class AnimatedMascot extends StatefulWidget {
  const AnimatedMascot({super.key});

  @override
  State<AnimatedMascot> createState() => _AnimatedMascotState();
}

class _AnimatedMascotState extends State<AnimatedMascot>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _blinkController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    // Wave animation
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat();

    _waveAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.25), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.25, end: -0.15), weight: 10),
      TweenSequenceItem(tween: Tween(begin: -0.15, end: 0.18), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.18, end: -0.07), weight: 10),
      TweenSequenceItem(tween: Tween(begin: -0.07, end: 0.18), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.18, end: 0.0), weight: 50),
    ]).animate(_waveController);

    // Blink animation
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final faceColor = const Color(0xFFFFFBF5); // Milk white/cream color
    final featureColor = isDark ? const Color(0xFF1A1D23) : Colors.grey[800]!;
    final earHandColor = isDark
        ? const Color(0xFF4A4A4A) // Medium grey for dark theme
        : const Color(0xFF2C2416); // Dark brown for light theme

    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          // Mascot Character
          SizedBox(
            width: 130,
            height: 130,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Main face circle - WHITE/LIGHT
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: faceColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.6 : 0.1,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),

                // Left ear - DARK (outside face)
                Positioned(
                  top: -8,
                  left: -8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: earHandColor,
                    ),
                  ),
                ),

                // Right ear - DARK (outside face)
                Positioned(
                  top: -8,
                  right: -8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: earHandColor,
                    ),
                  ),
                ),

                // Left eye with blink
                Positioned(
                  top: 40,
                  left: 32,
                  child: AnimatedBuilder(
                    animation: _blinkController,
                    builder: (context, child) {
                      final blinkValue = _blinkController.value;
                      final shouldBlink =
                          (blinkValue > 0.5 && blinkValue < 0.52) ||
                          (blinkValue > 0.98);

                      if (shouldBlink) {
                        return Container(
                          width: 28,
                          height: 4,
                          decoration: BoxDecoration(
                            color: featureColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      } else {
                        return Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: featureColor,
                          ),
                          child: Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),

                // Right eye with blink
                Positioned(
                  top: 40,
                  right: 32,
                  child: AnimatedBuilder(
                    animation: _blinkController,
                    builder: (context, child) {
                      final blinkValue = _blinkController.value;
                      final shouldBlink =
                          (blinkValue > 0.5 && blinkValue < 0.52) ||
                          (blinkValue > 0.98);

                      if (shouldBlink) {
                        return Container(
                          width: 28,
                          height: 4,
                          decoration: BoxDecoration(
                            color: featureColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      } else {
                        return Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: featureColor,
                          ),
                          child: Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),

                // Nose - DARK
                Positioned(
                  top: 65,
                  child: Container(
                    width: 16,
                    height: 12,
                    decoration: BoxDecoration(
                      color: featureColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),

                // Waving hand - DARK (outside face)
                Positioned(
                  bottom: 16,
                  right: -16,
                  child: AnimatedBuilder(
                    animation: _waveAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _waveAnimation.value,
                        origin: const Offset(-10, -10),
                        child: Container(
                          width: 48,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: earHandColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
