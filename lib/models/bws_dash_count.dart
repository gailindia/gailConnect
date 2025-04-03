// Created By Amit Jangid 20/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class BwsDashCount {
  String dept;
  int deptCloseCount;
  int deptReturnCount;
  int deptPendingCount;

  BwsDashCount({
    required this.dept,
    required this.deptCloseCount,
    required this.deptReturnCount,
    required this.deptPendingCount,
  });

  factory BwsDashCount.fromJson(Map<String, dynamic> _bwsDashCountJson) => BwsDashCount(
        dept: _bwsDashCountJson[kJsonDept],
        deptCloseCount: _bwsDashCountJson[kJsonDeptCloseCount],
        deptReturnCount: _bwsDashCountJson[kJsonDeptReturnCount],
        deptPendingCount: _bwsDashCountJson[kJsonDeptPendingCount],
      );
}

class BwsChartData {
  int count;
  Color color;
  String title;

  BwsChartData({required this.count, required this.color, required this.title});
}
