// Created By Amit Jangid 14/07/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class EnterVehicleNumber extends StatelessWidget {
  const EnterVehicleNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
       Center(child: Text(kMsgEnterVehicleNumber, style: textStyle18Bold));
}
