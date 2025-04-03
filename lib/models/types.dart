// Created By Amit Jangid on 08/11/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class Types {
  String value;
  String typeName;

  Types({required this.value, required this.typeName});

  factory Types.fromJson(Map<String, dynamic> _areaJson) => Types(
        value: _areaJson[kJsonValueCaps],
        typeName: _areaJson[kJsonTextCaps],
      );
}
