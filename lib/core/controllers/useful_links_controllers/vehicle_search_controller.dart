// Created By Amit Jangid 14/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/multiutillib.dart';

import '../../../models/consent_model.dart';

class VehicleSearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  final TextEditingController searchController = TextEditingController();

  bool isLoading = true;
  bool search = false;

  List<Employee> _empList = [];
  List<Employee> filteredEmpList = [];
  List<PhoneConsent> phoneConsentList = [];

  @override
  void onInit() {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // calling get emp list method
    getEmpList();
    getConsentData();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to.hitCountApi(
        activity: kVehicleSearchScreen, activityScreen: "/vehicleSearch");
  }

  getEmpList() async {
    isLoading = true;
    update([kVehicleSearch]);

    // calling get employees list from db method
    _empList = await EmployeeDb.getEmployeesListWithVehicleFromDb();
    filteredEmpList = _empList;

    isLoading = false;
    update([kVehicleSearch]);
  }

  onVehicleSearch(String _searchQuery) {
    if (_searchQuery.isNotEmpty) {
      final List<Employee> _tempEmpList = [];

      for (final Employee _employee in _empList) {
        if (_employee.vehicleNo!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase())) {
          _tempEmpList.add(_employee);
        }
      }

      search = true;
      filteredEmpList = _tempEmpList;
      for (int j = 0; j < phoneConsentList.length; j++) {
        // print(
        // "bdayConsentList getSupoperAnnuation  empcontroller:: ${phoneConsentList[j].cpfNo}");
        for (int i = 0; i < filteredEmpList.length; i++) {
          // print(
          //     "filteredEmployeesList[i].empNo :: ${filteredEmployeesList[i].empNo!.toInt}");
          if (filteredEmpList[i].empNo!.toInt.toString() ==
              phoneConsentList[j].cpfNo!.round().toString()) {
            filteredEmpList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";//assets/icons/logo.png
            filteredEmpList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";
            // print("bdayConsentList index :: $i ${filteredEmployeesList[i].image}");
            // filteredEmployeesList.removeAt(i).image;
            update([kEmployees]);
          }
        }
      }
      update([kVehicleSearch]);
    } else {
      filteredEmpList = _empList;
      update([kVehicleSearch]);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    animationController.dispose();

    super.dispose();
  }

  getConsentData() async {
    // calling get banner api method
    phoneConsentList.clear();
    phoneConsentList = await GailConnectServices.to.getConsentDatadetails();
    // for (int i = 0; i < phoneConsentList.length; i++) {
    //   activeNewsLength = activeNewsLength! + activeNewsList[i].title!.length;
    // }
    update([kDashboard]);
  }
}
