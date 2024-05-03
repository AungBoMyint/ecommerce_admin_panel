import 'package:ecommerce_admin/core/presentation/widgets/form_error_conditions.dart';
import 'package:ecommerce_admin/review/bloc/review_bloc.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/presentation/widgets/drop_down_searchable.dart';

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
