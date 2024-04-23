import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../product/model/product.dart';
import '../../../theme/colors.dart';

class SettingShippingWidget extends StatefulWidget {
  const SettingShippingWidget({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  State<SettingShippingWidget> createState() => _SettingShippingWidgetState();
}

class _SettingShippingWidgetState extends State<SettingShippingWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
          const TopActions(
            searchHint: "Search shipping",
            title: "Product shipping",
          ),
          Expanded(
            child: Row(
              children: [
                20.hSpace(),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add new shipping",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    20.vSpace(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Zone Name",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Zone Name
                            SizedBox(
                              height: 35,
                              width: 250,
                              child: TextFormField(
                                cursorHeight: 15,
                                decoration: const InputDecoration(
                                  hintText: "Zone name",
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(20),
                            //Postal Code
                            SizedBox(
                              height: 35,
                              width: 250,
                              child: TextFormField(
                                cursorHeight: 15,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Postal code",
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                ),
                              ),
                            ),
                            //Add Shipping Method
                            const Gap(20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: LabelDropDown(
                                  onChanged: (v) {},
                                  value: null,
                                  label: "",
                                  items: const [
                                    "Flat Shipping",
                                    "Free Shipping",
                                    "Local Shipping",
                                  ],
                                  hintText: "Shipping Method"),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Gap(20),
                    //sumbit button
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Add new shipping",
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Gap(20),
                          const DropDownWidget(
                            hintText: "Actions",
                            items: ["Edit", "Delete"],
                            width: 100,
                          ),
                          const Gap(10),
                          LinkTextButton(
                            height: 35,
                            onPressed: () {},
                            text: "Apply",
                            fillColor: linkBTNColor,
                          ),
                        ],
                      ),
                      Expanded(
                        child: DataTable2(
                          minWidth: 200,
                          border: TableBorder.symmetric(
                              outside: BorderSide(color: Colors.grey.shade300)),
                          columns: [
                            DataColumn2(
                              fixedWidth: 80,
                              size: ColumnSize.S,
                              label: Checkbox(
                                side: const BorderSide(
                                    width: 2, color: linkBTNColor),
                                value: false,
                                onChanged: (v) {},
                              ),
                            ),
                            DataColumn2(
                              size: ColumnSize.M,
                              label: Text(
                                "Zone Name",
                                style: textTheme.displaySmall,
                              ),
                            ),
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Postal Code",
                                style: textTheme.displaySmall,
                              ),
                            ),
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Shipping Method",
                                style: textTheme.displaySmall,
                              ),
                            ),
                          ],
                          rows: List.generate(
                            widget.products.length,
                            (index) => DataRow2(
                              specificRowHeight: 100,
                              color: (index % 2 == 0)
                                  ? MaterialStateProperty.all(
                                      Colors.grey.shade100)
                                  : MaterialStateProperty.all(Colors.white),
                              cells: [
                                DataCell(
                                  Checkbox(
                                      side: const BorderSide(
                                          width: 2, color: linkBTNColor),
                                      value: false,
                                      onChanged: (v) {}),
                                ),
                                DataCell(
                                  MainTitleText(
                                    e: widget.products[index].name,
                                    onEdit: () => context.read<CoreBloc>().add(
                                          ChangePageEvent(
                                            page: PageType.editShipping,
                                          ),
                                        ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "-",
                                    style: textTheme.headlineMedium,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "",
                                    style: textTheme.headlineMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).withMargin(20, 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
