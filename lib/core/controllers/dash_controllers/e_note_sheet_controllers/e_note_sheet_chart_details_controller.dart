// Created By Amit Jangid 22/10/21

import 'package:get/get.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/models/e_note_sheet_details.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class ENoteSheetChartDetailsController extends GetxController {
  bool isLoading = true;

  String? screenTitle;
  late String _selectedCpfNumber;
  String? _status, _partUrl, _selectedType;

  ReportingEmp? selectedReportingEmp;

  List<ReportingEmp> reportingEmpList = [];

  List<ENoteSheetDetails> eNoteSheetChartDetailsList = [];

  @override
  void onInit() {
    super.onInit();

    _status = Get.arguments[kStatus];
    _partUrl = Get.arguments[kPartUrl];
    screenTitle = Get.arguments[kTitle];
    _selectedType = Get.arguments[kType];
    _selectedCpfNumber = Get.arguments[kCpfNo];

    // calling get e note sheet chart details method
    getENoteSheetChartDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kENoteChartDetailsScreen);
  }

  getENoteSheetChartDetails() async {
    isLoading = true;
    update([kENoteSheetChartDetails]);

    // calling get e note sheet chart details api method
    eNoteSheetChartDetailsList =
        await GailConnectServices.to.getENoteSheetChartDetailsApi(
      status: _status!,
      partUrl: _partUrl!,
      type: _selectedType!,
      cpfNumber: _selectedCpfNumber,
    );

    isLoading = false;
    update([kENoteSheetChartDetails]);
  }
}
