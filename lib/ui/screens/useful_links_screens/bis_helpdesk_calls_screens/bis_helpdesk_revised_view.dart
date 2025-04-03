// Created By Amit Jangid on 17/12/21

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/bis_helpdesk_calls_controllers/bis_helpdesk_dash_controller.dart';
import 'package:get/get.dart';


import '../../../styles/color_controller.dart';

class BISHelpDeskDashTabScreen extends StatelessWidget {
  const BISHelpDeskDashTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return GetBuilder<BISHelpdeskDashController>(
      id: kBISHelpdeskDashTabRoute,
      init: BISHelpdeskDashController(),
      builder: (_bisHDeskDashController) => Scaffold(
        body: _bisHDeskDashController
            .bottomNavChildren[_bisHDeskDashController.currentIndex],
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
        //     BottomNavigationBarItem(label: '', icon: Icon(Feather.user)),
        //     BottomNavigationBarItem(label: '', icon: Icon(Feather.users)),
        //     BottomNavigationBarItem(label: '', icon: Icon(Entypo.chat)),
        //   ],
        // ),

        bottomNavigationBar: BottomNavyBar(
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.post_add),
              title: const Text(
                'Add Call',
                textAlign: TextAlign.center,
              ),
              activeColor: const Color.fromARGB(255, 234, 234, 234),
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.delivery_dining),
              title: const Text(
                'Open',
                textAlign: TextAlign.center,
              ),
              activeColor: const Color.fromARGB(255, 227, 227, 227),
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.assignment),
              title: const Text(
                'Completed',
                textAlign: TextAlign.center,
              ),
              activeColor: const Color.fromARGB(255, 227, 227, 227),
            ),
          ],
          onItemSelected: _bisHDeskDashController.onBottomNavTapped,
          selectedIndex: _bisHDeskDashController.currentIndex,
          containerHeight: 65,
          backgroundColor: colorController.kPrimaryColor,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
