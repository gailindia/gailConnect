// Created By Amit Jangid 14/07/21

import 'package:flutter/material.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Center(child: Text(kInternetNotAvailable, style: textStyle18Bold));
}
