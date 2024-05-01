import 'package:ecommerce_admin/core/constant.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_searchable.dart';
import 'package:ecommerce_admin/core/presentation/widgets/label_dropdown.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/settings/model/shipping_method.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/shipping_bloc.dart';

class EditShippingWidget extends StatelessWidget {
  const EditShippingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<ShippingBloc, ShippingState>(
              builder: (context, state) {
                return Text(
                  "Shipping zones > ${state.editItem?.zoneName}",
                  style: textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const Gap(45),
            SizedBox(
              height: 65,
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Zone name",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(40),
                    SizedBox(
                      height: 80,
                      width: 250,
                      child: BlocBuilder<ShippingBloc, ShippingState>(
                        builder: (context, state) {
                          return LabelDropDownSearchable(
                            getName: (v) => v,
                            items: state.zoneNames,
                            textEditingController: TextEditingController(),
                            hintText: "select zone",
                            value: state.zoneName.value,
                            onChanged: (v) => context
                                .read<ShippingBloc>()
                                .add(ChangingZoneNameEvent(name: v ?? "")),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                );
              }),
            ),
            const Gap(20),
            SizedBox(
              height: 65,
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Zone regions",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: BlocBuilder<ShippingBloc, ShippingState>(
                        builder: (context, state) {
                          return LabelDropDownSearchable(
                            getName: (v) => v,
                            items: state.zoneRegions,
                            selectedItems: state.zoneRegionList.value,
                            textEditingController: TextEditingController(),
                            hintText: "select regions",
                            onChanged: (v) => context.read<ShippingBloc>().add(
                                SelectZoneRegionEvent(zoneRegion: v ?? "")),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                );
              }),
            ),
            BlocBuilder<ShippingBloc, ShippingState>(builder: (context, state) {
              return Wrap(
                children: state.zoneRegionList.value
                    .map((e) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: Chip(
                            elevation: 0,
                            deleteIcon: const Icon(
                              Icons.clear,
                              size: 18,
                            ),
                            deleteIconColor: Colors.white,
                            onDeleted: () => context
                                .read<ShippingBloc>()
                                .add(SelectZoneRegionEvent(zoneRegion: e)),
                            backgroundColor: linkBTNColor,
                            labelStyle: textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                            label: Text(
                              e,
                            ),
                          ),
                        ))
                    .toList(),
              );
            }),
            const Gap(20),
            SizedBox(
              height: 65,
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<ShippingBloc, ShippingState>(
                      builder: (context, state) {
                        return Text(
                          state.shippingMethod.value ?? "",
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const Gap(60),
                    BlocBuilder<ShippingBloc, ShippingState>(
                      builder: (context, state) {
                        if (state.editItem!.shippingMethod.shipping ==
                            Shipping.free) {
                          return /* Container(
                            child: */
                              LabelDropDown(
                            width: 400,
                            onChanged: (v) => context.read<ShippingBloc>().add(
                                ChangeShippingTypeEvent(shippingType: v ?? "")),
                            value: freeShippingToString(
                                state.shippingType ?? FreeShippingType.empty),
                            label: "",
                            hintText: "Select free shipping type",
                            items: freeShippingTypeList,
                          );
                          /*  ); */
                        }
                        return Expanded(
                          child: TextFormField(
                            cursorHeight: 15,
                            initialValue: "${state.cost}",
                            onChanged: (v) => context.read<ShippingBloc>().add(
                                ChangeShippingCostEvent(
                                    cost: int.tryParse(v) ?? 0)),
                            decoration: const InputDecoration(
                              hintText: "0 (cost for this shipping method)",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                );
              }),
            ),
            const Gap(20),
            SizedBox(
              height: 35,
              width: 150,
              child: LinkTextButton(
                onPressed: () {},
                text: "Save changes",
                fillColor: linkBTNColor,
              ),
            )
          ],
        ).withPadding(20, 20);
      }),
    );
  }
}
