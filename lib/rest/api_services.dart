// Created By Amit Jangid 24/08/21

import 'package:get/get.dart';

class ApiServices extends GetConnect {
  static ApiServices get to => Get.find<ApiServices>();

  @override
  void onInit() {
    super.onInit();

    httpClient.timeout = const Duration(seconds: 30);

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Connection'] = 'keep-alive';
      return request;
    });
  }
}
