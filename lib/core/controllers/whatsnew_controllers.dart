// Created By Amit Jangid 20/10/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/whatsnew_model.dart';
import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';

class WhatsNewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final String _tag = 'WhatsNewController';

  String? screenTitle;
  bool isLoading = true;

  late AnimationController animationController;

  List<WhatsNewModel> whatsNewList = [];

  @override
  void onInit() {
    super.onInit();

    // animationController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // calling check connectivity method
    _checkConnectivity();

    // calling get banner details method

    getWhatsNew();
    // postwhtsnewupdateapi();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: 'Banner Details Screen');
  }

  _checkConnectivity() async {
    if (!await checkConnectivity()) {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!,
          title: kInfo,
          description: kInternetNotAvailable);

      isLoading = false;
      update([kWhatsnewTitle]);
    }
  }

  getWhatsNew() async {
    // isLoading = true;

    // calling get banner details api method
    whatsNewList = await GailConnectServices.to.getWhatsNewApi();

    // await GailConnectServices.to.insertWhatsNew();

    // isLoading = false;
    update([kWhatsnewTitle]);
  }

  downloadAndShareImage(
      {required String title, required String imageUrl}) async {
    try {
      if (!await checkConnectivity()) {
        // calling show custom dialog box method
        showCustomDialogBox(
            context: Get.context!,
            title: kInfo,
            description: kInternetNotAvailable);

        return;
      }

      // calling show progress dialog method
      await showProgressDialog(Get.context!);

      // calling download image method
      await GailConnectServices.to.downloadImage(imageUrl: imageUrl);

      // calling hide progress dialog method
      await hideProgressDialog();
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while downloading image',
      );

      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!,
          title: kInfo,
          description: kMsgImageDownloadFailed);
    }
  }

  @override
  void dispose() {
    // animationController.dispose();

    super.dispose();
  }

  void postwhtsnewupdateapi() async {
    // await GailConnectServices.to.insertWhatsNew();

    isLoading = false;
    update([kWhatsnewTitle]);
  }
}
