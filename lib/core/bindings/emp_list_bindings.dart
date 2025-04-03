// Created By Amit Jangid 01/09/21

import 'package:get/get.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_filters_controller.dart';

class EmpListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EmpFiltersController());
  }
}
