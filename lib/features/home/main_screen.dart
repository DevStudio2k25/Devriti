import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'home_screen.dart';
import 'widgets/custom_drawer.dart';
import '../mood/mood_tracker_screen.dart';
import '../chat/chat_screen.dart';
import '../self_care/self_care_screen.dart';
import '../profile/profile_view_screen.dart';

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
    _NavItem(icon: Icons.home_rounded, color: AppColors.primary),
    _NavItem(icon: Icons.mood_rounded, color: AppColors.lavender),
    _NavItem(icon: Icons.chat_bubble_rounded, color: AppColors.skyBlue),
    _NavItem(icon: Icons.spa_rounded, color: AppColors.pastelGreen),
    _NavItem(icon: Icons.person_rounded, color: AppColors.charcoal),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 65,
            child: Stack(
              children: [
                // Sliding indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: _getIndicatorPosition(context),
                  bottom: 0,
                  child: Container(
                    width: _getItemWidth(context),
                    height: 3,
                    decoration: BoxDecoration(
                      color: _navItems[_currentIndex].color,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3),
                      ),
                    ),
                  ),
                ),
                // Nav items
                Row(
                  children: List.generate(
                    _navItems.length,
                    (index) =>
                        _buildNavItem(item: _navItems[index], index: index),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getItemWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / _navItems.length;
  }

  double _getIndicatorPosition(BuildContext context) {
    return _getItemWidth(context) * _currentIndex;
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
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(8),
              child: Icon(
                item.icon,
                color: isSelected ? item.color : AppColors.textHint,
                size: isSelected ? 28 : 24,
              ),
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
