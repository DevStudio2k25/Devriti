import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import 'widgets/welcome_card.dart';
import 'widgets/ai_support_card.dart';
import 'widgets/dashboard_grid.dart';
import 'widgets/build_routine_section.dart';
import 'widgets/recent_insights.dart';
import 'widgets/week_review_chart.dart';

/// Modern Neumorphic Home Screen with 3D Depth Effects
class HomeScreen extends StatefulWidget {
  final bool showBackButton;

  const HomeScreen({super.key, this.showBackButton = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getRandomQuote() {
    final random = Random();
    return AppConstants.quotes[random.nextInt(AppConstants.quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const userName = 'Friend';

    return Scaffold(
      backgroundColor: NeumorphicColors.getBackground(context),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Welcome Card with Mascot
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            const SliverToBoxAdapter(child: WelcomeCard()),

            // AI Support Card
            const SliverToBoxAdapter(child: AISupportCard()),

            // Motivational Quote
            _buildMotivationalQuote(),

            // Dashboard Grid
            const SliverToBoxAdapter(child: DashboardGrid()),

            // Build Routine Section
            const SliverToBoxAdapter(child: BuildRoutineSection()),

            // Recent Insights
            const SliverToBoxAdapter(child: RecentInsights()),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Week in Review Chart
            const SliverToBoxAdapter(child: WeekReviewChart()),

            // Today's Activities
            _buildTodayActivities(l10n),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  // Neumorphic AppBar
  SliverAppBar _buildAppBar(BuildContext context, String userName) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: false,
      pinned: true,
      backgroundColor: NeumorphicColors.getBackground(context),
      elevation: 0,
      leading: widget.showBackButton
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.pop(context),
              ),
            )
          : null,
      actions: const [SizedBox(width: 16)],
    );
  }

  // Today's Activities
  Widget _buildTodayActivities(AppLocalizations l10n) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Activities",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.getTextPrimary(context),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14,
                      color: NeumorphicColors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              icon: Icons.self_improvement_rounded,
              title: 'Morning Meditation',
              time: '8:00 AM',
              isCompleted: true,
              color: NeumorphicColors.purple,
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              icon: Icons.medication_rounded,
              title: 'Take Medication',
              time: '10:00 AM',
              isCompleted: false,
              color: NeumorphicColors.coral,
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              icon: Icons.directions_walk_rounded,
              title: 'Evening Walk',
              time: '6:00 PM',
              isCompleted: false,
              color: NeumorphicColors.mint,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String time,
    required bool isCompleted,
    required Color color,
  }) {
    return NeumorphicCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          NeumorphicContainer(
            width: 48,
            height: 48,
            isCircle: true,
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: NeumorphicColors.getTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 13,
                    color: NeumorphicColors.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          if (isCompleted)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: NeumorphicColors.mint.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: NeumorphicColors.mint,
                size: 20,
              ),
            )
          else
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: NeumorphicColors.textTertiary,
            ),
        ],
      ),
    );
  }

  // Motivational Quote Card
  Widget _buildMotivationalQuote() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: NeumorphicCard(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      NeumorphicColors.orange.withValues(alpha: 0.3),
                      NeumorphicColors.coral.withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.format_quote_rounded,
                  color: NeumorphicColors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getRandomQuote(),
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: NeumorphicColors.getTextSecondary(context),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '- Daily Inspiration',
                      style: TextStyle(
                        fontSize: 12,
                        color: NeumorphicColors.getTextTertiary(context),
                        fontWeight: FontWeight.w500,
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
