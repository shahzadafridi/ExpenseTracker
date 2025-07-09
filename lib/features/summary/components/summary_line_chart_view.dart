import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/dummy_data.dart';
import 'summary_line_chart.dart';

class SummaryLineChartView extends StatelessWidget {
  const SummaryLineChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SummaryLineChart(
            monthlyData: monthlyChartData,
          )
        ],
      ),
    );
  }
}
