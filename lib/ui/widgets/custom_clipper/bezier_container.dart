// Created by AMIT JANGID on 6/22/2021.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/custom_clipper/custom_clipper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../styles/color_controller.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Transform.rotate(
      angle: -pi / 3.5,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .5,
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              stops: [0.2, 0.8],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colorController.kPrimaryLightColor, colorController.kPrimaryDarkColor],
            ),
          ),
        ),
      ),
    );
  }
}
