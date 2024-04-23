import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_searchable.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../product/model/product.dart';
import '../../../theme/colors.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
          const TopActions(
            searchHint: "Search reviews",
            title: "Product Reviews",
          ),
          Expanded(
            child: Row(
              children: [
                20.hSpace(),
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add new review",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        20.vSpace(),
                        //Review Form
                        const ReviewForm(),
                    
                        20.vSpace(),
                        //sumbit button
                        ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Add new review",
                              style: textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    )),
                Expanded(
                  flex: 8,
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
                              size: ColumnSize.S,
                              label: Checkbox(
                                side: const BorderSide(width: 2, color: linkBTNColor),
                                value: false,
                                onChanged: (v) {},
                              ),
                            ),
                            DataColumn2(
                              size: ColumnSize.M,
                              label: Text(
                                "Author",
                                style: textTheme.displaySmall,
                              ),
                            ),
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Rating",
                                style: textTheme.displaySmall,
                              ),
                            ),
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Review",
                                style: textTheme.displaySmall,
                              ),
                            ),
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Product",
                                style: textTheme.displaySmall,
                              ),
                            ),
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Submitted on",
                                style: textTheme.displaySmall,
                              ),
                            ),
                          ],
                          rows: List.generate(
                            products.length,
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
                                    e: products[index].name,
                                    onEdit: () => context.read<CoreBloc>().add(
                                          ChangePageEvent(
                                            page: PageType.editReview,
                                          ),
                                        ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (index % 2 == 0) ? "10" : "5",
                                    style: textTheme.headlineMedium,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    products[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.headlineMedium,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    products[index].category,
                                    style: textTheme.headlineMedium,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    (index % 2 == 0) ? "10" : "5",
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

class ReviewForm extends StatelessWidget {
  const ReviewForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelDropDownSearchable(
            textEditingController: TextEditingController(),
            label: "Author",
            hintText: "None",
            items: const [
              "Development",
              "IT",
              "Nurse",
            ],
          ),
          const Gap(15),
          SizedBox(
            height: 65,
            child: LayoutBuilder(builder: (context, constraints) {
              return ResponsiveRowColumn(
                layout: constraints.maxWidth > 420
                    ? ResponsiveRowColumnType.ROW
                    : ResponsiveRowColumnType.COLUMN,
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveRowColumnItem(
                    child: Text(
                      "Rating",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                      child: SizedBox(
                    width: 40,
                    height: 5,
                  )),
                  ResponsiveRowColumnItem(
                    child: Expanded(
                      child: TextFormField(
                        cursorHeight: 15,
                        decoration: const InputDecoration(
                          hintText: "3.5",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(
                            left: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  constraints.maxWidth > 420
                      ? ResponsiveRowColumnItem(
                          child: Expanded(
                          child: Container(),
                        ))
                      : ResponsiveRowColumnItem(child: 0.vSpace()),
                ],
              );
            }),
          ),
          const Gap(15),
          SizedBox(
            height: 65,
            child: LayoutBuilder(builder: (context, constraints) {
              return ResponsiveRowColumn(
                layout: constraints.maxWidth > 420
                    ? ResponsiveRowColumnType.ROW
                    : ResponsiveRowColumnType.COLUMN,
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveRowColumnItem(
                    child: Text(
                      "Review",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                      child: SizedBox(
                    width: 40,
                    height: 5,
                  )),
                  ResponsiveRowColumnItem(
                    child: Expanded(
                      child: TextFormField(
                        cursorHeight: 15,
                        decoration: const InputDecoration(
                          hintText: "A good product",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(
                            left: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  constraints.maxWidth > 420
                      ? ResponsiveRowColumnItem(
                          child: Expanded(
                          child: Container(),
                        ))
                      : ResponsiveRowColumnItem(child: 0.vSpace()),
                ],
              );
            }),
          ),
          const Gap(15),
          LabelDropDownSearchable(
            textEditingController: TextEditingController(),
            label: "Product",
            hintText: "None",
            items: const [
              "Development",
              "IT",
              "Nurse",
            ],
          ),
        ],
      );
    });
  }
}
