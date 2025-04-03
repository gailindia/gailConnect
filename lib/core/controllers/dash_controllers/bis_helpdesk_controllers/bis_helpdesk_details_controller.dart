// Created By Amit Jangid on 08/11/21

import 'package:get/get.dart';
import 'package:gail_connect/models/bis_report_details.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class BISHelpdeskDetailsController extends GetxController {
  bool isLoading = true;

  String screenTitle = '';
  late String reportType,
      selectedArea,
      selectedType,
      selectedToDate,
      selectedFromDate,
      selectedEngineer;

  List<BISReportDetails> bisReportDetailsList = [];

  @override
  void onInit() {
    super.onInit();

    screenTitle = Get.arguments[kTitle];
    selectedArea = Get.arguments[kArea];
    selectedType = Get.arguments[kType];
    reportType = Get.arguments[kReportType];
    selectedToDate = Get.arguments[kToDate];
    selectedFromDate = Get.arguments[kFromDate];
    selectedEngineer = Get.arguments[kEngineer];

    // calling get bis report count details method
    getBISReportCountDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kBISHelpdeskReportCountDetailsScreen);
  }

  getBISReportCountDetails() async {
    isLoading = true;
    update([kBISHelpdeskDetails]);

    // calling get bis reports count details api method
    bisReportDetailsList =
        await GailConnectServices.to.getBISReportsCountDetailsApi(
      reportType: reportType,
      selectedArea: selectedArea,
      selectedType: selectedType,
      selectedToDate: selectedToDate,
      selectedFromDate: selectedFromDate,
      selectedEngineer: selectedEngineer,
    );

    isLoading = false;
    update([kBISHelpdeskDetails]);
  }
}
