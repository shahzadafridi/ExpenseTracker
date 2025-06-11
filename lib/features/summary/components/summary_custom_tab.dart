import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';
import '../tabs/summary_day_view.dart';
import '../tabs/summary_week_view.dart';
import '../tabs/summary_month_view.dart';
import '../tabs/summary_year_view.dart';

class SummaryCustomTab extends StatefulWidget {
  const SummaryCustomTab({super.key});

  @override
  State<SummaryCustomTab> createState() => _SummaryCustomTabState();
}

class _SummaryCustomTabState extends State<SummaryCustomTab> {
  final List<String> tabs = ["Day", "Week", "Month", "Year"];
  int selectedIndex = 0;

  Widget _buildTabContent() {
    switch (selectedIndex) {
      case 0:
        return const SummaryDayView();
      case 1:
        return const SummaryWeekView();
      case 2:
        return const SummaryMonthView();
      case 3:
        return const SummaryYearView();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom tab bar
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(tabs.length, (index) {
                final isSelected = index == selectedIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorManager.primary // your selected color
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tabs[index],
                      style: isSelected
                          ? getBoldStyle(color: Colors.white, fontSize: 14)
                          : getRegularStyle(
                              color: ColorManager.lightGrey, fontSize: 14),
                    ),
                  ),
                );
              }),
            )),
        const SizedBox(height: 8),
        // Tab content
        _buildTabContent(),
      ],
    );
  }
}
