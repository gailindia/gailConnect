// Created By Amit Jangid 21/10/21

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/e_note_sheet_controllers/e_note_sheet_controller.dart';

import '../../../styles/color_controller.dart';

class ENoteSheetDashScreen extends StatelessWidget {
  const ENoteSheetDashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return GetBuilder<ENoteSheetController>(
      id: kENoteSheet,
      init: ENoteSheetController(),
      builder: (_eNoteSheetController) {
        return Scaffold(
          body: _eNoteSheetController
              .bottomNavChildren[_eNoteSheetController.currentIndex],
          // bottomNavigationBar: BottomNavigationBar(
          //   selectedFontSize: 15,
          //   unselectedFontSize: 14,
          //   showSelectedLabels: false,
          //   showUnselectedLabels: false,
          //   backgroundColor: kPrimaryColor,
          //   selectedItemColor: Colors.white,
          //   unselectedItemColor: Colors.grey,
          //   // calling on bottom nav tapped method
          //   onTap: _eNoteSheetController.onBottomNavTapped,
          //   currentIndex: _eNoteSheetController.currentIndex,
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
                  'Chart',
                  textAlign: TextAlign.center,
                ),
                activeColor: const Color.fromARGB(255, 234, 234, 234),
              ),
            ],
            onItemSelected: _eNoteSheetController.onBottomNavTapped,
            selectedIndex: _eNoteSheetController.currentIndex,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            containerHeight: 65,
            backgroundColor: colorController.kPrimaryColor,
          ),
        );
      },
    );
  }
}
