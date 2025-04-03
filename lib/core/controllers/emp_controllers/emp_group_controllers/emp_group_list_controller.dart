// Created By Amit Jangid on 17/12/21

import 'package:get/get.dart';
import 'package:gail_connect/models/emp_group.dart';
import 'package:multiutillib/utils/string_extension.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class EmpGroupListController extends GetxController {
  static EmpGroupListController get to => Get.find<EmpGroupListController>();

  bool isLoading = true;

  List<EmpGroup> empGroupList = [];

  @override
  void onInit() {
    super.onInit();

    // calling get emp groups list method
    getEmpGroupsList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kEmployeesGroupsScreen);
  }

  getEmpGroupsList() async {
    isLoading = true;
    update([kEmpGroups]);

    // calling get emp groups list api method
    empGroupList = await GailConnectServices.to.getEmpGroupsListApi();

    isLoading = false;
    update([kEmpGroups]);
  }

  Future<String> getCreatedByName(EmpGroup _empGroup) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;
    final int _cpf = _cpfNumber.toInt!;
    // final int _cpf = SharedPrefs.to.cpfNumber.toInt!;
    final int _createdByCpf = _empGroup.createdByCpf.toInt!;

    if (_cpf == _createdByCpf) {
    return kYou;
    } else {
    return _empGroup.createdByName;
    }
  }
}
