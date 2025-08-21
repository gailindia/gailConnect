// Created By Amit Jangid on 08/11/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class Engineer {
  String engId;
  String engName;

  Engineer({required this.engId, required this.engName});

  factory Engineer.fromJson(Map<String, dynamic> _employeeJson) => Engineer(
        engId: _employeeJson[kJsonValueCaps].toString(),
        engName: _employeeJson[kJsonTextCaps],
      );
}
