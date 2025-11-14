import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';
import 'home_screen.dart';
import 'widgets/custom_drawer.dart';
import '../mood/view/mood_tracker_view_screen.dart';
import '../chat/view/chat_view_screen.dart';
import '../self_care/view/self_care_screen.dart';
import '../profile/view/profile_view_screen.dart';

/// Main Screen with Bottom Navigation (5 tabs)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MoodTrackerScreen(),
    const ChatScreen(),
    const SelfCareScreen(),
    const ProfileViewScreen(),
  ];

  final List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_rounded, color: NeumorphicColors.purple),
    _NavItem(icon: Icons.mood_rounded, color: NeumorphicColors.orange),
    _NavItem(icon: Icons.chat_bubble_rounded, color: NeumorphicColors.mint),
    _NavItem(icon: Icons.spa_rounded, color: NeumorphicColors.blue),
    _NavItem(icon: Icons.person_rounded, color: NeumorphicColors.coral),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: NeumorphicColors.card,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 20,
              offset: const Offset(0, -4),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.02),
              blurRadius: 20,
              offset: const Offset(0, -4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 70,
            child: Row(
              children: List.generate(
                _navItems.length,
                (index) => _buildNavItem(item: _navItems[index], index: index),
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
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? NeumorphicColors.background
                : NeumorphicColors.card,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(isSelected ? 8 : 6),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              item.color,
                              item.color.withValues(alpha: 0.7),
                            ],
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
                        : NeumorphicColors.textTertiary,
                    size: isSelected ? 24 : 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final Color color;

  _NavItem({required this.icon, required this.color});
}
