// Created By Amit Jangid 09/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/office_controllers/office_dash_controller.dart';

import '../../../styles/color_controller.dart';

class OfficesDashScreen extends StatelessWidget {
  const OfficesDashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ColorController colorController = Get.put(ColorController());
    return GetBuilder<OfficeDashController>(
      id: kOfficeDash,
      init: OfficeDashController(),
      builder: (_officeDashController) => Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar:  CustomAppBar(title: kOffices),
        body: _officeDashController.bottomNavChildren[_officeDashController.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          selectedFontSize: 15,
          unselectedFontSize: 14,
          showUnselectedLabels: true,
          backgroundColor: colorController.kPrimaryColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          // calling on bottom nav tapped method
          onTap: _officeDashController.onBottomNavTapped,
          currentIndex: _officeDashController.currentIndex,
          items: const [
            BottomNavigationBarItem(label: kOffices, icon: Icon(MaterialCommunityIcons.office_building)),
            BottomNavigationBarItem(label: kControlRoom, icon: Icon(MaterialCommunityIcons.remote_desktop)),
          ],
        ),
      ),
    );
  }
}
