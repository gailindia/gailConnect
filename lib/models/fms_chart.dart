// Created By Amit Jangid 17/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class FmsChart {
  String? dataA;
  String? dataB;
  String? dataC;
  String? dataD;
  String? dataE;
  int? statusCode;
  String? empCpf;
  String? empName;
  String? grade;
  String? location;
  String? vendorCode;
  String? vendorMobile;
  String? vendorPhone;

  FmsChart({
    required this.dataA,
    required this.dataB,
    required this.dataC,
    required this.dataD,
    required this.dataE,
    required this.statusCode,
    required this.empCpf,
    required this.empName,
    required this.grade,
    required this.location,
    required this.vendorCode,
    required this.vendorMobile,
    required this.vendorPhone,
  });

  factory FmsChart.fromJson(Map<String, dynamic> _fmsChartJson) => FmsChart(
        dataA: _fmsChartJson[kJsonDataA],
        dataB: _fmsChartJson[kJsonDataB],
        dataC: _fmsChartJson[kJsonDataC],
        dataD: _fmsChartJson[kJsonDataD],
        dataE: _fmsChartJson[kJsonDataE],
        statusCode: _fmsChartJson[kJsonStatusCode],
        empCpf: _fmsChartJson[kJsonEmpCpf],
        empName: _fmsChartJson[kJsonEmpName],
        grade: _fmsChartJson[kJsonGrade],
        location: _fmsChartJson[kJsonLocation],
        vendorCode: _fmsChartJson[kJsonVendorCode],
        vendorMobile: _fmsChartJson[kJsonVendorMobile],
        vendorPhone: _fmsChartJson[kJsonVendorPhone],
      );
}

class FmsChartData {
  int count;
  String label;
  int pendingDays;

  FmsChartData({required this.count, required this.label, required this.pendingDays});
}
