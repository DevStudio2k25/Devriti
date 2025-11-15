import 'package:flutter/material.dart';
import '../../core/widgets/neumorphic_widgets.dart';

class AddRoutineScreen extends StatefulWidget {
  const AddRoutineScreen({super.key});

  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedPeriod = 'Morning';
  IconData _selectedIcon = Icons.star_rounded;

  final List<String> _periods = ['Morning', 'Afternoon', 'Evening'];
  final List<IconData> _icons = [
    Icons.star_rounded,
    Icons.self_improvement_rounded,
    Icons.fitness_center_rounded,
    Icons.restaurant_rounded,
    Icons.menu_book_rounded,
    Icons.work_rounded,
    Icons.directions_walk_rounded,
    Icons.bedtime_rounded,
  ];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveRoutine() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save routine to database/state management
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Routine "${_titleController.text}" added!'),
          backgroundColor: NeumorphicColors.mint,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.getBackground(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          _buildAppBar(),

          // Form Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Title Input
                    _buildSectionTitle('Routine Title'),
                    const SizedBox(height: 12),
                    _buildTitleInput(),

                    const SizedBox(height: 24),

                    // Time Picker
                    _buildSectionTitle('Time'),
                    const SizedBox(height: 12),
                    _buildTimePicker(),

                    const SizedBox(height: 24),

                    // Period Selection
                    _buildSectionTitle('Period'),
                    const SizedBox(height: 12),
                    _buildPeriodSelector(),

                    const SizedBox(height: 24),

                    // Icon Selection
                    _buildSectionTitle('Choose Icon'),
                    const SizedBox(height: 12),
                    _buildIconSelector(),

                    const SizedBox(height: 40),

                    // Save Button
                    _buildSaveButton(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: NeumorphicColors.getBackground(context),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          icon: Icons.close_rounded,
          onTap: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16, right: 20),
        title: Text(
          'Add New Routine',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: NeumorphicColors.getTextPrimary(context),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: NeumorphicColors.getTextPrimary(context),
      ),
    );
  }

  Widget _buildTitleInput() {
    return NeumorphicCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        controller: _titleController,
        style: TextStyle(
          fontSize: 16,
          color: NeumorphicColors.getTextPrimary(context),
        ),
        decoration: InputDecoration(
          hintText: 'e.g., Morning Meditation',
          hintStyle: TextStyle(
            color: NeumorphicColors.getTextSecondary(context),
          ),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a title';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: _selectTime,
      child: NeumorphicCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: NeumorphicColors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.access_time_rounded,
                color: NeumorphicColors.blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              _selectedTime.format(context),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: NeumorphicColors.getTextPrimary(context),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: NeumorphicColors.getTextSecondary(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      children: _periods.map((period) {
        final isSelected = _selectedPeriod == period;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPeriod = period;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? NeumorphicColors.purple
                      : NeumorphicColors.getCard(context),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: NeumorphicColors.purple.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.7),
                            blurRadius: 10,
                            offset: const Offset(-5, -5),
                          ),
                        ],
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : NeumorphicColors.getTextPrimary(context),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIconSelector() {
    return NeumorphicCard(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: _icons.map((icon) {
          final isSelected = _selectedIcon == icon;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIcon = icon;
              });
            },
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? NeumorphicColors.mint.withValues(alpha: 0.3)
                    : NeumorphicColors.getBackground(context),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? NeumorphicColors.mint
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? NeumorphicColors.mint
                    : NeumorphicColors.getTextSecondary(context),
                size: 28,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _saveRoutine,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [NeumorphicColors.purple, NeumorphicColors.blue],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: NeumorphicColors.purple.withValues(alpha: 0.4),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Text(
          'Save Routine',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
