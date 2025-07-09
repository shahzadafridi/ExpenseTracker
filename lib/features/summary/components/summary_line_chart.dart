import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';

class SummaryLineChart extends StatefulWidget {
  final Map<String, List<FlSpot>> monthlyData;

  const SummaryLineChart({super.key, required this.monthlyData});

  @override
  State<SummaryLineChart> createState() => _SummaryLineChartState();
}

class _SummaryLineChartState extends State<SummaryLineChart> {
  int touchedIndex = -1;
  String selectedMonth = 'Jan';

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

  List<FlSpot> get currentData => widget.monthlyData[selectedMonth] ?? [];

  double get maxY {
    if (currentData.isEmpty) return 1000;
    double max = currentData.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    return (max * 1.2).ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width + 200,
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
                          return GestureDetector(
                            onTap: () {
                              // Handle click here
                              debugPrint('Clicked on: ${months[index]}');
                              setState(() {
                                selectedMonth = months[index]; // For example
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                months[index],
                                style: selectedMonth == months[index]
                                    ? getBoldStyle(
                                        color: ColorManager.primary,
                                        fontSize: 14)
                                    : getRegularStyle(
                                        color: ColorManager.lightGrey,
                                        fontSize: 13,
                                      ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (LineBarSpot touchedSpot) {
                      return ColorManager.primary.withOpacity(0.1);
                    },
                    tooltipBorder: BorderSide(
                        color: ColorManager.primary.withOpacity(0.7), width: 1),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '\$${spot.y.toStringAsFixed(2)}',
                          getSemiBoldStyle(
                              color: ColorManager.primary, fontSize: 12),
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
                              strokeWidth: isTouched ? 6 : 0,
                              // simulates ripple
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
                    spots: currentData,
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
          )),
    );
  }
}
