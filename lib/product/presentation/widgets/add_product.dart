import 'dart:developer';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'product_base_form.dart';
import 'product_base_right_form.dart';

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
    final size = MediaQuery.of(context).size;
    final isColumn = size.width < STABLET;
    log("--🪖--Edit Product: ${size.width > STABLET}");
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
                        layout: isColumn
                            ? ResponsiveRowColumnType.COLUMN
                            : ResponsiveRowColumnType.ROW,
                        children: [
                          //Left Form
                          ResponsiveRowColumnItem(
                              child: isColumn
                                  ? const ProductBaseForm()
                                  : const Expanded(
                                      flex: 3,
                                      child: ProductBaseForm(),
                                    )),
                          const ResponsiveRowColumnItem(child: Gap(20)),
                          //Right Form
                          ResponsiveRowColumnItem(
                            child: isColumn
                                ? ProductBaseRightForm(
                                    isColumn: isColumn,
                                  )
                                : Expanded(
                                    child: ProductBaseRightForm(
                                    isColumn: isColumn,
                                  )),
                          ),
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
