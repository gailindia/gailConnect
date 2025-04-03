// Created By Amit Jangid on 20/12/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/custom_dialogs/show_custom_confirmation_dialog_box.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/models/emp_group.dart';
import 'package:multiutillib/utils/string_extension.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_list_controller.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class EmpGroupDetailsController extends GetxController {
  static EmpGroupDetailsController get to =>
      Get.find<EmpGroupDetailsController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();

  bool isLoading = true;
  late String _empGroupId;

  EmpGroup? empGroup;
  List<Employee> groupEmployeesList = [];

  @override
  void onInit() {
    super.onInit();

    _empGroupId = Get.arguments;

    // calling get emp group details method
    getEmpGroupDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kEmployeesGroupSendMsgScreen);
  }

  getEmpGroupDetails() async {
    isLoading = true;
    update([kGroupDetails]);

    // calling get emp group details api method
    empGroup = await GailConnectServices.to
        .getEmpGroupDetailsApi(empGroupId: _empGroupId);

    // calling get employees details method
    getEmployeesDetails();
  }

  getEmployeesDetails() async {
    // calling get group employees method
    groupEmployeesList = await EmployeeDb.getGroupEmployees(
        groupMembers: empGroup!.groupMembers!);

    isLoading = false;
    update([kGroupDetails]);
  }

  checkIfLoggedInEmpIsAdminForGroup() async{
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;
    final int _cpf = _cpfNumber.toInt!;

    final int _createdByCpf = empGroup!.createdByCpf.toInt!;

    if (_cpf == _createdByCpf) {
      return true;
    }

    return false;
  }

  Future<String> getCreatedByName() async{
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;
    final int _cpf = _cpfNumber.toInt!;
    final int _createdByCpf = empGroup!.createdByCpf.toInt!;

    if (_cpf == _createdByCpf) {
    return kYou;
    } else {
    return empGroup!.createdByName;
    }
  }

  removeMemberFromGroup({required String groupMembers}) async {
    // calling show progress dialog method
    await showProgressDialog(Get.context!);

    // calling remove member from group api method
    await GailConnectServices.to.removeMemberFromGroupApi(
        empGroupId: _empGroupId, groupMembers: groupMembers);

    // calling get emp group details method
    await getEmpGroupDetails();

    // calling hide progress dialog method
    await hideProgressDialog();
  }

  deleteGroup() async {
    showConfirmationDialog(
      Get.context!,
      title: kMsgDeleteGroup,
      description: 'Are you sure you want to delete ${empGroup!.groupName}?',
      onNegativePressed: Get.back,
      onPositivePressed: () async {
        Get.back();

        // calling show progress dialog method
        await showProgressDialog(Get.context!);

        // calling delete group api method
        final _response = await GailConnectServices.to.deleteGroupApi(
          empGroupId: _empGroupId,
          adminCpf: empGroup!.createdByCpf,
        );

        // calling hide progress dialog method
        await hideProgressDialog();

        // calling get emp groups list method
        EmpGroupListController.to.getEmpGroupsList();

        // calling show custom dialog box method
        await showCustomDialogBox(
            context: Get.context!, title: kInfo, description: _response!);

        Get.back();
        Get.back();
      },
    );
  }

  sendMessage() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final List<String> _recipients = [];
      final String _message = messageController.value.text;

      for (final Employee _employee in groupEmployeesList) {
        if (_employee.telNo != null && _employee.telNo!.isNotEmpty) {
          _recipients.add(_employee.telNo!);
        }
      }

      // calling send message method
      MainDashController.to
          .sendMessage(recipients: _recipients, message: _message);
    }
  }

  sendEmail() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      String _emails = '';
      final String _body = messageController.value.text;

      for (final Employee _employee in groupEmployeesList) {
        if (_employee.emails != null && _employee.emails!.isNotEmpty) {
          _emails += _employee.emails! + ',';
        }
      }

      // calling send email method
      MainDashController.to.sendEmail(
          body: _body, emailId: _emails.substring(0, _emails.length - 1));
    }
  }

  @override
  void dispose() {
    messageController.dispose();

    super.dispose();
  }
}
