import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/pages/base_table_form_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/tags/bloc/tag_bloc.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../theme/colors.dart';
import 'tags_form.dart';

class TagTable extends StatefulWidget {
  const TagTable({super.key});

  @override
  State<TagTable> createState() => _TagTableState();
}

class _TagTableState
    extends BaseTableFormWidgetState<TagTable, TagBloc, TagState> {
  @override
  List<Widget> columnList() {
    final textTheme = getTextTheme();
    final isMTABLET = getSize().width < MTABLET;

    return [
      BlocBuilder<TagBloc, TagState>(
        builder: (context, state) {
          return Checkbox(
              side: const BorderSide(width: 2, color: linkBTNColor),
              value: (state.selectedItems.length == state.items.length),
              onChanged: (v) {
                context.read<TagBloc>().add(SelectAllItemsEvent(
                      isSelectAll: v ?? false,
                    ));
              });
        },
      ),
      Text(
        "Name",
        style: textTheme.displaySmall,
      ),
      if (!isMTABLET) ...[
        Text(
          "Slug",
          style: textTheme.displaySmall,
        )
      ],
      Text(
        "Count",
        style: textTheme.displaySmall,
      ),
    ];
  }

  @override
  void endOfFrame() {
    context.read<TagBloc>().add(FetchEvent());
  }

  @override
  Widget getForm() {
    return const TagForm();
  }

  @override
  Widget getSubmitButton() {
    return ElevatedButton(
        onPressed: () {
          context.read<TagBloc>().add(AddEvent());
        },
        child: Text(
          "Add new tag",
          style: getTextTheme().bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ));
  }

  @override
  Widget getTitle() {
    return Text(
      "Add new tag",
      style: getTextTheme().bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  @override
  List<List<DataCell>> rowList(TagState state) {
    final textTheme = getTextTheme();
    final isMTABLET = getSize().width < MTABLET;
    return List.generate(
      state.items.length,
      (index) => [
        DataCell(
          Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.contains(state.items[index].id),
            onChanged: (v) {
              context.read<TagBloc>().add(
                    SelectItemEvent(
                      value: v ?? false,
                      id: state.items[index].id,
                    ),
                  );
            },
          ),
        ),
        DataCell(
          MainTitleText(
            e: state.items[index].name,
            onEdit: () => context.read<CoreBloc>().add(
                  ChangePageEvent(
                    page: PageType.editTag,
                  ),
                ),
          ),
        ),
        if (!isMTABLET) ...[
          DataCell(
            Text(
              "-",
              style: textTheme.headlineMedium,
            ),
          ),
        ],
        DataCell(
          Text(
            (index % 2 == 0) ? "10" : "5",
            style: textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }

  @override
  Widget topActions() {
    return TopActions(
      searchHint: "Search tags",
      title: "Product Tags",
      onSearch: () => context.read<TagBloc>().add(
            SearchEvent(),
          ),
      onAddNew: () => context.read<CoreBloc>().add(
            ChangePageEvent(
              page: PageType.editTag,
            ),
          ),
    );
  }
}
