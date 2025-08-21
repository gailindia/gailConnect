// Created By Amit Jangid 22/10/21

import 'package:get/get.dart';
import 'package:gail_connect/models/e_note_sheet.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class ENoteSheetChartController extends GetxController {
  static ENoteSheetChartController get to =>
      Get.find<ENoteSheetChartController>();

  bool isLoading = true;
  String userType = kSelf;
  String selectedType = kSelf;
  late String selectedCpfNumber;

  ReportingEmp? selectedReportingEmp;
  ENoteSheet? eNoteSheetInbox, eNoteSheetSentBox;

  List<ReportingEmp> reportingEmpList = [];

  @override
  void onInit() async{
    super.onInit();
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    // selectedCpfNumber = '575';
    selectedCpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    // calling get e note sheet inbox count method
    getENoteSheetInboxCount();

    // calling get e note sheet sent box count method
    getENoteSheetSentBoxCount();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kENoteChartScreen);
  }

  getENoteSheetInboxCount() async {
    isLoading = true;
    update([kENoteSheetChart]);

    // calling get e note sheet count api method
    eNoteSheetInbox = await GailConnectServices.to.getENoteSheetChartCountApi(
      type: selectedType,
      partUrl: 'get_inboxcount',
      cpfNumber: selectedCpfNumber,
    );

    isLoading = false;
    update([kENoteSheetChart]);
  }

  getENoteSheetSentBoxCount() async {
    isLoading = true;
    update([kENoteSheetChart]);

    // calling get e note sheet count api method
    eNoteSheetSentBox = await GailConnectServices.to.getENoteSheetChartCountApi(
      type: selectedType,
      partUrl: 'get_sentboxcount',
      cpfNumber: selectedCpfNumber,
    );

    isLoading = false;
    update([kENoteSheetChart]);
  }

  getReportingEmpList() async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!, message: kMsgGettingSubOrdinates);

    // calling get reporting emp api method
    reportingEmpList = await GailConnectServices.to.getReportingEmpApi();
    update([kENoteSheetChart]);

    // calling hide progress dialog method
    await hideProgressDialog();
  }

  onUserTypeSelected(String? _selectedValue) async {
    userType = _selectedValue!;
    update([kENoteSheetChart]);

    if (_selectedValue == kSubOrdinate) {
      selectedType = kAll;
      eNoteSheetInbox = null;
      eNoteSheetSentBox = null;
      update([kENoteSheetChart]);

      // calling get reporting emp list method
      await getReportingEmpList();
    } else {
      selectedType = kSelf;
      SecureSharedPref pref = await SecureSharedPref.getInstance();
      // selectedCpfNumber = '575';
      selectedCpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    }

    // calling get e note sheet inbox count method
    getENoteSheetInboxCount();

    // calling get e note sheet sent box count method
    getENoteSheetSentBoxCount();
  }

  onSubOrdinateSelected(ReportingEmp? _selectedReportingEmp) {
    selectedType = kSelf;
    selectedReportingEmp = _selectedReportingEmp;
    selectedCpfNumber = selectedReportingEmp!.empNo!;
    update([kENoteSheetChart]);

    // calling get e note sheet inbox count method
    getENoteSheetInboxCount();

    // calling get e note sheet sent box count method
    getENoteSheetSentBoxCount();
  }
}
