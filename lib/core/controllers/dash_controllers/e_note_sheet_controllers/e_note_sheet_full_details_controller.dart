// Created By Amit Jangid 21/10/21

import 'package:get/get.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/models/e_note_sheet_by_file.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class ENoteSheetFullDetailsController extends GetxController {
  bool isLoading = true;
  String? fileId, screenTitle;

  ENoteSheetByFile? eNoteSheetByFile;

  @override
  void onInit() {
    super.onInit();

    fileId = Get.arguments[kFileId];
    screenTitle = Get.arguments[kTitle];

    // calling get e note sheet details by file id method
    getENoteSheetDetailsByFileId();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: '$screenTitle Screen');
  }

  getENoteSheetDetailsByFileId() async {
    isLoading = true;
    update([kENoteSheetFullDetails]);

    // calling get e note sheet by file id api method
    eNoteSheetByFile =
        await GailConnectServices.to.getENoteSheetByFileIdApi(fileId: fileId!);

    isLoading = false;
    update([kENoteSheetFullDetails]);
  }
}
