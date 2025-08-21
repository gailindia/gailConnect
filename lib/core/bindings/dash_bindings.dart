// Created By Amit Jangid 25/08/21

import 'package:get/get.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';

class DashBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put(EmpListController());
    Get.put(MainDashController());
  }
}
