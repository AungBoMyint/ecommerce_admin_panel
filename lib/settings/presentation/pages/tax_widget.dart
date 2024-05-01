import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class TaxWidget extends StatelessWidget {
  const TaxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Text(
          "Settings Tax",
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).withPadding(20, 0),
        const Gap(20),
        SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tax include or not",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ).withPadding(20, 10),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: RadioListTile(
                      value: "Yes",
                      groupValue: "Yes",
                      onChanged: (v) {},
                      title: Text(
                        "Yes, include tax",
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    height: 30,
                    width: 250,
                    child: RadioListTile(
                      value: "No",
                      groupValue: "Yes",
                      onChanged: (v) {},
                      title: Text(
                        "No, not include tax",
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const Gap(20),
        //Tax input
        Row(
          children: [
            Text(
              "Tax percentage",
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).withPadding(25, 0),
            const Gap(35),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35,
                  width: 200,
                  child: TextFormField(
                    cursorHeight: 15,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  "%",
                  style: textTheme.bodyMedium,
                )
              ],
            ),
          ],
        ),
        //Save
        const Gap(20),
        SizedBox(
          width: 150,
          child: LinkTextButton(
            height: 35,
            onPressed: () {},
            text: "Save",
            fillColor: linkBTNColor,
          ),
        ).withPadding(20, 0),
        const Gap(20),
        //Expanded ListView
        SizedBox(
          height: 50,
          width: 400,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(
                  "1",
                  style: textTheme.bodyMedium,
                ),
                title: Text(
                  "Tax",
                  style: textTheme.bodyMedium,
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      // ignore: deprecated_member_use
                      FontAwesomeIcons.remove,
                      color: Colors.red,
                    )),
              ).withElevation(border: Border.all(color: Colors.grey.shade400));
            },
            itemCount: 2,
          ),
        ).withPadding(20, 0),
      ],
    );
  }
}
