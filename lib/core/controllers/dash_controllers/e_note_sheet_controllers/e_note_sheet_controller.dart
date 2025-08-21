// Created By Amit Jangid 21/10/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/e_note_sheet_screens/e_note_sheet_box_screen.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/e_note_sheet_screens/e_note_sheet_chart_screen.dart';

class ENoteSheetController extends GetxController {
  int currentIndex = 0;

  final List<Widget> bottomNavChildren = [
    const ENoteSheetBoxScreen(),
    const ENoteSheetChartScreen()
  ];

  onBottomNavTapped(int _index) {
    currentIndex = _index;
    update([kENoteSheet]);
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kENoteDashboardScreen);
  }
}
