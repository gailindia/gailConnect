// Created By Amit Jangid 20/09/21

import 'package:get/get.dart';
import 'package:gail_connect/models/bws_dash_details.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class BwsDashDetailsController extends GetxController {
  bool isLoading = true;
  String? dept, userId, toDate, status, fromDate, selectedBillTitle;

  List<BwsDashDetails> bwsDashDetailsList = [];

  @override
  void onInit() {
    super.onInit();

    userId = Get.arguments[kCpfNo];
    toDate = Get.arguments[kToDate];
    status = Get.arguments[kStatus];
    dept = Get.arguments[kDepartment];
    fromDate = Get.arguments[kFromDate];
    selectedBillTitle = Get.arguments[kTitle];

    // calling get bws dash details method
    getBwsDashDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kBWSCountDetailsScreen);
  }

  getBwsDashDetails() async {
    isLoading = true;
    update([kBillWatchSystem]);

    // calling get bws dash count details api
    bwsDashDetailsList = await GailConnectServices.to.getBwsDashDetailsApi(
      userId: userId!,
      department: dept!,
      status: status!,
      toDate: toDate!,
      fromDate: fromDate!,
    );

    isLoading = false;
    update([kBillWatchSystem]);
  }
}
