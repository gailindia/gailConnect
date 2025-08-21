// Created By Amit Jangid 23/09/21

import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class BrowserController extends GetxController {
  bool isLoading = true;
  late String title, initialUrl;

  @override
  void onInit() {
    super.onInit();

    title = Get.arguments[kTitle].toString();
    initialUrl = Get.arguments[kUrl].toString();
  }

  onPageFinished({required bool loading}) {
    isLoading = loading;
    update([kBrowserRoute]);
  }
}
