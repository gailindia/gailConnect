// Created By Amit Jangid 02/09/21

import 'package:gail_connect/core/controllers/news_controllers/news_controller.dart';
import 'package:get/get.dart';

class NewsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NewsController());
  }
}