import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class AdvancedProductType extends StatefulWidget {
  const AdvancedProductType({
    super.key,
  });

  @override
  State<AdvancedProductType> createState() => _AdvancedProductTypeState();
}

class _AdvancedProductTypeState extends State<AdvancedProductType> {
  String purchase = "";
  String menu = "";
  bool review = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  void changeReview(bool? value) {
    try {
      if (mounted) {
        setState(() {
          review = value!;
        });
        formData[enableReview] = value;
      }
    // ignore: empty_catches
    } catch (e) {}
  }

  void changeMenu(String value) {
    try {
      if (mounted) {
        setState(() {
          menu = value;
        });
        formData[menuOrder] = value;
      }
    } catch (e) {
      log("----error: $e");
    }
  }

  void changePurchase(String value) {
    try {
      if (mounted) {
        setState(() {
          purchase = value;
        });
        formData[purchaseNote] = value;
      }
    } catch (e) {
      log("---error: $e");
    }
  }

  void init() {
    try {
      if (mounted) {
        setState(() {
          purchase = formData[purchaseNote] ?? "";
          menu = formData[menuOrder] ?? "";
          review = formData[enableReview] ?? "";
        });
      }
    } catch (e) {
      log("🎯---Error Advanced Product Init: $e");
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
            fixedWidth: 150,
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
          DataRow2(specificRowHeight: 100, cells: [
            const DataCell(Text("Purchase note")),
            DataCell(
              TextFormField(
                maxLines: 5,
                cursorHeight: 15,
                onChanged: changePurchase,
                initialValue: purchase,
                decoration: const InputDecoration(
                  hintText: "",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
              ).withPadding(0, 10),
            ),
            DataCell(0.vSpace()),
          ]),
          DataRow2(specificRowHeight: 80, cells: [
            const DataCell(Text("Menu order")),
            DataCell(
              TextFormField(
                cursorHeight: 15,
                onChanged: changeMenu,
                initialValue: menu,
                decoration: const InputDecoration(
                  hintText: "0",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                ),
              ),
            ),
            DataCell(0.vSpace()),
          ]),
          DataRow2(
            cells: [
              const DataCell(
                Text("Enable reviews"),
              ),
              DataCell(
                Checkbox(
                  value: review,
                  onChanged: changeReview,
                ),
              ),
              DataCell(0.vSpace()),
            ],
          ),
        ],
      ),
    );
  }
}
