import 'dart:developer';

import 'package:ecommerce_admin/core/constant.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../core/data/form_data.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({super.key});

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  List<String> selectedCategories = [];
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toggleCategory(String value) {
    if (selectedCategories.contains(value)) {
      selectedCategories.remove(value);
      if (mounted) {
        setState(() {});
      }
    } else {
      selectedCategories.add(value);
      setState(() {});
    }
  }

  void getCategories() {
    try {
      selectedCategories = formData[productCategoriesKey] ?? [];

      if (mounted) {
        setState(() {
          selectedCategories = selectedCategories;
        });
      }
    } catch (e) {
      log("🧉--------Get categories exception: $e");
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
            "Product categories",
            style: textTheme.bodyMedium,
          ),
        ),
        for (var category in categories) ...[
          hasChild(category, textTheme).withPadding(20, 0)
        ]
        /* ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final category = categories[index];
            return hasChild(category, textTheme);
          },
          itemCount: categories.length,
        ) */
        ,
      ],
    ).withElevation(
        border: Border.all(
      color: Colors.grey,
    ));
  }

  Widget hasChild(Category category, TextTheme textTheme) {
    if (category.hasChild) {
      return Column(
        children: [
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            value: selectedCategories.contains(category.name),
            onChanged: (v) => toggleCategory(category.name),
            title: Text(
              category.name,
              style: textTheme.bodyMedium,
            ),
          ),
          for (var child in category.children) ...[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: hasChild(child, textTheme),
            ),
          ]
        ],
      );
    } else {
      return CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: selectedCategories.contains(category.name),
        onChanged: (v) => toggleCategory(category.name),
        title: Text(
          category.name,
          style: textTheme.bodyMedium,
        ),
      );
    }
  }
}
