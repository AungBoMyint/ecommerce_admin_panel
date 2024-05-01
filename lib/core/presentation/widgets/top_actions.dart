import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'link_text_button.dart';

class TopActions extends StatelessWidget {
  const TopActions({
    super.key,
    required this.title,
    required this.searchHint,
    this.onAddNew,
    this.onSearch,
  });

  final String title;
  final String searchHint;
  final void Function()? onAddNew;
  final void Function()? onSearch;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        10.vSpace(),
        SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.hSpace(),
              Text(
                title,
                style: textTheme.displayLarge,
              ),
              20.hSpace(),
              onAddNew == null
                  ? 0.vSpace()
                  : LinkTextButton(
                      height: 30,
                      fillColor: linkBTNColor,
                      text: "Add New",
                      onPressed: onAddNew,
                    ),
            ],
          ),
        ),
        10.vSpace(),
        //Search
        searchHint.isEmpty
            ? const Gap(0)
            : Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  width: 400,
                  height: 35,
                  child: Row(
                    children: [
                      //search textform
                      const Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            border: searchTextBorder,
                            disabledBorder: searchTextBorder,
                            enabledBorder: searchTextBorder,
                            focusedBorder: searchTextBorder,
                            contentPadding: EdgeInsets.only(left: 5)),
                        cursorHeight: 15,
                        cursorColor: linkBTNColor,
                      )),
                      10.hSpace(),
                      //search btn
                      LinkTextButton(
                        fillColor: linkBTNColor,
                        onPressed: onSearch,
                        text: searchHint,
                      )
                    ],
                  ),
                ),
              ),
        10.vSpace(),
      ],
    );
  }
}
