// Created By Amit Jangid on 24/11/21

import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gail_connect/models/areas.dart';
import 'package:gail_connect/models/types.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../ui/widgets/custom_dialogs/show_custom_confirmation_dialog_box.dart';

class BISHelpdeskAddCallController extends GetxController {
  static const String _tag = 'BISHelpdeskAddCallController';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController descController = TextEditingController();
  final GailConnectServices _gailConnectServices = GailConnectServices.to;

  Areas? selectedArea;
  XFile? capturedImage;
  Types? selectedTypes;

  List<Areas> areasList = [];
  List<Types> typesList = [];
  List<PlatformFile> selectedFilesList = [];

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    _gailConnectServices.hitCountApi(
        activity: kBISHelpdeskCallsScreen, activityScreen: "/bisHelpdeskDash");

    // calling get areas  list method
    getAreasList();
  }

  clearTypesSelection() {
    typesList = [];
    selectedTypes = null;
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
    update([kBISHelpdeskNewCall]);
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

      update([kBISHelpdeskNewCall]);
    } else {
      typesList = [];
      selectedTypes = null;
    }
  }

  onAreaSelected({required Areas? area}) async {
    selectedArea = area;

    // calling get types list by area method
    getTypesListByArea();
  }

  onTypesSelected(Types? _selectedTypes) => selectedTypes = _selectedTypes;

  openDialog() async{
    showConfirmationDialog(
      Get.context!,
      title: "Grant Permission",
      description:
      "In order to access the BIS Helpdesk, you first need to grant 'Camera' permission in app settings. Click YES to go to app settings.",
      onPositivePressed: () async {
        openAppSettings();
        Navigator.pop(Get.context!, "");
      }, onNegativePressed: () {
      Navigator.pop(Get.context!, "");
    },
    );
  }

  checkPermission() async{
    var cameraPer = await Permission.camera.status;


    print("Camera Permission $cameraPer");

      if (cameraPer.isDenied || cameraPer.isPermanentlyDenied) {
        openDialog();
      } else {
        captureImage();
      }
  }

  captureImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    selectedFilesList = [];
    capturedImage = await _imagePicker.pickImage(
        imageQuality: 80, source: ImageSource.camera);
    update([kBISHelpdeskNewCall]);
  }

  chooseFiles() async {
    try {
      final FilePickerResult? _result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        // type: FileType.image,
      );

      if (_result != null) {
        capturedImage = null;
        selectedFilesList = _result.files;

        update([kBISHelpdeskNewCall]);
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while choosing files',
      );
    }
  }

  resetUi() {
    descController.clear();
    selectedFilesList = [];

    update([kBISHelpdeskNewCall]);
  }

  addNewCall() async {
    try {
      if (selectedArea == null) {
        // calling show custom dialog box method
        showCustomDialogBox(
            context: Get.context!,
            title: kWarning,
            description: kMsgSelectProposedArea);

        return;
      }

      if (selectedTypes == null) {
        // calling show custom dialog box method
        showCustomDialogBox(
            context: Get.context!,
            title: kWarning,
            description: kMsgSelectProposedType);

        return;
      }

      // calling show progress dialog method
      await showProgressDialog(Get.context!);

      // calling request call api method
      final _response = await _gailConnectServices.requestCallApi(
        area: selectedArea!.value,
        type: selectedTypes!.value,
        capturedImage: capturedImage,
        uploadedFilesList: selectedFilesList,
        description: descController.value.text,
      );

      // calling hide progress dialog method
      await hideProgressDialog();

      if (_response != null) {
        final _responseBytesToString = await _response.stream.bytesToString();
        debugPrint('addNewCall: response body is $_responseBytesToString');

        if (_response.statusCode == 200) {
          final String _data =
              json.decode(_responseBytesToString)[kJsonMessage].toString();

          // calling show custom dialog method
          await showCustomDialogBox(
              context: Get.context!, title: kInfo, description: _data);

          // calling reset ui method
          resetUi();

          Get.back();
        } else {
          final String _message =
              json.decode(_responseBytesToString)[kJsonMessage].toString();

          // calling show custom dialog method
          showCustomDialogBox(
              context: Get.context!, title: kInfo, description: _message);
        }
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while adding new call and making api call',
      );
    }
  }

  @override
  void dispose() {
    descController.dispose();

    super.dispose();
  }
}
