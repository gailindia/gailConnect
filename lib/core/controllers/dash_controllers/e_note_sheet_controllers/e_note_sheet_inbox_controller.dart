// Created By Amit Jangid 21/10/21

import 'package:get/get.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/models/e_note_sheet_details.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class ENoteSheetInboxController extends GetxController {
  bool isLoading = true;
  String userType = kSelf;
  String selectedType = kSelf;
  String selectedStatus = kOpen;
  late String _selectedCpfNumber;

  ReportingEmp? selectedReportingEmp;

  List<ReportingEmp> reportingEmpList = [];
  List<ENoteSheetDetails> eNoteSheetInboxList = [];

  @override
  void onInit() async{
    super.onInit();
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    _selectedCpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    // _selectedCpfNumber = '575';

    // calling get e note sheet inbox details method
    getENoteSheetInboxDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kENoteInboxScreen);
  }

  getENoteSheetInboxDetails() async {
    isLoading = true;
    update([kENoteSheetInbox]);

    // calling get e note sheet count details api method
    eNoteSheetInboxList =
        await GailConnectServices.to.getENoteSheetCountDetailsApi(
      type: selectedType,
      status: selectedStatus,
      cpfNumber: _selectedCpfNumber,
      partUrl: 'get_inboxcountdetails',
    );

    isLoading = false;
    update([kENoteSheetInbox]);
  }

  onENoteStatusSelected(String? _selectedValue) {
    selectedStatus = _selectedValue!;
    update([kENoteSheetInbox]);

    // calling get e note sheet inbox details method
    getENoteSheetInboxDetails();
  }

  getReportingEmpList() async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!, message: kMsgGettingSubOrdinates);

    // calling get reporting emp api method
    reportingEmpList = await GailConnectServices.to.getReportingEmpApi();
    update([kENoteSheetInbox]);

    // calling hide progress dialog method
    await hideProgressDialog();
  }

  onUserTypeSelected(String? _selectedValue) async {
    userType = _selectedValue!;
    update([kENoteSheetInbox]);

    if (_selectedValue == kSubOrdinate) {
      selectedType = kAll;
      eNoteSheetInboxList = [];
      update([kENoteSheetInbox]);

      // calling get reporting emp list method
      await getReportingEmpList();
    } else {
      selectedType = kSelf;
      SecureSharedPref pref = await SecureSharedPref.getInstance();
      _selectedCpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

      // _selectedCpfNumber = '575';
    }

    // calling get e note sheet inbox details method
    await getENoteSheetInboxDetails();
  }

  onSubOrdinateSelected(ReportingEmp? _selectedReportingEmp) {
    selectedType = kSelf;
    selectedReportingEmp = _selectedReportingEmp;
    _selectedCpfNumber = selectedReportingEmp!.empNo!;
    update([kENoteSheetInbox]);

    // calling get e note sheet inbox details method
    getENoteSheetInboxDetails();
  }
}
