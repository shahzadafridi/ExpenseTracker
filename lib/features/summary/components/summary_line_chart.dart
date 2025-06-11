import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';

class SummaryLineChart extends StatefulWidget {
  final List<FlSpot> dataPoints;

  const SummaryLineChart({super.key, required this.dataPoints});

  @override
  State<SummaryLineChart> createState() => _SummaryLineChartState();
}

class _SummaryLineChartState extends State<SummaryLineChart> {
  int touchedIndex = -1;

  final List<String> months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  double get maxY {
    if (widget.dataPoints.isEmpty) return 1000;
    double max =
        widget.dataPoints.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    return (max * 1.2).ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: maxY,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, _) {
                      int index = value.toInt();
                      if (index >= 0 && index < months.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            months[index],
                            style: getRegularStyle(
                                color: ColorManager.lightGrey, fontSize: 12),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '${months[spot.x.toInt()]}: \$${spot.y.toStringAsFixed(2)}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      FlLine(
                        color: ColorManager.lightGrey,
                        strokeWidth: 1,
                        dashArray: [12, 8],
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          final isTouched = spot == barData.spots[index];
                          return FlDotCirclePainter(
                            radius: 4,
                            color: ColorManager.primary,
                            strokeWidth: isTouched ? 6 : 0, // simulates ripple
                            strokeColor: isTouched
                                ? ColorManager.primary.withOpacity(0.3)
                                : Colors.transparent,
                          );
                        },
                      ),
                    );
                  }).toList();
                },
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (!event.isInterestedForInteractions ||
                      response == null ||
                      response.lineBarSpots == null) {
                    setState(() => touchedIndex = -1);
                    return;
                  }
                  setState(() =>
                      touchedIndex = response.lineBarSpots!.first.spotIndex);
                },
                handleBuiltInTouches: true,
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: widget.dataPoints,
                  isCurved: true,
                  color: ColorManager.primary,
                  barWidth: 1,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: ColorManager.lineChartGradient,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
