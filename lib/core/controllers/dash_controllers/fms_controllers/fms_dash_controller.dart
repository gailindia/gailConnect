// Created By Amit Jangid 16/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:get/get.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/fms_dash_screens/fms_chart_screen.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/fms_dash_screens/fms_mail_box_screen.dart';

class FmsDashController extends GetxController {
  int currentIndex = 0;

  List<Widget> bottomNavChildren = [const FmsMailBoxScreen(), const FmsChartScreen()];

  onBottomNavTapped(int _index) {
    currentIndex = _index;
    update([kFmsDashboard]);
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: kFMSDashboardScreen);
  }
}
