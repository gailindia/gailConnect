// Created By Amit Jangid on 09/11/21

import 'package:get/get.dart';
import 'package:gail_connect/models/bis_report_details.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class BISHelpdeskCallDetailsController extends GetxController {
  bool isLoading = true;

  late String callId;

  List<BISReportDetails> bisReportCallDetails = [];

  @override
  void onInit() {
    super.onInit();

    callId = Get.arguments;

    // calling get bis report call details method
    getBISReportCallDetails();
    // calling hit count api method
    GailConnectServices.to.hitCountApi(
        activity: kHomeScreen, activityScreen: kHomeScreen);

  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kBISHelpdeskCallDetailsScreen);
  }

  getBISReportCallDetails() async {
    isLoading = true;
    update([kBISHelpdeskCallDetails]);

    // calling get bis report call details api method
    bisReportCallDetails = await GailConnectServices.to
        .getBISReportsCallDetailsApi(callId: callId);

    isLoading = false;
    update([kBISHelpdeskCallDetails]);
  }
}
