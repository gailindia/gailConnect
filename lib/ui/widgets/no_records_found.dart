// Created By Amit Jangid 14/07/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class NoRecordsFound extends StatelessWidget {
  const NoRecordsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Center(child: Text(kMsgNoRecordsFound, style: textStyle18Bold));
}
