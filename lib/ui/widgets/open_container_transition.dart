// Created By Amit Jangid 04/10/21

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class OpenContainerTransition extends StatelessWidget {
  final openBuilder;
  final bool tappable;
  final ShapeBorder openShape;
  final double closedElevation;
  final ShapeBorder closedShape;
  final CloseContainerBuilder closedBuilder;

  const OpenContainerTransition({
    Key? key,
    required this.openBuilder,
    required this.closedBuilder,
    this.tappable = true,
    this.closedElevation = 0,
    this.openShape = const RoundedRectangleBorder(),
    this.closedShape = const RoundedRectangleBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      tappable: tappable,
      openShape: openShape,
      closedShape: closedShape,
      openBuilder: openBuilder,
      closedBuilder: closedBuilder,
      closedElevation: closedElevation,
      transitionDuration: const Duration(milliseconds: 600),
    );
  }
}
