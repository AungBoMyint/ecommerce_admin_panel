import 'package:ecommerce_admin/dashboard/model/pie_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BasePieChart extends StatelessWidget {
  const BasePieChart({
    super.key,
    this.height,
    this.width,
    required this.centerText,
    required this.items,
  });

  final String centerText;
  final double? height;
  final double? width;
  final List<PieItem> items;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    final centerTextStyle = textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );
    return SizedBox(
      height: height ?? 180,
      width: width ?? 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            centerText,
            style: centerTextStyle,
          ),
          PieChart(
            swapAnimationDuration: const Duration(microseconds: 750),
            swapAnimationCurve: Curves.easeInOutQuint,
            PieChartData(
              sections: items
                  .map(
                    (e) => PieChartSectionData(
                      value: e.value,
                      color: e.color,
                      titleStyle: titleStyle?.copyWith(
                        color: e.color == Colors.white
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
