// Created by AMIT JANGID on 6/22/2021.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'color_controller.dart';

ColorController colorController = Get.put(ColorController());
 TextStyle textStyle30Bold = TextStyle(
  fontSize: 30,
  letterSpacing: 0.55,
  color: colorController.kPrimaryColor,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle30Normal =
TextStyle(fontSize: 30, letterSpacing: 0.55, color: colorController.kPrimaryColor);

 TextStyle textStyle24Bold = TextStyle(
  fontSize: 24,
  letterSpacing: 0.55,
  color: colorController.kPrimaryColor,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle24Normal =
TextStyle(fontSize: 24, letterSpacing: 0.55, color: colorController.kPrimaryColor);

 TextStyle textStyle20Bold = TextStyle(
  fontSize: 20,
  letterSpacing: 0.55,
  color: colorController.kPrimaryDarkColor,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle20Bold2 = TextStyle(
  fontSize: 20,
  letterSpacing: 0.55,
  color: colorController.kBgColor,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle20Normal =
TextStyle(fontSize: 20, letterSpacing: 0.55, color: colorController.kPrimaryColor);

 TextStyle textStyle18Bold = TextStyle(
  fontSize: 18,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle18UBold = TextStyle(
  fontSize: 18,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w800,
);

 TextStyle textStyle18Normal =
TextStyle(fontSize: 18, letterSpacing: 0.55, color: colorController.kBlackShadeColor);

 TextStyle textStyle16Bold = TextStyle(
  fontSize: 16,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w700,
);

 TextStyle textStyle16Bold14 = TextStyle(
  fontSize: 14,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w700,
);

 TextStyle textStyle16Normal =
TextStyle(fontSize: 16, letterSpacing: 0.55, color: colorController.kBlackShadeColor);

 TextStyle textStyle15Bold = TextStyle(
  fontSize: 15,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle15Normal =
TextStyle(fontSize: 15, letterSpacing: 0.55, color: colorController.kBlackShadeColor);

 TextStyle textStyle14Bold = TextStyle(
  fontSize: 14,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w600,
);
 TextStyle textStyle14Bold4 = TextStyle(
  fontSize: 14,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w400,
);
TextStyle textStyle14BoldClick =
TextStyle(fontSize: 15, letterSpacing: 0.55, color: Colors.blue[600]);

 TextStyle textStyle14Normal =
TextStyle(fontSize: 14, letterSpacing: 0.55, color: colorController.kBlackShadeColor,);

 TextStyle textStyle13Bold = TextStyle(
  fontSize: 13,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle13Normal =
TextStyle(fontSize: 13, letterSpacing: 0.55, color: colorController.kBlackShadeColor);

 TextStyle textStyle10Normal = TextStyle(
    fontSize: 13,
    letterSpacing: 0.55,
    color: colorController.kBlackShadeColor,
    fontWeight: FontWeight.w400);
 TextStyle textStyle10brown = TextStyle(
    fontSize: 10,
    letterSpacing: 0.55,
    color: colorController.kUnselectedColor,
    fontWeight: FontWeight.w500);
const TextStyle textStyle10black = TextStyle(
    fontSize: 10,
    letterSpacing: 0.55,
    color: Colors.black,
    fontWeight: FontWeight.w500);

const TextStyle textStyle10blackweight = TextStyle(
    fontSize: 10,
    letterSpacing: 0.55,
    color: Colors.black,
    fontWeight: FontWeight.w300);
 TextStyle textStyle18brown = TextStyle(
    fontSize: 16,
    letterSpacing: 0.55,
    color: colorController.kUnselectedColor,
    fontWeight: FontWeight.w500);

 TextStyle textStyle18brown16 = TextStyle(
    fontSize: 16,
    letterSpacing: 0.55,
    color: colorController.kUnselectedColor,
    fontWeight: FontWeight.w500);

 TextStyle textStyle12Bold = TextStyle(
  fontSize: 12,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle12Normal =
TextStyle(fontSize: 12, letterSpacing: 0.55, color: colorController.kBlackShadeColor);
TextStyle textStyle10telNormal =
TextStyle(fontSize: 10, letterSpacing: 0.40, color: colorController.kBlackShadeColor);
 TextStyle textStyle12Normalblack =
TextStyle(fontSize: 12, letterSpacing: 0.55, color: colorController.kBlackColor);

const TextStyle buttonTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle8normal = TextStyle(
  fontSize: 8,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w300,
);
 TextStyle textStyle8Bold = TextStyle(
  fontSize: 8,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w600,
);

 TextStyle textStyle9Bold = TextStyle(
  fontSize: 9,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w700,
);
 TextStyle textStyle13Normalpro =
TextStyle(fontSize: 20, letterSpacing: 0.55, color: colorController.kBlackShadeColor);
 TextStyle textStyle15Boldpro = TextStyle(
  fontSize: 24,
  color: colorController.kBlackColor,
  letterSpacing: 0.55,
  fontWeight: FontWeight.w600,
);


 TextStyle textStyle9Normal =
TextStyle(fontSize: 9, letterSpacing: 0.55, color: colorController.kBlackShadeColor);
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}