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

    print('Transactions: ${txns.map((e) => e.toJson()).toList()}');

    Map<int, double> grouped = {};

    for (final txn in txns) {
      final date = DateTime.tryParse(txn.date);
      if (date != null) {
        final amount = double.tryParse(txn.amount) ?? 0;

        int x;
        switch (filter) {
          case TimeFilter.day:
            x = date.hour;
            break;
          case TimeFilter.week:
            x = date.weekday - 1;
            break;
          case TimeFilter.month:
            x = date.day - 1;
            break;
          case TimeFilter.year:
            x = date.month - 1;
            break;
        }

        grouped.update(x, (val) => val + amount, ifAbsent: () => amount);
      }
    }

    // Fill missing months/days/weeks with 0
    int length = switch (filter) {
      TimeFilter.day => 24,
      TimeFilter.week => 7,
      TimeFilter.month => 31,
      TimeFilter.year => 12,
    };

    List<FlSpot> spots = [];
    for (int i = 0; i < length; i++) {
      spots.add(FlSpot(i.toDouble(), grouped[i] ?? 0));
    }

    return spots;
  }

}
