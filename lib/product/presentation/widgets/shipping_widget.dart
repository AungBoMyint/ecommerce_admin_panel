import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';


class ShippingWidget extends StatefulWidget {
  const ShippingWidget({
    super.key,
  });

  @override
  State<ShippingWidget> createState() => _ShippingWidgetState();
}

class _ShippingWidgetState extends State<ShippingWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DataTable2(
        headingRowHeight: 0,
        showBottomBorder: true,
        columns: const [
          DataColumn2(
            label: Text(""),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text(""),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text(""),
            size: ColumnSize.S,
            fixedWidth: 20,
          ),
        ],
        rows: [
          DataRow2(
            specificRowHeight: 80,
            cells: [
              const DataCell(Text("Weight (kg)")),
              DataCell(
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    cursorHeight: 15,
                    initialValue: getWeight(),
                    onChanged: changeWeight,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "0",
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(Container()),
            ],
          ),
          DataRow2(specificRowHeight: 80, cells: [
            const DataCell(Text("Dimensions (cm)")),
            DataCell(Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      cursorHeight: 15,
                      onChanged: changeLength,
                      initialValue: getLength(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Length",
                        contentPadding: EdgeInsets.only(
                          left: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                10.hSpace(),
                //Width
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      cursorHeight: 15,
                      initialValue: getWidth(),
                      onChanged: changeWidth,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Width",
                        contentPadding: EdgeInsets.only(
                          left: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                10.hSpace(),
                //Height
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      cursorHeight: 15,
                      initialValue: getHeight(),
                      onChanged: changeHeight,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Height",
                        contentPadding: EdgeInsets.only(
                          left: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            DataCell(0.vSpace()),
          ]),
          DataRow2(specificRowHeight: 80, cells: [
            const DataCell(
              Text(
                "Shipping class",
                textAlign: TextAlign.start,
              ),
            ),
            const DataCell(DropDownWidget(
                hintText: "No shipping class", items: ["No shipping class"])),
            DataCell(0.vSpace()),
          ]),
        ],
      ),
    );
  }

  String getWeight() {
    try {
      return formData[weight] ?? "";
    } catch (e) {
      return "";
    }
  }

  void changeWeight(String? v) => formData[weight] = v;

  String getLength() {
    try {
      return formData[length] ?? "";
    } catch (e) {
      return "";
    }
  }

  void changeLength(String? v) => formData[length] = v;

  String getWidth() {
    try {
      return formData[width] ?? "";
    } catch (e) {
      return "";
    }
  }

  void changeWidth(String? v) => formData[width] = v;

  String getHeight() {
    try {
      return formData[height] ?? "";
    } catch (e) {
      return "";
    }
  }

  void changeHeight(String? v) => formData[height] = v;
}
