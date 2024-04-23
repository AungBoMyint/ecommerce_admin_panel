import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class Inventory extends StatefulWidget {
  const Inventory({
    super.key,
  });

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  bool isTrackStockQuantity = false;
  bool? soldIndividual;
  String? stockStatus;
  void changeSoldIndividual(bool value) {
    if (mounted) {
      setState(() {
        soldIndividual = value;
      });
      formData[soldIndividualKey] = value;
    }
  }

  void changeStockStatus(String value) {
    if (mounted) {
      setState(() {
        stockStatus = value;
      });
      formData[stockStatusKey] = value;
    }
  }

  void changeTrackStockQuantity(value) {
    if (mounted) {
      setState(() {
        isTrackStockQuantity = value;
      });
      formData[trackStock] = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DataTable2(
        headingRowHeight: 0,
        border: null,
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
          DataRow(
            cells: [
              const DataCell(Text("SKU")),
              DataCell(
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    initialValue: getSku(),
                    onChanged: changeSKu,
                    cursorHeight: 15,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
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
          DataRow(cells: [
            const DataCell(Text("Stock management")),
            DataCell(Row(
              children: [
                Checkbox(
                  value: (isTrackStockQuantity || getTrackStock()),
                  onChanged: (v) {
                    changeTrackStockQuantity(v ?? false);
                  },
                ),
                const Text("Track stock quantity for this product"),
              ],
            )),
            DataCell(0.vSpace()),
          ]),
          if (isTrackStockQuantity || getTrackStock()) ...[
            DataRow(
              cells: [
                const DataCell(Text(quantity)),
                DataCell(
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      initialValue: getQuantity(),
                      onChanged: changeQuantity,
                      cursorHeight: 15,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
          ],
          DataRow2(specificRowHeight: 100, cells: [
            DataCell(
              Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Stock status",
                  textAlign: TextAlign.start,
                ).withPadding(0, 10),
              ),
            ),
            DataCell(Column(
              children: [
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: "In stock",
                  groupValue: (stockStatus ?? getStockStatus()),
                  onChanged: (v) {
                    changeStockStatus(v ?? "");
                  },
                  title: const Text("In stock"),
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: "Out of stock",
                  groupValue: stockStatus ?? getStockStatus(),
                  onChanged: (v) {
                    changeStockStatus(v ?? "");
                  },
                  title: const Text("Out of stock"),
                ),
              ],
            )),
            DataCell(0.vSpace()),
          ]),
          DataRow(cells: [
            const DataCell(Text("Sold individually")),
            DataCell(
              Row(
                children: [
                  Checkbox(
                    value: soldIndividual ?? getSoldIndividual(),
                    onChanged: (v) {
                      changeSoldIndividual(v ?? false);
                    },
                  ),
                  const Text("Limit purchases to 1 item per order"),
                ],
              ),
            ),
            DataCell(0.vSpace()),
          ]),
        ],
      ),
    );
  }

  bool getSoldIndividual() {
    try {
      return formData[soldIndividualKey] ?? false;
    } catch (e) {
      return false;
    }
  }

  void changeSKu(String value) {
    formData[sku] = value;
  }

  String getSku() {
    try {
      return formData[sku] ?? "";
    } catch (e) {
      return "";
    }
  }

  void changeQuantity(String value) {
    formData[quantity] = value;
  }

  String getQuantity() {
    try {
      return formData[quantity] ?? "";
    } catch (e) {
      return "";
    }
  }

  bool getTrackStock() {
    try {
      return formData[trackStock] ?? false;
    } catch (e) {
      return false;
    }
  }

  String getStockStatus() {
    try {
      return formData[stockStatusKey] ?? "In stock";
    } catch (e) {
      return "In stock";
    }
  }
}
