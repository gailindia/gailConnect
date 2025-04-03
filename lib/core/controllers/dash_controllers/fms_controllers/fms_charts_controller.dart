// Created By Amit Jangid 17/09/21

import 'package:get/get.dart';
import 'package:gail_connect/models/fms_chart.dart';
import 'package:multiutillib/utils/string_extension.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class FmsChartsController extends GetxController {
  bool isLoading = true;
  FmsChart? fmsChart;
  List<FmsChartData> fmsChartDataList = [];

  @override
  void onInit() {
    super.onInit();

    // calling get fms chart data method
    getFmsChartData();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kFMSChartScreen);
  }

  getFmsChartData() async {
    isLoading = true;
    update([kFmsChart]);

    // calling get fms chart data api method
    fmsChart = await GailConnectServices.to.getFmsChartDataApi();

    if (fmsChart != null) {
      // calling generate fms chart data list method
      generateFmsChartDataList();
    }

    isLoading = false;
    update([kFmsChart]);
  }

  generateFmsChartDataList() {
    fmsChartDataList = <FmsChartData>[
      FmsChartData(
          count: fmsChart!.dataA!.toInt!, label: '< 7', pendingDays: 1),
      FmsChartData(
          count: fmsChart!.dataB!.toInt!, label: '< 14', pendingDays: 2),
      FmsChartData(
          count: fmsChart!.dataC!.toInt!, label: '< 21', pendingDays: 3),
      FmsChartData(
          count: fmsChart!.dataD!.toInt!, label: '< 28', pendingDays: 4),
      FmsChartData(
          count: fmsChart!.dataE!.toInt!, label: '> 28', pendingDays: 5),
    ];
  }
}
