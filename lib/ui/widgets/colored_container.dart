// Created By Amit Jangid 06/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

class ColoredContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final GestureTapCallback? onTap;

  const ColoredContainer(
      {Key? key, this.onTap, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration:  BoxDecoration(
            color: colorController.kPrimaryLightColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            horizontalSpace6,
            Text(text,
                style: textStyle13Normal.apply(
                    fontSizeFactor: 0.9, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
