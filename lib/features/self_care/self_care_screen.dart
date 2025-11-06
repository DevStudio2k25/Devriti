import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';

class SelfCareScreen extends StatelessWidget {
  const SelfCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.pastelGreen,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.spa_rounded, size: 20),
              ),
              const SizedBox(width: 12),
              Text(l10n.selfCare),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: [
              Tab(
                icon: const Icon(Icons.music_note_rounded),
                text: l10n.relaxSounds,
              ),
              Tab(
                icon: const Icon(Icons.air_rounded),
                text: l10n.breathingExercise,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [RelaxSoundsTab(), BreathingExerciseTab()],
        ),
      ),
    );
  }
}

class RelaxSoundsTab extends StatefulWidget {
  const RelaxSoundsTab({super.key});

  @override
  State<RelaxSoundsTab> createState() => _RelaxSoundsTabState();
}

class _RelaxSoundsTabState extends State<RelaxSoundsTab> {
  int? _playingIndex;

  @override
  Widget build(BuildContext context) {
    final sounds = [
      {
        'name': 'Rain',
        'description': 'Gentle rain sounds',
        'icon': Icons.water_drop_rounded,
        'color': AppColors.skyBlue,
        'duration': '10 min',
      },
      {
        'name': 'Ocean',
        'description': 'Calming ocean waves',
        'icon': Icons.waves_rounded,
        'color': AppColors.skyBlue,
        'duration': '15 min',
      },
      {
        'name': 'Forest',
        'description': 'Nature forest sounds',
        'icon': Icons.forest_rounded,
        'color': AppColors.pastelGreen,
        'duration': '12 min',
      },
      {
        'name': 'Flute',
        'description': 'Peaceful flute music',
        'icon': Icons.music_note_rounded,
        'color': AppColors.lavender,
        'duration': '8 min',
      },
      {
        'name': 'Birds',
        'description': 'Chirping birds',
        'icon': Icons.flutter_dash_rounded,
        'color': AppColors.pastelGreen,
        'duration': '10 min',
      },
      {
        'name': 'Wind',
        'description': 'Soft wind breeze',
        'icon': Icons.air_rounded,
        'color': AppColors.skyBlue,
        'duration': '20 min',
      },
    ];

    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.pastelGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.headphones_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Relax & Unwind',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose calming sounds to relax your mind',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Sound Cards
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final sound = sounds[index];
              final isPlaying = _playingIndex == index;
              final color = sound['color'] as Color;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _playingIndex = isPlaying ? null : index;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isPlaying
                            ? 'Paused ${sound['name']}'
                            : 'Playing ${sound['name']}',
                      ),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isPlaying ? color : color.withValues(alpha: 0.2),
                      width: isPlaying ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isPlaying
                            ? color.withValues(alpha: 0.3)
                            : Colors.black.withValues(alpha: 0.05),
                        blurRadius: isPlaying ? 15 : 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon Container
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color, color.withValues(alpha: 0.7)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          sound['icon'] as IconData,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Sound Name
                      Text(
                        sound['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          sound['description'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Play Button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isPlaying
                              ? color
                              : color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: isPlaying ? Colors.white : color,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              sound['duration'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isPlaying ? Colors.white : color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: sounds.length),
          ),
        ),
      ],
    );
  }
}

class BreathingExerciseTab extends StatefulWidget {
  const BreathingExerciseTab({super.key});

  @override
  State<BreathingExerciseTab> createState() => _BreathingExerciseTabState();
}

class _BreathingExerciseTabState extends State<BreathingExerciseTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRunning = false;
  String _phase = 'Inhale';
  int _breathCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

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
        _controller.forward();
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.pastelGreen.withValues(alpha: 0.1),
            AppColors.background,
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Instruction Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.air_rounded,
                      size: 40,
                      color: AppColors.pastelGreen,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Deep Breathing Exercise',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Follow the circle to breathe deeply',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary.withValues(alpha: 0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Breathing Circle
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        width: 280 * _animation.value,
                        height: 280 * _animation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.pastelGreen.withValues(alpha: 0.0),
                              AppColors.pastelGreen.withValues(alpha: 0.2),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Main circle
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        width: 220 * _animation.value,
                        height: 220 * _animation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.pastelGreen, AppColors.skyBlue],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.pastelGreen.withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 30 * _animation.value,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _phase == 'Inhale'
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _phase,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Breath Counter
              if (_isRunning)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pastelGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite_rounded,
                        color: AppColors.pastelGreen,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Breaths: $_breathCount',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pastelGreen,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 32),

              // Control Button
              SizedBox(
                width: 200,
                height: 56,
                child: ElevatedButton(
                  onPressed: _toggleBreathing,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning
                        ? Colors.red.shade400
                        : AppColors.pastelGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    shadowColor: AppColors.pastelGreen.withValues(alpha: 0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isRunning
                            ? Icons.stop_rounded
                            : Icons.play_arrow_rounded,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isRunning ? 'Stop' : 'Start',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Tips
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.skyBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.skyBlue.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.lightbulb_rounded,
                      color: AppColors.skyBlue,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Tip: Practice for 5 minutes daily to reduce stress',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
