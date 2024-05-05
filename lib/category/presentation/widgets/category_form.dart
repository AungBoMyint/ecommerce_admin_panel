import 'dart:io';
import 'package:ecommerce_admin/category/bloc/category_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/label_dropdown.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/responsive_rowcolumn_textfield.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Name
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return ResponsiveRowColumnTextField(
                  onChanged: (v) => context.read<CategoryBloc>().add(
                        ChangeNameEvent(value: v),
                      ),
                  hasFormError:
                      (state.isFirstTimePressed && !(state.name.error == null)),
                  label: "Name",
                  errorText: "* Name is required",
                );
              },
            ),
            20.vSpace(),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return LabelDropDown(
                  onChanged: (v) => context
                      .read<CategoryBloc>()
                      .add(ChangeDropDownParentCategory(value: v ?? "")),
                  value: state.selectedParentCategory,
                  label: "Parent category",
                  hintText: "None",
                  items: const [
                    "Development",
                    "IT",
                    "Nurse",
                  ],
                );
              },
            ),
            20.vSpace(),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return LabelDropDown(
                  onChanged: (v) => context
                      .read<CategoryBloc>()
                      .add(ChangeDropDownDisplayType(value: v ?? "")),
                  value: state.displayType,
                  label: "Display type",
                  hintText: "Default",
                  items: const [
                    "Subscategory",
                    "Product",
                  ],
                );
              },
            ),
            20.vSpace(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Thumbnail",
                      style: textTheme.bodyLarge,
                    ),
                    const Gap(8),
                    LinkTextButton(
                        onPressed: () {
                          context.read<CategoryBloc>().add(PickImageEvent());
                        },
                        text: "Pick image")
                  ],
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                  return ((state.isFirstTimePressed) &&
                          !(state.image.error == null))
                      ? const ErrorText(error: "* Image is required.")
                      : 0.vSpace();
                }),
                const Gap(10),
                BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                  if (state.image.value == null ||
                      state.image.value?.isEmpty == true) {
                    return Image.asset(
                      AppImage.picture,
                      height: 100,
                    );
                  } else {
                    return Image.file(
                      File(state.image.value!),
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  }
                })
              ],
            ),
          ],
        ),
      );
    });
  }
}
