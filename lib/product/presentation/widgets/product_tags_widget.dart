import 'dart:developer';

import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class ProductTags extends StatefulWidget {
  const ProductTags({
    super.key,
  });

  @override
  State<ProductTags> createState() => _ProductTagsState();
}

class _ProductTagsState extends State<ProductTags> {
  final TextEditingController tagController = TextEditingController();

  @override
  void initState() {
    getTags();
    super.initState();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  List<String> tags = [];

  void addTags(String value) {
    if (value.isNotEmpty) {
      List<String> list = value.split(",");
      for (var item in list) {
        tags.add(item.trim());
      }
      if (mounted) {
        setState(() {
          tags = tags;
        });
      }
    }
  }

  void removeTags(String value) {
    tags.remove(value);
    if (mounted) {
      setState(() {
        tags = tags;
      });
    }
  }

  void getTags() {
    try {
      tags = formData[productTagsKey] ?? [];

      if (mounted) {
        setState(() {
          tags = tags;
        });
      }
    } catch (e) {
      log("🧉--------Get tags exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: Text(
            "Product tags",
            style: textTheme.bodyMedium,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 35,
                child: TextFormField(
                  cursorHeight: 15,
                  controller: tagController,
                  decoration: const InputDecoration(
                    hintText: "",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
            ),
            10.hSpace(),
            LinkTextButton(
              onPressed: () => addTags(tagController.text),
              text: "Add",
            ),
          ],
        ).withPadding(20, 10),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Separate tags with commas",
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
            ),
          ).withPadding(20, 10),
        ),
        //Tags List if not empty
        tags.isNotEmpty
            ? Wrap(
                children: tags.map((e) {
                  return Container(
                    //color: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: e.length * 16,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => removeTags(e),
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 8,
                            child: Icon(
                              // ignore: deprecated_member_use
                              FontAwesomeIcons.remove,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ),
                        const Gap(5),
                        Text(e),
                      ],
                    ),
                  );
                }).toList(),
              )
            : const SizedBox(),
      ],
    ).withElevation(
        border: Border.all(
      color: Colors.grey,
    ));
  }
}
