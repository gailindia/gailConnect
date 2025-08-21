// Created By Amit Jangid 02/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/live_event.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class LiveEventController extends GetxController {
  bool isLoading = true;
  List<LiveEvent> liveEventList = [];

  @override
  void onInit() {
    super.onInit();

    // calling get live events method
    getLiveEvents();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: 'Live Event Screen');
  }

  getLiveEvents() async {
    isLoading = true;
    update([kLiveEvents]);

    // calling get live events api method
    liveEventList = await GailConnectServices.to.getLiveEventsApi();

    isLoading = false;
    update([kLiveEvents]);
  }

  openLiveEventLink(
      {required BuildContext context, required String link}) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      Get.toNamed(kBrowserRoute, arguments: {kUrl: link, kTitle: kLiveEvents});
    }
  }
}
