// Created By Amit Jangid 16/09/21

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/fms_controllers/fms_dash_controller.dart';

class FmsDashScreen extends StatelessWidget {
  const FmsDashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GetBuilder<FmsDashController>(
      id: kFmsDashboard,
      init: FmsDashController(),
      builder: (_fmsDashController) => Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        body: _fmsDashController
            .bottomNavChildren[_fmsDashController.currentIndex],
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedFontSize: 15,
        //   unselectedFontSize: 14,
        //   showSelectedLabels: false,
        //   showUnselectedLabels: false,
        //   backgroundColor: kPrimaryColor,
        //   selectedItemColor: Colors.white,
        //   unselectedItemColor: Colors.grey,
        //   // calling on bottom nav tapped method
        //   onTap: _fmsDashController.onBottomNavTapped,
        //   currentIndex: _fmsDashController.currentIndex,
        //   items: const [
        //     BottomNavigationBarItem(label: '', icon: Icon(FontAwesome5Solid.clipboard_list)),
        //     BottomNavigationBarItem(label: '', icon: Icon(Ionicons.bar_chart_outline)),
        //   ],
        // ),
        bottomNavigationBar: BottomNavyBar(
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(FontAwesome5Solid.clipboard_list),
              title: const Text(
                'Summary',
                textAlign: TextAlign.center,
              ),
              activeColor: const Color.fromARGB(255, 234, 234, 234),
            ),
            BottomNavyBarItem(
              icon: const Icon(Ionicons.bar_chart_outline),
              title: const Text(
                'Open Files',
                textAlign: TextAlign.center,
              ),
              activeColor: const Color.fromARGB(255, 234, 234, 234),
            )
          ],
          onItemSelected: _fmsDashController.onBottomNavTapped,
          selectedIndex: _fmsDashController.currentIndex,
          containerHeight: 65,
          backgroundColor: colorController.kPrimaryColor,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
