import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PaymentsWidget extends StatelessWidget {
  const PaymentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
          const TopActions(
            searchHint: "",
            title: "Payment Methods",
          ),
          Expanded(
            child: DataTable2(
              minWidth: 200,
              border: TableBorder.symmetric(
                  outside: BorderSide(color: Colors.grey.shade300)),
              columns: [
                DataColumn2(
                  size: ColumnSize.L,
                  label: Text(
                    "Method",
                    style: textTheme.displaySmall,
                  ),
                ),
                DataColumn2(
                  size: ColumnSize.L,
                  label: Text(
                    "Enabled",
                    style: textTheme.displaySmall,
                  ),
                ),
                DataColumn2(
                  size: ColumnSize.L,
                  label: Text(
                    "Description",
                    style: textTheme.displaySmall,
                  ),
                ),
              ],
              rows: [
                DataRow2(specificRowHeight: 100, cells: [
                  //method
                  DataCell(Row(
                    children: [
                      Text(
                        "2C2P Payment Gateway",
                        style: textTheme.bodyLarge,
                      ),
                      const Gap(10),
                      Image.asset(
                        AppImage.visa,
                        width: 35,
                        height: 35,
                      ),
                      const Gap(10),
                      Image.asset(
                        AppImage.master,
                        width: 35,
                        height: 35,
                      ),
                      const Gap(10),
                      Image.asset(
                        AppImage.american,
                        width: 35,
                        height: 35,
                      ),
                    ],
                  )),
                  //enabled
                  DataCell(
                    Switch(
                      value: true,
                      onChanged: (v) {},
                      activeColor: linkBTNColor,
                    ),
                  ),
                  //descriptoin
                  const DataCell(Text(
                      "	Payments made simple, with no monthly fees – designed exclusively for WooCommerce stores. Accept credit cards, debit cards, and other popular payment methods.")),
                ]),
                //Cach on delivery
                DataRow2(specificRowHeight: 100, cells: [
                  //method
                  DataCell(
                    Text(
                      "Cash on delivery",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  //enabled
                  DataCell(
                    Switch(
                      value: false,
                      onChanged: (v) {},
                      activeColor: linkBTNColor,
                    ),
                  ),
                  //descriptoin
                  const DataCell(Text(
                      "Have your customers pay with cash (or by other means) upon delivery.")),
                ])
              ],
            ).withMargin(20, 20),
          ),
        ],
      ),
    );
  }
}
