// Created By Amit Jangid 18/10/21

import 'package:flutter/material.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

import 'package:get/get.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class DashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Animation<double> carouselAnimation;
  late AnimationController _carouselAnimationController;
  String isBISHelpdeskAdmin ="";
  bool isDashboardAdmin=false;
  @override
  void onInit() async{
    super.onInit();

    _carouselAnimationController = AnimationController(
      value: 0.1,
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    carouselAnimation = CurvedAnimation(
        parent: _carouselAnimationController, curve: Curves.easeIn);
    _carouselAnimationController.forward();
    isBISHelpdeskAdmin = (await pref.getString("isBISHelpdeskAdmin"))!;
    isDashboardAdmin = (await pref.getBool("isDashboardAdmin"))!;
    update([kFmsBwsDashboard]);
  }
  /*Admin
  I/flutter (32766): admin
  [GETX] Instance "DashController" has been created
  I/flutter (32766): false*/
  @override
  void onReady() async {
    super.onReady();
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    isBISHelpdeskAdmin = (await pref.getString("isBISHelpdeskAdmin"))!;
    isDashboardAdmin = (await pref.getBool("isDashboardAdmin"))!;
    update([kFmsBwsDashboard]);
    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kDashboardScreen);
  }

  @override
  void dispose() {
    _carouselAnimationController.dispose();
    super.dispose();
  }
}
