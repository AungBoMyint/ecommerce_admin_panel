import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalysisData {
  final String name;
  final int number;
  final IconData iconData;
  AnalysisData({
    required this.name,
    required this.number,
    required this.iconData,
  });
}

List<AnalysisData> analysisCards = [
  AnalysisData(
    name: "Total Orders",
    number: 1200,
    iconData: FontAwesomeIcons.moneyBillWave,
  ),
  AnalysisData(
      name: "Total Users", number: 150, iconData: FontAwesomeIcons.users),
  AnalysisData(
      name: "Total Revenue",
      number: 15267532,
      iconData: FontAwesomeIcons.moneyCheck),
  AnalysisData(
    name: "Total Products",
    number: 15,
    iconData: FontAwesomeIcons.superpowers,
  ),
  AnalysisData(
      name: "Mode of Payment",
      number: 15,
      iconData: FontAwesomeIcons.creditCard),
  AnalysisData(
      name: "Total Staff", number: 15, iconData: FontAwesomeIcons.chartBar)
];
