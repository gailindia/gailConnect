// Created By Amit Jangid on 28/12/21

import 'package:gail_connect/models/chat_user.dart';
import 'package:get/get.dart';

class EmpInfoController extends GetxController {
  late ChatUser chatUser;

  @override
  void onInit() {
    super.onInit();

    chatUser = Get.arguments;
  }
}
