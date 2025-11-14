import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import 'home_screen.dart';
import 'widgets/custom_drawer.dart';
import '../mood/view/mood_tracker_view_screen.dart';
import '../self_care/view/self_care_screen.dart';
import '../profile/view/profile_view_screen.dart';
import '../emergency/view/emergency_view_screen.dart';
import '../doctor/view/doctor_connect_view_screen.dart';
import '../reports/reports_screen.dart';

/// Main Screen with Unique Floating Bottom Navigation (8 pages, 4 visible)
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
  late AnimationController _navbarController;
  late Animation<double> _navbarAnimation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Total 7 screens - Set 1: 4 pages | Set 2: 3 pages
  final List<Widget> _allScreens = [
    const HomeScreen(),
    const MoodTrackerScreen(),
    const SelfCareScreen(),
    const ProfileViewScreen(),
    const EmergencyScreen(),
    const DoctorConnectScreen(),
    const ReportsScreen(),
  ];

  // Total 7 nav items - Set 1: 4 pages, Set 2: 3 pages + shuffle button
  final List<_NavItem> _allNavItems = [
    _NavItem(
      icon: Icons.home_rounded,
      color: NeumorphicColors.purple,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.mood_rounded,
      color: NeumorphicColors.orange,
      label: 'Mood',
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
      value: 1.0, // Start visible
    );
    _navbarAnimation = CurvedAnimation(
      parent: _navbarController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _shuffleController.dispose();
    _navbarController.dispose();
    super.dispose();
  }

  // Get visible nav items based on current set (Set 1: 4 pages, Set 2: 3 pages)
  List<_NavItem> get _visibleNavItems {
    if (_currentSet == 0) {
      return _allNavItems.sublist(0, 4); // First 4 pages
    } else {
      return _allNavItems.sublist(4, 7); // Next 3 pages
    }
  }

  // Get visible screen indices based on current set
  List<int> get _visibleScreenIndices {
    if (_currentSet == 0) {
      return [0, 1, 2, 3]; // First 4 screens
    } else {
      return [4, 5, 6]; // Next 3 screens
    }
  }

  void _shuffleNavBar() {
    _shuffleController.forward().then((_) {
      setState(() {
        _currentSet = (_currentSet + 1) % 2; // Toggle between set 0 and 1
        _currentIndex = 0;
      });
      _shuffleController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final actualScreenIndex = _visibleScreenIndices[_currentIndex];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: NeumorphicColors.getBackground(context),
      extendBody: true,
      drawerScrimColor: Colors.black.withValues(alpha: 0.6),
      drawerEdgeDragWidth: 0,
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          _navbarController.reverse();
        } else {
          _navbarController.forward();
        }
      },
      drawer: const CustomDrawer(),
      body: IndexedStack(index: actualScreenIndex, children: _allScreens),
      bottomNavigationBar: AnimatedBuilder(
        animation: _navbarAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 100 * (1 - _navbarAnimation.value)),
            child: Opacity(opacity: _navbarAnimation.value, child: child),
          );
        },
        child: Container(
          color: Colors.transparent,
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
              child: Container(
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
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.02),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                            spreadRadius: -2,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                            spreadRadius: -5,
                          ),
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.9),
                            blurRadius: 20,
                            offset: const Offset(0, -4),
                            spreadRadius: -2,
                          ),
                        ],
                ),
                child: Row(
                  children: [
                    // Dynamic pages (4 in set 1, 3 in set 2)
                    ...List.generate(
                      _visibleNavItems.length,
                      (index) => _buildNavItem(
                        item: _visibleNavItems[index],
                        index: index,
                      ),
                    ),
                    // Last position: Shuffle button
                    _buildShuffleButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
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
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.6),
                      offset: const Offset(3, 3),
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.03),
                      offset: const Offset(-3, -3),
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                  ]
                : [],
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
}

class _NavItem {
  final IconData icon;
  final Color color;
  final String label;

  _NavItem({required this.icon, required this.color, required this.label});
}
