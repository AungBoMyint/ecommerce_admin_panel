import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';

import 'category_form.dart';

class EditCategory extends StatelessWidget {
  const EditCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Edit new category",
            style: textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          20.vSpace(),
          //Category Form
          const CategoryForm(),
          20.vSpace(),
          //sumbit button
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Update",
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              20.hSpace(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Delete",
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          )
        ],
      ).withMargin(20, 20),
    );
  }
}
