// Created By Amit Jangid on 08/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/models/areas.dart';
import 'package:gail_connect/models/types.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:gail_connect/models/engineer.dart';
import 'package:gail_connect/models/bis_report.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/utils/date_time_extension.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:multiutillib/widgets/custom_date_picker/date_picker_popup_view.dart';

class BISHelpdeskController extends GetxController {
  // late TooltipBehavior tooltip;
  final String _tag = 'BISHelpdeskController';

  final GailConnectServices _gailConnectServices = GailConnectServices.to;

  static BISHelpdeskController get to => Get.find<BISHelpdeskController>();
  ColorController colorController = Get.put(ColorController());

  final ScrollController scrollController = ScrollController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();

  bool isLoading = false, showTotalCallsChart = false;

  Areas? selectedArea;
  Types? selectedTypes;
  BISReport? bisReport;
  Engineer? selectedEngineer;

  DateTime? _selectedFromDate;

  List<Areas> areasList = [];
  List<Types> typesList = [];
  List<Engineer> engineersList = [];
  List<BISReportData> allOpenCallsList = [];
  List<BISReportData> allPendingCallsList = [];
  List<BISReportData> openClosedPendingCallsList = [];

  @override
  void onInit() {
    // tooltip = TooltipBehavior(enable: true);

    super.onInit();

    // calling clear types selection method
    clearTypesSelection();

    // calling set initial date selection method
    setInitialDateSelection();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kBISHelpdeskReportCountScreen);

    // calling get areas  list method
    getAreasList();
  }

  clearTypesSelection() {
    typesList = [];
    selectedTypes = null;
  }

  setInitialDateSelection() {
    final DateTime _currentDate = DateTime.now();
    final DateTime _fromDate = _currentDate.subtract(const Duration(days: 30));

    fromDateController.text =
        _fromDate.formatDateTime(newDateTimeFormat: kDateDisplayFormat);
    toDateController.text =
        _currentDate.formatDateTime(newDateTimeFormat: kDateDisplayFormat);
  }

  getAreasList() async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!, message: kMsgGettingArea);

    // calling get all areas list api method
    areasList = await _gailConnectServices.getAllAreasListApi();

    // calling hide progress dialog method
    await hideProgressDialog();

    // calling clear types selection method
    clearTypesSelection();
    update([kBISHelpdesk]);
  }

  getTypesListByArea() async {
    // calling clear types selection method
    clearTypesSelection();

    if (selectedArea != null) {
      // calling show progress dialog method
      await showProgressDialog(Get.context!, message: kMsgGettingTypesForArea);

      // calling get types list by area api method
      typesList = await _gailConnectServices.getTypesListByAreaApi(
          area: selectedArea?.value);

      // calling hide progress dialog method
      await hideProgressDialog();

      update([kBISHelpdesk]);
    } else {
      typesList = [];
      selectedTypes = null;
    }
  }

  getEngineersListByArea() async {
    // calling get engineers list api method
    engineersList = await _gailConnectServices.getEngineersListApi(
        selectedArea: selectedArea!.value);

    update([kBISHelpdesk]);
  }

  getReportsCount() async {
    if (toDateController.value.text.isEmpty) {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: kMsgSelectFromDate);

      return;
    }

    if (fromDateController.value.text.isEmpty) {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: kMsgSelectFromDate);

      return;
    }

    if (selectedArea == null) {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: kMsgSelectArea);

      return;
    }

    isLoading = true;
    update([kBISHelpdesk]);

    // calling get bis reports count api method
    bisReport = await _gailConnectServices.getBISReportsCountApi(
      selectedArea: selectedArea!.value,
      selectedType: selectedTypes?.value ?? '0',
      selectedToDate: toDateController.value.text,
      selectedFromDate: fromDateController.value.text,
      selectedEngineer: selectedEngineer?.engId ?? '0',
    );

    if (bisReport != null) {
      final int _pendingCallTotal = (bisReport!.pendingForCloserWithAdmin! +
          bisReport!.pendingWithAdminForAssignment! +
          bisReport!.pendingWithEng! +
          bisReport!.pendingForCloserWithAdmin! +
          bisReport!.pendingForCloserWithUser! +
          bisReport!.revertedByUser!);

      openClosedPendingCallsList = [
        // BISReportData(color: kRedColor, title: kOpenCalls, count: bisReport!.totalCalls!),
        BISReportData(
            color: Colors.green,
            title: kClosedCalls,
            count: bisReport!.callsClosedDuringPeriod!),
        BISReportData(
            title: kPendingCalls,
            color: Color(0xFFFEC525),
            count: _pendingCallTotal),
      ];
    }

    // calling scroll to end method
    _scrollToEnd();

    allOpenCallsList = [];
    allPendingCallsList = [];
    isLoading = false;
    update([kBISHelpdesk]);
  }

  onOpenCallsSectionPressed(int index) {
    switch (index) {
      case 2:
        allOpenCallsList = [
          BISReportData(
              color: Colors.red,
              title: kPreviousOpenCalls,
              count: bisReport!.previousOpenCalls!),
          BISReportData(
            color: Colors.green,
            title: kCallsLoggedDuringPeriod,
            count: bisReport!.callsLoggedDuringPeriod!,
          ),
        ];

        // calling scroll to end method
        _scrollToEnd();

        allPendingCallsList = [];
        update([kBISHelpdesk]);

        break;

      case 0:
        allOpenCallsList = [];
        allPendingCallsList = [];
        update([kBISHelpdesk]);

        // calling on report type selected method
        onReportTypeSelected(
            reportType: 'CallsclosedDuringPeriod',
            screenTitle: kCallsLoggedDuringPeriodDetails);

        break;

      case 1:
        allPendingCallsList = [
          BISReportData(
            axisTitle: '1',
            color: Color(0xFFFEC525),
            title: kPendingForAssignmentWithHelpdesk,
            count: bisReport!.pendingForAssignmentWithHelpdesk!,
          ),
          BISReportData(
            axisTitle: '2',
            color: Colors.green,
            title: kPendingForAssignmentWithAdmin,
            count: bisReport!.pendingWithAdminForAssignment!,
          ),
          BISReportData(
            axisTitle: '3',
            color: colorController.kPrimaryDarkColor,
            title: kPendingWithEngineer,
            count: bisReport!.pendingWithEng!,
          ),
          BISReportData(
            axisTitle: '4',
            color: Colors.red,
            title: kPendingForClosureWithAdmin,
            count: bisReport!.pendingForCloserWithAdmin!,
          ),
          BISReportData(
            axisTitle: '5',
            color: colorController.kPrimaryColor,
            title: kPendingForClosureWithUser,
            count: bisReport!.pendingForCloserWithUser!,
          ),
          BISReportData(
            axisTitle: '6',
            title: kRevertedByUser,
            color:Color(0xFFFEC525),
            count: bisReport!.revertedByUser!,
          ),
        ];

        // calling scroll to end method
        _scrollToEnd();

        allOpenCallsList = [];
        update([kBISHelpdesk]);

        break;
    }

    if (index == 0) {
    } else {}
  }

  onAreaSelected({required Areas? area}) async {
    selectedArea = area;

    // calling get types list by area method
    getTypesListByArea();

    // calling get engineers list by area method
    // getEngineersListByArea();
  }

  onTypesSelected(Types? _selectedTypes) => selectedTypes = _selectedTypes;

  onEngineerSelected(Engineer? _selectedEngineer) =>
      selectedEngineer = _selectedEngineer;

  onPendingCallsSectionPressed(int index) {
    switch (index) {
      case 0:
        // calling on report type selected method
        onReportTypeSelected(
          reportType: 'pendingforassignmentWithhelpdesk',
          screenTitle: kPendingForAssignmentWithHelpdeskDetails,
        );

        break;
      case 1:
        // calling on report type selected method
        onReportTypeSelected(
          reportType: 'PendingWithAdminForAssignment',
          screenTitle: kPendingForAssignmentWithAdminDetails,
        );

        break;
      case 2:
        // calling on report type selected method
        onReportTypeSelected(
            reportType: 'Pendingwitheng',
            screenTitle: kPendingWithEngineerDetails);

        break;
      case 3:
        // calling on report type selected method
        onReportTypeSelected(
          reportType: 'PendingforcloserWithAdmin',
          screenTitle: kPendingForClosureWithAdminDetails,
        );

        break;
      case 4:
        // calling on report type selected method
        onReportTypeSelected(
          reportType: 'Pendingforcloserwithuser',
          screenTitle: kPendingForClosureWithUserDetails,
        );

        break;
      case 5:
        // calling on report type selected method
        onReportTypeSelected(
            reportType: 'revertedbyuser', screenTitle: kRevertedByUserDetails);

        break;
    }
  }

  onReportTypeSelected({String? screenTitle, String? reportType}) {
    if (reportType != null && screenTitle != null) {
      Get.toNamed(
        kBISHelpdeskDetailsRoute,
        arguments: {
          kTitle: screenTitle,
          kReportType: reportType,
          kArea: selectedArea!.value,
          kType: selectedTypes?.value ?? '0',
          kToDate: toDateController.value.text,
          kFromDate: fromDateController.value.text,
          kEngineer: selectedEngineer?.engId ?? '0',
        },
      );
    }
  }

  _scrollToEnd() async {
    await Future.delayed(const Duration(milliseconds: 400));

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
    );
  }

  showDatePickerDialog({bool isEndDate = false}) async {
    try {
      // calling show custom date picker method
      await showCustomDatePicker(
        onCancelClick: () {},
        context: Get.context!,
        maximumDate: DateTime.now(),
        leftArrowColor: colorController.kPrimaryDarkColor,
        rightArrowColor: colorController.kPrimaryDarkColor,
        applyButtonColor: colorController.kPrimaryDarkColor,
        selectedDateColor: colorController.kPrimaryDarkColor,
        weekDaysTextColor: colorController.kPrimaryDarkColor,
        monthYearTextColor: colorController.kPrimaryDarkColor,
        applyButtonTextStyle: buttonTextStyle,
        onApplyClick: (DateTime? _selectedDate) async {
          if (_selectedDate != null) {
            final String selectedDate = _selectedDate.formatDateTime(
                newDateTimeFormat: kDateDisplayFormat);

            if (isEndDate) {
              if (_selectedFromDate != null &&
                  _selectedFromDate!.isAfter(_selectedDate)) {
                // calling show custom dialog box method
                await showCustomDialogBox(
                  title: kError,
                  context: Get.context!,
                  description: kMsgToDateLessThanFromDate,
                );
              } else {
                toDateController.text = selectedDate;

                Get.back();
              }
            } else {
              _selectedFromDate = _selectedDate;
              fromDateController.text = selectedDate;

              Get.back();
            }
          }
        },
      );
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while showing date picker dialog',
      );
    }
  }

  @override
  void dispose() {
    toDateController.dispose();
    fromDateController.dispose();

    super.dispose();
  }
}
