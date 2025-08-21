import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/bis_helpdesk_calls_screens/bis_helpdesk_closed_call_screen.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/bis_helpdesk_calls_screens/bis_helpdesk_open_call_screen.dart';
import 'package:get/get.dart';

import '../../../../ui/screens/useful_links_screens/bis_helpdesk_calls_screens/bis_helpdesk_add_call_screen.dart';

class BISHelpdeskDashController extends GetxController {
  int currentIndex = 0;

  List<Widget> bottomNavChildren = [
    const BISHelpdeskAddCallScreen(),
    // const BISHelpdeskCallsScreen(),

    const BISHelpdeskOpenCallsScreen(),
    const BISHelpdeskClosedCallsScreen(),
  ];

  onBottomNavTapped(int _index) {
    currentIndex = _index;
    update([kBISHelpdeskDashTabRoute]); //kBISHelpdeskDashTab
  }
}
