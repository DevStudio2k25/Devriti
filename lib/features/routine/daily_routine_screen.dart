import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';

class DailyRoutineScreen extends StatefulWidget {
  final bool showBackButton;

  const DailyRoutineScreen({
    super.key,
    this.showBackButton = false, // Default: no back button (from navbar)
  });

  @override
  State<DailyRoutineScreen> createState() => _DailyRoutineScreenState();
}

class _DailyRoutineScreenState extends State<DailyRoutineScreen> {
  // Mock data for routines
  final List<RoutineItem> _morningRoutines = [
    RoutineItem(
      title: 'Wake Up',
      time: '6:00 AM',
      icon: Icons.wb_sunny_rounded,
      isCompleted: true,
    ),
    RoutineItem(
      title: 'Meditation',
      time: '6:30 AM',
      icon: Icons.self_improvement_rounded,
      isCompleted: true,
    ),
    RoutineItem(
      title: 'Exercise',
      time: '7:00 AM',
      icon: Icons.fitness_center_rounded,
      isCompleted: false,
    ),
    RoutineItem(
      title: 'Breakfast',
      time: '8:00 AM',
      icon: Icons.restaurant_rounded,
      isCompleted: false,
    ),
  ];

  final List<RoutineItem> _afternoonRoutines = [
    RoutineItem(
      title: 'Work/Study',
      time: '9:00 AM',
      icon: Icons.work_rounded,
      isCompleted: false,
    ),
    RoutineItem(
      title: 'Lunch Break',
      time: '1:00 PM',
      icon: Icons.lunch_dining_rounded,
      isCompleted: false,
    ),
    RoutineItem(
      title: 'Short Walk',
      time: '3:00 PM',
      icon: Icons.directions_walk_rounded,
      isCompleted: false,
    ),
  ];

  final List<RoutineItem> _eveningRoutines = [
    RoutineItem(
      title: 'Dinner',
      time: '7:00 PM',
      icon: Icons.dinner_dining_rounded,
      isCompleted: false,
    ),
    RoutineItem(
      title: 'Reading',
      time: '8:30 PM',
      icon: Icons.menu_book_rounded,
      isCompleted: false,
    ),
    RoutineItem(
      title: 'Sleep',
      time: '10:00 PM',
      icon: Icons.bedtime_rounded,
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.getBackground(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          _buildAppBar(),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Stats Card
                _buildStatsCard(),

                const SizedBox(height: 24),

                // Morning Routines
                _buildRoutineSection(
                  'Morning',
                  Icons.wb_sunny_rounded,
                  NeumorphicColors.orange,
                  _morningRoutines,
                ),

                const SizedBox(height: 20),

                // Afternoon Routines
                _buildRoutineSection(
                  'Afternoon',
                  Icons.wb_cloudy_rounded,
                  NeumorphicColors.blue,
                  _afternoonRoutines,
                ),

                const SizedBox(height: 20),

                // Evening Routines
                _buildRoutineSection(
                  'Evening',
                  Icons.nightlight_rounded,
                  NeumorphicColors.purple,
                  _eveningRoutines,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          // Bottom spacing for navbar
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  // Neumorphic AppBar matching other pages
  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
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
          : const SizedBox.shrink(), // No back button from navbar
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeumorphicButton(
            icon: Icons.add_rounded,
            onTap: () {
              Navigator.pushNamed(context, '/add-routine');
            },
          ),
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final expandRatio =
              (constraints.maxHeight - kToolbarHeight) / (120 - kToolbarHeight);
          final leftPadding = 20.0;

          return FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: EdgeInsets.only(
              left: leftPadding,
              bottom: 16,
              right: 20,
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (expandRatio > 0.5)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: NeumorphicContainer(
                      width: 36,
                      height: 36,
                      isCircle: true,
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: NeumorphicColors.purple,
                        size: 18,
                      ),
                    ),
                  ),
                Flexible(
                  child: Text(
                    'Daily Routine',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: NeumorphicColors.getTextPrimary(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeumorphicCard(
        child: Row(
          children: [
            Expanded(
              child: _buildStatItem(
                '2/11',
                'Completed',
                NeumorphicColors.mint,
                Icons.check_circle_rounded,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: NeumorphicColors.getTextTertiary(
                context,
              ).withValues(alpha: 0.3),
            ),
            Expanded(
              child: _buildStatItem(
                '18%',
                'Progress',
                NeumorphicColors.blue,
                Icons.trending_up_rounded,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: NeumorphicColors.getTextTertiary(
                context,
              ).withValues(alpha: 0.3),
            ),
            Expanded(
              child: _buildStatItem(
                '9',
                'Remaining',
                NeumorphicColors.orange,
                Icons.pending_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String value,
    String label,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: NeumorphicColors.getTextPrimary(context),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: NeumorphicColors.getTextSecondary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildRoutineSection(
    String title,
    IconData icon,
    Color color,
    List<RoutineItem> items,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.getTextPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Routine Items
          ...items.map((item) => _buildRoutineItem(item)),
        ],
      ),
    );
  }

  Widget _buildRoutineItem(RoutineItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: NeumorphicCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon
            NeumorphicContainer(
              width: 50,
              height: 50,
              isCircle: true,
              child: Icon(
                item.icon,
                color: item.isCompleted
                    ? NeumorphicColors.mint
                    : NeumorphicColors.getTextSecondary(context),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Title and Time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: NeumorphicColors.getTextPrimary(context),
                      decoration: item.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.time,
                    style: TextStyle(
                      fontSize: 13,
                      color: NeumorphicColors.getTextSecondary(context),
                    ),
                  ),
                ],
              ),
            ),

            // Checkbox
            GestureDetector(
              onTap: () {
                setState(() {
                  item.isCompleted = !item.isCompleted;
                });
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.isCompleted
                      ? NeumorphicColors.mint
                      : Colors.transparent,
                  border: Border.all(
                    color: item.isCompleted
                        ? NeumorphicColors.mint
                        : NeumorphicColors.getTextTertiary(context),
                    width: 2,
                  ),
                ),
                child: item.isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Removed to keep navbar floating
  // Widget _buildAddButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Add new routine (UI only)'),
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //     },
  //     child: Container(
  //       width: 60,
  //       height: 60,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         gradient: const LinearGradient(
  //           colors: [NeumorphicColors.purple, NeumorphicColors.blue],
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: NeumorphicColors.purple.withValues(alpha: 0.4),
  //             blurRadius: 20,
  //             spreadRadius: 2,
  //           ),
  //         ],
  //       ),
  //       child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
  //     ),
  //   );
  // }
}

// Mock data model
class RoutineItem {
  final String title;
  final String time;
  final IconData icon;
  bool isCompleted;

  RoutineItem({
    required this.title,
    required this.time,
    required this.icon,
    this.isCompleted = false,
  });
}
