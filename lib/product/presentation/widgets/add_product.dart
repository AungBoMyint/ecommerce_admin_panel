import 'dart:developer';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/product/presentation/widgets/porduct_image_form.dart';
import 'package:ecommerce_admin/product/presentation/widgets/product_categories.dart';
import 'package:ecommerce_admin/product/presentation/widgets/product_tags_widget.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'product_base_form.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  void dispose() {
    formData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final coreBloc = context.read<CoreBloc>();
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        log("Add Product's Width: ${constraints.maxWidth}\nHeight: ${constraints.maxHeight}");
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coreBloc.state.page == PageType.editProduct
                        ? "Edit product"
                        : "Add new product",
                    style: textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  20.vSpace(),
                  //Category Form
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxWidth > STABLET
                        ? constraints.maxHeight * 1.8
                        : constraints.maxHeight * 4,
                    child: SingleChildScrollView(
                      child: ResponsiveRowColumn(
                        rowCrossAxisAlignment: CrossAxisAlignment.start,
                        layout: constraints.maxWidth > STABLET
                            ? ResponsiveRowColumnType.ROW
                            : ResponsiveRowColumnType.COLUMN,
                        children: [
                          //Left Form
                          const ResponsiveRowColumnItem(
                              child: ProductBaseForm()),
                          const ResponsiveRowColumnItem(child: Gap(20)),
                          //Right Form
                          ResponsiveRowColumnItem(
                            child: Expanded(
                                child: Column(
                              children: [
                                //Push,Save,Preview
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
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
                                        coreBloc.state.page ==
                                                PageType.editProduct
                                            ? "Update"
                                            : "Publish",
                                        style: textTheme.bodyMedium,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LinkTextButton(
                                            onPressed: () {},
                                            text: "Save Draft"),
                                        LinkTextButton(
                                            onPressed: () {}, text: "Preview"),
                                      ],
                                    ).withPadding(20, 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: LinkTextButton(
                                        onPressed: () {
                                          log("🥃------FormData: ${formData.toString()}");
                                        },
                                        text: coreBloc.state.page ==
                                                PageType.editProduct
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
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                  20.vSpace(),
                ],
              ).withMargin(20, 20),
            ),
          ),
        );
      }),
    );
  }
}
