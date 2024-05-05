import 'package:ecommerce_admin/dashboard/model/analysis_data.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({
    super.key,
    required this.e,
  });

  final AnalysisData e;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isxTABLET = size.width <= xTABLET;
    return SizedBox(
      width: isxTABLET ? 200 : size.width * 0.2,
      height: 150,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              e.iconData,
              size: 30,
              color: linkBTNColor,
            ),
            Text(
              e.name,
              style: textTheme.bodyLarge,
            ),
            Text(
              "${e.number}",
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ).withPadding(20, 8),
      ),
    );
  }
}
