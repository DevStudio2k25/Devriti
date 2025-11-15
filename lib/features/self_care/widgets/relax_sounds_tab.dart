import 'package:flutter/material.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

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
        'color': NeumorphicColors.blue,
        'duration': '10 min',
      },
      {
        'name': 'Ocean',
        'description': 'Calming ocean waves',
        'icon': Icons.waves_rounded,
        'color': NeumorphicColors.blue,
        'duration': '15 min',
      },
      {
        'name': 'Forest',
        'description': 'Nature forest sounds',
        'icon': Icons.forest_rounded,
        'color': NeumorphicColors.mint,
        'duration': '12 min',
      },
      {
        'name': 'Flute',
        'description': 'Peaceful flute music',
        'icon': Icons.music_note_rounded,
        'color': NeumorphicColors.purple,
        'duration': '8 min',
      },
      {
        'name': 'Birds',
        'description': 'Chirping birds',
        'icon': Icons.flutter_dash_rounded,
        'color': NeumorphicColors.mint,
        'duration': '10 min',
      },
      {
        'name': 'Wind',
        'description': 'Soft wind breeze',
        'icon': Icons.air_rounded,
        'color': NeumorphicColors.blue,
        'duration': '20 min',
      },
    ];

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Relax & Unwind',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Choose calming sounds 🎵',
                  style: TextStyle(
                    fontSize: 14,
                    color: NeumorphicColors.textSecondary.withValues(
                      alpha: 0.9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final sound = sounds[index];
              final isPlaying = _playingIndex == index;
              final color = sound['color'] as Color;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
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
                        backgroundColor: NeumorphicColors.card,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  child: NeumorphicCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        NeumorphicContainer(
                          width: 50,
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color, color.withValues(alpha: 0.7)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isPlaying
                                  ? [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.4),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Icon(
                              sound['icon'] as IconData,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sound['name'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: NeumorphicColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                sound['description'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: NeumorphicColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: isPlaying
                                ? LinearGradient(
                                    colors: [
                                      color,
                                      color.withValues(alpha: 0.8),
                                    ],
                                  )
                                : null,
                            color: isPlaying
                                ? null
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
                                  fontSize: 11,
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
                ),
              );
            }, childCount: sounds.length),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
