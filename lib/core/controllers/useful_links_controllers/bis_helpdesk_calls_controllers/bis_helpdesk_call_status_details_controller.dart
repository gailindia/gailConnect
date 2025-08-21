// Created By Amit Jangid on 25/11/21

import 'package:get/get.dart';
import 'package:gail_connect/models/bis_helpdesk_calls.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class BISHelpdeskCallStatusDetailsController extends GetxController {
  bool isLoading = true;

  late BISHelpdeskCalls? userCall;

  @override
  void onInit() {
    super.onInit();
    print("gxdthcfygjvubhkjl ${Get.arguments}");

    // calling get bis helpdesk call details method
    getBISHelpdeskCallDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kBISHelpdeskCallsDetailsScreen);
  }

  getBISHelpdeskCallDetails() async {
    isLoading = true;
    update([kBISHelpdeskCallStatusDetails]);



    // calling get bis helpdesk call by id api method
    final List<BISHelpdeskCalls> _userCallIst = await GailConnectServices.to
        .getBISHelpdeskCallByIdApi(callId: Get.arguments);

    if (_userCallIst.isNotEmpty) {
      userCall = _userCallIst.first;
    }

    isLoading = false;
    update([kBISHelpdeskCallStatusDetails]);
  }
}
