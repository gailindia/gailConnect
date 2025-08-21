// Created By Amit Jangid 27/08/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../styles/color_controller.dart';

class Chevron extends CustomPainter {
  ColorController colorController = Get.put(ColorController());
  @override
  void paint(Canvas canvas, Size size) {
     Gradient _gradient = LinearGradient(
      stops: [0.2, 0.8],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [colorController.kPrimaryLightColor, colorController.kPrimaryDarkColor],
    );

    final Rect _colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint _paint = Paint()..shader = _gradient.createShader(_colorBounds);

    final Path _path = Path();
    _path.moveTo(0, 0);
    _path.lineTo(0, size.height);
    _path.lineTo(size.width / 2, size.height - size.height / 3);
    _path.lineTo(size.width, size.height);
    _path.lineTo(size.width, 0);
    _path.close();

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RPSCustomPainter extends CustomPainter {
  ColorController colorController = Get.put(ColorController());

  @override
  void paint(Canvas canvas, Size size) {
     Gradient _gradient = LinearGradient(
      stops: [0.1, 0.8],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [colorController.kPrimaryLightColor, colorController.kPrimaryDarkColor],
    );

    final Rect _colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint _paint = Paint()..shader = _gradient.createShader(_colorBounds);

    final Path _path = Path();
    _path.moveTo(0, size.height);

    _path.quadraticBezierTo(
      size.width * 0.12,
      size.height * 0.8,
      size.width * 0.4,
      size.height * 0.8,
    );

    _path.cubicTo(
      size.width * 0.6,
      size.height * 0.8,
      size.width * 0.8,
      size.height * 0.82,
      size.width * 0.87,
      size.height * 0.81,
    );

    _path.quadraticBezierTo(size.width * 0.95, size.height * 0.8, size.width, size.height * 0.75);

    _path.lineTo(size.width, 0);
    _path.lineTo(0, 0);
    _path.lineTo(0, size.height);
    _path.close();

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
