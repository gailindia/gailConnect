// Created by AMIT JANGID on 6/22/2021.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'color_controller.dart';

ThemeData themeData() {
  ColorController colorController = Get.put(ColorController());
  return ThemeData(
    hintColor: colorController.kDarkGreyColor,
    focusColor: colorController.kPrimaryColor,
    primaryColor: colorController.kPrimaryColor,
    buttonTheme: _buttonThemeData(),
    scaffoldBackgroundColor: colorController.kBgColor,
    primaryColorDark: colorController.kPrimaryDarkColor,
    primaryColorLight: colorController.kPrimaryLightColor,
    inputDecorationTheme: _inputDecorationTheme(),
    iconTheme: const IconThemeData(color: Colors.white),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme:  TextSelectionThemeData(cursorColor: colorController.kPrimaryDarkColor),
    appBarTheme:  AppBarTheme(
      backgroundColor: colorController.kPrimaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.android: ZoomPageTransitionsBuilder()},
    ),
  );
}

ButtonThemeData _buttonThemeData() {
  ColorController colorController = Get.put(ColorController());
  return  ButtonThemeData(
    height: 48,
    buttonColor: colorController.kPrimaryColor,
    splashColor: Colors.white70,
    textTheme: ButtonTextTheme.primary,
  );
}

InputDecorationTheme _inputDecorationTheme() {
  ColorController colorController = Get.put(ColorController());
  const OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  return  InputDecorationTheme(
    focusColor: colorController.kPrimaryColor,
    border: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    focusedBorder: _outlineInputBorder,
    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
  );
}
