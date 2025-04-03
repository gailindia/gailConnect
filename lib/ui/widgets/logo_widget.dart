// Created By Amit Jangid 24/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class LogoWidget extends StatelessWidget {
  final double? width, height;

  const LogoWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Image(
        width: width,
        height: height,
        image: const AssetImage(kIconLogo),
      );
}
