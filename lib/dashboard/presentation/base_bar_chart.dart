import 'package:ecommerce_admin/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BaseBarChart extends StatelessWidget {
  const BaseBarChart({
    super.key,
    required this.barWidth,
    required this.leftGetTitles,
    required this.bottomGetTitles,
    required this.title,
    required this.description,
    required this.data,
  });

  final double barWidth;
  final String title, description;
  final String Function(double)? leftGetTitles, bottomGetTitles;
  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const Color barBackgroundColor = Colors.white;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.displayMedium,
                ),
              ],
            ),
            Text(
              description,
              style: textTheme.displaySmall,
            ),
          ],
        ),
        const Gap(20),
        SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
                borderData: FlBorderData(show: false),
                alignment: BarChartAlignment.spaceBetween,
                gridData: FlGridData(
                    drawHorizontalLine: true, horizontalInterval: 30),
                titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                      reservedSize: 30,
                      getTextStyles: (value) =>
                          const TextStyle(color: linkBTNColor, fontSize: 12),
                      showTitles: true,
                      getTitles: leftGetTitles,
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) =>
                          const TextStyle(color: linkBTNColor, fontSize: 12),
                      getTitles: bottomGetTitles,
                    )),
                barGroups: List.generate(data.length, (index) {
                  final value = ((data[index].values.first as int) + 0.0);
                  return BarChartGroupData(x: index, barRods: [
                    BarChartRodData(
                        y: value,
                        colors: [linkBTNColor],
                        borderRadius: BorderRadius.circular(0),
                        width: barWidth,
                        backDrawRodData: BackgroundBarChartRodData(
                            y: 100 - value,
                            show: true,
                            colors: [
                              barBackgroundColor,
                            ])),
                  ]);
                })),
            swapAnimationDuration:
                const Duration(milliseconds: 150), // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
        ),
      ],
    );
  }
}
