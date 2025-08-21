// Created By Amit Jangid 14/07/21

import 'package:flutter/material.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class BwsNoRecordsFound extends StatelessWidget {
  const BwsNoRecordsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(child: Image(height: 200, image: AssetImage(kIconBwsNoRecords)));
}
