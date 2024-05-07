import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

abstract class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context);
}

class AppBar1 extends MyAppBar {
  const AppBar1({super.key});

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "AppBar1";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 65,
      child: Row(
        children: [
          const Icon(
            Icons.dehaze_sharp,
          ),
          Gap(25),
          Text(
            "Page Title",
            style: textTheme.displayLarge,
          ),
          Gap(60),
          Icon(
            Icons.favorite_outline_rounded,
            color: Colors.red,
          ),
          Gap(20),
          Icon(
            Icons.search,
          ),
          Gap(20),
          Icon(
            Icons.notifications,
          ),
        ],
      ),
    );
  }
}

class AppBar2 extends MyAppBar {
  const AppBar2({super.key});

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "AppBar2";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Page Title",
            style: textTheme.displayLarge,
          ),
          const Icon(
            Icons.search,
          ),
        ],
      ),
    );
  }
}
