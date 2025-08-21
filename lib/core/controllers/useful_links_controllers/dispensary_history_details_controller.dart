import 'package:flutter/material.dart';
import 'package:gail_connect/models/address_details_model.dart';
import 'package:gail_connect/models/dispensary_history_details.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../../models/dispensary_details_url.dart';

class DispensaryHistoryDetailsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GailConnectServices _gailConnectServices = GailConnectServices.to;

  List<DispensaryHistoryDetailsModel> dispensaryHistoryDetailsList = [];
  List<DispensaryHistoryDetailsModelUrl> dispensaryHistoryDetailsList1 = [];
  List<AddressDetailsModel> dispensaryAddressDetailsModel = [];
  final TextEditingController patientName = new TextEditingController();
  final TextEditingController address = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController pincode = new TextEditingController();
  final TextEditingController remarks = new TextEditingController();
  final TextEditingController pharmacy = new TextEditingController();
  final TextEditingController delivery = new TextEditingController();
  String? dispensaryhistoryEmpNo;
  String? dispensaryhistoryDependantName;
  String? dispensaryhistoryAddress;
  String? dispensaryhistoryMobileNo;
  String? dispensaryhistoryPin;
  String? dispensaryhistoryApolloOrderNo;
  String? dispensaryhistoryInvoiceNo;
  String? dispensaryhistoryInvoiceAmt;
  String? newSelection;
  String? reqNodis;
  bool isLoading = true;

  // List<DispensaryHistoryDetailsModel> dispensaryHistoryDetailsList = [];
  // List<String> dispensaryhistorydetailslist = [];

  @override
  void onReady() async{
    super.onReady();
    // print(Get.arguments[1].toString());
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    pref.putString("reqNumber", reqNodis!);
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading = true;
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    pref.putString("reqNumber", reqNodis!);

    String? s = await pref.getString("reqNumber");
    dispensaryHistoryDetailsList1.clear();
    getreqNumverDetailsURL(s!);
    getDetails(s);
    // await hideProgressDialog();

    // update([kDispensaryHistory]);
    // calling get bis helpdesk calls list method
  }

  getDetails(String reqNo) async {
    dispensaryHistoryDetailsList =
        await _gailConnectServices.getDispensaryHistoryDetailsListApi(reqNo);

    for (int i = 0; i < dispensaryHistoryDetailsList.length; i++) {
      dispensaryhistoryEmpNo = dispensaryHistoryDetailsList[i].empno.toString();
      dispensaryhistoryDependantName =
          dispensaryHistoryDetailsList[i].dependent.toString();
      patientName.text = dispensaryhistoryDependantName.toString();
      address.text = dispensaryHistoryDetailsList[i].address.toString();

      pharmacy.text = dispensaryHistoryDetailsList[i].pharmacystore.toString();
      delivery.text = dispensaryHistoryDetailsList[i].deliverymode.toString();
      mobile.text = dispensaryHistoryDetailsList[i].mobileno.toString();
      remarks.text = dispensaryHistoryDetailsList[i].remarks.toString();
      dispensaryhistoryPin = dispensaryHistoryDetailsList[i].pin.toString();
      pincode.text = dispensaryhistoryPin.toString();
      dispensaryhistoryApolloOrderNo =
          dispensaryHistoryDetailsList[i].apolloOrderno.toString();
      dispensaryhistoryInvoiceNo =
          dispensaryHistoryDetailsList[i].invoiceNo.toString();
      dispensaryhistoryInvoiceAmt =
          dispensaryHistoryDetailsList[i].invoiceAmt.toString();
    }
    // await hideProgressDialog();
    // dispensaryHistoryDetailsList1 =
    //     await _gailConnectServices.getDispensaryHistoryDetailsListApi1();
// isLoading = false;

    update([kDispensaryHistoryDetails]);
  }

  // getDetailsPrescription() async{
  //   dispensaryHistoryDetailsList1 =
  //       await _gailConnectServices.getDispensaryHistoryDetailsListApi1();
  //   await hideProgressDialog();
  //   update([kDispensaryHistoryDetails]);
  // }

  getreqNumverDetailsURL(String sno) async {
    dispensaryHistoryDetailsList1.clear();
    dispensaryHistoryDetailsList1 =
        await _gailConnectServices.getDispensaryHistoryDetailsListApi1(sno);
    update([kDispensaryHistoryDetails]);
    // await hideProgressDialog();
  }

  getRequestHistoryApi(String sno) async {
    dispensaryAddressDetailsModel =
        await _gailConnectServices.getRequestHistoryAPI(sno);

    update([kDispensaryHistoryDetails]);
    // await hideProgressDialog();
  }

  onDeliveryModeSelected({DispensaryHistoryDetailsModelUrl? deliverymode}) {
    newSelection = deliverymode?.url;
  }
}
