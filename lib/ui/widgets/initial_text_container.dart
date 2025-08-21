// Created By Amit Jangid 03/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class InitialTextContainer extends StatelessWidget {
  final String text;
  final double width, height, fontSize;
  final Color circleColor;

  const InitialTextContainer(
      {Key? key,
      this.circleColor = Colors.black,
      this.width = 38,
      this.height = 38,
      this.fontSize = 24,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (ColorController) {
          return Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorController.kPrimaryDarkColor),
            child: Text(
              text.substring(0, 1),
              textAlign: TextAlign.center,
              style: textStyle24Bold.copyWith(
                  color: Colors.white, fontSize: fontSize),
            ),
          );
        });
  }
}
