import 'package:ecommerce_admin/core/presentation/widgets/responsive_rowcolumn_textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/tag_bloc.dart';

class TagForm extends StatelessWidget {
  const TagForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<TagBloc, TagState>(
            builder: (context, state) {
              return ResponsiveRowColumnTextField(
                onChanged: (v) => context.read<TagBloc>().add(
                      ChangeNameEvent(value: v),
                    ),
                hasFormError:
                    (state.isFirstTimePressed && !(state.name.error == null)),
                label: "Name",
                errorText: "* Name is required.",
              );
            },
          ),
          const Gap(15),
          BlocBuilder<TagBloc, TagState>(
            builder: (context, state) {
              return ResponsiveRowColumnTextField(
                onChanged: (v) => context.read<TagBloc>().add(
                      ChangeSlugEvent(value: v),
                    ),
                hasFormError: false,
                label: "Slug",
                errorText: "",
              );
            },
          ),
          const Gap(20),
        ],
      );
    });
  }
}
