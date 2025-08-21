// Created By Amit Jangid 17/09/21

import 'package:get/get.dart';
import 'package:gail_connect/models/fms_mail.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class FmsChartDetailsController extends GetxController {
  bool isLoading = true;
  List<FmsMail> fmsChartDetailsList = [];

  @override
  void onInit() {
    super.onInit();

    // calling get fms chart details method
    getFmsChartDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kFMSChartDetailsScreen);
  }

  getFmsChartDetails() async {
    isLoading = true;
    update([kFmsChartDetails]);

    // calling get fms chart details list method
    fmsChartDetailsList = await GailConnectServices.to
        .getFmsChartDetailsListApi(pendingDays: Get.arguments);

    isLoading = false;
    update([kFmsChartDetails]);
  }
}
