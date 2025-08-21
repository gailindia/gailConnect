// Created By Amit Jangid 24/08/21

import 'package:get/get.dart';
import 'package:gail_connect/core/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}