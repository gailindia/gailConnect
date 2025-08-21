// Created By Amit Jangid 02/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class NewsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // static const String _tag = 'NewsController';

  static NewsController get to => Get.find<NewsController>();

  late String newsCategory, newsListTitle;

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
        vsync: this, value: 0.1, duration: const Duration(milliseconds: 1000));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to
        .hitCountApi(activity: kNewsDashboardScreen, activityScreen: "/news");
  }

  onNewsCategorySelected(
      {required String hitCountScreen,
      required String category,
      required String listTitle}) {
    newsCategory = category;
    newsListTitle = listTitle;

    Get.toNamed(kNewsCatRoute);

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: hitCountScreen);
  }

  navigateToLiveEventsScreen() => Get.toNamed(kLiveEventRoute);

  openTwitterAccount() {
    Get.toNamed(kBrowserRoute,
        arguments: {kUrl: kTwitterUrl, kTitle: kTwitter});

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: kTwitterScreen);
  }

  openFacebookAccount() {
    Get.toNamed(kBrowserRoute,
        arguments: {kUrl: kFacebookUrl, kTitle: kFacebook});

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: kFacebookScreen);
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
}
