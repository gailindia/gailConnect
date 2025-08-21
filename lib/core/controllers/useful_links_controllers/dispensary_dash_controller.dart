import 'package:flutter/material.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/dispensary_screens/dispensary_add_call.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/dispensary_screens/dispensary_history.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';

import '../../../ui/screens/useful_links_screens/dispensary_screens/dispensary_pending.dart';

class DispensaryDashController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList<Widget> bottomNavChildren =
      <Widget>[Dispensary(), DispensaryPending(), DispensaryHistory()].obs;

  @override
  void onInit() {

    bottomNavChildren.add(Dispensary());
    bottomNavChildren.add(DispensaryPending());
    bottomNavChildren.add(DispensaryHistory());
  }

  onBottomNavTapped(int _index) {
    currentIndex.value = _index;

    print("_index" + _index.toString());
    update([kDispensaryDash]);
  }
}
