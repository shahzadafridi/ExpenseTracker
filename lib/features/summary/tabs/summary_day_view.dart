import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/summary_line_chart.dart';

class SummaryDayView extends StatelessWidget {
  const SummaryDayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: Stack(
        children: [
          const SummaryLineChart(
            dataPoints: [
              FlSpot(0, 200),
              FlSpot(1, 500),
              FlSpot(2, 300),
              FlSpot(3, 700),
              FlSpot(4, 400),
              FlSpot(5, 800),
              FlSpot(6, 600),
              FlSpot(7, 1200),
              FlSpot(8, 900),
              FlSpot(9, 1100),
              FlSpot(10, 1000),
              FlSpot(11, 1300),
            ],
          ),
        ],
      ),
    );
  }
}
