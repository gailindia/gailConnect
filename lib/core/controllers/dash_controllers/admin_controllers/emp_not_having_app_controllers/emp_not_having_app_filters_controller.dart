// Created By Amit Jangid on 30/11/21

import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/models/location.dart';
import 'package:gail_connect/models/emp_grade.dart';
import 'package:gail_connect/models/department.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/admin_controllers/emp_not_having_app_controllers/emp_not_having_app_controller.dart';

class EmpNotHavingAppFiltersController extends GetxController {
  static EmpNotHavingAppFiltersController get to => Get.find<EmpNotHavingAppFiltersController>();

  static bool isFilterSelected = false;

  static Location? selectedLocation;
  static EmpGrade? selectedEmpGrade;
  static Department? selectedDepartment;

  List<EmpGrade> empGradeList = [];
  List<Department> departmentList = [];
  List<Location> _locationList = [], filteredLocationList = [];

  @override
  void onReady() {
    super.onReady();

    // calling get location list method
    getLocationList();

    // calling get department list method
    getDepartmentList();

    // get emp grade list
    getEmpGradeList();
  }

  getLocationList() async {
    final Map<String, Location> _departmentMap = {};

    for (final Employee _employee in EmpNotHavingAppController.to.empNotHavingAppList) {
      _locationList.add(Location(locationName: _employee.location!));
    }

    for (final Location _location in _locationList) {
      _departmentMap[_location.locationName] = _location;
    }

    _locationList = _departmentMap.values.toList();

    for (final Location _location in _locationList) {
      if (_location.locationName.toLowerCase() == 'DELHI-CORPORATE'.toLowerCase()) {
        filteredLocationList.add(_location);
      } else if (_location.locationName.toLowerCase() == 'NOIDA'.toLowerCase()) {
        filteredLocationList.add(_location);
      } else if (_location.locationName.toLowerCase() == 'PATA'.toLowerCase()) {
        filteredLocationList.add(_location);
      } else if (_location.locationName.toLowerCase() == 'VIJAIPUR'.toLowerCase()) {
        filteredLocationList.add(_location);
      } else if (_location.locationName.toLowerCase() == 'GTI-NOIDA'.toLowerCase()) {
        filteredLocationList.add(_location);
      }
    }

    for (final Location _location in _locationList) {
      if (_location.locationName.toLowerCase() != 'DELHI-CORPORATE'.toLowerCase() &&
          _location.locationName.toLowerCase() != 'NOIDA'.toLowerCase() &&
          _location.locationName.toLowerCase() != 'PATA'.toLowerCase() &&
          _location.locationName.toLowerCase() != 'VIJAIPUR'.toLowerCase() &&
          _location.locationName.toLowerCase() != 'GTI-NOIDA'.toLowerCase()) {
        filteredLocationList.add(_location);
      }
    }

    update([kSelectEmpFilters]);
  }

  getDepartmentList() async {
    final Map<String, Department> _departmentMap = {};

    for (final Employee _employee in EmpNotHavingAppController.to.empNotHavingAppList) {
      departmentList.add(Department(department: _employee.department!));
    }

    for (final Department _department in departmentList) {
      _departmentMap[_department.department] = _department;
    }

    departmentList = _departmentMap.values.toList();
    update([kSelectEmpFilters]);
  }

  getEmpGradeList() async {
    final Map<String, EmpGrade> _empGradeMap = {};

    for (final Employee _employee in EmpNotHavingAppController.to.empNotHavingAppList) {
      empGradeList.add(EmpGrade(empGrade: _employee.grade!));
    }

    for (final EmpGrade _empGrade in empGradeList) {
      _empGradeMap[_empGrade.empGrade] = _empGrade;
    }

    empGradeList = _empGradeMap.values.toList();
    update([kSelectEmpFilters]);
  }

  onLocationSelected(Location? _location) {
    isFilterSelected = true;
    selectedLocation = _location;
    update([kSelectEmpFilters]);
  }

  onDepartmentSelected(Department? _department) {
    isFilterSelected = true;
    selectedDepartment = _department;
    update([kSelectEmpFilters]);
  }

  onEmpGradeSelected(EmpGrade? _empGrade) {
    isFilterSelected = true;
    selectedEmpGrade = _empGrade;
    update([kSelectEmpFilters]);
  }

  clearFilters() async {
    selectedEmpGrade = null;
    selectedLocation = null;
    isFilterSelected = false;
    selectedDepartment = null;

    Get.back();
  }

  advanceSearch() async {
    isFilterSelected = true;

    Get.back();
  }
}
