import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/core/presentation/widgets/loading_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/tags/bloc/tag_bloc.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../theme/colors.dart';
import 'tags_form.dart';

class TagsWidget extends StatefulWidget {
  const TagsWidget({
    super.key,
  });

  @override
  State<TagsWidget> createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<TagBloc>().add(FetchTagEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<TagBloc>().add(FetchMoreTagEvent());
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
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
          TopActions(
            searchHint: "Search tags",
            title: "Product Tags",
            onSearch: () => context.read<TagBloc>().add(
                  SearchTagEvent(),
                ),
            onAddNew: () => context.read<CoreBloc>().add(
                  ChangePageEvent(
                    page: PageType.editTag,
                  ),
                ),
          ),
          Expanded(
            child: Row(
              children: [
                20.hSpace(),
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add new tag",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        20.vSpace(),
                        //Tag Form
                        const TagForm(),

                        20.vSpace(),
                        //sumbit button
                        ElevatedButton(
                            onPressed: () {
                              context.read<TagBloc>().add(AddTagEvent());
                            },
                            child: Text(
                              "Add new tag",
                              style: textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Gap(20),
                          BlocBuilder<TagBloc, TagState>(
                            builder: (context, state) {
                              return DropDownWidget(
                                hintText: "Actions",
                                items: const ["Edit", "Delete"],
                                width: 100,
                                value: state.selectedAction,
                                onChanged: (value) {
                                  context.read<TagBloc>().add(
                                      ChangeDropDownActions(
                                          value: value ?? ""));
                                },
                              );
                            },
                          ),
                          const Gap(10),
                          LinkTextButton(
                            height: 35,
                            onPressed: () {
                              context.read<TagBloc>().add(ActionApplyEvent());
                            },
                            text: "Apply",
                            fillColor: linkBTNColor,
                          ),
                        ],
                      ),
                      Expanded(
                        child: BlocBuilder<TagBloc, TagState>(
                          builder: (context, state) {
                            switch (state.actionStatus) {
                              case ActionStatus.fetching:
                                return const Expanded(child: LoadingWidget());
                              case ActionStatus.searching:
                                return const Expanded(child: LoadingWidget());
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
                                          value: (state.selectedTags.length ==
                                              state.tags.length),
                                          onChanged: (v) {
                                            context
                                                .read<TagBloc>()
                                                .add(SelectAllTagsEvent(
                                                  isSelectAll: v ?? false,
                                                ));
                                          }),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.L,
                                      label: Text(
                                        "Name",
                                        style: textTheme.displaySmall,
                                      ),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.S,
                                      label: Text(
                                        "Slug",
                                        style: textTheme.displaySmall,
                                      ),
                                    ),
                                    DataColumn2(
                                      size: ColumnSize.S,
                                      label: Text(
                                        "Count",
                                        style: textTheme.displaySmall,
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                    state.tags.length,
                                    (index) => DataRow2(
                                      specificRowHeight: 85,
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
                                            value: state.selectedTags
                                                .contains(state.tags[index].id),
                                            onChanged: (v) {
                                              context.read<TagBloc>().add(
                                                    SelectTagEvent(
                                                      value: v ?? false,
                                                      id: state.tags[index].id,
                                                    ),
                                                  );
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          MainTitleText(
                                            e: state.tags[index].name,
                                            onEdit: () =>
                                                context.read<CoreBloc>().add(
                                                      ChangePageEvent(
                                                        page: PageType.editTag,
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
