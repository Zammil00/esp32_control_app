import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 25),
              const FlSpot(1, 26),
              const FlSpot(2, 25),
              const FlSpot(3, 24),
              const FlSpot(4, 25),
              const FlSpot(5, 27),
            ],
            isCurved: true,
            color: Theme.of(context).primaryColorLight,
            barWidth: 5,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
