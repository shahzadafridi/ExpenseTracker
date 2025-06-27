import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/TransactionModel.dart';
import '../../main/main_viewmodel.dart';
import 'summary_line_chart.dart';

class SummaryLineChartView extends StatelessWidget {
  final void Function(String month) onMonthSelected;
  final void Function(String year) onYearSelected;
  final List<TransactionModel> transactions;
  final TimeFilter filter;

  const SummaryLineChartView({
    super.key,
    required this.transactions,
    required this.filter,
    required this.onMonthSelected,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    final chartData = _convertToFlSpots(transactions);

    return SummaryLineChart(
      chartData: chartData,
      selectedFilter: filter,
      onMonthSelected: onMonthSelected,
      onYearSelected: onYearSelected,
    );
  }

  List<FlSpot> _convertToFlSpots(List<TransactionModel> txns) {
    Map<int, double> grouped = {};

    for (final txn in txns) {
      final date = DateTime.tryParse(txn.date);
      if (date != null) {
        final amount = double.tryParse(txn.amount) ?? 0;

        int x;
        switch (filter) {
          case TimeFilter.day:
            x = date.hour; // optional
            break;
          case TimeFilter.week:
            x = date.weekday - 1; // 0 = Monday, 6 = Sunday
            break;
          case TimeFilter.month:
            x = date.day - 1; // 0-based day index
            break;
          case TimeFilter.year:
            x = date.month - 1; // 0-based month index
            break;
        }

        grouped.update(x, (val) => val + amount, ifAbsent: () => amount);
      }
    }

    final sorted = grouped.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return sorted.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();
  }
}
