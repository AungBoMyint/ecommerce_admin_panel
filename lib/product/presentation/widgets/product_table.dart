import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/pages/base_table_form_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';

import 'package:ecommerce_admin/product/bloc/product_bloc.dart';
import 'package:ecommerce_admin/product/model/product.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductTable extends StatefulWidget {
  const ProductTable({super.key});

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState
    extends BaseTableFormWidgetState<ProductTable, ProductBloc, ProductState> {
  @override
  List<Widget> columnList() {
    final width = getSize().width;
    final textTheme = getTheme().textTheme;
    final isMTABLET = width < mTABLET;
    final isMDESKTOP = width < MDESKTOP;
    return [
      BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.length == state.items.length,
            onChanged: (v) {
              context.read<ProductBloc>().add(
                    SelectAllItemsEvent(isSelectAll: v ?? false),
                  );
            },
          );
        },
      ),
      Image.asset(
        AppImage.picture,
        width: 40,
        height: 25,
        fit: BoxFit.contain,
      ).withMargin(0, 20),
      Text(
        "Name",
        style: textTheme.displaySmall,
      ),
      if (!isMTABLET)
        Text(
          "Stock",
          style: textTheme.displaySmall,
        ),
      if (!isMTABLET)
        Text(
          "Price",
          style: textTheme.displaySmall,
        ),
      if (!isMTABLET)
        Text(
          "Categories",
          style: textTheme.displaySmall,
        ),
      if (!isMDESKTOP)
        Text(
          "Tags",
          style: textTheme.displaySmall,
        ),
      if (!isMDESKTOP)
        Text(
          "Date",
          style: textTheme.displaySmall,
        ),
    ];
  }

  @override
  void endOfFrame() {
    context.read<ProductBloc>().add(FetchEvent());
  }

  @override
  Widget getForm() {
    return Container();
  }

  @override
  bool hasForm() {
    return false;
  }

  @override
  Widget getSubmitButton() {
    return Container();
  }

  @override
  Widget getTitle() {
    return const Gap(0);
  }

  @override
  List<List<DataCell>> rowList(ProductState state) {
    final width = getSize().width;
    return List.generate(state.items.length, (index) {
      final e = state.items[index];
      final textTheme = Theme.of(context).textTheme;
      final isMTABLET = width < mTABLET;
      final isMDESKTOP = width < MDESKTOP;
      return [
        DataCell(
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            return Checkbox(
                side: const BorderSide(width: 2, color: linkBTNColor),
                value: state.selectedItems.contains(e.id),
                onChanged: (v) {
                  context.read<ProductBloc>().add(
                        SelectItemEvent(
                          value: v ?? false,
                          id: e.id,
                        ),
                      );
                });
          }),
        ),
        DataCell(Image.asset(
          images[index % 3],
          width: 50,
          height: 50,
        )),
        DataCell(
          MainTitleText(
            e: e.name,
          ),
        ),
        if (!isMTABLET)
          DataCell(LinkTextButton(
            height: 30,
            onPressed: () {},
            text: e.stock,
            color: e.stock == "In stock" ? Colors.green : Colors.red,
          )
              /*  Text(
                    e.stock,
                    style: textTheme.headlineMedium,
                  ), */
              ),
        if (!isMTABLET)
          DataCell(
            Text(
              e.price.toString(),
              style: textTheme.headlineMedium,
            ),
          ),
        if (!isMTABLET)
          DataCell(
            Text(e.category),
          ),
        if (!isMDESKTOP)
          const DataCell(
            Text(""),
          ),
        if (!isMDESKTOP)
          DataCell(
            Text(e.dateTime.toString()),
          ),
      ];
    });
  }

  @override
  Widget topActions() {
    return Column(
      children: [
        TopActions(
          searchHint: "Search products",
          title: "Products",
          onSearch: () => context.read<ProductBloc>().add(
                SearchEvent(),
              ),
          onAddNew: () => context.read<CoreBloc>().add(
                ChangePageEvent(
                  page: PageType.addProduct,
                ),
              ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Wrap(
            runSpacing: 10,
            children: [
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return DropDownWidget(
                    hintText: "Actions",
                    items: const ["Edit", "Delete"],
                    width: 100,
                    value: state.selectedAction,
                    onChanged: (value) {
                      context
                          .read<ProductBloc>()
                          .add(ChangeActionsEvent(value: value ?? ""));
                    },
                  );
                },
              ),
              10.hSpace(),
              LinkTextButton(
                width: 100,
                height: 35,
                onPressed: () {
                  context.read<ProductBloc>().add(ActionApplyEvent());
                },
                text: "Apply",
                fillColor: linkBTNColor,
              ),
              40.hSpace(),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return DropDownWidget(
                    onChanged: (v) => context
                        .read<ProductBloc>()
                        .add(ChangeDropDownCategory(value: v ?? "")),
                    value: state.selectedCategory.isEmpty
                        ? null
                        : state.selectedCategory,
                    hintText: "Select a category",
                    items: const ["IT", "Health Care", "Illustration"],
                  );
                },
              ),
              20.hSpace(),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return DropDownWidget(
                    width: 180,
                    hintText: "Filter by product type",
                    items: const ["Simple product", "Variable product"],
                    value: state.produtType.isEmpty ? null : state.produtType,
                    onChanged: (v) => context.read<ProductBloc>().add(
                          ChangeDropDownProductType(value: v ?? ""),
                        ),
                  );
                },
              ),
              20.hSpace(),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                return DropDownWidget(
                  width: 180,
                  hintText: "Filter by stock status",
                  items: const ["In stock", "Out of stock"],
                  value: state.stockStatus.isEmpty ? null : state.stockStatus,
                  onChanged: (v) => context.read<ProductBloc>().add(
                        ChangeDropDownStockStatus(value: v ?? ""),
                      ),
                );
              }),
              10.hSpace(),
              LinkTextButton(
                height: 35,
                width: 100,
                text: "Filter",
                onPressed: () => context.read<ProductBloc>().add(FilterEvent()),
                fillColor: linkBTNColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
