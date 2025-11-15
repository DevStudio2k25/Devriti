import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import 'home_screen.dart';
import 'widgets/custom_drawer.dart';
import '../routine/daily_routine_screen.dart';
import '../self_care/view/self_care_screen.dart';
import '../profile/view/profile_view_screen.dart';
import '../emergency/view/emergency_view_screen.dart';
import '../doctor/view/doctor_connect_view_screen.dart';
import '../reports/reports_screen.dart';

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
  bool _isDrawerOpen = false;

  late AnimationController _shuffleController;
  late Animation<double> _shuffleAnimation;
  late AnimationController _navbarController;
  late Animation<double> _navbarAnimation;
  late AnimationController _drawerController;
  late Animation<double> _drawerSlideAnimation;

  // Total 7 screens
  List<Widget> get _allScreens => [
    HomeScreen(showBackButton: false, onMenuTap: _openDrawer),
    const DailyRoutineScreen(showBackButton: false),
    const SelfCareScreen(showBackButton: false),
    const ProfileViewScreen(showBackButton: false),
    const EmergencyScreen(showBackButton: false),
    const DoctorConnectScreen(showBackButton: false),
    const ReportsScreen(showBackButton: false),
  ];

  // Total 7 nav items
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

    _navbarController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: 1.0,
    );
    _navbarAnimation = CurvedAnimation(
      parent: _navbarController,
      curve: Curves.easeInOut,
    );

    _drawerController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _drawerSlideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _drawerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shuffleController.dispose();
    _navbarController.dispose();
    _drawerController.dispose();
    super.dispose();
  }

  List<_NavItem> get _visibleNavItems {
    if (_currentSet == 0) {
      return _allNavItems.sublist(0, 4);
    } else {
      return _allNavItems.sublist(4, 7);
    }
  }

  List<int> get _visibleScreenIndices {
    if (_currentSet == 0) {
      return [0, 1, 2, 3];
    } else {
      return [4, 5, 6];
    }
  }

  void _openDrawer() {
    setState(() => _isDrawerOpen = true);
    _drawerController.forward();
    _navbarController.reverse();
    print('🚪 [DRAWER] OPENED');
    print('⬇️ [NAVBAR] Hiding navbar');
  }

  void _closeDrawer() {
    _drawerController.reverse().then((_) {
      setState(() => _isDrawerOpen = false);
    });
    _navbarController.forward();
    print('🚪 [DRAWER] CLOSED');
    print('⬆️ [NAVBAR] Showing navbar');
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

    print('🏗️ [BUILD] MainScreen with proper Z-Order');
    print('📍 [Z-ORDER] Layer 1 (Bottom): Main Content');
    print('📍 [Z-ORDER] Layer 2: Bottom Navbar (Floating)');
    print('📍 [Z-ORDER] Layer 3: Scrim Overlay');
    print('📍 [Z-ORDER] Layer 4 (Top): Drawer/Sidebar');

    return Scaffold(
      backgroundColor: NeumorphicColors.getBackground(context),
      body: Stack(
        children: [
          // ═══════════════════════════════════════════════════════
          // LAYER 1: Main Content (Bottom) - Full Width with Top Padding
          // ═══════════════════════════════════════════════════════
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 72, // App bar height
            ),
            child: IndexedStack(
              index: actualScreenIndex,
              children: _allScreens,
            ),
          ),

          // ═══════════════════════════════════════════════════════
          // LAYER 1.5: Fixed App Bar (Always Visible)
          // ═══════════════════════════════════════════════════════
          Positioned(top: 0, left: 0, right: 0, child: _buildAppBar(context)),

          // ═══════════════════════════════════════════════════════
          // LAYER 2: Bottom Navigation Bar (Floating, Animated)
          // ═══════════════════════════════════════════════════════
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _navbarAnimation,
              builder: (context, child) {
                final offset = 100 * (1 - _navbarAnimation.value);
                return Transform.translate(
                  offset: Offset(0, offset),
                  child: Opacity(opacity: _navbarAnimation.value, child: child),
                );
              },
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
          ),

          // ═══════════════════════════════════════════════════════
          // LAYER 3: Scrim Overlay (When drawer open)
          // ═══════════════════════════════════════════════════════
          if (_isDrawerOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeDrawer,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 0.6,
                  child: Container(color: Colors.black),
                ),
              ),
            ),

          // ═══════════════════════════════════════════════════════
          // LAYER 4: Drawer/Sidebar (Top - Always above everything)
          // ═══════════════════════════════════════════════════════
          if (_isDrawerOpen || _drawerController.isAnimating)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width:
                  MediaQuery.of(context).size.width *
                  0.75, // 75% of screen width
              child: AnimatedBuilder(
                animation: _drawerSlideAnimation,
                builder: (context, child) {
                  final drawerWidth = MediaQuery.of(context).size.width * 0.75;
                  return Transform.translate(
                    offset: Offset(
                      _drawerSlideAnimation.value * drawerWidth,
                      0,
                    ),
                    child: child,
                  );
                },
                child: const CustomDrawer(),
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

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
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
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: item.color.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
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
            boxShadow: [
              BoxShadow(
                color: NeumorphicColors.purple.withValues(alpha: 0.4),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
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
          // Menu Button
          GestureDetector(
            onTap: _openDrawer,
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
                Icons.menu_rounded,
                color: NeumorphicColors.getTextPrimary(context),
              ),
            ),
          ),
          const SizedBox(width: 16),
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
                  'Your Mental Health Companion',
                  style: TextStyle(
                    fontSize: 11,
                    color: NeumorphicColors.getTextSecondary(context),
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

class _NavItem {
  final IconData icon;
  final Color color;
  final String label;

  _NavItem({required this.icon, required this.color, required this.label});
}
