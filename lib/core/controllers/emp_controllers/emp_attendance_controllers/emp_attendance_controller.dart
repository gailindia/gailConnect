

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gail_connect/models/emp_attendance.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib.dart';

import '../../../../rest/gail_connect_services.dart';
import '../../../../ui/screens/emp_screens/emp_attendance_screens/emp_attendance_screen.dart';
import '../../../../utils/constants/app_constants.dart';

class EmpAttendanceController extends GetxController
{

  static EmpAttendanceController get to => Get.find<EmpAttendanceController>();

  bool isLoading = true;

  List<EmpAttendance> empAttendanceList = [];
  List<EmpAttendanceAverage> empAttendanceAverage = [];
  late List<SalesDataEmp> chartDataTodayDB = [];

  String? countDays = "0";
  String avergaeTime = '0.0';
  String shotHours = "Keep it up 👍";

  @override
  void onInit() {
    super.onInit();

    // calling get emp groups list method
    getEmpAttendanceList();
    getEmpAttendanceAverage();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kEmployeesGroupsScreen);
  }

  getEmpAttendanceList() async {
    isLoading = true;
    update([kMyAttendance]);

    // calling get emp groups list api method
    empAttendanceList = await GailConnectServices.to.getAttendanceDetails();
    for(int i = 0; i <empAttendanceList.length; i++){
      final format = DateFormat("HH:mm");
      final one = format.parse(empAttendanceList[i].outTime);
      final two = format.parse(empAttendanceList[i].inTime);
      final String duration = one.difference(two).toString();
      String duration1 = DateFormat('HH:mm').format(DateFormat("HH:mm:ss.s").parse(duration));
      String intime = DateFormat('HH:mm').format(DateFormat("HH:mm:ss").parse(empAttendanceList[i].inTime)).replaceAll(":", ".");
      String outtime = DateFormat('HH:mm').format(DateFormat("HH:mm:ss").parse(empAttendanceList[i].outTime)).replaceAll(":", ".");
      String duration2 = duration1.replaceAll(":", ".");
      double durationsales = double.parse(duration2);

      // intime = intime.replaceAll(":", ".");

      Color c;

      if(double.parse(intime) <= 9.15 && double.parse(outtime) >= 5.45){
        c = Colors.blueAccent;
      }else{
        if(durationsales>=8.30){
          c = Colors.green;
        }else if(durationsales<8.30 && durationsales>=8.0){
          c = Colors.yellow;
        }else{
          c = Colors.red;
        }
      }


      DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(empAttendanceList[i].date);
      String weekday = DateFormat('MMM d').format(tempDate);

      chartDataTodayDB.add(SalesDataEmp(weekday,durationsales,c));
    }

    isLoading = false;
    update([kMyAttendance]);
  }


  getEmpAttendanceAverage() async{
    isLoading = true;
    update([kMyAttendance]);

    // calling get emp groups list api method
    empAttendanceAverage = await GailConnectServices.to.getAttendanceAverage();
    var hr = empAttendanceAverage[0].hours.toInt().toString();
    var min = empAttendanceAverage[0].min.toInt().toString();
    var sec = empAttendanceAverage[0].sec.toInt().toString();

    if(hr.toInt! < 10){
      hr = "0$hr";
    }
    if(min.toInt! < 10){
      min = "0$min";
    }
    if(sec.toInt! < 10){
      sec = "0$sec";
    }

    final count = empAttendanceAverage[0].count;
    final totalD = count.toInt();
    countDays = count.toInt().toString();

    avergaeTime = "$hr:$min:$sec";
    DateTime d = DateFormat("HH:mm:ss").parse("08:00:00");
    DateTime d1 = DateFormat("HH:mm:ss").parse(avergaeTime);
    if(d1.isAfter(d)){

    }else{
      String diff = d.difference(d1).toString();
      DateTime d2 = DateFormat("HH:mm:ss").parse(diff);

      int hr = d2.hour;
      int min = d2.minute;
      int sec = d2.second;

      String sec_new = ((sec * totalD)%60).toString() ;

      int s = ((sec * totalD)/60).toInt();

      String min_new = (((min*totalD)+s)%60).toString();

      int m = ((min * totalD)/60).toInt();

      String hr_new = ((hr*totalD)+m).toString();

      if(hr_new.toInt! < 10){
        hr_new = "0$hr_new";
      }
      if(min_new.toInt! < 10){
        min_new = "0$min_new";
      }
      if(sec_new.toInt! < 10){
        sec_new = "0$sec_new";
      }

      shotHours = "$hr_new:$min_new:$sec_new  Hr";
    }



    isLoading = false;
    update([kMyAttendance]);
  }

 String getDuration(String t1,String t2){
    final format = DateFormat("HH:mm");
    final one = format.parse(t1);
    final two = format.parse(t2);
    
    final String duration = one.difference(two).toString();
    
    String duration1 = DateFormat('HH:mm').format(DateFormat("HH:mm:ss.s").parse(duration));


    return duration1;

  }

  String getTimeFormat(String s){

    final format = DateFormat("HH:mm");
    final String newString = format.parse(s).toString();

    return newString;
  }

  String getDateFormat(String date){

    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd-MM-yyyy');
    return outputFormat.format(inputDate);

  }

  String getBirthdayFormat(String date){

    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd-MMM');
    return outputFormat.format(inputDate);

  }

  String getWeekDayFromDate(String date){
    DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(date);

    String weekday = DateFormat('EEE').format(tempDate);
    return weekday;
  }

}