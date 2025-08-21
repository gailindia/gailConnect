import 'package:flutter/material.dart';
import 'package:gail_connect/ui/screens/health_screens/calculation_screen.dart';
import 'package:gail_connect/ui/screens/health_screens/ohc_screen.dart';
import 'package:gail_connect/ui/screens/health_screens/records_screen.dart';
import 'package:gail_connect/ui/screens/health_screens/stats_screen.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (colorController) {
          return Scaffold(
              backgroundColor: colorController.kHomeBgColor,
              appBar: CustomAppBar(title: 'Health ', isBirthdayScreen: false),
              body: DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: colorController.kHomeBgColor,
                      elevation: 0,
                      toolbarHeight: 10,
                      // leadingWidth: 50,
                      bottom: TabBar(
                          unselectedLabelColor:
                              colorController.kPrimaryDarkColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: colorController.kCircleBgColor,
                          labelPadding: EdgeInsets.only(left: 5, right: 5),
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colorController.kPrimaryDarkColor),
                          tabs: [
                            Tab(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              colorController.kPrimaryDarkColor,
                                          width: 1)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "STATS",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            colorController.kPrimaryDarkColor,
                                        width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "RECORDS",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            colorController.kPrimaryDarkColor,
                                        width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "CALCULATION",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              colorController.kPrimaryDarkColor,
                                          width: 1)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "OHC",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    body: TabBarView(children: [
                      StatsScreen(),
                      RecordScreen(),
                      CalculationScreen(),
                      OHCScreen()
                    ]),
                  )));
        });
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final double year;
  final double sales;
}

class DailyDataOnClickModel {
  List<SalesData>? charData;
  String? Steps, cal, distance;

  DailyDataOnClickModel({this.charData, this.Steps, this.cal, this.distance});
}
