import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/loading_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/product/bloc/product_bloc.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/colors.dart';
import '../../../utils/app_image.dart';
import '../../model/product.dart';

List<Widget> columnList(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  return [
    BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Checkbox(
          side: const BorderSide(width: 2, color: linkBTNColor),
          value: state.selectedProducts.length == state.products.length,
          onChanged: (v) {
            context.read<ProductBloc>().add(
                  SelectAllProductsEvent(isSelectAll: v ?? false),
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
    Text(
      "Stock",
      style: textTheme.displaySmall,
    ),
    Text(
      "Price",
      style: textTheme.displaySmall,
    ),
    Text(
      "Categories",
      style: textTheme.displaySmall,
    ),
    Text(
      "Tags",
      style: textTheme.displaySmall,
    ),
    Text(
      "Date",
      style: textTheme.displaySmall,
    ),
  ];
}

List<List<DataCell>> rowList(BuildContext context, List<Product> products) =>
    List.generate(products.length, (index) {
      final e = products[index];
      final textTheme = Theme.of(context).textTheme;
      return [
        DataCell(
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            return Checkbox(
                side: const BorderSide(width: 2, color: linkBTNColor),
                value: state.selectedProducts.contains(e.id),
                onChanged: (v) {
                  context.read<ProductBloc>().add(
                        SelectProductEvent(
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
        DataCell(
          Text(
            e.price.toString(),
            style: textTheme.headlineMedium,
          ),
        ),
        DataCell(
          Text(e.category),
        ),
        const DataCell(
          Text(""),
        ),
        DataCell(
          Text(e.dateTime.toString()),
        ),
      ];
    });
List<List<DataCell>> getRowList(BuildContext context, List<Product> products) {
  final size = MediaQuery.of(context).size;
  var list = rowList(context, products);

  if (size.width < DESKTOP) {
    for (var cellList in list) {
      cellList.removeAt(1);
      cellList.removeAt(2);
      cellList.removeAt(4);
    }
    if (size.width < XSTABLET) {
      for (var cellList in list) {
        cellList.removeAt(3);
        cellList.removeAt(3);
      }
      if (size.width < SMALL_MOBILE) {
        for (var cellList in list) {
          cellList.removeAt(2);
        }
        return list;
      }
    }
    return list;
  }
  return rowList(context, products);
}

List<Widget> getColumnList(BuildContext context) {
  final size = MediaQuery.of(context).size;

  if (size.width < DESKTOP) {
    var list = columnList(context);
    list.removeAt(1);
    list.removeAt(2);
    list.removeAt(4);
    if (size.width < XSTABLET) {
      list.removeAt(3);
      list.removeAt(3);
      if (size.width < SMALL_MOBILE) {
        list.removeAt(2);
      }
    }
    return list;
  }
  return columnList(context);
}

class AllProducts extends StatefulWidget {
  const AllProducts({
    super.key,
  });

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchProductEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<ProductBloc>().add(FetchMoreProductEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log("Screen's Width: ${size.width}\nScreen'ts Height: ${size.height}");
    return Expanded(
      child: Column(
        children: [
          TopActions(
            searchHint: "Search products",
            title: "Products",
            onSearch: () => context.read<ProductBloc>().add(
                  SearchProductEvent(),
                ),
            onAddNew: () => context.read<CoreBloc>().add(
                  ChangePageEvent(
                    page: PageType.addProduct,
                  ),
                ),
          ),
          /* BaseTable(
            actionsWidget: getProductActionWidget(context),
            columnList: getColumnList(context),
            rowList: getRowList(context, widget.products),
          ), */
          Expanded(
            flex: 1,
            child: Column(
              children: [
                getProductActionWidget(context),
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                    final products = state.products;
                    if (!state.fetching && state.products.isNotEmpty) {
                      return DataTable2(
                        scrollController: _scrollController,
                        border: TableBorder.symmetric(
                            outside: BorderSide(color: Colors.grey.shade300)),
                        columns: List.generate(
                          getColumnList(context).length,
                          (index) => DataColumn2(
                            onSort: (v, b) => {},
                            size: (index == 0) ? ColumnSize.S : ColumnSize.L,
                            label: getColumnList(context)[index],
                          ),
                        ),
                        rows: List.generate(
                            getRowList(context, products).length,
                            (index) => DataRow2(
                                specificRowHeight: 85,
                                color: (index % 2 == 0)
                                    ? MaterialStateProperty.all(
                                        Colors.grey.shade100)
                                    : MaterialStateProperty.all(Colors.white),
                                cells: getRowList(context, products)[index])),
                      ).withMargin(20, 20);
                    }

                    return const LoadingWidget(); /*  const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ); */
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget getProductActionWidget(BuildContext context) {
  return Container(
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
              value: state.selectedAction.isEmpty ? null : state.selectedAction,
              onChanged: (value) {
                context
                    .read<ProductBloc>()
                    .add(ChangeDropDownActions(value: value ?? ""));
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
          onPressed: () =>
              context.read<ProductBloc>().add(FilterProductEvent()),
          fillColor: linkBTNColor,
        ),
      ],
    ),
  );
}
