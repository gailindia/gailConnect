// Created By Amit Jangid on 08/11/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class Areas {
  String value;
  String areaName;

  Areas({required this.value, required this.areaName});

  factory Areas.fromJson(Map<String, dynamic> _areaJson) => Areas(
        value: _areaJson[kJsonValueCaps],
        areaName: _areaJson[kJsonTextCaps],
      );
}
