// Created By Amit Jangid on 26/11/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class Utilization {
  int count;
  String screen;
  String appCode;

  Utilization({required this.count, required this.appCode, required this.screen});

  factory Utilization.fromJson(Map<String, dynamic> _utilizationJson) => Utilization(
        count: _utilizationJson[kJsonCounts].toInt(),
        screen: _utilizationJson[kJsonActivity],
        appCode: _utilizationJson[kJsonAppCode],
      );
}
