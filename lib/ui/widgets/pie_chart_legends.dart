// Created By Amit Jangid 25/10/21

import 'package:flutter/material.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

class PieChartLegends extends StatelessWidget {
  final Color color;
  final String legendTitle;

  const PieChartLegends({Key? key, required this.color, required this.legendTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 30, height: 18, color: color),
        horizontalSpace6,
        Text(legendTitle, style: textStyle14Normal),
      ],
    );
  }
}
