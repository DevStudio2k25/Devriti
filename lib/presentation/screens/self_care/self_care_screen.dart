import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/localization/app_localizations.dart';
import 'journal_entry_screen.dart';

class SelfCareScreen extends StatelessWidget {
  const SelfCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.selfCare),
          bottom: TabBar(
            tabs: [
              Tab(icon: const Icon(Icons.music_note), text: l10n.relaxSounds),
              Tab(icon: const Icon(Icons.air), text: l10n.breathingExercise),
              Tab(icon: const Icon(Icons.book), text: l10n.myJournal),
              Tab(icon: const Icon(Icons.nightlight), text: l10n.sleepCorner),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RelaxSoundsTab(),
            BreathingExerciseTab(),
            JournalTab(),
            SleepCornerTab(),
          ],
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
        'icon': Icons.water_drop,
        'color': AppColors.skyBlue,
        'duration': '10 min',
      },
      {
        'name': 'Ocean',
        'icon': Icons.waves,
        'color': AppColors.skyBlue,
        'duration': '15 min',
      },
      {
        'name': 'Forest',
        'icon': Icons.forest,
        'color': AppColors.pastelGreen,
        'duration': '12 min',
      },
      {
        'name': 'Flute',
        'icon': Icons.music_note,
        'color': AppColors.lavender,
        'duration': '8 min',
      },
      {
        'name': 'Birds',
        'icon': Icons.flutter_dash,
        'color': AppColors.pastelGreen,
        'duration': '10 min',
      },
      {
        'name': 'Wind',
        'icon': Icons.air,
        'color': AppColors.skyBlue,
        'duration': '20 min',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: sounds.length,
      itemBuilder: (context, index) {
        final sound = sounds[index];
        final isPlaying = _playingIndex == index;

        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          elevation: isPlaying ? 4 : 1,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: sound['color'] as Color,
              child: Icon(sound['icon'] as IconData, color: Colors.white),
            ),
            title: Text(
              sound['name'] as String,
              style: TextStyle(
                fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(sound['duration'] as String),
            trailing: IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              color: isPlaying ? AppColors.skyBlue : null,
              onPressed: () {
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
                  ),
                );
              },
            ),
          ),
        );
      },
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
        setState(() => _phase = 'Exhale');
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
        setState(() => _phase = 'Inhale');
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
        _controller.forward();
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 200 * _animation.value,
                height: 200 * _animation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.skyBlue.withValues(alpha: 0.6),
                      AppColors.pastelGreen.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.xxxl),
          Text(
            _phase,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.xxl),
          ElevatedButton.icon(
            onPressed: _toggleBreathing,
            icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
            label: Text(_isRunning ? 'Pause' : 'Start'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xxl,
                vertical: AppSpacing.lg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JournalTab extends StatelessWidget {
  const JournalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.book, size: 80, color: AppColors.lavender),
            const SizedBox(height: AppSpacing.xl),
            const Text(
              'My Journal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              'Write your thoughts, feelings, and gratitude here.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JournalEntryScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('New Entry'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.lg,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('View past entries - Coming soon!'),
                  ),
                );
              },
              icon: const Icon(Icons.history),
              label: const Text('View Past Entries'),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepCornerTab extends StatefulWidget {
  const SleepCornerTab({super.key});

  @override
  State<SleepCornerTab> createState() => _SleepCornerTabState();
}

class _SleepCornerTabState extends State<SleepCornerTab> {
  final List<Map<String, dynamic>> _meditations = [
    {
      'title': 'Body Scan Meditation',
      'duration': '15 min',
      'icon': Icons.self_improvement,
      'color': AppColors.lavender,
    },
    {
      'title': 'Sleep Story: Forest Walk',
      'duration': '20 min',
      'icon': Icons.forest,
      'color': AppColors.pastelGreen,
    },
    {
      'title': 'Deep Relaxation',
      'duration': '10 min',
      'icon': Icons.spa,
      'color': AppColors.skyBlue,
    },
    {
      'title': 'Gratitude Meditation',
      'duration': '12 min',
      'icon': Icons.favorite,
      'color': AppColors.peach,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.lavender, AppColors.skyBlue],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            children: [
              Icon(Icons.nightlight, size: 60, color: Colors.white),
              SizedBox(height: AppSpacing.md),
              Text(
                'Sleep Corner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Guided meditations and sleep stories',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        ..._meditations.map(
          (meditation) => Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: meditation['color'] as Color,
                child: Icon(
                  meditation['icon'] as IconData,
                  color: Colors.white,
                ),
              ),
              title: Text(meditation['title'] as String),
              subtitle: Text(meditation['duration'] as String),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_filled),
                color: AppColors.skyBlue,
                iconSize: 36,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Playing: ${meditation['title']}'),
                      action: SnackBarAction(label: 'Stop', onPressed: () {}),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
