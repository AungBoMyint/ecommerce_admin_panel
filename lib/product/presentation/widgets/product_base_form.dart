import 'dart:developer';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/product/bloc/detail_product_bloc.dart';
import 'package:ecommerce_admin/product/data/get_type.dart';
import 'package:ecommerce_admin/product/presentation/widgets/advanced_product_type.dart';
import 'package:ecommerce_admin/product/presentation/widgets/attributes_widget.dart';
import 'package:ecommerce_admin/product/presentation/widgets/inventory_widget.dart';
import 'package:ecommerce_admin/product/presentation/widgets/linked_products.dart';
import 'package:ecommerce_admin/product/presentation/widgets/product_functions_widget.dart';
import 'package:ecommerce_admin/product/presentation/widgets/shipping_widget.dart';
import 'package:ecommerce_admin/product/presentation/widgets/simple_product_general.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gap/gap.dart';

import 'variations_widget.dart';

class ProductBaseForm extends StatefulWidget {
  const ProductBaseForm({
    super.key,
  });

  @override
  State<ProductBaseForm> createState() => _ProductBaseFormState();
}

class _ProductBaseFormState extends State<ProductBaseForm> {
  final QuillController _descriptionController = QuillController.basic();
  final QuillController _shortDescriptionController = QuillController.basic();
  final TextEditingController _productNameController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _shortDescriptionController.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20),
          SizedBox(
              height: 50,
              child: TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                  label: Text(
                    "Product Name",
                    style: textTheme.displaySmall,
                  ),
                  enabledBorder: searchTextBorder,
                  focusedBorder: searchTextBorder,
                ),
              )).withElevation(),
          20.vSpace(),
          SizedBox(
            height: 300,
            /* flex: 1, */
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(
                  10,
                )),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 2),
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: Colors.grey.shade200,
                  ),
                  BoxShadow(
                    offset: const Offset(-2, -2),
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: textTheme.displaySmall,
                  ),
                  8.vSpace(),
                  Expanded(
                    child: QuillProvider(
                      configurations: QuillConfigurations(
                        controller: _descriptionController,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('en'),
                        ),
                      ),
                      child: Column(
                        children: [
                          const QuillToolbar(),
                          Expanded(
                            child: QuillEditor.basic(
                              configurations: const QuillEditorConfigurations(
                                readOnly: false,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.vSpace(),
          const ProductDataWidget(),
          20.vSpace(),
          SizedBox(
            height: 200,
            /* flex: 1, */
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(
                  10,
                )),
                border: Border.all(
                  color: Colors.grey,
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 2),
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: Colors.grey.shade200,
                  ),
                  BoxShadow(
                    offset: const Offset(-2, -2),
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product short description",
                    style: textTheme.displaySmall,
                  ),
                  8.vSpace(),
                  Expanded(
                    child: QuillProvider(
                      configurations: QuillConfigurations(
                        controller: _shortDescriptionController,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('en'),
                        ),
                      ),
                      child: Column(
                        children: [
                          const QuillToolbar(),
                          Expanded(
                            child: QuillEditor.basic(
                              configurations: const QuillEditorConfigurations(
                                readOnly: false,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.vSpace(),
        ],
      ),
    );
  }
}

class ProductDataWidget extends StatefulWidget {
  const ProductDataWidget({super.key});

  @override
  State<ProductDataWidget> createState() => _ProductDataWidgetState();
}

class _ProductDataWidgetState extends State<ProductDataWidget>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return /* SizedBox(
      height: 400,
      child: LayoutBuilder(builder: (context, constraints) {
        log("Product Data's H & W: ${constraints.maxHeight} & ${constraints.maxWidth}");
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: SingleChildScrollView(
            child: */
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Product Data",
            ),
            const Gap(10),
            Container(
              height: 2,
              width: 20,
              color: linkBTNColor,
            ),
            const Gap(10),
            BlocBuilder<DetailProductBloc, DetailProductState>(
              builder: (context, state) {
                return DropDownWidget(
                  onChanged: (v) {
                    context
                        .read<DetailProductBloc>()
                        .add(ChangeProductType(type: getProductTypeString(v)));
                  },
                  value: getProductType(state.productType),
                  hintText: "Simple Product",
                  items: const [
                    "Simple Product",
                    "Grouped Product",
                    "Variable Product",
                  ],
                );
              },
            ),
          ],
        ).withPadding(10, 0),
        10.vSpace(),
        //Functions
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Functions
            const SingleChildScrollView(
              child: ProductFunctionsWidget(),
            ),
            //Area
            //for simple product
            Expanded(
              flex: 2,
              child: LayoutBuilder(builder: (context, constraints) {
                log("🥃------Product Data Tab's Height: ${constraints.maxHeight}\n Width: ${constraints.maxWidth}");
                return SizedBox(
                  /* height: constraints.maxHeight - 75, */
                  child: BlocBuilder<DetailProductBloc, DetailProductState>(
                    builder: (context, state) {
                      switch (state.productDataTab) {
                        case ProductDataTab.general:
                          return const SimpleProductGeneral();
                        case ProductDataTab.inventory:
                          return const Inventory();
                        case ProductDataTab.shipping:
                          return const ShippingWidget();
                        case ProductDataTab.linkedProducts:
                          return const LinkedProducts();
                        case ProductDataTab.attributes:
                          return const AttributesWidget();
                        case ProductDataTab.advanced:
                          return const AdvancedProductType();
                        case ProductDataTab.variations:
                          return const VariationsWidget();
                        default:
                          return Container();
                      }
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    ).withElevation(
            v: 10,
            border: Border.all(
              color: Colors.grey,
            ));
    /* ),
        );
      }),
    ); */
  }
}
