// Created By Amit Jangid 18/10/21

import 'package:flutter/cupertino.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/dashboard_list.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:get/get.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class OtpController extends GetxController {
  bool isOtpSent = false, showOtpScreen = false;

  final int otpLength = 6;
  String currentDigit = '';
  String _mobileNo = '', mobileNoDisplay = '';
  List<DashboardListModel> dashboardlist = [];


  List<String> otpValue = [];

  @override
  void onInit() {
    super.onInit();

    otpValue = List<String>.filled(otpLength, '');

    // calling show otp screen method
    getDashboard();
    // _showOtpScreen();
    // if (showOtpScreen) {
    //   sendOtp(reOtp: false);
    // }
  }

  @override
  void onReady() {
    // if (showOtpScreen) {
    //   // calling send otp method
    //   sendOtp(reOtp: false);

    //   // calling hit count api method
    //   // GailConnectServices.to.hitCountApi(activity: kDashboardOTPScreen);
    // }
  }

  _showOtpScreen() async {
    await showProgressDialog(Get.context!);
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    final String _empGrade =
        MainDashController.to.loggedInEmployee!.grade!.toLowerCase();
    dashboardlist = await GailConnectServices.to.dashboardListData();
    for (int i = 0; i < dashboardlist.length; i++) {
      if (_cpfNumber.toString()
          .contains(dashboardlist[i].cpfno.toString().toLowerCase())) {
        showOtpScreen = true;
        await hideProgressDialog();

        // showOtpScreen = true;
        update([kOtp]);
      } else if (_empGrade.contains('E7'.toLowerCase()) ||
          _empGrade.contains('E8'.toLowerCase()) ||
          _empGrade.contains('E9'.toLowerCase()) ||
          // _cpfNumber.contains('17231'.toLowerCase()) ||
          // _cpfNumber.contains('17405'.toLowerCase()) ||
          // _cpfNumber.contains('0000575'.toLowerCase()) ||
          _empGrade.contains('Directors'.toLowerCase())) {
        showOtpScreen = true;
        await hideProgressDialog();
        update([kOtp]);
      }
    }
    if (showOtpScreen) {
      await hideProgressDialog();
      // calling send otp method
      sendOtp(reOtp: false);

      // calling hit count api method
      // GailConnectServices.to.hitCountApi(activity: kDashboardOTPScreen);
    }
    await hideProgressDialog();
    // if (_empGrade.contains('E7'.toLowerCase()) ||
    //     _empGrade.contains('E8'.toLowerCase()) ||
    //     _empGrade.contains('E9'.toLowerCase()) ||
    //     _cpfNumber.contains('17231'.toLowerCase()) ||
    //     _cpfNumber.contains('17405'.toLowerCase()) ||
    //     _cpfNumber.contains('0000575'.toLowerCase()) ||
    //     _empGrade.contains('Directors'.toLowerCase())) {
    //   showOtpScreen = true;
    //   update([kOtp]);
    // }
  }

  setCurrentDigit(int _digit) {
    int _currentField;
    currentDigit = _digit.toString();

    for (_currentField = 0; _currentField < otpLength; _currentField++) {
      if (otpValue[_currentField].isEmpty) {
        otpValue[_currentField] = currentDigit;
        update([kOtp]);

        break;
      }
    }

    if (_currentField == otpLength - 1) {
      // calling validate otp method
      validateOtp();
    }
  }

  sendOtp({required bool reOtp}) async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!);
    // calling send otp api method
    final Map<String, String> _response =
        await GailConnectServices.to.sendOtpApi(reOtp: reOtp);
    // calling hide progress dialog method
    await hideProgressDialog();
    // calling show custom dialog box method
    showCustomDialogBox(
        context: Get.context!,
        title: kInfo,
        description: _response[kJsonMessage].toString());
    isOtpSent = true;
    _mobileNo = _response[kJsonPhoneNo].toString();
    mobileNoDisplay = '******${_mobileNo.substring(6, 10)}';
    update([kOtp]);
  }

  validateOtp() async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!);
    final String _otp = otpValue.join();
    // calling send otp api method
    final String _response = await GailConnectServices.to
        .validateOtpApi(otp: _otp, mobileNo: _mobileNo);

    // calling hide progress dialog method
    await hideProgressDialog();
    if (_response == "true") {
      Get.offNamed(kDashboardRoute);
    } else {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: kMessage);
    }
  }

  onBackButtonPressed() {
    for (int i = otpLength - 1; i >= 0; i--) {
      if (otpValue[i].isNotEmpty) {
        otpValue[i] = '';
        break;
      }
    }

    update([kOtp]);
  }

  void getDashboard() async {
    dashboardlist = await GailConnectServices.to.dashboardListData();
    _showOtpScreen();
  }
}
