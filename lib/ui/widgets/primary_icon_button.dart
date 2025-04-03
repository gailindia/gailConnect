// Created By Amit Jangid 13/07/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:get/get.dart';

class PrimaryIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color btnColor;
  final VoidCallback onPressed;
  final TextStyle? btnTextStyle;
  final EdgeInsetsGeometry margin;
  final double height, borderRadius;

  const PrimaryIconButton({
    Key? key,
    this.height = 48,
    this.borderRadius = 12,
    this.btnColor = Colors.black,
    this.btnTextStyle = buttonTextStyle,
    this.margin = const EdgeInsets.only(top: 12),
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ColorController colorController = Get.put(ColorController());
    return GetBuilder<ColorController>(
      init: ColorController(),
      id: 'color',
      builder: (colorController) {
        return Container(
          height: height,
          margin: margin,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: 20,color: Colors.white,),
            clipBehavior: Clip.antiAlias,
            label: Text(text.toUpperCase(), style: buttonTextStyle.copyWith(fontSize: 13)),
            style: ElevatedButton.styleFrom(
              elevation: 4, backgroundColor: colorController.kPrimaryColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            ),
          ),
        );
      }
    );
  }
}
