// Created By Amit Jangid 10/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/ui/screens/screens.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class OfficeDashController extends GetxController {
  int currentIndex = 0;

  List<Widget> bottomNavChildren = [const OfficesScreen(), const ControlRoomScreen()];

  onBottomNavTapped(int _index) {
    currentIndex = _index;
    update([kOfficeDash]);
  }
}
