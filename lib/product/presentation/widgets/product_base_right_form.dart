import 'dart:developer';

import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/form_data.dart';
import '../../../theme/colors.dart';
import '../../../utils/utils.dart';
import 'porduct_image_form.dart';
import 'product_categories.dart';
import 'product_tags_widget.dart';

class ProductBaseRightForm extends StatelessWidget {
  const ProductBaseRightForm({
    super.key,
    required this.isColumn,
  });

  final bool isColumn;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final coreBloc = context.read<CoreBloc>();
    return Column(
      children: [
        //Push,Save,Preview
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Text(
                coreBloc.state.page == PageType.editProduct
                    ? "Update"
                    : "Publish",
                style: textTheme.bodyMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LinkTextButton(onPressed: () {}, text: "Save Draft"),
                LinkTextButton(onPressed: () {}, text: "Preview"),
              ],
            ).withPadding(20, 10),
            Align(
              alignment: Alignment.centerRight,
              child: LinkTextButton(
                onPressed: () {
                  log("🥃------FormData: ${formData.toString()}");
                },
                text: coreBloc.state.page == PageType.editProduct
                    ? "Update"
                    : "Publish",
                fillColor: linkBTNColor,
              ),
            ).withPadding(20, 10),
          ],
        ).withElevation(
            border: Border.all(
          color: Colors.grey,
        )),
        25.vSpace(),
        //Product Image
        const ProductImage(),
        25.vSpace(),
        //Product Categories
        const ProductCategories(),
        25.vSpace(),
        //Product tags
        const ProductTags(),
      ],
    );
  }
}
