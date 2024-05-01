import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_searchable.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/label_dropdown.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/presentation/widgets/main_title_text.dart';
import '../../../theme/colors.dart';
import '../../bloc/shipping_bloc.dart';

class SettingShippingWidget extends StatefulWidget {
  const SettingShippingWidget({
    super.key,
    /* required this.products, */
  });

  /* final List<Product> products; */

  @override
  State<SettingShippingWidget> createState() => _SettingShippingWidgetState();
}

class _SettingShippingWidgetState extends State<SettingShippingWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
          const TopActions(
            searchHint: "Search shipping",
            title: "Product shipping",
          ),
          Expanded(
            child: Row(
              children: [
                20.hSpace(),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add new shipping",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    20.vSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Zone Name",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                      ],
                    ),
                    //zone regions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Zone Regions",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                                onChanged: (v) => context
                                    .read<ShippingBloc>()
                                    .add(SelectZoneRegionEvent(
                                        zoneRegion: v ?? "")),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<ShippingBloc, ShippingState>(
                        builder: (context, state) {
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
                                        .add(SelectZoneRegionEvent(
                                            zoneRegion: e)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shipping Methods",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: BlocBuilder<ShippingBloc, ShippingState>(
                            builder: (context, state) {
                              return LabelDropDown(
                                  onChanged: (v) =>
                                      context.read<ShippingBloc>().add(
                                            ChangeShippingMethodEvent(
                                              shippingMethod: v ?? "",
                                            ),
                                          ),
                                  value: state.shippingMethod.value,
                                  label: "",
                                  items: const [
                                    "Flat Shipping",
                                    "Free Shipping",
                                    "Local Shipping",
                                  ],
                                  hintText: "Shipping Method");
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    //sumbit button
                    ElevatedButton(
                        onPressed: () =>
                            context.read<ShippingBloc>().add(AddEvent()),
                        child: Text(
                          "Add new shipping",
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Gap(20),
                          const DropDownWidget(
                            hintText: "Actions",
                            items: ["Edit", "Delete"],
                            width: 100,
                          ),
                          const Gap(10),
                          LinkTextButton(
                            height: 35,
                            onPressed: () {},
                            text: "Apply",
                            fillColor: linkBTNColor,
                          ),
                        ],
                      ),
                      Expanded(
                        child: BlocBuilder<ShippingBloc, ShippingState>(
                          builder: (context, state) {
                            return DataTable2(
                              minWidth: 200,
                              border: TableBorder.symmetric(
                                  outside:
                                      BorderSide(color: Colors.grey.shade300)),
                              columns: [
                                DataColumn2(
                                  fixedWidth: 80,
                                  size: ColumnSize.S,
                                  label: Checkbox(
                                    side: const BorderSide(
                                        width: 2, color: linkBTNColor),
                                    value: false,
                                    onChanged: (v) {},
                                  ),
                                ),
                                DataColumn2(
                                  size: ColumnSize.M,
                                  label: Text(
                                    "Zone Name",
                                    style: textTheme.displaySmall,
                                  ),
                                ),
                                DataColumn2(
                                  size: ColumnSize.S,
                                  label: Text(
                                    "Zone Regions",
                                    style: textTheme.displaySmall,
                                  ),
                                ),
                                DataColumn2(
                                  size: ColumnSize.S,
                                  label: Text(
                                    "Shipping Method",
                                    style: textTheme.displaySmall,
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                state.items.length,
                                (index) => DataRow2(
                                  specificRowHeight: 100,
                                  color: (index % 2 == 0)
                                      ? MaterialStateProperty.all(
                                          Colors.grey.shade100)
                                      : MaterialStateProperty.all(Colors.white),
                                  cells: [
                                    DataCell(
                                      Checkbox(
                                          side: const BorderSide(
                                              width: 2, color: linkBTNColor),
                                          value: false,
                                          onChanged: (v) {}),
                                    ),
                                    DataCell(
                                      MainTitleText(
                                        e: state.items[index].zoneName,
                                        onEdit: () {
                                          context.read<ShippingBloc>().add(
                                                SetEditItemEvent(
                                                    item: state.items[index]),
                                              );
                                          context.read<CoreBloc>().add(
                                                ChangePageEvent(
                                                  page: PageType.editShipping,
                                                ),
                                              );
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        state.items[index].zoneRegions.fold(
                                          "",
                                          (previousValue, element) =>
                                              "$previousValue ${element} |",
                                        ),
                                        style: textTheme.bodyMedium,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        state.items[index].shippingMethod.name,
                                        style: textTheme.headlineMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).withMargin(20, 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
