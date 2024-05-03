import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../bloc/tag_bloc.dart';

class TagForm extends StatelessWidget {
  const TagForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final isMTABLET = width < MTABLET;
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: isMTABLET ? 150 : 100,
            child: LayoutBuilder(builder: (context, constraints) {
              return ResponsiveRowColumn(
                layout: constraints.maxWidth > 420
                    ? ResponsiveRowColumnType.ROW
                    : ResponsiveRowColumnType.COLUMN,
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveRowColumnItem(
                    child: Text(
                      "Name",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                    child: SizedBox(
                      width: 40,
                      height: 5,
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35,
                            child: BlocBuilder<TagBloc, TagState>(
                              builder: (context, state) {
                                return TextFormField(
                                  cursorHeight: 15,
                                  initialValue: state.name.value,
                                  onChanged: (v) => context
                                      .read<TagBloc>()
                                      .add(ChangeNameEvent(value: v)),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Gap(5),
                          Text(
                            "Name for the attribute (shown on the front-end).",
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  constraints.maxWidth > 420
                      ? ResponsiveRowColumnItem(
                          child: Expanded(
                            child: Container(),
                          ),
                        )
                      : ResponsiveRowColumnItem(child: 0.vSpace()),
                ],
              );
            }),
          ),
          const Gap(15),
          SizedBox(
            height: isMTABLET ? 150 : 120,
            child: LayoutBuilder(builder: (context, constraints) {
              return ResponsiveRowColumn(
                layout: constraints.maxWidth > 420
                    ? ResponsiveRowColumnType.ROW
                    : ResponsiveRowColumnType.COLUMN,
                columnCrossAxisAlignment: CrossAxisAlignment.start,
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveRowColumnItem(
                    child: Text(
                      "Slug",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                    child: SizedBox(
                      width: 40,
                      height: 5,
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35,
                            child: BlocBuilder<TagBloc, TagState>(
                              builder: (context, state) {
                                return TextFormField(
                                  cursorHeight: 15,
                                  initialValue: state.slug,
                                  onChanged: (v) => context
                                      .read<TagBloc>()
                                      .add(ChangeSlugEvent(value: v)),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Gap(5),
                          Text(
                            "Unique slug/reference for the attribute;must be no more than 28 characters.",
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  constraints.maxWidth > 420
                      ? ResponsiveRowColumnItem(
                          child: Expanded(
                          child: Container(),
                        ))
                      : ResponsiveRowColumnItem(child: 0.vSpace()),
                ],
              );
            }),
          ),
          const Gap(20),
        ],
      );
    });
  }
}
