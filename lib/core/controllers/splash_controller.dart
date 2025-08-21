// Created By Amit Jangid 13/07/21

import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class SplashController extends GetxController {
  bool? seen = false;
  SecureSharedPref? prefs;

  @override
  void onInit() {
    super.onInit();

    // calling navigate to next screen method
    navigateToNextScreen();
  }

  navigateToNextScreen() async {
    prefs = await SecureSharedPref.getInstance();
    seen = (await prefs!.getBool('seen') ?? false);

    if (seen == true) {
      await Future.delayed(const Duration(seconds: 5));
      Get.offNamedUntil(kLoginRoute, (route) => false);
    } else {
      // await prefs!.setBool('seen', true);
      // await Future.delayed(const Duration(seconds: 5));
      Get.offNamedUntil(kLoginRoute, (route) => false);
    }
  }
}
