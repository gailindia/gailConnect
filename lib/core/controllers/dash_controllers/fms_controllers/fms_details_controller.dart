// Created By Amit Jangid 16/09/21

import 'package:get/get.dart';
import 'package:gail_connect/models/fms_detail.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class FmsDetailsController extends GetxController {
  bool isLoading = true;
  List<FmsDetail> fmsDetailsList = [];

  @override
  void onInit() {
    super.onInit();

    // calling get fms details list method
    getFmsDetailList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kFMSDetailsScreen);
  }

  getFmsDetailList() async {
    isLoading = true;
    update([kFmsInboxDetail]);

    // calling get fms detail by id api method
    fmsDetailsList =
        await GailConnectServices.to.getFmsDetailByIdApi(id: Get.arguments);

    isLoading = false;
    update([kFmsInboxDetail]);
  }
}
