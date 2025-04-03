/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';

import '../../../../../core/controllers/dash_controllers/admin_controllers/emp_not_having_app_controllers/emp_not_having_app_controller.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../../../styles/color_controller.dart';
import '../../../../widgets/custom_app_bar.dart';
import 'emp_having_app_screen.dart';
import 'emp_not_having_app_screen.dart';

class EmpNotHavingAppInstallCount extends StatefulWidget {
  @override
  State<EmpNotHavingAppInstallCount> createState() =>
      _EmpNotHavingAppInstallCount();
}

class _EmpNotHavingAppInstallCount extends State<EmpNotHavingAppInstallCount> {
  List<Widget> bottomNavChildren = <Widget>[];
  int currentIndex = 0;
  EmpNotHavingAppController _empNotHavingAppController =
  Get.put(EmpNotHavingAppController());

  @override
  void initState() {
    super.initState();
    bottomNavChildren.add(AppNotInstalledTable(context));
    bottomNavChildren.add(const EmpHavingAppScreen());
    bottomNavChildren.add(const EmpNotHavingAppScreen());
  }

  onBottomNavTapped(int _index) {
    // Get.put(_empNotHavingAppController);
    // _empNotHavingAppController.onInit();
    setState(() {
      currentIndex = _index;
    });
    // if (_index == 0) {
    //   getAcknowledgeData();
    // }
    // update([kDispensaryDash]);
  }

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    // TODO: implement build
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar: CustomAppBar(
          title: kEmpNotHavingApp, isEmpNotHavingAppListScreen: false),
      // appBar: CustomAppBar(
      //     title: kEmpNotHavingApp,
      //     ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: bottomNavChildren[currentIndex],
          ),
          BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0.0,
            selectedItemColor: colorController.kSelectedColor,
            unselectedItemColor: colorController.kUnselectedColor,
            selectedLabelStyle: TextStyle(
                fontSize: 0,
                color: colorController.kSelectedColor,
                fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
                fontSize: 0,
                color: colorController.kUnselectedColor,
                fontWeight: FontWeight.bold),
            onTap: (index) {
              onBottomNavTapped(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: bottomButtonDesign(
                  0,
                  "Count Table",
                  "assets/icons/apps_icon.png",
                  "assets/icons/apps_icon.png",
                  colorController.kUnselectedColor,
                  colorController.kSelectedColor,
                  3,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: bottomButtonDesign(
                    1,
                    "Installed",
                    "assets/icons/employee_icon.png",
                    "assets/icons/employee_icon.png",
                    colorController.kUnselectedColor,
                    colorController.kSelectedColor,
                    3,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: bottomButtonDesign(
                    2,
                    "Not installed",
                    "assets/icons/employee_icon.png",
                    "assets/icons/employee_icon.png",
                    colorController.kUnselectedColor,
                    colorController.kSelectedColor,
                    3,
                  ),
                  label: ''),
            ],
          ),
        ],
      ),
    );
    /* GetBuilder<ColorController>(
        id: kEmpNotHavingApp,
        init: ColorController(),
        builder: (colorController) {
          return ColoredSafeArea(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                backgroundColor: colorController.kHomeBgColor,
                appBar: CustomAppBar(
                    title: kEmpNotHavingApp, isEmpNotHavingAppListScreen: true),
                // appBar: CustomAppBar(
                //     title: kEmpNotHavingApp,
                //     ),
                body: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45.0),
                      child: bottomNavChildren[currentIndex],
                    ),
                    BottomNavigationBar(
                      landscapeLayout:
                          BottomNavigationBarLandscapeLayout.linear,
                      backgroundColor: Colors.transparent,
                      type: BottomNavigationBarType.fixed,
                      currentIndex: currentIndex,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      elevation: 0.0,
                      selectedItemColor: colorController.kSelectedColor,
                      unselectedItemColor: colorController.kUnselectedColor,
                      selectedLabelStyle: TextStyle(
                          fontSize: 0,
                          color: colorController.kSelectedColor,
                          fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(
                          fontSize: 0,
                          color: colorController.kUnselectedColor,
                          fontWeight: FontWeight.bold),
                      onTap: (index) {
                        onBottomNavTapped(index);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: bottomButtonDesign(
                            0,
                            "Count Table",
                            "assets/icons/apps_icon.png",
                            "assets/icons/apps_icon.png",
                            colorController.kUnselectedColor,
                            colorController.kSelectedColor,
                            3,
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                            icon: bottomButtonDesign(
                              1,
                              "App installed",
                              "assets/icons/employee_icon.png",
                              "assets/icons/employee_icon.png",
                              colorController.kUnselectedColor,
                              colorController.kSelectedColor,
                              3,
                            ),
                            label: ''),
                        BottomNavigationBarItem(
                            icon: bottomButtonDesign(
                              2,
                              "App uninstall",
                              "assets/icons/employee_icon.png",
                              "assets/icons/employee_icon.png",
                              colorController.kUnselectedColor,
                              colorController.kSelectedColor,
                              3,
                            ),
                            label: ''),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });*/
  }

  Widget AppNotInstalledTable(BuildContext context) {

    return GetBuilder<EmpNotHavingAppController>(
        init: _empNotHavingAppController,
        id: kEmpNotHavingApp,
        builder: (_controller) {

          return _controller.temEmpNotHavingAppListCount.isNotEmpty
              ? SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 80.0, right: 80),
                //   child: Center(
                //     child: Text(
                //       'App Insatalled Count - ${_controller.filteredEmpHavingAppList.length}',
                //       style: textStyle14Normal,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 80.0, right: 80),
                //   child: Center(
                //     child: Text(
                //       'Not Insatalled Count - ${_controller.filteredEmpNotHavingAppList.length}',
                //       style: textStyle14Normal,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: DataTable(
                    columns: [
                      const DataColumn(label: Text('Grade')),
                      const DataColumn(label: Text('App installed')),
                      const DataColumn(label: Text('Not Installed')),
                    ],
                    rows: _controller
                        .temEmpNotHavingAppListCount // Loops through dataColumnText, each iteration assigning the value to element
                        .map(
                      ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(
                            element.grade.toString(),
                          )), //Extracting from Map element the value
                          DataCell(
                              Text(element.app_installed.toString())),
                          DataCell(
                              Text(element.appunistalled.toString())),
                        ],
                      )),
                    )
                        .toList(),
                  ),

                  /*             Table(
                      border: TableBorder.all(color: Colors.black, width: 2.0),
                      children: [
                        //This table row is for the table header which is static
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Grade",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "App installed",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Not Installed",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                        ]),
                        if (_controller.temEmpNotHavingAppListCount.isNotEmpty)
                          for (int i = 0;
                              i < _controller.temEmpNotHavingAppListCount.length;
                              i++)
                            TableRow(children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "${_controller.temEmpNotHavingAppListCount[i].grade}",
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "${_controller.temEmpNotHavingAppListCount[i].app_installed}",
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "${_controller.temEmpNotHavingAppListCount[i].appunistalled}",
                                  ),
                                ),
                              ),
                            ]),
                      ]),*/
                ),
              ],
            ),
          )
              : const Center(child: const CircularProgressIndicator());
        });
  }

  Widget AppInststalledTable(BuildContext context) {
    return GetBuilder<EmpNotHavingAppController>(
        init: _empNotHavingAppController,
        id: kEmpNotHavingApp,
        builder: (_controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Table(
                  border: TableBorder.all(color: Colors.black, width: 2.0),
                  children: [
                    //This table row is for the table header which is static
                    // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
                    TableRow(children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Grade",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "App installed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Not Installed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                    ]),
                    if (_controller.temEmpNotHavingAppListCount.isNotEmpty)
                      for (int i = 0;
                      i < _controller.temEmpNotHavingAppListCount.length;
                      i++)
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "${_controller.temEmpNotHavingAppListCount[i].grade}",
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "${_controller.temEmpNotHavingAppListCount[i].app_installed}",
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "${_controller.temEmpNotHavingAppListCount[i].appunistalled}",
                              ),
                            ),
                          ),
                        ]),
                  ]),
            ),
          );
          // ): Center(child: CircularProgressIndicator());
        });
  }

  Widget bottomButtonDesign(
      int index,
      String name,
      String firstImage,
      String secondImage,
      Color iconColor1,
      Color iconColor2,
      double scale,
      ) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        color: currentIndex == index ? iconColor2 : iconColor1,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          horizontalSpace3,
          // ignore: prefer_const_constructors
          name == "Count Table"
              ? const Icon(
            Icons.table_chart_sharp,
            color: Colors.white,
          )
              : name == "App installed"
              ? const Icon(
            Icons.install_mobile,
            color: Colors.white,
          )
              : const Icon(
            Icons.app_blocking_rounded,
            color: Colors.white,
          ),
          horizontalSpace3,
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          )
        ],
      ),
    );
  }
}
