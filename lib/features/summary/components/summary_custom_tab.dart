import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';
import '../../../model/TransactionModel.dart';
import '../../main/main_viewmodel.dart';
import 'summary_line_chart_view.dart';

class SummaryCustomTab extends StatefulWidget {
  final void Function(TimeFilter filter) onTabSelected;
  final void Function(String month) onMonthSelected;
  final void Function(String year) onYearSelected;
  final List<TransactionModel> filteredTransactions;

  const SummaryCustomTab({
    super.key,
    required this.onTabSelected,
    required this.filteredTransactions,
    required this.onMonthSelected,
    required this.onYearSelected,
  });

  @override
  State<SummaryCustomTab> createState() => _SummaryCustomTabState();
}

class _SummaryCustomTabState extends State<SummaryCustomTab> {
  final List<String> tabs = ["Day", "Week", "Month", "Year"];
  int selectedIndex = 0;

  final List<TimeFilter> filterValues = [
    TimeFilter.day,
    TimeFilter.week,
    TimeFilter.month,
    TimeFilter.year,
  ];

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
                    widget.onTabSelected(
                        filterValues[selectedIndex]); // 🔥 Call parent callback
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
        SummaryLineChartView(
          transactions: widget.filteredTransactions,
          filter: filterValues[selectedIndex],
          onMonthSelected: widget.onMonthSelected,
          onYearSelected: widget.onYearSelected,
        ),
      ],
    );
  }
}
