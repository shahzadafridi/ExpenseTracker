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
  String selectedMonth = DateFormat('MMM').format(DateTime.now());
  String selectedYear = DateFormat('y').format(DateTime.now());

  double get maxY => widget.chartData.isEmpty
      ? 1000
      : (widget.chartData.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.2)
          .ceilToDouble();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: widget.chartData.isEmpty
              ? Center(
                  child: Text(
                    'no_data_available'.tr(),
                    style: getRegularStyle(
                        color: ColorManager.lightGrey, fontSize: 14),
                  ),
                )
              : LineChart(
                  _buildChartData(),
                  duration: const Duration(milliseconds: 250),
                ),
        ),
        if (widget.selectedFilter != TimeFilter.day)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: _buildFilterTiles(),
          ),
      ],
    );
  }

  LineChartData _buildChartData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: const FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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

  Widget _buildFilterTiles() {
    final isMonth = widget.selectedFilter == TimeFilter.month;
    final labels = widget.selectedFilter == TimeFilter.year
        ? years
        : widget.selectedFilter == TimeFilter.week
            ? weekDays
            : months;

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        itemBuilder: (context, index) {
          final label = labels[index];
          final isSelected = (isMonth && selectedMonth == label) ||
              (!isMonth && selectedYear == label);

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
            child: Container(
              height: 40,
              // Ensures consistent height
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              // Align text vertically & horizontally
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorManager.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: isSelected
                      ? getBoldStyle(color: ColorManager.primary, fontSize: 12)
                      : getRegularStyle(
                          color: ColorManager.lightGrey, fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
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
