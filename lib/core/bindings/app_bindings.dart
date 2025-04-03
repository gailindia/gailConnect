// Created By Amit Jangid 24/08/21

import 'package:get/get.dart';
import 'package:gail_connect/rest/api_services.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put(SharedPrefs());
    Get.put(ApiServices());
    Get.put(GailConnectServices());
  }
}
