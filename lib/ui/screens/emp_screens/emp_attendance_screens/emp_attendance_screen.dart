import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_attendance_controllers/emp_attendance_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../styles/color_controller.dart';
import '../../../widgets/custom_app_bar.dart';

class EmpAttendanceScreen extends StatelessWidget {
  const EmpAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    String s = "";

    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar:
          CustomAppBar(title: kAttendanceEmployees, isBirthdayScreen: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: GetBuilder<EmpAttendanceController>(
              id: kMyAttendance,
              init: EmpAttendanceController(),
              builder: (EmpAttendanceController) {
                print("EmpAttendanceController :: ${EmpAttendanceController.chartDataTodayDB}");
                return Column(
                  children: [
                    // AnimatedGradient(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Office In-Out time for last ${EmpAttendanceController.empAttendanceList.length.toString()} days",
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 22,
                          // letterSpacing: 2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    // style: textStyle16Bold.copyWith(color: Colors.white),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 12, right: 12),
                          // color: Colors.blueAccent,
                          width: MediaQuery.of(context).size.width,
                          //height: 40,
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Date",
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 12,
                                    // letterSpacing: 2,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  // style: textStyle16Bold.copyWith(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Day",
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 12,
                                    // letterSpacing: 2,
                                    fontWeight: FontWeight.w900,
                                  ),

                                  // style: textStyle16Bold.copyWith(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "In Time",
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 12,
                                    // letterSpacing: 2,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  // style: textStyle16Bold.copyWith(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Out Time",
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 12,
                                    //letterSpacing: 2,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  // style: textStyle16Bold.copyWith(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Duration",
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 12,
                                      // letterSpacing: 2,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    // style: textStyle16Bold.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            itemCount: EmpAttendanceController
                                .empAttendanceList.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 36),
                            itemBuilder: (context, _position) {
                              return Center(
                                // alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    // color: Colors.blueAccent,
                                    width: MediaQuery.of(context).size.width,
                                    //height: 40,
                                    padding: const EdgeInsets.all(6),

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            EmpAttendanceController.getDateFormat(
                                                EmpAttendanceController
                                                    .empAttendanceList[
                                                        _position]
                                                    .date
                                                    .substring(
                                                        0,
                                                        EmpAttendanceController
                                                                .empAttendanceList[
                                                                    _position]
                                                                .date
                                                                .length -
                                                            9)),
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 11,
                                              // letterSpacing: 2,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            // style: textStyle16Bold.copyWith(color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "${EmpAttendanceController.getWeekDayFromDate(EmpAttendanceController.empAttendanceList[_position].date)}   ",
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 12,
                                              // letterSpacing: 2,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            // style: textStyle16Bold.copyWith(color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${EmpAttendanceController.empAttendanceList[_position].inTime}     ",
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 12,
                                              // letterSpacing: 2,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            // style: textStyle16Bold.copyWith(color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${EmpAttendanceController.empAttendanceList[_position].outTime}          ",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 12,
                                              //letterSpacing: 2,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            // style: textStyle16Bold.copyWith(color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "${EmpAttendanceController.getDuration(EmpAttendanceController.empAttendanceList[_position].outTime, EmpAttendanceController.empAttendanceList[_position].inTime)}   ",
                                              style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontSize: 12,
                                                // letterSpacing: 2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              // style: textStyle16Bold.copyWith(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 80,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                border:Border.all(color: colorController.kBgColor)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(child: Text("Current Month Summary",style: TextStyle(fontWeight: FontWeight.bold),)),
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text("Days : ",),
                                    Text(EmpAttendanceController.countDays.toString()),
                                    Spacer(),
                                    Text("Average : ", ),
                                    Text("${EmpAttendanceController.avergaeTime} Hr"),
                                    SizedBox(width: 30,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text(EmpAttendanceController.shotHours.startsWith("Keep it")?"":"Short to 8 hours average: ",),
                                    Text("${EmpAttendanceController.shotHours}"),
                                    SizedBox(width: 30,),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),

                        Container(
                          height: 320,
                          padding: EdgeInsets.all(8.0),
                          child:  SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  majorGridLines: MajorGridLines(
                                    width: 0.0,
                                    color: Color.fromARGB(255, 197, 172, 162),
                                  ),
                                ),
                                primaryYAxis: CategoryAxis(
                                  minimum: 2,
                                  maximum: 12,
                                  interval: 2,
                                  majorGridLines: MajorGridLines(
                                    width: 0.0,
                                    color: Color.fromARGB(255, 197, 172, 162),
                                  ),
                                ),
                              plotAreaBackgroundColor:Colors.transparent,
                              backgroundColor:Colors.transparent,
                                // isTransposed: true,
                                series: <CartesianSeries>[
                                  ColumnSeries<SalesDataEmp, String>(
                                    color: colorController.kHomeBgColor,
                                      dataSource: EmpAttendanceController.chartDataTodayDB,
                                      xValueMapper: (data, _) => data.sales,
                                      yValueMapper: (data, _) => data.year,
                                      // Map color for each data points from the data source
                                      pointColorMapper: (data, _) => data.color,
                                    dataLabelSettings: DataLabelSettings(
                                                isVisible: true,
                                                textStyle: TextStyle(fontSize: 10),
                                              builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex){
                                                  s = data.year.toStringAsFixed(2).replaceAll(".", ":");
                                                  print("s :: $s");
                                                  return Container(
                                                    height: 30,
                                                    width: 30,
                                                    child: Text(s,style: TextStyle(fontSize: 10),)
                                                );
                                              }
                                            ),
                                    // width: 4,
                                    spacing: 0.5,
                                    enableTooltip: true
                                  )
                                ]
                            )
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class SalesDataEmp {
  SalesDataEmp(this.sales,this.year,this.color);
  final String sales;
  final double year;
  final Color color;
}
