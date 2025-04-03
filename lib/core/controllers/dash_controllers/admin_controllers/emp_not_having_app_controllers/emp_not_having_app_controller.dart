// Created By Amit Jangid on 26/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/installed_uninstalled_count_model.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/admin_controllers/emp_not_having_app_controllers/emp_not_having_app_filters_controller.dart';

import '../../../../../models/emp_by_grade_count.dart';

class EmpNotHavingAppController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static EmpNotHavingAppController get to =>
      Get.find<EmpNotHavingAppController>();

  bool isLoading = true, fromSearchQuery = false;

  late AnimationController animationController;
  final TextEditingController searchController = TextEditingController();

  List<Employee> empNotHavingAppList = [];
  List<Employee> filteredEmpNotHavingAppList = [];
  List<Employee> filteredEmpHavingAppList = [];
  List<Installed> installedList = [];
  List<Uninstalled> uninstalledList = [];
  final List<EmpByGradeCount> temEmpNotHavingAppListCount = [];
  // dynamic installeduninstalledcount;
  final List<EmpByGradeCount> empNotHavingAppListCount = [];
  List<String> grade = [
    "E0",
    "E1",
    "E2",
    "E3",
    "E4",
    "E5",
    "E6",
    "E7",
    "E8",
    "E9",
    "S0",
    "S1",
    "S2",
    "S3",
    "S4",
    "S5",
    "S6",
    "S7",
    "S8",
    "S9"
  ];

  @override
  void onInit() {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // calling get emp not having app list method
    getApplicationCountbGrade();
    getEmpNotHavingAppList();
    getEmpHavingAppList();
    getEmpNotHavingAppListCount();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kEmployeesNotHavingAppAdvanceFilterScreen);
  }

  getEmpNotHavingAppList() async {
    isLoading = true;
    update([kEmpNotHavingApp]);

    if (EmpNotHavingAppFiltersController.selectedEmpGrade == null &&
        EmpNotHavingAppFiltersController.selectedLocation == null &&
        EmpNotHavingAppFiltersController.selectedDepartment == null) {
      EmpNotHavingAppFiltersController.isFilterSelected = false;
    }

    if (EmpNotHavingAppFiltersController.isFilterSelected) {
      // calling get filtered emp not having app method
      _getFilteredEmpNotHavingApp();
    } else {
      // calling emp not having app api method
      empNotHavingAppList =
      await GailConnectServices.to.getEmpNotHavingAppApi();

      for (int i = 0; i < empNotHavingAppList.length; i++) {}
      filteredEmpNotHavingAppList = empNotHavingAppList;
    }

    isLoading = false;
    update([kEmpNotHavingApp]);
  }

  getEmpNotHavingAppListCount() async {
    //TODO :: Loader is not working
    isLoading = true;
    update([kEmpNotHavingApp]);
    if (temEmpNotHavingAppListCount.isEmpty) {
      empNotHavingAppList =
          await GailConnectServices.to.getEmpNotHavingAppApi();
      filteredEmpHavingAppList =
          await GailConnectServices.to.getEmpHavingAppApi();
      getEmpNotHavingAppListCount();
    }
    isLoading = false;
    update([kEmpNotHavingApp]);
  }

  _getEmployeeCountBasedOnGrade() {
    List<String> designationCount = [];
    List<String> designationCount1 = [];
    for (int i = 0; i < empNotHavingAppList.length; i++) {
      designationCount.add(empNotHavingAppList[i].grade!);
    }

    for (int i = 0; i < filteredEmpHavingAppList.length; i++) {
      designationCount1.add(filteredEmpHavingAppList[i].grade!);
    }
    var temdesignationCount = designationCount.toSet();
    var temdesignationCount1 = designationCount1.toSet();
    final List<EmpByGradeCount> temEmpHavingAppListCount = [];
    final List<EmpByGradeCount> temEmpNotHavingAppListCount = [];

    var myDesignationCount = Map<String, int>.fromIterables(temdesignationCount,
        List.generate(temdesignationCount.length, (i) => 0));
    designationCount
        .forEach((e) => myDesignationCount[e] = myDesignationCount[e]! + 1);
    myDesignationCount.forEach((key, value) {
      temEmpNotHavingAppListCount.add(EmpByGradeCount(key, 0, value));
      update([kEmpNotHavingApp]);
    });

    var myDesignationCount1 = Map<String, int>.fromIterables(
        temdesignationCount1,
        List.generate(temdesignationCount1.length, (i) => 0));
    designationCount1
        .forEach((e) => myDesignationCount1[e] = myDesignationCount1[e]! + 1);
    myDesignationCount1.forEach((key, value) {
      temEmpHavingAppListCount.add(EmpByGradeCount(key, value, 0));
      update([kEmpNotHavingApp]);
    });

    List<EmpByGradeCount> difference = temEmpHavingAppListCount
        .toSet()
        .difference(temEmpNotHavingAppListCount.toSet())
        .toList();


    if (temEmpNotHavingAppListCount.length < temEmpHavingAppListCount.length) {
      temEmpNotHavingAppListCount.addAll(difference);
    } else {
      temEmpHavingAppListCount.addAll(difference);
    }


    empNotHavingAppListCount.sort();
  }

  _getFilteredEmpNotHavingApp() {
    final List<Employee> _tempEmpNotHavingAppList = [];

    if (EmpNotHavingAppFiltersController.selectedLocation != null &&
        EmpNotHavingAppFiltersController.selectedDepartment != null &&
        EmpNotHavingAppFiltersController.selectedEmpGrade != null) {
      for (final Employee _employee in empNotHavingAppList) {
        if (_employee.location!.toLowerCase() ==
            EmpNotHavingAppFiltersController.selectedLocation!.locationName
                .toLowerCase() &&
            _employee.department!.toLowerCase() ==
                EmpNotHavingAppFiltersController.selectedDepartment!.department
                    .toLowerCase() &&
            _employee.grade!.toLowerCase() ==
                EmpNotHavingAppFiltersController.selectedEmpGrade!.empGrade
                    .toLowerCase()) {
          _tempEmpNotHavingAppList.add(_employee);
        }
      }
    } else if (EmpNotHavingAppFiltersController.selectedLocation != null &&
        EmpNotHavingAppFiltersController.selectedDepartment != null &&
        EmpNotHavingAppFiltersController.selectedEmpGrade == null) {
      for (final Employee _employee in empNotHavingAppList) {
        if (_employee.location!.toLowerCase() ==
            EmpNotHavingAppFiltersController.selectedLocation!.locationName
                .toLowerCase() &&
            _employee.department!.toLowerCase() ==
                EmpNotHavingAppFiltersController.selectedDepartment!.department
                    .toLowerCase()) {
          _tempEmpNotHavingAppList.add(_employee);
        }
      }
    } else if (EmpNotHavingAppFiltersController.selectedLocation != null &&
        EmpNotHavingAppFiltersController.selectedDepartment == null &&
        EmpNotHavingAppFiltersController.selectedEmpGrade != null) {
      for (final Employee _employee in empNotHavingAppList) {
        if (_employee.location!.toLowerCase() ==
            EmpNotHavingAppFiltersController.selectedLocation!.locationName
                .toLowerCase() &&
            _employee.grade!.toLowerCase() ==
                EmpNotHavingAppFiltersController.selectedEmpGrade!.empGrade
                    .toLowerCase()) {
          _tempEmpNotHavingAppList.add(_employee);
        }
      }
    } else if (EmpNotHavingAppFiltersController.selectedLocation != null &&
        EmpNotHavingAppFiltersController.selectedDepartment == null &&
        EmpNotHavingAppFiltersController.selectedEmpGrade == null) {
      for (final Employee _employee in empNotHavingAppList) {
        if (_employee.location!.toLowerCase() ==
            EmpNotHavingAppFiltersController.selectedLocation!.locationName
                .toLowerCase()) {
          _tempEmpNotHavingAppList.add(_employee);
        }
      }
    } else if (EmpNotHavingAppFiltersController.selectedLocation == null &&
        EmpNotHavingAppFiltersController.selectedDepartment != null &&
        EmpNotHavingAppFiltersController.selectedEmpGrade != null) {
      for (final Employee _employee in empNotHavingAppList) {
        if (_employee.department!.toLowerCase() ==
            EmpNotHavingAppFiltersController.selectedDepartment!.department
                .toLowerCase() &&
            _employee.grade!.toLowerCase() ==
                EmpNotHavingAppFiltersController.selectedEmpGrade!.empGrade
                    .toLowerCase()) {
          _tempEmpNotHavingAppList.add(_employee);
        }
      }
    } else if (EmpNotHavingAppFiltersController.selectedLocation == null &&
        EmpNotHavingAppFiltersController.selectedDepartment != null &&
        EmpNotHavingAppFiltersController.selectedEmpGrade == null) {
      for (final Employee _employee in empNotHavingAppList) {
        if (_employee.department!.toLowerCase() ==
            EmpNotHavingAppFiltersController.selectedDepartment!.department
                .toLowerCase()) {
          _tempEmpNotHavingAppList.add(_employee);
        }
      }
    } else if (EmpNotHavingAppFiltersController.selectedLocation == null &&
        EmpNotHavingAppFiltersController.selectedDepartment == null &&
        EmpNotHavingAppFiltersController.selectedEmpGrade != null) {
      for (final Employee _employee in empNotHavingAppList) {
        if (_employee.grade!.toLowerCase() ==
            EmpNotHavingAppFiltersController.selectedEmpGrade!.empGrade
                .toLowerCase()) {
          _tempEmpNotHavingAppList.add(_employee);
        }
      }
    }

    filteredEmpNotHavingAppList = _tempEmpNotHavingAppList;
    update([kEmpNotHavingApp]);
  }

  searchEmployee(String _searchQuery) async {

    if (_searchQuery.length !=0) {
      fromSearchQuery = true;

      final List<Employee> _tempEmpList = [];

      for (final Employee _employee in empNotHavingAppList) {

        if (_employee.empNo!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()) ||
            _employee.empName!
                .replaceAll(' ', '')
                .toLowerCase()
                .contains(_searchQuery.replaceAll(' ', '').toLowerCase())) {

          _tempEmpList.add(_employee);
        }
      }

      filteredEmpNotHavingAppList = _tempEmpList;
      update([kEmpNotHavingApp]);
    } else {
      fromSearchQuery = false;

      filteredEmpNotHavingAppList = empNotHavingAppList;

    }
  }

  @override
  void dispose() {
    searchController.dispose();
    animationController.dispose();

    super.dispose();
  }

  void getEmpHavingAppList() async {
    isLoading = true;
    update([kEmpNotHavingApp]);
    // calling emp not having app api method
    filteredEmpHavingAppList =
    await GailConnectServices.to.getEmpHavingAppApi();

    isLoading = false;
    update([kEmpNotHavingApp]);
  }

  void getApplicationCountbGrade() async {
    // Response? response;
    int? installeddval, uninstalledval;
    isLoading = true;
    update([kEmpNotHavingApp]);
    // calling emp not having app api method
    installedList = await GailConnectServices.to.getAppCountbyGradeApi();
    uninstalledList =
    await GailConnectServices.to.getAppCountUninstalledbyGradeApi();
    for (int i = 0; i < grade.length; i++) {
      for (int j = 0; j < installedList.length; j++) {
        if (grade[i] == installedList[j].grade) {
          installeddval = installedList[j].count!.toInt();
          break;
        } else {
          installeddval = 0;
        }
      }
      for (int k = 0; k < uninstalledList.length; k++) {
        if (grade[i] == uninstalledList[k].grade) {
          uninstalledval = uninstalledList[k].count!.toInt();
          break;
        } else {
          uninstalledval = 0;
        }
      }

      temEmpNotHavingAppListCount
          .add(EmpByGradeCount(grade[i], installeddval, uninstalledval));
      print(temEmpNotHavingAppListCount[i].toString() +
          "installeduninstalledcount");
    }

    isLoading = false;
    update([kEmpNotHavingApp]);
  }
}
