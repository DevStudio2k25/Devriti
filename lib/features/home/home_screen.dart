import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/welcome_card.dart';

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
  int? _selectedMood;

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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const userName = 'Friend';

    return Scaffold(
      backgroundColor: NeumorphicColors.getBackground(context),
      drawer: const CustomDrawer(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(context, userName),

            // Welcome Card with Mascot and Greeting
            const SliverToBoxAdapter(child: WelcomeCard()),

            // _buildMoodCheckCard(l10n), // Removed - no mood tracker
            // _buildQuickStatsGrid(), // Removed - no chat/mood stats
            _buildQuickActionsRow(context),
            _buildAIChatCard(context),
            _buildTodayActivities(l10n),
            _buildMotivationalQuote(),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  // Neumorphic AppBar with Actions
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
          : Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: NeumorphicButton(
                  icon: Icons.menu_rounded,
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
      actions: const [SizedBox(width: 16)],
    );
  }

  // Daily Mood Check Card
  Widget _buildMoodCheckCard(AppLocalizations l10n) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(scale: value, child: child);
          },
          child: NeumorphicCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    NeumorphicContainer(
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.mood_rounded,
                        color: NeumorphicColors.purple,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'How are you feeling?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: NeumorphicColors.getTextPrimary(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMoodButton('😢', 0, 'Terrible'),
                    _buildMoodButton('😔', 1, 'Bad'),
                    _buildMoodButton('😐', 2, 'Okay'),
                    _buildMoodButton('😊', 3, 'Good'),
                    _buildMoodButton('😄', 4, 'Amazing'),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Tap to log your mood',
                  style: TextStyle(
                    fontSize: 12,
                    color: NeumorphicColors.getTextTertiary(
                      context,
                    ).withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodButton(String emoji, int index, String label) {
    final isSelected = _selectedMood == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedMood = index);
        Navigator.pushNamed(context, '/mood-tracker');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: NeumorphicColors.getCard(context),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: NeumorphicColors.purple.withValues(alpha: 0.4),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : isDark
              ? [
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
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(4, 4),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.9),
                    offset: const Offset(-4, -4),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ],
        ),
        child: Center(
          child: Text(emoji, style: TextStyle(fontSize: isSelected ? 32 : 28)),
        ),
      ),
    );
  }

  // Quick Stats Grid (2x2)
  Widget _buildQuickStatsGrid() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.chat_bubble_rounded,
                label: 'Chats',
                value: '12',
                color: NeumorphicColors.blue,
                delay: 0,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.mood_rounded,
                label: 'Mood Logs',
                value: '7',
                color: NeumorphicColors.orange,
                delay: 100,
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
        return Transform.scale(scale: animValue, child: child);
      },
      child: NeumorphicCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            NeumorphicContainer(
              width: 48,
              height: 48,
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: NeumorphicColors.getTextTertiary(context),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Quick Actions Row
  Widget _buildQuickActionsRow(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: NeumorphicColors.getTextPrimary(context),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickActionButton(
                    icon: Icons.self_improvement_rounded,
                    label: 'Meditate',
                    color: NeumorphicColors.purple,
                    onTap: () => Navigator.pushNamed(context, '/self-care'),
                  ),
                  const SizedBox(width: 12),
                  _buildQuickActionButton(
                    icon: Icons.psychology_rounded,
                    label: 'AI Chat',
                    color: NeumorphicColors.mint,
                    onTap: () => Navigator.pushNamed(context, '/chat'),
                  ),
                  const SizedBox(width: 12),
                  _buildQuickActionButton(
                    icon: Icons.book_rounded,
                    label: 'Journal',
                    color: NeumorphicColors.orange,
                    onTap: () => Navigator.pushNamed(context, '/journal-entry'),
                  ),
                  const SizedBox(width: 12),
                  _buildQuickActionButton(
                    icon: Icons.music_note_rounded,
                    label: 'Sounds',
                    color: NeumorphicColors.blue,
                    onTap: () => Navigator.pushNamed(context, '/self-care'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: NeumorphicColors.getCard(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? [
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
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(4, 4),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.9),
                    offset: const Offset(-4, -4),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ],
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.7)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: NeumorphicColors.getTextSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // AI Chat Card (Featured)
  Widget _buildAIChatCard(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/chat'),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF8B7FFF), Color(0xFFB8A8FF)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: NeumorphicColors.purple.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.psychology_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'AI Support',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.verified_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.circle, color: Colors.white, size: 8),
                              SizedBox(width: 6),
                              Text(
                                'Online 24/7',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'Your safe space to talk. Share your thoughts, feelings, and concerns with our AI companion.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Start Conversation',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
