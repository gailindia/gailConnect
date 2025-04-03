/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */ // Created By Amit Jangid 13/07/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:get/get.dart';

class ElevatedButtonPending extends StatelessWidget {
  final String status;
  final String cancelstatus;
  final String ackno;
  final String text;
  final double? width;
  final Color? btnColor;
  final OutlinedBorder shape;
  final VoidCallback onPressed;
  final double height, elevation;

  const ElevatedButtonPending({
    Key? key,
    this.width,
    this.height = 48,
    this.elevation = 4,
    this.btnColor = Colors.black,
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    required this.status,
    required this.cancelstatus,
    required this.ackno,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (context) {
          return _DefaultButton(
            status: status,
            cancelstatus: cancelstatus,
            ackno: ackno,
            text: text,
            width: width,
            shape: shape,
            height: height,
            btnColor: btnColor,
            elevation: elevation,
            onPressed: onPressed,
            btnTextStyle: buttonTextStyle,
          );
        });
  }
}

class _DefaultButton extends StatelessWidget {
  final String? status;
  final String cancelstatus;
  final String ackno;
  final String? text;
  final double? width;
  final Color? btnColor;
  final Function onPressed;
  final OutlinedBorder shape;
  final TextStyle? btnTextStyle;
  final double height, elevation;
  final EdgeInsetsGeometry margin;
  final bool isEnabled, isUpperCase;

  const _DefaultButton({
    this.width,
    this.btnColor,
    this.height = 48,
    this.elevation = 4,
    this.isEnabled = true,
    this.isUpperCase = false,
    this.margin = const EdgeInsets.only(top: 12),
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24))),
    this.btnTextStyle = const TextStyle(
      fontSize: 14,
      letterSpacing: 0.27,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    required this.status,
    required this.cancelstatus,
    required this.ackno,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    Color cancelColor = status.toString() == "Processed" ||
            status.toString() == "Received" ||
            status.toString() == "Processing" && cancelstatus == null
        ? colorController.kPrimaryDarkColor
        : colorController.kDarkGreyColor;
    Color ackcolor = status.toString() == "Delivered"
        ? colorController.kPrimaryDarkColor
        : colorController.kDarkGreyColor;

    return status == 'circle'
        ? Icon(Icons.circle,
            color: ackno.toString() == "1"
                ? (ackno.toString() == "Cancelled"
                    ? colorController.kPrimaryColor
                    : colorController.kPrimaryColor)
                : (ackno.toString() == "0"
                    ? colorController.kPrimaryColor
                    : colorController.kPrimaryColor))
        : Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 5),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: isEnabled ? onPressed as void Function()? : null,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))), backgroundColor: text == 'View'
                        ? colorController.kPrimaryDarkColor
                        : text == 'Cancel'
                            ? cancelColor
                            : ackcolor,
                    elevation: 5,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  child: FittedBox(
                    child: Text(text.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ),
            ),
          );
  }
}
