import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import 'home_screen.dart';
import '../routine/daily_routine_screen.dart';
import '../self_care/view/self_care_screen.dart';
import '../profile/view/profile_view_screen.dart';
import '../emergency/view/emergency_view_screen.dart';
import '../doctor/view/doctor_connect_view_screen.dart';
import '../reports/reports_screen.dart';
import '../about/about_screen.dart';
import '../settings/settings_screen.dart';

/// Main Screen with Proper Z-Order using Stack + Positioned
/// Drawer always on top, Navbar behind drawer when open
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _currentSet = 0; // 0 = first 4, 1 = next 4

  late AnimationController _shuffleController;
  late Animation<double> _shuffleAnimation;

  // Total 7 screens
  List<Widget> get _allScreens => [
    const HomeScreen(showBackButton: false),
    const DailyRoutineScreen(showBackButton: false),
    const SelfCareScreen(showBackButton: false),
    const ProfileViewScreen(showBackButton: false),
    const EmergencyScreen(showBackButton: false),
    const DoctorConnectScreen(showBackButton: false),
    const ReportsScreen(showBackButton: false),
  ];

  // Total 8 nav items
  final List<_NavItem> _allNavItems = [
    _NavItem(
      icon: Icons.home_rounded,
      color: NeumorphicColors.purple,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.calendar_today_rounded,
      color: NeumorphicColors.orange,
      label: 'Routine',
    ),
    _NavItem(
      icon: Icons.spa_rounded,
      color: NeumorphicColors.mint,
      label: 'Self Care',
    ),
    _NavItem(
      icon: Icons.person_rounded,
      color: NeumorphicColors.coral,
      label: 'Profile',
    ),
    _NavItem(
      icon: Icons.emergency_rounded,
      color: NeumorphicColors.coral,
      label: 'Emergency',
    ),
    _NavItem(
      icon: Icons.medical_services_rounded,
      color: NeumorphicColors.blue,
      label: 'Doctor',
    ),
    _NavItem(
      icon: Icons.analytics_rounded,
      color: NeumorphicColors.purple,
      label: 'Reports',
    ),
    _NavItem(
      icon: Icons.settings_rounded,
      color: NeumorphicColors.mint,
      label: 'Settings',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _shuffleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shuffleAnimation = CurvedAnimation(
      parent: _shuffleController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _shuffleController.dispose();
    super.dispose();
  }

  List<_NavItem> get _visibleNavItems {
    if (_currentSet == 0) {
      return _allNavItems.sublist(0, 4);
    } else {
      return _allNavItems.sublist(4, 8);
    }
  }

  List<int> get _visibleScreenIndices {
    if (_currentSet == 0) {
      return [0, 1, 2, 3];
    } else {
      return [4, 5, 6, 7];
    }
  }

  void _shuffleNavBar() {
    print(
      '🔀 [SHUFFLE] Shuffling navbar from Set $_currentSet to Set ${(_currentSet + 1) % 2}',
    );
    _shuffleController.forward().then((_) {
      setState(() {
        _currentSet = (_currentSet + 1) % 2;
        _currentIndex = 0;
      });
      print('✅ [SHUFFLE] Now showing Set $_currentSet');
      _shuffleController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final actualScreenIndex = _visibleScreenIndices[_currentIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    print('🏗️ [MAIN SCREEN] Building MainScreen');
    print('📍 [MAIN SCREEN] Current index: $_currentIndex');
    print('📍 [MAIN SCREEN] Actual screen index: $actualScreenIndex');
    print(
      '📍 [MAIN SCREEN] Background: ${NeumorphicColors.getBackground(context)}',
    );

    return Scaffold(
      backgroundColor: NeumorphicColors.getBackground(context),
      body: Stack(
        children: [
          // ═══════════════════════════════════════════════════════
          // LAYER 1: Main Content (Bottom) - Full Width with Top Padding
          // ═══════════════════════════════════════════════════════
          Padding(
            padding: EdgeInsets.only(
              top: actualScreenIndex == 0
                  ? MediaQuery.of(context).padding.top +
                        72 // App bar height for home
                  : 0, // No padding for other screens
            ),
            child: IndexedStack(
              index: actualScreenIndex,
              children: _allScreens,
            ),
          ),

          // ═══════════════════════════════════════════════════════
          // LAYER 1.5: Fixed App Bar (Only on Home Screen)
          // ═══════════════════════════════════════════════════════
          if (actualScreenIndex == 0) // Only show on Home screen
            Positioned(top: 0, left: 0, right: 0, child: _buildAppBar(context)),

          // ═══════════════════════════════════════════════════════
          // LAYER 2: Bottom Navigation Bar (Floating, Animated)
          // ═══════════════════════════════════════════════════════
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: AnimatedBuilder(
                animation: _shuffleAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 100 * _shuffleAnimation.value),
                    child: Opacity(
                      opacity: 1 - _shuffleAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: _buildNavBar(isDark),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar(bool isDark) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: NeumorphicColors.getCard(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.8),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                  spreadRadius: -5,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                  spreadRadius: -5,
                ),
              ],
      ),
      child: Row(
        children: [
          ...List.generate(
            _visibleNavItems.length,
            (index) =>
                _buildNavItem(item: _visibleNavItems[index], index: index),
          ),
          _buildShuffleButton(),
        ],
      ),
    );
  }

  Widget _buildNavItem({required _NavItem item, required int index}) {
    final isSelected = _currentIndex == index;
    final actualIndex = _visibleScreenIndices[index];
    final isSettings = actualIndex == 7;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isSettings) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? NeumorphicColors.getBackground(context)
                : NeumorphicColors.getCard(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.all(isSelected ? 8 : 6),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [item.color, item.color.withValues(alpha: 0.7)],
                      )
                    : null,
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: isSelected
                    ? Colors.white
                    : NeumorphicColors.getTextTertiary(context),
                size: isSelected ? 24 : 22,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShuffleButton() {
    return Expanded(
      child: GestureDetector(
        onTap: _shuffleNavBar,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [NeumorphicColors.purple, NeumorphicColors.blue],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Icon(Icons.shuffle_rounded, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: NeumorphicColors.getBackground(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // App Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: NeumorphicColors.purple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // App Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DEVRITI',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.getTextPrimary(context),
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'One stop for every mind',
                  style: TextStyle(
                    fontSize: 11,
                    color: NeumorphicColors.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // About Button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: NeumorphicColors.getCard(context),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.7),
                    blurRadius: 8,
                    offset: const Offset(-2, -2),
                  ),
                ],
              ),
              child: Icon(
                Icons.info_rounded,
                color: NeumorphicColors.getTextPrimary(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final Color color;
  final String label;

  _NavItem({required this.icon, required this.color, required this.label});
}
