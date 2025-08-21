// Created By Amit Jangid on 27/12/21

import 'package:flutter/material.dart';

class ChatBubbleShape extends CustomPainter {
  final Color? bgColor;

  ChatBubbleShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    final _path = Path();
    final _paint = Paint()..color = bgColor!;

    _path.lineTo(-8, 0);
    _path.lineTo(0, 10);
    _path.lineTo(8, 0);

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
