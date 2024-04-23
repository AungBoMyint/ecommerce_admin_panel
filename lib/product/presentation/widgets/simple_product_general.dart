import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class SimpleProductGeneral extends StatefulWidget {
  const SimpleProductGeneral({
    super.key,
  });

  @override
  State<SimpleProductGeneral> createState() => _SimpleProductGeneralState();
}

class _SimpleProductGeneralState extends State<SimpleProductGeneral> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            25.hSpace(),
            const Text("Regular price (MMK)"),
            25.hSpace(),
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  initialValue: getRegularPrice(),
                  onChanged: changeRegularPrice,
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
            25.hSpace(),
          ],
        ),
        20.vSpace(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            25.hSpace(),
            const Text("Sale price (MMK)"),
            45.hSpace(),
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  initialValue: getSalePrice(),
                  onChanged: changeSalePrice,
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
            25.hSpace(),
          ],
        ),
      ],
    );
  }

  void changeRegularPrice(String value) {
    formData[regularPrice] = value;
  }

  void changeSalePrice(String value) {
    formData[salePrice] = value;
  }

  getRegularPrice() {
    try {
      return formData[regularPrice];
    } catch (e) {
      return "";
    }
  }

  getSalePrice() {
    try {
      return formData[salePrice];
    } catch (e) {
      return "";
    }
  }
}
