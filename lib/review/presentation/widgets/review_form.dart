import 'package:ecommerce_admin/core/presentation/widgets/responsive_rowcolumn_textfield.dart';
import 'package:ecommerce_admin/review/bloc/review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../core/presentation/widgets/drop_down_searchable.dart';

class ReviewForm extends StatelessWidget {
  const ReviewForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  condition:
                      state.isFirstTimePressed && !(state.author.error == null),
                  errorText: "* Author must be selected.");
            },
          ),

          const Gap(15),
          //Rating
          BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
            return ResponsiveRowColumnTextField(
              hasFormError:
                  (state.isFirstTimePressed && !(state.rating.error == null)),
              label: "Rating",
              errorText: "* Rating is required.",
              onChanged: (v) =>
                  context.read<ReviewBloc>().add(ChangeRatingEvent(value: v)),
            );
          }),
          const Gap(15),
          //Review
          BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
            return ResponsiveRowColumnTextField(
              hasFormError:
                  (state.isFirstTimePressed && !(state.review.error == null)),
              label: "Review",
              errorText: "* Review is required.",
              onChanged: (v) =>
                  context.read<ReviewBloc>().add(ChangeReviewEvent(value: v)),
            );
          }),
          const Gap(15),
          BlocBuilder<ReviewBloc, ReviewState>(
            builder: (context, state) {
              return LabelDropDownSearchable(
                getName: (v) => v,
                condition:
                    state.isFirstTimePressed && !(state.product.error == null),
                errorText: "* Product is required.",
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
        ],
      );
    });
  }
}
