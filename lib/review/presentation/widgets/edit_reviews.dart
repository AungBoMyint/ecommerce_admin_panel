import 'package:ecommerce_admin/review/presentation/widgets/review_form.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';

class EditReviews extends StatelessWidget {
  const EditReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Edit review",
            style: textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          20.vSpace(),
          //Category Form
          const ReviewForm(),
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
