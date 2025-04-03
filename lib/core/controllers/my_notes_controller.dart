import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/models/my_notes_model.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
 

import '../../main.dart';

class MyNotesController extends GetxController {
  final String _tag = 'MyNotesController';
  File? selectedImageFile;
  String? base64Image = "";
  // var notesList = <MyNotesModel>[].obs;
  bool isLoading = false;

  var notesList = <MyNotesModel>[];

  TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // animationController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // calling check connectivity method
    // _checkConnectivity();

    // // calling get banner details method

    // getWhatsNew();
    // postwhtsnewupdateapi();

    getNotesList();
  }

  chooseCamera() {}

  captureImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    var capturedImage = (await _imagePicker.pickImage(
        imageQuality: 80, source: ImageSource.camera));
    selectedImageFile = File(capturedImage!.path);
    List<int> imageBytes = selectedImageFile!.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    update([kMyNotes]);
  }

  chooseFiles() async {
    try {
      final FilePickerResult? _result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );

      if (_result != null) {
        update([kMyNotes]);
        final PlatformFile fileo = _result.files.first;
        selectedImageFile = File(fileo.path!);
        List<int> imageBytes = selectedImageFile!.readAsBytesSync();

        base64Image = base64Encode(imageBytes);
        print("IMAGE: " + base64Image.toString());
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

  getNotesList() async {
    // await showProgressDialog(Get.context!, message: kMsgPleaseWaitFetchingData);
// const Expanded(child: LoadingWidget()),
    isLoading = true;
    update([kMyNotes]);
    notesList = await GailConnectServices.to.getMyNotesApi();
    // hideProgressDialog();
    isLoading = false;
    update([kMyNotes]);
  }

  onTextMessageSend(text) async {
    var response = await GailConnectServices.to.sendMyNotesData(
        messageController.value.text.toString(), base64Image.toString());
    print(response);
    if (response.contains("Inserted Successfully")) {
      // await showProgressDialog(Get.context!,
      //     message: kMsgPleaseWaitFetchingData);

      messageController.clear();
      Get.snackbar(
        "Note Saved",
        "Hello everyone",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
      getNotesList();
      update([kMyNotes]);
    }
  }
}
