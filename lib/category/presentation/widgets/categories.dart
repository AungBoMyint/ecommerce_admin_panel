import 'package:ecommerce_admin/category/bloc/category_bloc.dart';
import 'package:ecommerce_admin/category/presentation/widgets/category_form.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/pages/base_table_form_widget.dart';

import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/product/model/product.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTable extends StatefulWidget {
  const CategoryTable({super.key});

  @override
  State<CategoryTable> createState() => _CategoryTableState();
}

class _CategoryTableState extends BaseTableFormWidgetState<CategoryTable,
    CategoryBloc, CategoryState> {
  @override
  List<Widget> columnList() {
    final textTheme = getTextTheme();
    final isMTABLET = getSize().width < MTABLET;
    return [
      BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        return Checkbox(
          side: const BorderSide(width: 2, color: linkBTNColor),
          value: (state.selectedItems.length == state.items.length),
          onChanged: (v) {
            context.read<CategoryBloc>().add(SelectAllItemsEvent(
                  isSelectAll: v ?? false,
                ));
          },
        );
      }),
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
          "Description",
          style: textTheme.displaySmall,
        ),
      if (!isMTABLET)
        Text(
          "Count",
          style: textTheme.displaySmall,
        ),
    ];
  }

  @override
  void endOfFrame() {
    context.read<CategoryBloc>().add(FetchEvent());
  }

  @override
  Widget getForm() {
    return const CategoryForm();
  }

  @override
  Widget getSubmitButton() {
    return ElevatedButton(
        onPressed: () {
          context.read<CategoryBloc>().add(AddEvent());
        },
        child: Text(
          "Add new category",
          style: getTextTheme().bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ));
  }

  @override
  Widget getTitle() {
    final textTheme = getTextTheme();
    return Text(
      "Add new category",
      style: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  List<List<DataCell>> rowList(CategoryState state) {
    final textTheme = getTextTheme();
    final isMTABLET = getSize().width < MTABLET;
    return List.generate(state.items.length, (index) {
      final e = state.items[index];

      return [
        DataCell(
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return Checkbox(
                  side: const BorderSide(width: 2, color: linkBTNColor),
                  value: state.selectedItems.contains(e.id),
                  onChanged: (v) {
                    context.read<CategoryBloc>().add(
                          SelectItemEvent(
                            value: v ?? false,
                            id: e.id,
                          ),
                        );
                  });
            },
          ),
        ),
        DataCell(Image.asset(
          images[index % 3],
          width: 50,
          height: 50,
        )),
        DataCell(
          MainTitleText(
            e: e.name,
            onEdit: () => context.read<CoreBloc>().add(
                  ChangePageEvent(
                    page: PageType.editCategory,
                  ),
                ),
          ),
        ),
        if (!isMTABLET)
          DataCell(
            Text(
              "-",
              style: textTheme.headlineMedium,
            ),
          ),
        if (!isMTABLET)
          DataCell(
            Text(
              (index % 2 == 0) ? "10" : "5",
              style: textTheme.headlineMedium,
            ),
          ),
      ];
    });
  }

  @override
  Widget topActions() {
    return Column(
      children: [
        TopActions(
          searchHint: "Search categories",
          title: "Product categories",
          onSearch: () => context.read<CategoryBloc>().add(SearchEvent()),
        ),
      ],
    );
  }
}
