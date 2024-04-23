import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditShippingWidget extends StatelessWidget {
  const EditShippingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping zones > Thailand",
              style: textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(45),
            SizedBox(
              height: 65,
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Zone name",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(40),
                    Expanded(
                      child: TextFormField(
                        cursorHeight: 15,
                        decoration: const InputDecoration(
                          hintText: "Zone name",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(
                            left: 10,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                );
              }),
            ),
            const Gap(20),
            SizedBox(
              height: 65,
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Zone regions",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: TextFormField(
                        cursorHeight: 15,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: "Zone regions",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                );
              }),
            ),
            const Gap(20),
            SizedBox(
              height: 65,
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Flat rate",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(60),
                    Expanded(
                      child: TextFormField(
                        cursorHeight: 15,
                        decoration: const InputDecoration(
                          hintText: "0",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                );
              }),
            ),
            const Gap(20),
            SizedBox(
              height: 35,
              width: 150,
              child: LinkTextButton(
                onPressed: () {},
                text: "Save changes",
                fillColor: linkBTNColor,
              ),
            )
          ],
        ).withPadding(20, 20);
      }),
    );
  }
}
