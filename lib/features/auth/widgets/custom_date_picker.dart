import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/neumorphic_widgets.dart';

/// Neumorphic Custom Date Picker with Unique Design
class CustomDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final String label;
  final String hint;

  const CustomDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.label,
    required this.hint,
  });

  Future<void> _selectDate(BuildContext context) async {
    await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _NeumorphicDatePickerModal(
        initialDate: selectedDate ?? DateTime(2000),
        onDateSelected: onDateSelected,
      ),
    );
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: NeumorphicCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            NeumorphicContainer(
              width: 40,
              height: 40,
              child: const Icon(
                Icons.cake_outlined,
                color: NeumorphicColors.purple,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: NeumorphicColors.getTextTertiary(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  selectedDate != null
                      ? Row(
                          children: [
                            Text(
                              DateFormat('dd MMM yyyy').format(selectedDate!),
                              style: TextStyle(
                                fontSize: 15,
                                color: NeumorphicColors.getTextPrimary(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: NeumorphicColors.purple.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${_calculateAge(selectedDate!)} yrs',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: NeumorphicColors.purple,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          hint,
                          style: TextStyle(
                            fontSize: 15,
                            color: NeumorphicColors.getTextTertiary(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              color: NeumorphicColors.getTextTertiary(context),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

/// Neumorphic Date Picker Modal
class _NeumorphicDatePickerModal extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const _NeumorphicDatePickerModal({
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<_NeumorphicDatePickerModal> createState() =>
      _NeumorphicDatePickerModalState();
}

class _NeumorphicDatePickerModalState
    extends State<_NeumorphicDatePickerModal> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;
  late PageController _monthController;
  late PageController _yearController;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialDate.day;
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;
    _monthController = PageController(
      initialPage: selectedMonth - 1,
      viewportFraction: 0.33,
    );
    _yearController = PageController(
      initialPage: DateTime.now().year - selectedYear,
      viewportFraction: 0.33,
    );
  }

  Future<void> _showYearPicker(BuildContext context) async {
    final currentYear = DateTime.now().year;
    final years = List.generate(100, (index) => currentYear - index);

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: NeumorphicColors.getBackground(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Select Year',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: NeumorphicColors.getTextPrimary(context),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: years.length,
                  itemBuilder: (context, index) {
                    final year = years[index];
                    final isSelected = year == selectedYear;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedYear = year;
                          _yearController.jumpToPage(
                            DateTime.now().year - year,
                          );
                        });
                        Navigator.pop(context);
                      },
                      child: NeumorphicCard(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            year.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? NeumorphicColors.purple
                                  : NeumorphicColors.getTextPrimary(context),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final daysInMonth = _daysInMonth(selectedYear, selectedMonth);

    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: BoxDecoration(
        color: NeumorphicColors.getBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: NeumorphicColors.getTextTertiary(
                context,
              ).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Date of Birth',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: NeumorphicColors.getTextPrimary(context),
                  ),
                ),
                NeumorphicButton(
                  icon: Icons.close_rounded,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Year Selector - Shows 3 years at once
          SizedBox(
            height: 70,
            child: PageView.builder(
              controller: _yearController,
              padEnds: false,
              onPageChanged: (index) {
                setState(() {
                  selectedYear = DateTime.now().year - index;
                });
              },
              itemCount: 100,
              itemBuilder: (context, index) {
                final year = DateTime.now().year - index;
                final isSelected = year == selectedYear;
                return GestureDetector(
                  onTap: isSelected
                      ? () => _showYearPicker(context)
                      : () {
                          setState(() {
                            selectedYear = year;
                            _yearController.jumpToPage(index);
                          });
                        },
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? NeumorphicColors.getCard(context)
                            : null,
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
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          fontSize: isSelected ? 28 : 18,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? NeumorphicColors.purple
                              : NeumorphicColors.getTextTertiary(context),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Month Selector - Shows 3 months at once
          SizedBox(
            height: 60,
            child: PageView.builder(
              controller: _monthController,
              padEnds: false,
              onPageChanged: (index) {
                setState(() {
                  selectedMonth = index + 1;
                  if (selectedDay > _daysInMonth(selectedYear, selectedMonth)) {
                    selectedDay = _daysInMonth(selectedYear, selectedMonth);
                  }
                });
              },
              itemCount: 12,
              itemBuilder: (context, index) {
                final isSelected = index + 1 == selectedMonth;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMonth = index + 1;
                      _monthController.jumpToPage(index);
                      if (selectedDay >
                          _daysInMonth(selectedYear, selectedMonth)) {
                        selectedDay = _daysInMonth(selectedYear, selectedMonth);
                      }
                    });
                  },
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: isSelected
                          ? BoxDecoration(
                              color: NeumorphicColors.getCard(context),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
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
                              ],
                            )
                          : null,
                      child: Text(
                        months[index],
                        style: TextStyle(
                          fontSize: isSelected ? 20 : 16,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? NeumorphicColors.blue
                              : NeumorphicColors.getTextTertiary(context),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Day Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: daysInMonth,
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final isSelected = day == selectedDay;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = day;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [
                                  NeumorphicColors.purple,
                                  NeumorphicColors.blue,
                                ],
                              )
                            : null,
                        color: isSelected
                            ? null
                            : NeumorphicColors.getCard(context),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: NeumorphicColors.purple.withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ]
                            : isDark
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  offset: const Offset(2, 2),
                                  blurRadius: 6,
                                  spreadRadius: -1,
                                ),
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.03),
                                  offset: const Offset(-2, -2),
                                  blurRadius: 6,
                                  spreadRadius: -1,
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  offset: const Offset(2, 2),
                                  blurRadius: 6,
                                  spreadRadius: -1,
                                ),
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  offset: const Offset(-2, -2),
                                  blurRadius: 6,
                                  spreadRadius: -1,
                                ),
                              ],
                      ),
                      child: Center(
                        child: Text(
                          day.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : NeumorphicColors.getTextPrimary(context),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Confirm Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: NeumorphicButton(
                label: 'Confirm',
                onTap: () {
                  final selectedDate = DateTime(
                    selectedYear,
                    selectedMonth,
                    selectedDay,
                  );
                  widget.onDateSelected(selectedDate);
                  Navigator.pop(context, selectedDate);
                },
                gradient: const LinearGradient(
                  colors: [NeumorphicColors.purple, NeumorphicColors.blue],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
