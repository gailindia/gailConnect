// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:gail_connect/models/bws_dash_count.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/utils/date_time_extension.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:multiutillib/widgets/custom_date_picker/date_picker_popup_view.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../../../ui/styles/color_controller.dart';

class BwsDashController extends GetxController {
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  ColorController colorController = Get.put(ColorController());

  bool isLoading = true;
  String selectedUserType = kIndividual;

  late String _selectedUserId;

  BwsDashCount? bwsDashCount;
  ReportingEmp? selectedReportingEmp;

  DateTime? _selectedFromDate;
  String billFilterType = kIndividual;

  List<ReportingEmp> reportingEmpList = [];

  @override
  void onInit() async{
    super.onInit();
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    _selectedUserId = (await  pref.getString("cpfNumber",isEncrypted: true))!;
    // _selectedUserId = '575';

    // calling set initial date selection method
    setInitialDateSelection();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kBWSDashboardScreen);
  }

  setInitialDateSelection() {
    final DateTime _currentDate = DateTime.now();
    final DateTime _fromDate = _currentDate.subtract(const Duration(days: 30));

    fromDateController.text =
        _fromDate.formatDateTime(newDateTimeFormat: kDateDisplayFormat);
    toDateController.text =
        _currentDate.formatDateTime(newDateTimeFormat: kDateDisplayFormat);

    // calling get bws dash count method
    getBwsDashCount();
  }

  selectDateFilter({bool isToDate = false}) async {
    await showCustomDatePicker(
      context: Get.context!,
      onCancelClick: () => Get.back(),
      leftArrowColor: colorController.kPrimaryDarkColor,
      rightArrowColor: colorController.kPrimaryDarkColor,
      applyButtonColor: colorController.kPrimaryDarkColor,
      selectedDateColor: colorController.kPrimaryDarkColor,
      weekDaysTextColor: colorController.kPrimaryDarkColor,
      monthYearTextColor: colorController.kPrimaryDarkColor,
      applyButtonTextStyle: buttonTextStyle,
      onApplyClick: (_selectedDate) async {
        if (_selectedDate != null) {
          final String selectedDate = _selectedDate.formatDateTime(
              newDateTimeFormat: kDateDisplayFormat);

          if (isToDate) {
            if (_selectedFromDate != null &&
                _selectedFromDate!.isAfter(_selectedDate)) {
              // calling show custom dialog box method
              await showCustomDialogBox(
                  context: Get.context!,
                  title: kError,
                  description: kMsgToDateLessThanFromDate);
            } else {
              Get.back();
              toDateController.text = selectedDate;

              // calling get bws dash count method
              getBwsDashCount();
            }
          } else {
            Get.back();

            _selectedFromDate = _selectedDate;
            fromDateController.text = selectedDate;

            if (toDateController.value.text.isNotEmpty) {
              // calling get bws dash count method
              getBwsDashCount();
            }
          }
        }
      },
    );
  }

  getBwsDashCount() async {
    isLoading = true;
    update([kBwsDashboard]);

    // calling get bws dash count api method
    bwsDashCount = await GailConnectServices.to.getBwsDashCountApi(
      userId: _selectedUserId,
      toDate: toDateController.value.text,
      fromDate: fromDateController.value.text,
    );

    isLoading = false;
    update([kBwsDashboard]);
  }

  getReportingEmpList() async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!, message: kMsgGettingSubOrdinates);

    // calling get reporting emp api method
    reportingEmpList = await GailConnectServices.to.getReportingEmpApi();
    update([kBwsDashboard]);

    // calling hide progress dialog method
    await hideProgressDialog();
  }

  onUserTypeSelected(String? _selectedValue) async {
    selectedUserType = _selectedValue!;
    update([kBwsDashboard]);

    if (_selectedValue == kSubOrdinate) {
      bwsDashCount = null;
      update([kBwsDashboard]);

      // calling get reporting emp list method
      getReportingEmpList();
    } else {
      SecureSharedPref pref = await SecureSharedPref.getInstance();

      _selectedUserId = (await  pref.getString("cpfNumber",isEncrypted: true))!;
      // _selectedUserId = '575';

      // calling get bws dash count method
      getBwsDashCount();
    }
  }

  onSubOrdinateSelected(ReportingEmp? _selectedReportingEmp) {
    selectedReportingEmp = _selectedReportingEmp;
    update([kBwsDashboard]);

    _selectedUserId = _selectedReportingEmp!.empNo!;

    // calling get bws dash count method
    getBwsDashCount();
  }

  openBwsDashDetailsScreen(
      {required String dept, required String title, required String status}) {
    Get.toNamed(
      kBwsDashDetailRoute,
      arguments: {
        kTitle: title,
        kStatus: status,
        kDepartment: dept,
        kCpfNo: _selectedUserId,
        kToDate: toDateController.value.text,
        kFromDate: fromDateController.value.text,
      },
    );
  }

  @override
  void dispose() {
    toDateController.dispose();
    fromDateController.dispose();

    super.dispose();
  }
}
