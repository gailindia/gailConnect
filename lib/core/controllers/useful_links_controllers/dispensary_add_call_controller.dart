// Created By Amit Jangid on 25/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/bis_helpdesk_calls.dart';
import 'package:gail_connect/models/dispensary_details_url.dart';
import 'package:gail_connect/models/dispensary_history.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../ui/widgets/show_custom_dialog_box.dart';

class DispensaryHistoryController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  List<DispensaryHistoryDetailsModelUrl> dispensaryHistoryDetailsList1 = [];

  bool isLoading = true;
  String selectedCallStatus = kAll;

  BISHelpdeskCalls? selectedUserCall;

  List<DispensaryHistoryModel> userCallsList = [];
  // List<DispensaryHistoryModel> filteredUserCallsList = [];

  String? selectedAcknowledge;
  final List<String> acknowledgestatus = ["0", "1"];

  String? select = "0";
  void onClickRadioButton(value) {
    select = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    update([kDispensaryHistory]);
    // calling get bis helpdesk calls list method
    getDispensaryHistoryList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getCallApollo() async {
    // print(no);
    await launch("tel: +914047476988");
  }

  getDispensaryHistoryList() async {
    update([kDispensaryHistory]);
    isLoading = true;
    update([kDispensaryHistory]);
    // calling get bis helpdesk calls list api method
    userCallsList = await GailConnectServices.to.getDispensaryHistoryListApi();
    isLoading = false;
    update([kDispensaryHistory]);
  }

  getreqNumverDetailsURL(String sno) async {
    // await showProgressDialog(Get.context!, message: kMsgGettingData);
    dispensaryHistoryDetailsList1.clear();
    dispensaryHistoryDetailsList1 =
        await GailConnectServices.to.getDispensaryHistoryDetailsListApi1(sno);
    update([kDispensaryHistoryDetails]);
    // await hideProgressDialog();
  }

  Future<int> acknowledgeApiHit(String sno, BuildContext context) async {
    int a = 0;
    var str;
    await showProgressDialog(Get.context!, message: "");
    String? status = await GailConnectServices.to.getacknowledeApi(
        SNO: sno,
        remarks: remarksController.text,
        rcvStatus: select.toString());
    str = status!.split(",");


    await hideProgressDialog();
    if (str[1] == "200") {
      update([kDispensaryHistory]);
      getDispensaryHistoryList();
      Navigator.pop(context);
      a = 1;

      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: str[0]);

    } else {
      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: str[0]);
    }
    return a;
  }

  Future<int> pharmacyRequestCancel(String sno, BuildContext context) async {
    int a = 0;
    var str;
    await showProgressDialog(Get.context!, message: "");
    String? status =
        await GailConnectServices.to.getpharmacyCancelApi(SNO: sno);
    str = status!.split(",");


    await hideProgressDialog();
    if (str[1] == "200") {
      update([kDispensaryHistory]);
      getDispensaryHistoryList();
      Navigator.pop(context);
      a = 1;

      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: str[0]);


    } else {
      update([kDispensaryHistory]);
      getDispensaryHistoryList();
      Navigator.pop(context);

      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: str[0]);
    }
    return a;
  }



  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}
