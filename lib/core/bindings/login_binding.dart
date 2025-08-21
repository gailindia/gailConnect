// Created By Amit Jangid 24/08/21

import 'package:get/get.dart';
import 'package:gail_connect/rest/auth_services.dart';
import 'package:gail_connect/core/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthServices());
    Get.put(LoginController());
  }
}
