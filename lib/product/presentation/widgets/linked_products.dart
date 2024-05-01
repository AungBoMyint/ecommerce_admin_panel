import 'dart:developer';
import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_searchable.dart';

import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class LinkedProducts extends StatefulWidget {
  const LinkedProducts({
    super.key,
  });

  @override
  State<LinkedProducts> createState() => _LinkedProductsState();
}

class _LinkedProductsState extends State<LinkedProducts> {
  @override
  void initState() {
    initSells();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: SizedBox(
                  width: 100,
                  child: Text("Upsells"),
                ),
              ),
              SizedBox(
                width: width - 120,
                child: Wrap(
                  children: [
                    LabelDropDownSearchable(
                      getName: (v) => v,
                      onChanged: changeUpSells,
                      items: const [
                        "Basic Programming Language",
                        "AI model tranning with Python",
                        "Advance English Course",
                        "Understanding Design Pattern",
                        "Figma Course For Beginner",
                        "Photoshop Full Course",
                        "Machine Learning With Python",
                        "Java for Bank Network",
                        "What are you doing right now?",
                        "Understanding what you are in real life!",
                        "Know yourself about your job.",
                      ],
                      textEditingController: TextEditingController(),
                      hintText: "Search for a product",
                      width: 350,
                    ),
                    for (var e in upSellsList) ...[
                      Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Wrap(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                e,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const Gap(5),
                              InkWell(
                                onTap: () => removeUpSells(e),
                                child: const Icon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.remove,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ))
                    ]
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: SizedBox(
                  width: 100,
                  child: Text("Cross-sells"),
                ),
              ),
              SizedBox(
                width: width - 120,
                child: Wrap(
                  children: [
                    LabelDropDownSearchable(
                      getName: (v) => v,
                      onChanged: changeCrossSells,
                      items: const [
                        "Basic Programming Language",
                        "AI model tranning with Python",
                        "Advance English Course",
                        "Understanding Design Pattern",
                        "Figma Course For Beginner",
                        "Photoshop Full Course",
                        "Machine Learning With Python",
                        "Java for Bank Network",
                        "What are you doing right now?",
                        "Understanding what you are in real life!",
                        "Know yourself about your job.",
                      ],
                      textEditingController: TextEditingController(),
                      hintText: "Search for a product",
                      width: 350,
                    ),
                    for (var e in crossSellsList) ...[
                      Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Wrap(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                e,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const Gap(5),
                              InkWell(
                                onTap: () => removeCrossSells(e),
                                child: const Icon(
                                  // ignore: deprecated_member_use
                                  FontAwesomeIcons.remove,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ))
                    ]
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  List<String> getCrossSells() {
    try {
      return formData[crossSells];
    } catch (e) {
      return crossSellsList;
    }
  }

  List<String> crossSellsList = [];
  void changeCrossSells(String? p1) {
    if (crossSellsList.contains(p1)) {
      return;
    }
    if (mounted && !(p1 == null)) {
      setState(() {
        crossSellsList.add(p1);
      });
      /* formData[crossSells].add(p1); */
    }
  }

  void removeCrossSells(String e) {
    crossSellsList.remove(e);
    if (mounted) {
      setState(() {
        crossSellsList = crossSellsList;
      });
      /* formData[crossSells].remove(e); */
    }
  }

  //up sells
  List<String> getUpSells() {
    try {
      return formData[upSells];
    } catch (e) {
      return upSellsList;
    }
  }

  List<String> upSellsList = [];
  void changeUpSells(String? p1) {
    if (upSellsList.contains(p1)) {
      return;
    }
    if (mounted && !(p1 == null)) {
      setState(() {
        upSellsList.add(p1);
      });
      /* formData[upSells].add(p1); */
    }
  }

  void removeUpSells(String e) {
    upSellsList.remove(e);
    if (mounted) {
      setState(() {
        upSellsList = upSellsList;
      });
      formData[upSells].remove(e);
    }
  }

  void initSells() {
    try {
      crossSellsList = formData[crossSells] as List<String>;
      upSellsList = formData[upSells] as List<String>;
      if (mounted) {
        setState(() {
          crossSellsList = crossSellsList;
          upSellsList = upSellsList;
        });
        log("🥢------Mounted : $mounted");
      }
      log("🥢------Mounted : $mounted");
    } catch (e) {
      log("Error Init Sells: $e");
    }
  }
}
