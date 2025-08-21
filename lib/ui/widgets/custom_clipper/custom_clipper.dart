// Created by AMIT JANGID on 6/22/2021.

import 'package:flutter/material.dart';

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final _path = Path();
    final _width = size.width;
    final _height = size.height;

    _path.lineTo(0, size.height);
    _path.lineTo(size.width, _height);
    _path.lineTo(size.width, 0);

    /// [Top Left corner]
    const _secondControlPoint = Offset(0, 0);
    final _secondEndPoint = Offset(_width * .2, _height * .3);
    _path.quadraticBezierTo(_secondControlPoint.dx, _secondControlPoint.dy, _secondEndPoint.dx, _secondEndPoint.dy);

    /// [Left Middle]
    final _fifthControlPoint = Offset(_width * .3, _height * .5);
    final _fifthEndPoint = Offset(_width * .23, _height * .6);
    _path.quadraticBezierTo(_fifthControlPoint.dx, _fifthControlPoint.dy, _fifthEndPoint.dx, _fifthEndPoint.dy);

    /// [Bottom Left corner]
    final _thirdControlPoint = Offset(0, _height);
    final _thirdEndPoint = Offset(_width, _height);
    _path.quadraticBezierTo(_thirdControlPoint.dx, _thirdControlPoint.dy, _thirdEndPoint.dx, _thirdEndPoint.dy);

    _path.lineTo(0, size.height);
    _path.close();

    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
