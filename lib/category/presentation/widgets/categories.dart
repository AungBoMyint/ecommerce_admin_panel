import 'package:ecommerce_admin/category/bloc/category_bloc.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/core/presentation/widgets/loading_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/table/base_table_widget.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/model/product.dart';
import '../../../theme/colors.dart';
import '../../../utils/app_image.dart';
import 'category_form.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
    /*   required this.products, */
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(FetchCategoryEvent());
    super.initState();
  }

  /* final List<Product> products; */
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
          TopActions(
            searchHint: "Search categories",
            title: "Product categories",
            onSearch: () =>
                context.read<CategoryBloc>().add(SearchCategoryEvent()),
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
                        "Add new category",
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      20.vSpace(),
                      //Category Form
                      const CategoryForm(),
                      20.vSpace(),
                      //sumbit button
                      ElevatedButton(
                          onPressed: () {
                            context
                                .read<CategoryBloc>()
                                .add(AddCategoryEvent());
                          },
                          child: Text(
                            "Add new category",
                            style: textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    switch (state.actionStatus) {
                      case ActionStatus.fetching:
                        return const Expanded(child: LoadingWidget());
                      case ActionStatus.searching:
                        return const Expanded(child: LoadingWidget());
                      default:
                        return BaseTable(
                          flex: 2,
                          actionsWidget: Row(
                            children: [
                              20.hSpace(),
                              DropDownWidget(
                                hintText: "Actions",
                                items: const ["Edit", "Delete"],
                                width: 100,
                                value: state.selectedAction,
                                onChanged: (v) => context
                                    .read<CategoryBloc>()
                                    .add(ChangeDropDownActions(value: v ?? "")),
                              ),
                              10.hSpace(),
                              LinkTextButton(
                                height: 35,
                                onPressed: () {
                                  context
                                      .read<CategoryBloc>()
                                      .add(ActionApplyEvent());
                                },
                                text: "Apply",
                                fillColor: linkBTNColor,
                              ),
                            ],
                          ),
                          columnList: [
                            Checkbox(
                              side: const BorderSide(
                                  width: 2, color: linkBTNColor),
                              value: (state.selectedCategories.length ==
                                  state.categories.length),
                              onChanged: (v) {
                                context
                                    .read<CategoryBloc>()
                                    .add(SelectAllCategoriesEvent(
                                      isSelectAll: v ?? false,
                                    ));
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
                              "Description",
                              style: textTheme.displaySmall,
                            ),
                            Text(
                              "Count",
                              style: textTheme.displaySmall,
                            ),
                          ],
                          rowList:
                              List.generate(state.categories.length, (index) {
                            final e = state.categories[index];
                            return [
                              DataCell(
                                BlocBuilder<CategoryBloc, CategoryState>(
                                  builder: (context, state) {
                                    return Checkbox(
                                        side: const BorderSide(
                                            width: 2, color: linkBTNColor),
                                        value: state.selectedCategories
                                            .contains(e.id),
                                        onChanged: (v) {
                                          context.read<CategoryBloc>().add(
                                                SelectCategoryEvent(
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
                              DataCell(
                                Text(
                                  "-",
                                  style: textTheme.headlineMedium,
                                ),
                              ),
                              DataCell(
                                Text(
                                  (index % 2 == 0) ? "10" : "5",
                                  style: textTheme.headlineMedium,
                                ),
                              ),
                            ];
                          }),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
