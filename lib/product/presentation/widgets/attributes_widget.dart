import 'dart:developer';

import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../core/presentation/widgets/link_text_button.dart';

class AttributesWidget extends StatefulWidget {
  const AttributesWidget({
    super.key,
  });

  @override
  State<AttributesWidget> createState() => _AttributesWidgetState();
}

class _AttributesWidgetState extends State<AttributesWidget> {
  Map<int, Map<String, String>> attributes = {};

  @override
  void initState() {
    initAttributes();
    super.initState();
  }

  void initAttributes() {
    try {
      attributes = formData[attributesKey] ?? {};
      if (mounted) {
        setState(() {
          attributes = attributes;
        });
      }
    } catch (e) {
      log("🎯-------Error Attributes..");
    }
  }

  void addNew() {
    try {
      attributes.putIfAbsent((attributes.length + 1), () => {});
      log("🎯--------Added: ${(attributes.length + 1)}");
      if (mounted) {
        setState(() {
          attributes = attributes;
        });
      }
      formData[attributesKey] = attributes;
    } catch (e) {
      log("🧉--------Add new exception: $e");
    }
  }

  void remove(int key) {
    try {
      attributes.remove(key);
      log("🎯--------Removed: $key");
      if (mounted) {
        setState(() {
          attributes = attributes;
        });
      }
      formData[attributesKey] = attributes;
    } catch (e) {
      log("🧉--------Add new exception: $e");
    }
  }

  void changeName(int key, String? v) {
    if (mounted) {
      setState(() {
        attributes[key]?["name"] = v ?? "";
      });
    }
  }

  void changeValue(int key, String? v) => attributes[key]?["value"] = v ?? "";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              const DropDownWidget(
                width: 220,
                hintText: "Custom product attribute",
                items: ["Custom product attribute"],
              ),
              20.hSpace(),
              LinkTextButton(
                height: 35,
                onPressed: () => addNew(),
                text: "Add",
              ),
            ],
          ).withPadding(20, 0),
          20.vSpace(),
          /* Expanded(
              child:  */
          SingleChildScrollView(
            child: Column(
              children: attributes.entries.map((e) {
                return Container(
                  key: ValueKey("${e.key}"),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: ExpandablePanel(
                    header: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.value["name"] ?? "New attribute",
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Icon(
                            FontAwesomeIcons.gripLines,
                            color: Colors.grey.shade400,
                          ),
                          const Gap(20),
                          TextButton(
                              onPressed: () => remove(e.key),
                              child: Text(
                                "Remove",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.red,
                                ),
                              ))
                        ],
                      ).withPadding(20, 0),
                    ),
                    collapsed: const SizedBox(),
                    expanded: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Name
                        SizedBox(
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Name:"),
                              5.vSpace(),
                              SizedBox(
                                height: 45,
                                width: 200,
                                child: TextFormField(
                                  cursorHeight: 15,
                                  initialValue: e.value["name"],
                                  onChanged: (v) => changeName(e.key, v),
                                  decoration: InputDecoration(
                                    hintText: "f.e. size or color",
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
                        ),
                        20.hSpace(),
                        //Value(s)
                        SizedBox(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Value (s):"),
                              5.vSpace(),
                              SizedBox(
                                height: 65,
                                width: 350,
                                child: TextFormField(
                                  cursorHeight: 15,
                                  maxLines: 5,
                                  initialValue: e.value['value'],
                                  onChanged: (v) => changeValue(e.key, v),
                                  decoration: InputDecoration(
                                    hintStyle: textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade700,
                                    ),
                                    hintText:
                                        "Enter options for customers to choose from, f.e. 'Blue' or 'Large'.Use '|' to sperate differeent options",
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).withPadding(20, 0),
                  ), /*  Column(
                    children: [
                      //
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New attribute",
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () => remove(e.key),
                                child: Text(
                                  "Remove",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.red,
                                  ),
                                ))
                          ],
                        ).withPadding(20, 0),
                      ),
                      5.vSpace(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Name
                          SizedBox(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Name:"),
                                5.vSpace(),
                                SizedBox(
                                  height: 45,
                                  width: 200,
                                  child: TextFormField(
                                    cursorHeight: 15,
                                    initialValue: e.value["name"],
                                    onChanged: (v) => changeName(e.key, v),
                                    decoration: InputDecoration(
                                      hintText: "f.e. size or color",
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
                          ),
                          20.hSpace(),
                          //Value(s)
                          SizedBox(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Value (s):"),
                                5.vSpace(),
                                SizedBox(
                                  height: 65,
                                  width: 350,
                                  child: TextFormField(
                                    cursorHeight: 15,
                                    maxLines: 5,
                                    initialValue: e.value['value'],
                                    onChanged: (v) => changeValue(e.key, v),
                                    decoration: InputDecoration(
                                      hintStyle: textTheme.bodySmall?.copyWith(
                                        color: Colors.grey.shade700,
                                      ),
                                      hintText:
                                          "Enter options for customers to choose from, f.e. 'Blue' or 'Large'.Use '|' to sperate differeent options",
                                      border: const OutlineInputBorder(),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).withPadding(20, 0),
                    ],
                  ),
                */
                );
              }).toList(),
            ),
          ) /* ListView.separated(
              separatorBuilder: (context, index) {
                return 20.vSpace();
              },
              itemBuilder: (context, index) {
                final item = attributes.entries.toList()[index];
                return Container(
                  key: ValueKey("${item.key}"),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    children: [
                      //
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New attribute",
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () => remove(item.key),
                                child: Text(
                                  "Remove",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.red,
                                  ),
                                ))
                          ],
                        ).withPadding(20, 0),
                      ),
                      5.vSpace(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Name
                          SizedBox(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Name:"),
                                5.vSpace(),
                                SizedBox(
                                  height: 45,
                                  width: 200,
                                  child: TextFormField(
                                    cursorHeight: 15,
                                    initialValue: attributes[index]?['name'],
                                    onChanged: (v) => changeName(index, v),
                                    decoration: InputDecoration(
                                      hintText: "f.e. size or color",
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
                          ),
                          20.hSpace(),
                          //Value(s)
                          SizedBox(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Value (s):"),
                                5.vSpace(),
                                SizedBox(
                                  height: 65,
                                  width: 350,
                                  child: TextFormField(
                                    cursorHeight: 15,
                                    maxLines: 5,
                                    initialValue: attributes[index]?['value'],
                                    onChanged: (v) => changeName(index, v),
                                    decoration: InputDecoration(
                                      hintStyle: textTheme.bodySmall?.copyWith(
                                        color: Colors.grey.shade700,
                                      ),
                                      hintText:
                                          "Enter options for customers to choose from, f.e. 'Blue' or 'Large'.Use '|' to sperate differeent options",
                                      border: const OutlineInputBorder(),
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).withPadding(20, 0),
                    ],
                  ),
                );
              },
              itemCount: attributes.length,
            ),
          */
          /*  ), */
        ],
      ),
    );
  }
}
