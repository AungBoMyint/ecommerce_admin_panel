import 'package:ecommerce_admin/core/constant.dart';
import 'package:ecommerce_admin/dashboard/model/analysis_data.dart';
import 'package:ecommerce_admin/dashboard/model/pie_item.dart';
import 'package:ecommerce_admin/dashboard/presentation/analysis_card.dart';
import 'package:ecommerce_admin/dashboard/presentation/base_bar_chart.dart';
import 'package:ecommerce_admin/dashboard/presentation/base_pie_chart.dart';
import 'package:ecommerce_admin/dashboard/presentation/favourite_flavour.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isMTABLET = size.width <= MTABLET;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              "Dashboard",
              style: textTheme.displayLarge,
            ),
            const Gap(10),
            Text(
              "Store Data Analysis",
              style: textTheme.bodyMedium,
            ),
            const Gap(20),
            //row
            ResponsiveRowColumn(
              layout: isMTABLET
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //left
                ResponsiveRowColumnItem(
                  child: SizedBox(
                    width: isMTABLET ? size.width * 0.95 : size.width * 0.68,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //analysis card
                        Wrap(
                          children: analysisCards.map((e) {
                            return AnalysisCard(
                              e: e,
                            );
                          }).toList(),
                        ),
                        Gap(50),
                        //Daily Bar Chart
                        BaseBarChart(
                          barWidth: 20,
                          leftGetTitles: (value) {
                            if ((value % 30) == 0) {
                              return "${(value / 30) * 30}";
                            }
                            return "";
                          },
                          bottomGetTitles: (value) {
                            if (value >= 0 && value <= 30) {
                              return "${value + 1}";
                            }
                            return "";
                          },
                          title: 'Orders for April (Daily Orders)',
                          description: 'Past 30 DAYS',
                          data: dailyData,
                        ),
                        const Gap(50),
                        //Monthly Bar Chart
                        BaseBarChart(
                          barWidth: 50,
                          leftGetTitles: (value) {
                            if ((value % 30) == 0) {
                              return "${(value / 30) * 30}k";
                            }
                            return "";
                          },
                          bottomGetTitles: (value) {
                            if (value == 0) {
                              return 'JAN';
                            } else if (value == 1) {
                              return 'FEB';
                            } else if (value == 2) {
                              return 'MAR';
                            } else if (value == 3) {
                              return 'APR';
                            } else if (value == 4) {
                              return 'MAY';
                            } else if (value == 5) {
                              return 'JUN';
                            } else if (value == 6) {
                              return 'JUL';
                            } else if (value == 7) {
                              return 'AUG';
                            } else if (value == 8) {
                              return 'SEP';
                            } else if (value == 9) {
                              return 'OCT';
                            } else if (value == 10) {
                              return 'NOV';
                            } else if (value == 11) {
                              return 'DEC';
                            } else {
                              return '';
                            }
                          },
                          title: 'Orders for 2024 (Monthly Orders)',
                          description: "",
                          data: monthlyData,
                        ),
                        Gap(50),
                        //Favourite
                        Text(
                          'Favorite Flavors',
                          style: textTheme.displayMedium,
                        ),
                        Text(
                          'Collecting data on the most popular bubble tea flavors among customers.',
                          style: textTheme.displayMedium,
                        ),
                        Gap(20),
                        Container(child: const FavoriteFlavorsTable()),
                      ],
                    ),
                  ),
                ),
                const ResponsiveRowColumnItem(child: Gap(50)),
                //right
                ResponsiveRowColumnItem(
                  child: SizedBox(
                    width: isMTABLET ? size.width * 0.95 : size.width * 0.15,
                    child: ResponsiveRowColumn(
                      layout: isMTABLET
                          ? ResponsiveRowColumnType.ROW
                          : ResponsiveRowColumnType.COLUMN,
                      children: [
                        //AGE RANGE
                        ResponsiveRowColumnItem(
                            child: BasePieChart(
                          centerText: "Age Range",
                          items: [
                            PieItem(
                              value: 35,
                              color: Colors.black,
                            ),
                            PieItem(
                              value: 35,
                              color: linkBTNColor,
                            ),
                            PieItem(
                              value: 20,
                              color: Colors.white,
                            ),
                            PieItem(
                              value: 10,
                              color: const Color(0xffe17055),
                            ),
                          ],
                        )),
                        const ResponsiveRowColumnItem(child: Gap(40)),
                        //GENDER
                        ResponsiveRowColumnItem(
                            child:
                                BasePieChart(centerText: "Age Range", items: [
                          PieItem(value: 50, color: Colors.white),
                          PieItem(value: 50, color: linkBTNColor),
                        ])),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
