// Created By Amit Jangid 17/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class ReportingEmp {
  String? empNo;
  String? empName;

  ReportingEmp({required this.empNo, required this.empName});

  factory ReportingEmp.fromJson(Map<String, dynamic> _reportingEmpJson) => ReportingEmp(
        empNo: _reportingEmpJson[kJsonEmpNo],
        empName: _reportingEmpJson[kJsonEmpName],
      );
}
