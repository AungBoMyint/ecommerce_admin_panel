import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/widgets/row_link_btn.dart';
import '../../bloc/detail_product_bloc.dart';

class ProductFunctionsWidget extends StatelessWidget {
  const ProductFunctionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      builder: (context, state) {
        return Column(
          children: [
            state.productType == ProductType.groupedProduct
                ? const SizedBox()
                : BlocBuilder<DetailProductBloc, DetailProductState>(
                    builder: (context, state) {
                      return RowLinkButton(
                        onPressed: () {
                          context.read<DetailProductBloc>().add(
                                ChangeProductDataTab(
                                  dataTab: ProductDataTab.general,
                                ),
                              );
                        },
                        text: "General",
                        bgColor: state.productDataTab == ProductDataTab.general
                            ? Colors.grey.shade200
                            : Colors.white,
                        iColor: state.productDataTab == ProductDataTab.general
                            ? Colors.grey.shade400
                            : null,
                        textStyle:
                            state.productDataTab == ProductDataTab.general
                                ? textTheme.bodyMedium
                                : null,
                      );
                    },
                  ),
            BlocBuilder<DetailProductBloc, DetailProductState>(
                builder: (context, state) {
              return RowLinkButton(
                onPressed: () {
                  context.read<DetailProductBloc>().add(
                        ChangeProductDataTab(
                          dataTab: ProductDataTab.inventory,
                        ),
                      );
                },
                text: "Inventory",
                bgColor: state.productDataTab == ProductDataTab.inventory
                    ? Colors.grey.shade200
                    : Colors.white,
                iColor: state.productDataTab == ProductDataTab.inventory
                    ? Colors.grey.shade400
                    : null,
                textStyle: state.productDataTab == ProductDataTab.inventory
                    ? textTheme.bodyMedium
                    : null,
              );
            }),
            state.productType == ProductType.groupedProduct
                ? const SizedBox()
                : BlocBuilder<DetailProductBloc, DetailProductState>(
                    builder: (context, state) {
                    return RowLinkButton(
                      onPressed: () {
                        context.read<DetailProductBloc>().add(
                              ChangeProductDataTab(
                                dataTab: ProductDataTab.shipping,
                              ),
                            );
                      },
                      text: "Shipping",
                      bgColor: state.productDataTab == ProductDataTab.shipping
                          ? Colors.grey.shade200
                          : Colors.white,
                      iColor: state.productDataTab == ProductDataTab.shipping
                          ? Colors.grey.shade400
                          : null,
                      textStyle: state.productDataTab == ProductDataTab.shipping
                          ? textTheme.bodyMedium
                          : null,
                    );
                  }),
            BlocBuilder<DetailProductBloc, DetailProductState>(
                builder: (context, state) {
              return RowLinkButton(
                onPressed: () {
                  context.read<DetailProductBloc>().add(
                        ChangeProductDataTab(
                          dataTab: ProductDataTab.linkedProducts,
                        ),
                      );
                },
                text: "Linked Products",
                bgColor: state.productDataTab == ProductDataTab.linkedProducts
                    ? Colors.grey.shade200
                    : Colors.white,
                iColor: state.productDataTab == ProductDataTab.linkedProducts
                    ? Colors.grey.shade400
                    : null,
                textStyle: state.productDataTab == ProductDataTab.linkedProducts
                    ? textTheme.bodyMedium
                    : null,
              );
            }),
            BlocBuilder<DetailProductBloc, DetailProductState>(
                builder: (context, state) {
              return RowLinkButton(
                onPressed: () {
                  context.read<DetailProductBloc>().add(
                        ChangeProductDataTab(
                          dataTab: ProductDataTab.attributes,
                        ),
                      );
                },
                text: "Attributes",
                bgColor: state.productDataTab == ProductDataTab.attributes
                    ? Colors.grey.shade200
                    : Colors.white,
                iColor: state.productDataTab == ProductDataTab.attributes
                    ? Colors.grey.shade400
                    : null,
                textStyle: state.productDataTab == ProductDataTab.attributes
                    ? textTheme.bodyMedium
                    : null,
              );
            }),
            //Variations
            BlocBuilder<DetailProductBloc, DetailProductState>(
                builder: (context, state) {
              return state.productType == ProductType.variableProduct
                  ? RowLinkButton(
                      onPressed: () {
                        context.read<DetailProductBloc>().add(
                              ChangeProductDataTab(
                                dataTab: ProductDataTab.variations,
                              ),
                            );
                      },
                      text: "Variations",
                      bgColor: state.productDataTab == ProductDataTab.variations
                          ? Colors.grey.shade200
                          : Colors.white,
                      iColor: state.productDataTab == ProductDataTab.variations
                          ? Colors.grey.shade400
                          : null,
                      textStyle:
                          state.productDataTab == ProductDataTab.variations
                              ? textTheme.bodyMedium
                              : null,
                    )
                  : const SizedBox();
            }),
            //
            BlocBuilder<DetailProductBloc, DetailProductState>(
                builder: (context, state) {
              return RowLinkButton(
                onPressed: () {
                  context.read<DetailProductBloc>().add(
                        ChangeProductDataTab(
                          dataTab: ProductDataTab.advanced,
                        ),
                      );
                },
                text: "Advanced",
                bgColor: state.productDataTab == ProductDataTab.advanced
                    ? Colors.grey.shade200
                    : Colors.white,
                iColor: state.productDataTab == ProductDataTab.advanced
                    ? Colors.grey.shade400
                    : null,
                textStyle: state.productDataTab == ProductDataTab.advanced
                    ? textTheme.bodyMedium
                    : null,
              );
            }),
            BlocBuilder<DetailProductBloc, DetailProductState>(
                builder: (context, state) {
              return RowLinkButton(
                onPressed: () {
                  context.read<DetailProductBloc>().add(
                        ChangeProductDataTab(
                          dataTab: ProductDataTab.getMoreOptions,
                        ),
                      );
                },
                text: "Get more options",
                bgColor: state.productDataTab == ProductDataTab.getMoreOptions
                    ? Colors.grey.shade200
                    : Colors.white,
                iColor: state.productDataTab == ProductDataTab.getMoreOptions
                    ? Colors.grey.shade400
                    : null,
                textStyle: state.productDataTab == ProductDataTab.getMoreOptions
                    ? textTheme.bodyMedium
                    : null,
              );
            }),
          ],
        );
      },
    );
  }
}