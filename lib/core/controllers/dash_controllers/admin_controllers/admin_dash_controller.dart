// Created By Amit Jangid on 15/12/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AdminDashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Animation<double> carouselAnimation;
  late AnimationController _carouselAnimationController;

  @override
  void onInit() {
    super.onInit();

    _carouselAnimationController = AnimationController(
      value: 0.1,
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    carouselAnimation = CurvedAnimation(
        parent: _carouselAnimationController, curve: Curves.easeIn);
    _carouselAnimationController.forward();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kAdminDashboardScreen);
  }

  @override
  void dispose() {
    _carouselAnimationController.dispose();

    super.dispose();
  }
}
