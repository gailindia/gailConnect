// Created By Amit Jangid on 21/12/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:get/get.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_list_controller.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_details_controller.dart';

class EmpGroupIconNameUpdateController extends GetxController {
  final String _tag = 'EmpGroupIconNameUpdateController';

  File? selectedGroupIconFile;
  String? empGroupId, imageUrl;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController groupNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    imageUrl = Get.arguments[kImageUrl];
    empGroupId = Get.arguments[kGroupId];
    groupNameController.text = '${Get.arguments[kTitle]}';
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kUpdateEmployeeGroupIconNameScreen);
  }

  chooseGroupIcon() async {
    try {
      final ImagePicker _imagePicker = ImagePicker();

      // calling pick image method
      final XFile? _selectedGroupIcon = await _imagePicker.pickImage(
          imageQuality: 50, source: ImageSource.gallery);

      if (_selectedGroupIcon != null) {
        imageUrl = null;
        selectedGroupIconFile = File(_selectedGroupIcon.path);
        update([kUpdateGroupDetails]);
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while choosing group icon for new group',
      );
    }
  }

  updateGroupNameIcon() async {
    final String _groupName = groupNameController.value.text;

    if (_groupName.isEmpty) {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!,
          title: kWarning,
          description: kMsgGroupNameIsRequired);

      return;
    }

    // calling show progress dialog method
    await showProgressDialog(Get.context!);

    // calling update group icon name api method
    final _response = await GailConnectServices.to.updateGroupIconNameApi(
      groupName: _groupName,
      empGroupId: empGroupId!,
      selectedGroupIcon: selectedGroupIconFile,
    );

    // calling hide progress dialog method
    await hideProgressDialog();

    // calling get emp groups list method
    EmpGroupListController.to.getEmpGroupsList();

    // calling get emp group details method
    EmpGroupDetailsController.to.getEmpGroupDetails();

    // calling show custom dialog box method
    await showCustomDialogBox(
        context: Get.context!, title: kInfo, description: _response!);

    Get.back();
  }

  @override
  void dispose() {
    groupNameController.dispose();

    super.dispose();
  }
}
