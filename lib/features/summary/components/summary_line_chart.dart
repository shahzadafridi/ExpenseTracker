import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';
import '../../../utils/static_data.dart';
import '../../main/main_viewmodel.dart';

class SummaryLineChart extends StatefulWidget {
  final List<FlSpot> chartData;
  final TimeFilter selectedFilter;
  final void Function(String month) onMonthSelected;
  final void Function(String year) onYearSelected;

  const SummaryLineChart({
    super.key,
    required this.chartData,
    required this.selectedFilter,
    required this.onMonthSelected,
    required this.onYearSelected,
  });

  @override
  State<SummaryLineChart> createState() => _SummaryLineChartState();
}

class _SummaryLineChartState extends State<SummaryLineChart> {
  int touchedIndex = -1;
  String selectedMonth = 'Jan';
  String selectedYear = '2000';

  double get maxY => widget.chartData.isEmpty
      ? 1000
      : (widget.chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.2).ceilToDouble();

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
          child: LineChart(_buildChartData()),
        ),
      ),
    );
  }

  LineChartData _buildChartData() {
    return LineChartData(
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
            getTitlesWidget: _buildBottomTitle,
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      lineTouchData: _buildLineTouchData(),
      lineBarsData: [
        LineChartBarData(
          spots: widget.chartData,
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
    );
  }

  Widget _buildBottomTitle(double value, TitleMeta meta) {
    int index = value.toInt();
    final isMonth = widget.selectedFilter == TimeFilter.month;
    final labels = isMonth ? months : years;
    if (index >= 0 && index < labels.length) {
      final label = labels[index];
      final isSelected = isMonth
          ? selectedMonth == label
          : selectedYear == label;

      return GestureDetector(
        onTap: () {
          setState(() {
            if (isMonth) {
              selectedMonth = label;
              widget.onMonthSelected(label);
            } else {
              selectedYear = label;
              widget.onYearSelected(label);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: isSelected
                ? getBoldStyle(color: ColorManager.primary, fontSize: 14)
                : getRegularStyle(color: ColorManager.lightGrey, fontSize: 13),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  LineTouchData _buildLineTouchData() {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (_) => ColorManager.primary.withOpacity(0.1),
        tooltipBorder: BorderSide(
          color: ColorManager.primary.withOpacity(0.7),
          width: 1,
        ),
        getTooltipItems: (touchedSpots) => touchedSpots
            .map((spot) => LineTooltipItem(
          '\$${spot.y.toStringAsFixed(2)}',
          getSemiBoldStyle(color: ColorManager.primary, fontSize: 12),
        ))
            .toList(),
      ),
      getTouchedSpotIndicator: (barData, spotIndexes) {
        return spotIndexes.map((i) {
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
                  strokeColor: isTouched
                      ? ColorManager.primary.withOpacity(0.3)
                      : Colors.transparent,
                );
              },
            ),
          );
        }).toList();
      },
      touchCallback: (event, response) {
        setState(() {
          touchedIndex = (event.isInterestedForInteractions &&
              response?.lineBarSpots?.isNotEmpty == true)
              ? response!.lineBarSpots!.first.spotIndex
              : -1;
        });
      },
      handleBuiltInTouches: true,
    );
  }
}