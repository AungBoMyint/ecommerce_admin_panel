import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/pages/base_table_form_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/review/bloc/review_bloc.dart';
import 'package:ecommerce_admin/review/presentation/widgets/review_form.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../theme/colors.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState
    extends BaseTableFormWidgetState<ReviewWidget, ReviewBloc, ReviewState> {
  @override
  List<Widget> columnList() {
    final textTheme = getTheme().textTheme;
    final isTABLET = getSize().width < MDESKTOP;
    return [
      BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          return Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.length == state.items.length,
            onChanged: (v) => context.read<ReviewBloc>().add(
                  SelectAllItemsEvent(
                    isSelectAll: v ?? false,
                  ),
                ),
          );
        },
      ),
      Text(
        "Author",
        style: textTheme.displaySmall,
      ),
      Text(
        "Rating",
        style: textTheme.displaySmall,
      ),
      if (!isTABLET) ...[
        Text(
          "Review",
          style: textTheme.displaySmall,
        ),
      ],
      if (!isTABLET) ...[
        Text(
          "Product",
          style: textTheme.displaySmall,
        ),
      ],
      if (!isTABLET) ...[
        Text(
          "Submitted on",
          style: textTheme.displaySmall,
        )
      ],
    ];
  }

  @override
  void endOfFrame() {
    context.read<ReviewBloc>().add(FetchEvent());
  }

  @override
  Widget getForm() {
    return const ReviewForm();
  }

  @override
  Widget getSubmitButton() {
    return ElevatedButton(
        onPressed: () => context.read<ReviewBloc>().add(AddEvent()),
        child: Text(
          "Add new review",
          style: getTheme().textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ));
  }

  @override
  Widget getTitle() {
    return Text(
      "Add new review",
      style: getTheme().textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  @override
  List<List<DataCell>> rowList(ReviewState state) {
    final textTheme = getTheme().textTheme;
    final isTABLET = getSize().width < MDESKTOP;
    return List.generate(
      state.items.length,
      (index) => [
        DataCell(
          Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.contains(
              state.items[index].id,
            ),
            onChanged: (v) => context.read<ReviewBloc>().add(
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
        if (!isTABLET) ...[
          DataCell(
            Text(
              state.items[index].rating.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headlineMedium,
            ),
          )
        ],
        if (!isTABLET) ...[
          DataCell(
            Text(
              state.items[index].review,
              style: textTheme.headlineMedium,
            ),
          )
        ],
        if (!isTABLET) ...[
          DataCell(
            Text(
              (index % 2 == 0) ? "10" : "5",
              style: textTheme.headlineMedium,
            ),
          )
        ],
      ],
    );
  }

  @override
  Widget topActions() {
    return TopActions(
      searchHint: "Search reviews",
      title: "Product Reviews",
      onSearch: () => context.read<ReviewBloc>().add(
            SearchEvent(),
          ),
    );
  }
}
