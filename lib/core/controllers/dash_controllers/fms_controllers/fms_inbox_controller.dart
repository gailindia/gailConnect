// Created By Amit Jangid 16/09/21

import 'package:get/get.dart';
import 'package:gail_connect/models/fms_mail.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class FmsInboxController extends GetxController {
  bool isLoading = true;
  String userType = kSelf;

  ReportingEmp? selectedReportingEmp;

  List<FmsMail> fmsInboxList = [];
  List<ReportingEmp> reportingEmpList = [];

  @override
  void onInit() async {
    super.onInit();
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;
    // const String _cpfNumber = '575';

    // calling get fms inbox list method
    getFmsInboxList(id: _cpfNumber);
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kFMSInboxScreen);
  }

  getFmsInboxList({required String id}) async {
    isLoading = true;
    update([kInbox]);

    // calling get fms mail list api method
    fmsInboxList = await GailConnectServices.to
        .getFmsMailListApi(id: id, api: kFmsInboxApi);

    isLoading = false;
    update([kInbox]);
  }

  getReportingEmpList() async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!, message: kMsgGettingSubOrdinates);

    // calling get reporting emp api method
    reportingEmpList = await GailConnectServices.to.getReportingEmpApi();
    update([kInbox]);

    // calling hide progress dialog method
    await hideProgressDialog();
  }

  onUserTypeSelected(String? _selectedValue) async{
    userType = _selectedValue!;
    update([kInbox]);

    if (_selectedValue == kSubOrdinate) {
      fmsInboxList = [];
      update([kInbox]);

      // calling get reporting emp list method
      getReportingEmpList();
    } else {
      SecureSharedPref pref = await SecureSharedPref.getInstance();

      final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;
      // const String _cpfNumber = '575';

      // calling get fms inbox list method
      getFmsInboxList(id: _cpfNumber);
    }
  }

  onSubOrdinateSelected(ReportingEmp? _selectedReportingEmp) {
    selectedReportingEmp = _selectedReportingEmp;
    update([kInbox]);

    // calling get fms inbox list method
    getFmsInboxList(id: _selectedReportingEmp!.empNo!);
  }
}
