// Created By Amit Jangid 21/10/21

import 'package:get/get.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/models/e_note_sheet_details.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class ENoteSheetSentBoxController extends GetxController {
  bool isLoading = true;
  String userType = kSelf;
  String selectedType = kSelf;
  String selectedStatus = kOpen;
  late String _selectedCpfNumber;

  ReportingEmp? selectedReportingEmp;

  List<ReportingEmp> reportingEmpList = [];

  List<ENoteSheetDetails> eNoteSheetSentBoxList = [];

  @override
  void onInit() async{
    super.onInit();
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    _selectedCpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    // _selectedCpfNumber = '575';

    // calling get e note sheet sent box details method
    getENoteSheetSentBoxDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kENoteSentBoxScreen);
  }

  getENoteSheetSentBoxDetails() async {
    isLoading = true;
    update([kENoteSheetSentBox]);

    // calling get e note sheet count details api method
    eNoteSheetSentBoxList =
        await GailConnectServices.to.getENoteSheetCountDetailsApi(
      type: selectedType,
      status: selectedStatus,
      cpfNumber: _selectedCpfNumber,
      partUrl: 'get_sentboxcountdetails',
    );

    isLoading = false;
    update([kENoteSheetSentBox]);
  }

  onENoteStatusSelected(String? _selectedValue) {
    selectedStatus = _selectedValue!;
    update([kENoteSheetSentBox]);

    // calling get e note sheet sent box details method
    getENoteSheetSentBoxDetails();
  }

  getReportingEmpList() async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!, message: kMsgGettingSubOrdinates);

    // calling get reporting emp api method
    reportingEmpList = await GailConnectServices.to.getReportingEmpApi();
    update([kENoteSheetSentBox]);

    // calling hide progress dialog method
    await hideProgressDialog();
  }

  onUserTypeSelected(String? _selectedValue) async {
    userType = _selectedValue!;
    update([kENoteSheetSentBox]);

    if (_selectedValue == kSubOrdinate) {
      selectedType = kAll;
      eNoteSheetSentBoxList = [];
      update([kENoteSheetSentBox]);

      // calling get reporting emp list method
      await getReportingEmpList();
    } else {
      selectedType = kSelf;
      SecureSharedPref pref = await SecureSharedPref.getInstance();
      _selectedCpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

      // _selectedCpfNumber = '575';
    }

    // calling get e note sheet sent box details method
    await getENoteSheetSentBoxDetails();
  }

  onSubOrdinateSelected(ReportingEmp? _selectedReportingEmp) {
    selectedType = kSelf;
    selectedReportingEmp = _selectedReportingEmp;
    _selectedCpfNumber = selectedReportingEmp!.empNo!;
    update([kENoteSheetSentBox]);

    // calling get e note sheet sent box details method
    getENoteSheetSentBoxDetails();
  }
}
