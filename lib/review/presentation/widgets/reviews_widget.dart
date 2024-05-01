import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_searchable.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/form_error_conditions.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/loading_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/review/bloc/review_bloc.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../product/model/product.dart';
import '../../../theme/colors.dart';

class ReviewsWidget extends StatefulWidget {
  const ReviewsWidget({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<ReviewBloc>().add(FetchEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<ReviewBloc>().add(FetchMoreEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
          TopActions(
            searchHint: "Search reviews",
            title: "Product Reviews",
            onSearch: () => context.read<ReviewBloc>().add(
                  SearchEvent(),
                ),
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
                            onPressed: () =>
                                context.read<ReviewBloc>().add(AddEvent()),
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
                          BlocBuilder<ReviewBloc, ReviewState>(
                            builder: (context, state) {
                              return DropDownWidget(
                                value: state.selectedAction,
                                hintText: "Actions",
                                items: const ["Edit", "Delete"],
                                onChanged: (v) => context
                                    .read<ReviewBloc>()
                                    .add(ChangeActionsEvent(value: v ?? "")),
                                width: 100,
                              );
                            },
                          ),
                          const Gap(10),
                          BlocBuilder<ReviewBloc, ReviewState>(
                              builder: (context, state) {
                            return LinkTextButton(
                              height: 35,
                              onPressed: () => context
                                  .read<ReviewBloc>()
                                  .add(ActionApplyEvent()),
                              text: "Apply",
                              fillColor: linkBTNColor,
                            );
                          }),
                        ],
                      ),
                      Expanded(
                        child: BlocBuilder<ReviewBloc, ReviewState>(
                          builder: (context, state) {
                            switch (state.actionStatus) {
                              case ActionStatus.fetching:
                                return const /* Expanded(child:  */ LoadingWidget() /* ) */;
                              case ActionStatus.searching:
                                return const /* Expanded(child:  */ LoadingWidget() /* ) */;
                              default:
                                return DataTable2(
                                  scrollController: _scrollController,
                                  minWidth: 200,
                                  border: TableBorder.symmetric(
                                      outside: BorderSide(
                                          color: Colors.grey.shade300)),
                                  columns: [
                                    DataColumn2(
                                      size: ColumnSize.S,
                                      label: Checkbox(
                                        side: const BorderSide(
                                            width: 2, color: linkBTNColor),
                                        value: state.selectedItems.length ==
                                            state.items.length,
                                        onChanged: (v) =>
                                            context.read<ReviewBloc>().add(
                                                  SelectAllItemsEvent(
                                                    isSelectAll: v ?? false,
                                                  ),
                                                ),
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
                                    state.items.length,
                                    (index) => DataRow2(
                                      specificRowHeight: 100,
                                      color: (index % 2 == 0)
                                          ? MaterialStateProperty.all(
                                              Colors.grey.shade100)
                                          : MaterialStateProperty.all(
                                              Colors.white),
                                      cells: [
                                        DataCell(
                                          Checkbox(
                                            side: const BorderSide(
                                                width: 2, color: linkBTNColor),
                                            value: state.selectedItems.contains(
                                              state.items[index].id,
                                            ),
                                            onChanged: (v) => context
                                                .read<ReviewBloc>()
                                                .add(
                                                  SelectItemEvent(
                                                    value: v ?? false,
                                                    id: state.items[index].id,
                                                  ),
                                                ),
                                          ),
                                        ),
                                        DataCell(
                                          MainTitleText(
                                            e: state.items[index].author,
                                            onEdit: () => context
                                                .read<CoreBloc>()
                                                .add(
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
                                            state.items[index].rating
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.headlineMedium,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            state.items[index].review,
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
                                );
                            }
                          },
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
          BlocBuilder<ReviewBloc, ReviewState>(
            builder: (context, state) {
              return LabelDropDownSearchable(
                getName: (v) => v,
                textEditingController: TextEditingController(),
                label: "Author",
                hintText: "None",
                value: state.author.value,
                onChanged: (v) => context.read<ReviewBloc>().add(
                      ChangeAuthorEvent(value: v ?? ""),
                    ),
                items: const [
                  "Development",
                  "IT",
                  "Nurse",
                ],
              );
            },
          ),
          FormErrorCondition<ReviewBloc, ReviewState>(
              condition: (state) =>
                  state.isFirstTimePressed && !(state.review.error == null),
              errorText: "* Author must be selected."),
          const Gap(15),
          SizedBox(
            height: 85,
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
                      child: BlocBuilder<ReviewBloc, ReviewState>(
                        builder: (context, state) {
                          return TextFormField(
                            cursorHeight: 15,
                            initialValue: "${state.rating.value}",
                            onChanged: (v) => context.read<ReviewBloc>().add(
                                  ChangeRatingEvent(
                                    value: v,
                                  ),
                                ),
                            decoration: const InputDecoration(
                              hintText: "3.5",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: FormErrorCondition<ReviewBloc, ReviewState>(
                          condition: (state) {
                            return state.isFirstTimePressed &&
                                !(state.rating.error == null);
                          },
                          errorText: "* Rating is required.")),
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
            height: 85,
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
                      child: BlocBuilder<ReviewBloc, ReviewState>(
                        builder: (context, state) {
                          return TextFormField(
                            cursorHeight: 15,
                            initialValue: state.review.value,
                            onChanged: (v) => context
                                .read<ReviewBloc>()
                                .add(ChangeReviewEvent(
                                  value: v,
                                )),
                            decoration: const InputDecoration(
                              hintText: "A good product",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: FormErrorCondition<ReviewBloc, ReviewState>(
                        condition: (state) =>
                            state.isFirstTimePressed &&
                            !(state.review.error == null),
                        errorText: "* Review is required."),
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
          BlocBuilder<ReviewBloc, ReviewState>(
            builder: (context, state) {
              return LabelDropDownSearchable(
                getName: (v) => v,
                textEditingController: TextEditingController(),
                label: "Product",
                hintText: "None",
                value: state.product.value,
                onChanged: (v) => context
                    .read<ReviewBloc>()
                    .add(ChangeProductEvent(value: v ?? "")),
                items: const [
                  "Development",
                  "IT",
                  "Nurse",
                ],
              );
            },
          ),
          ResponsiveRowColumnItem(
            child: FormErrorCondition<ReviewBloc, ReviewState>(
                condition: (state) =>
                    state.isFirstTimePressed && !(state.product.error == null),
                errorText: "* Product is required."),
          ),
        ],
      );
    });
  }
}
