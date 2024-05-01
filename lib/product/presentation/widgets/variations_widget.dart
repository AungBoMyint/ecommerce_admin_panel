import 'dart:developer';
import 'dart:io';

import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class VariationsWidget extends StatefulWidget {
  const VariationsWidget({super.key});

  @override
  State<VariationsWidget> createState() => _VariationsWidgetState();
}

class _VariationsWidgetState extends State<VariationsWidget> {
  Map<int, Map<String, dynamic>> variations = {};

  @override
  void initState() {
    getVariations();
    super.initState();
  }

  void addNew() {
    try {
      variations.putIfAbsent((variations.length + 1), () => {});
      log("🎯--------Added: ${(variations.length + 1)}");
      if (mounted) {
        setState(() {
          variations = variations;
        });
      }
      formData[variationsKey] = variations;
    } catch (e) {
      log("🧉--------Add new exception: $e");
    }
  }

  void remove(int key) {
    try {
      variations.remove(key);
      log("🎯--------Removed: $key");
      if (mounted) {
        setState(() {
          variations = variations;
        });
      }
      formData[variationsKey] = variations;
    } catch (e) {
      log("🧉--------Add new exception: $e");
    }
  }

  Future<void> takePicture(int key) async {
   
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (!(result == null)) {
      /* File file = File(result.files.single.path ?? ""); */
      setState(() {
        variations[key]!["image"] = result.files.single.path;
      });
    } else {
      // User canceled the picker
    }
  }

  void changeSKU(int key, String value) {
    try {
      variations[key]!["sku"] = value;
    } catch (e) {
      log("Error : $e");
    }
  }

  void changeRegularPrice(int key, String value) {
    try {
      variations[key]!["regular-price"] = value;
    } catch (e) {
      log("Error : $e");
    }
  }

  void changeSalePrice(int key, String value) {
    try {
      variations[key]!["sale-price"] = value;
    } catch (e) {
      log("Error : $e");
    }
  }

  void changeStockStatus(int key, String value) {
    try {
      variations[key]!["stock-status"] = value;
      if (mounted) {
        setState(() {
          variations = variations;
        });
      }
    } catch (e) {
      log("error: $e");
    }
  }

  void getVariations() {
    try {
      variations = formData[variationsKey] ?? {};
      if (mounted) {
        setState(() {
          variations = variations;
        });
      }
    } catch (e) {
      log("🍹----Error Getting Variations: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              LinkTextButton(
                onPressed: () {},
                text: "Generate variations",
              ),
              const Gap(20),
              LinkTextButton(
                onPressed: () => addNew(),
                text: "Add manually",
              ),
            ],
          ),
          const Divider(),
          //Variations Items
          for (var item in variations.entries) ...[
            ExpandablePanel(
              theme: const ExpandableThemeData(
                hasIcon: false,
              ),
              header: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const DropDownWidget(
                        hintText: "Any Color",
                        items: ["Red"],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Icon(
                        FontAwesomeIcons.gripLines,
                        color: Colors.grey.shade400,
                      ),
                      const Gap(20),
                      InkWell(
                        onTap: () => remove(item.key),
                        child: Text(
                          "Remove",
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ).withPadding(10, 5),
                  const Divider(),
                ],
              ),
              collapsed: const SizedBox(),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //photo
                      IconButton(
                        onPressed: () => takePicture(item.key),
                        icon: const Icon(
                          FontAwesomeIcons.image,
                          color: linkBTNColor,
                          size: 65,
                        ),
                      ),
                      !(variations[item.key]?["image"] == null)
                          ? Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.grey,
                              )),
                              child: Image.file(
                                File(variations[item.key]?["image"]),
                                height: 65,
                                width: 65,
                              ),
                            )
                          : const SizedBox(),
                      Expanded(child: Container()),
                      //sku
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SKU",
                            style: textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: TextFormField(
                              cursorHeight: 15,
                              onChanged: (v) => changeSKU(item.key, v),
                              initialValue: variations[item.key]?["sku"],
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade700,
                                ),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).withPadding(10, 5),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Regular Price (MMK)",
                            style: textTheme.bodyMedium,
                          ),
                          const Gap(5),
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: TextFormField(
                              cursorHeight: 15,
                              onChanged: (v) => changeRegularPrice(item.key, v),
                              initialValue: variations[item.key]
                                  ?["regular-price"],
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade700,
                                ),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sale Price (MMK)",
                            style: textTheme.bodyMedium,
                          ),
                          const Gap(5),
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: TextFormField(
                              cursorHeight: 15,
                              onChanged: (v) => changeSalePrice(item.key, v),
                              initialValue: variations[item.key]?["sale-price"],
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade700,
                                ),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.only(
                                  left: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).withPadding(10, 5),
                  ////Stock Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stock status",
                        style: textTheme.bodyMedium,
                      ),
                      DropDownWidget<String>(
                        width: 250,
                        onChanged: (v) => changeStockStatus(item.key, v ?? ""),
                        value: variations[item.key]?["stock-status"],
                        hintText: "Stock status",
                        items: const [
                          "In stock",
                          "Out of stock",
                        ],
                      ),
                    ],
                  ).withPadding(10, 5),
                  const Gap(25),
                  const Divider(),
                  const Gap(25),
                ],
              ),
            ),
            /*    Column(
              key: ValueKey("${item.key}"),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropDownWidget(
                      hintText: "Any Color",
                      items: ["Red"],
                    ),
                    InkWell(
                      onTap: () => remove(item.key),
                      child: Text(
                        "Remove",
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ).withPadding(10, 5),
                Divider(),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //photo
                    IconButton(
                      onPressed: () => takePicture(item.key),
                      icon: const Icon(
                        FontAwesomeIcons.image,
                        color: linkBTNColor,
                        size: 65,
                      ),
                    ),
                    !(variations[item.key]?["image"] == null)
                        ? Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.grey,
                            )),
                            child: Image.file(
                              File(variations[item.key]?["image"]),
                              height: 65,
                              width: 65,
                            ),
                          )
                        : const SizedBox(),
                    Expanded(child: Container()),
                    //sku
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SKU",
                          style: textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: 45,
                          width: 200,
                          child: TextFormField(
                            cursorHeight: 15,
                            onChanged: (v) => changeSKU(item.key, v),
                            initialValue: variations[item.key]?["sku"],
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade700,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).withPadding(10, 5),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Regular Price (MMK)",
                          style: textTheme.bodyMedium,
                        ),
                        Gap(5),
                        SizedBox(
                          height: 45,
                          width: 200,
                          child: TextFormField(
                            cursorHeight: 15,
                            onChanged: (v) => changeRegularPrice(item.key, v),
                            initialValue: variations[item.key]
                                ?["regular-price"],
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade700,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sale Price (MMK)",
                          style: textTheme.bodyMedium,
                        ),
                        Gap(5),
                        SizedBox(
                          height: 45,
                          width: 200,
                          child: TextFormField(
                            cursorHeight: 15,
                            onChanged: (v) => changeSalePrice(item.key, v),
                            initialValue: variations[item.key]?["sale-price"],
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade700,
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).withPadding(10, 5),
                ////Stock Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stock status",
                      style: textTheme.bodyMedium,
                    ),
                    DropDownWidget(
                      width: 250,
                      onChanged: (v) => changeStockStatus(item.key, v ?? ""),
                      value: variations[item.key]?["stock-status"],
                      hintText: "Stock status",
                      items: const [
                        "In stock",
                        "Out of stock",
                      ],
                    ),
                  ],
                ).withPadding(10, 5),
              ],
            ),
           */
          ]
        ],
      ),
    );
  }
}
