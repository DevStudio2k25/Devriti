import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import '../../core/localization/app_localizations.dart';
import '../mood/mood_repository.dart';
import '../mood/models/mood_entry_model.dart';

/// Modern Neumorphic Reports Screen with 3D Depth Effects
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  final MoodRepository _moodRepository = MoodRepository();
  List<MoodEntryModel> _moodEntries = [];
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _selectedPeriod = 'Week'; // Week, Month, Year

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _loadMoodData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadMoodData() async {
    try {
      await _moodRepository.init();
      final entries = await _moodRepository.getAllMoodEntries();
      if (mounted) {
        setState(() {
          _moodEntries = entries;
          _isLoading = false;
        });
        _animationController.forward();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Map<int, int> _getMoodCounts() {
    final counts = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0};
    for (var entry in _moodEntries) {
      counts[entry.moodLevel] = (counts[entry.moodLevel] ?? 0) + 1;
    }
    return counts;
  }

  double _getAverageMood() {
    if (_moodEntries.isEmpty) return 0;
    final sum = _moodEntries.fold(0, (sum, entry) => sum + entry.moodLevel);
    return sum / _moodEntries.length;
  }

  int _getImprovementPercentage() {
    if (_moodEntries.length < 2) return 0;
    final halfPoint = _moodEntries.length ~/ 2;
    final firstHalf = _moodEntries.sublist(halfPoint);
    final secondHalf = _moodEntries.sublist(0, halfPoint);
    if (firstHalf.isEmpty || secondHalf.isEmpty) return 0;
    final firstAvg =
        firstHalf.fold(0, (sum, e) => sum + e.moodLevel) / firstHalf.length;
    final secondAvg =
        secondHalf.fold(0, (sum, e) => sum + e.moodLevel) / secondHalf.length;
    final improvement = ((secondAvg - firstAvg) / 4 * 100).clamp(0, 100);
    return improvement.toInt();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D23),
      body: _isLoading ? _buildLoadingState() : _buildContent(l10n),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNeumorphicContainer(
            width: 80,
            height: 80,
            child: const CircularProgressIndicator(
              color: Color(0xFF8B7FFF),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Loading your insights...',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF9BA5B4),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppLocalizations l10n) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(l10n),
          _buildHeaderSection(),
          _buildStatsGrid(),
          _buildPeriodSelector(),
          _buildProgressCard(),
          _buildMoodTrendChart(),
          _buildMoodDistribution(),
          _buildInsightsCard(),
          _buildActionButtons(),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  // Neumorphic AppBar
  SliverAppBar _buildAppBar(AppLocalizations l10n) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF1A1D23),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildNeumorphicButton(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNeumorphicContainer(
              width: 36,
              height: 36,
              child: const Icon(
                Icons.analytics_rounded,
                color: Color(0xFF8B7FFF),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.reports,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE8EDF3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header Section with Greeting
  Widget _buildHeaderSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Wellness Journey',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE8EDF3),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your progress and celebrate growth 🌱',
              style: TextStyle(
                fontSize: 15,
                color: const Color(0xFF9BA5B4).withValues(alpha: 0.9),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Stats Grid (3 Cards)
  Widget _buildStatsGrid() {
    final improvement = _getImprovementPercentage();
    final averageMood = _getAverageMood();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.trending_up_rounded,
                label: 'Improvement',
                value: '$improvement%',
                color: const Color(0xFF7FDFB1),
                delay: 0,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_today_rounded,
                label: 'Total Days',
                value: '${_moodEntries.length}',
                color: const Color(0xFF7FB8FF),
                delay: 100,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.mood_rounded,
                label: 'Avg Mood',
                value: averageMood.toStringAsFixed(1),
                color: const Color(0xFFB8A8FF),
                delay: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutBack,
      builder: (context, animValue, child) {
        return Transform.scale(
          scale: animValue,
          child: _buildNeumorphicContainer(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildNeumorphicContainer(
                  width: 48,
                  height: 48,
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6D737A),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Period Selector (Week/Month/Year)
  Widget _buildPeriodSelector() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: _buildNeumorphicContainer(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: ['Week', 'Month', 'Year'].map((period) {
              final isSelected = _selectedPeriod == period;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedPeriod = period),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [Color(0xFF8B7FFF), Color(0xFFB8A8FF)],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xFF8B7FFF,
                                ).withValues(alpha: 0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      period,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF9BA5B4),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Progress Card with Circular Ring
  Widget _buildProgressCard() {
    final improvement = _getImprovementPercentage();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: _buildNeumorphicContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE8EDF3),
                ),
              ),
              const SizedBox(height: 24),
              _buildProgressRing(improvement),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF7FDFB1).withValues(alpha: 0.2),
                      const Color(0xFF7FB8FF).withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "You're healing — Keep going! 💖",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFE8EDF3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressRing(int improvement) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: improvement / 100),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return SizedBox(
          width: 180,
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7FDFB1).withValues(alpha: 0.3),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
              // Inner neumorphic circle
              _buildNeumorphicContainer(
                width: 160,
                height: 160,
                isCircle: true,
                child: Container(),
              ),
              // Progress ring
              CustomPaint(
                size: const Size(170, 170),
                painter: _ProgressRingPainter(progress: value),
              ),
              // Center text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(value * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFE8EDF3),
                      letterSpacing: -1,
                    ),
                  ),
                  const Text(
                    'Improvement',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6D737A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Mood Trend Chart
  Widget _buildMoodTrendChart() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildNeumorphicContainer(
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.show_chart_rounded,
                    color: Color(0xFFB8A8FF),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Mood Trend',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE8EDF3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildNeumorphicContainer(
              padding: const EdgeInsets.all(20),
              child: _moodEntries.isEmpty
                  ? _buildEmptyState()
                  : _buildLineChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    final last7Days = _moodEntries.take(7).toList().reversed.toList();
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xFF2A2F38).withValues(alpha: 0.5),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= last7Days.length) return const Text('');
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      days[value.toInt() % 7],
                      style: const TextStyle(
                        color: Color(0xFF6D737A),
                        fontSize: 11,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (last7Days.length - 1).toDouble(),
          minY: 0,
          maxY: 4,
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                last7Days.length,
                (index) => FlSpot(
                  index.toDouble(),
                  last7Days[index].moodLevel.toDouble(),
                ),
              ),
              isCurved: true,
              gradient: const LinearGradient(
                colors: [Color(0xFF8B7FFF), Color(0xFF7FDFB1)],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 5,
                    color: const Color(0xFF8B7FFF),
                    strokeWidth: 2,
                    strokeColor: const Color(0xFF1A1D23),
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF8B7FFF).withValues(alpha: 0.3),
                    const Color(0xFF7FDFB1).withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mood Distribution
  Widget _buildMoodDistribution() {
    final moodCounts = _getMoodCounts();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: _buildNeumorphicContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mood Distribution',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE8EDF3),
                ),
              ),
              const SizedBox(height: 20),
              if (_moodEntries.isEmpty)
                _buildEmptyState()
              else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMoodStat(
                      '😢',
                      '${moodCounts[0]}',
                      'Terrible',
                      const Color(0xFFFF9B9B),
                    ),
                    _buildMoodStat(
                      '😔',
                      '${moodCounts[1]}',
                      'Bad',
                      const Color(0xFFFFB88C),
                    ),
                    _buildMoodStat(
                      '😐',
                      '${moodCounts[2]}',
                      'Okay',
                      const Color(0xFFFFE08C),
                    ),
                    _buildMoodStat(
                      '😊',
                      '${moodCounts[3]}',
                      'Good',
                      const Color(0xFF7FDFB1),
                    ),
                    _buildMoodStat(
                      '😄',
                      '${moodCounts[4]}',
                      'Amazing',
                      const Color(0xFF7FB8FF),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 150,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY:
                          (moodCounts.values.reduce((a, b) => a > b ? a : b) +
                                  2)
                              .toDouble(),
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const emojis = ['😢', '😔', '😐', '😊', '😄'];
                              return Text(
                                emojis[value.toInt()],
                                style: const TextStyle(fontSize: 20),
                              );
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(5, (index) {
                        final colors = [
                          const Color(0xFFFF9B9B),
                          const Color(0xFFFFB88C),
                          const Color(0xFFFFE08C),
                          const Color(0xFF7FDFB1),
                          const Color(0xFF7FB8FF),
                        ];
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: (moodCounts[index] ?? 0).toDouble(),
                              gradient: LinearGradient(
                                colors: [
                                  colors[index],
                                  colors[index].withValues(alpha: 0.6),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              width: 32,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodStat(String emoji, String count, String label, Color color) {
    return Column(
      children: [
        _buildNeumorphicContainer(
          width: 50,
          height: 50,
          isCircle: true,
          child: Text(emoji, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF6D737A)),
        ),
      ],
    );
  }

  // Insights Card
  Widget _buildInsightsCard() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: _buildNeumorphicContainer(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildNeumorphicContainer(
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.lightbulb_rounded,
                      color: Color(0xFFFFB88C),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Insights',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE8EDF3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInsightItem(
                '🎯',
                'Most Common Mood',
                _getMostCommonMood(),
                const Color(0xFF8B7FFF),
              ),
              const SizedBox(height: 12),
              _buildInsightItem(
                '📈',
                'Best Day',
                'Thursday',
                const Color(0xFF7FDFB1),
              ),
              const SizedBox(height: 12),
              _buildInsightItem(
                '⏰',
                'Peak Time',
                'Morning (8-10 AM)',
                const Color(0xFF7FB8FF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMostCommonMood() {
    final counts = _getMoodCounts();
    if (counts.values.every((v) => v == 0)) return 'No data';
    final maxEntry = counts.entries.reduce((a, b) => a.value > b.value ? a : b);
    const moods = ['Terrible', 'Bad', 'Okay', 'Good', 'Amazing'];
    return moods[maxEntry.key];
  }

  Widget _buildInsightItem(
    String emoji,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9BA5B4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Action Buttons
  Widget _buildActionButtons() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            _buildActionButton(
              icon: Icons.picture_as_pdf_rounded,
              label: 'Generate PDF Report',
              gradient: const LinearGradient(
                colors: [Color(0xFF8B7FFF), Color(0xFFB8A8FF)],
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Generating PDF report...'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFF2A2F38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.share_rounded,
                    label: 'Share',
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF7FB8FF).withValues(alpha: 0.8),
                        const Color(0xFF7FDFB1).withValues(alpha: 0.8),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.download_rounded,
                    label: 'Export',
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFB88C).withValues(alpha: 0.8),
                        const Color(0xFFFF9B9B).withValues(alpha: 0.8),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Empty State
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          _buildNeumorphicContainer(
            width: 80,
            height: 80,
            isCircle: true,
            child: const Icon(
              Icons.mood_outlined,
              size: 40,
              color: Color(0xFF6D737A),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No mood data yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9BA5B4),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start tracking your mood to see insights',
            style: TextStyle(fontSize: 14, color: Color(0xFF6D737A)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Neumorphic Container Builder
  Widget _buildNeumorphicContainer({
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    Widget? child,
    bool isCircle = false,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2F38),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(20),
        boxShadow: [
          // Inner shadow (dark)
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            offset: const Offset(4, 4),
            blurRadius: 12,
            spreadRadius: -2,
          ),
          // Outer highlight
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

  // Neumorphic Button
  Widget _buildNeumorphicButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _buildNeumorphicContainer(
        width: 44,
        height: 44,
        child: Icon(icon, color: const Color(0xFF9BA5B4), size: 22),
      ),
    );
  }
}

// Custom Progress Ring Painter
class _ProgressRingPainter extends CustomPainter {
  final double progress;

  _ProgressRingPainter({required this.progress});

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
        colors: const [Color(0xFF7FDFB1), Color(0xFF7FB8FF), Color(0xFF8B7FFF)],
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
  bool shouldRepaint(_ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
