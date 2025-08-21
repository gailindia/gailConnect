// Created By Amit Jangid 31/08/21

import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_list_controller.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/location.dart';
import 'package:gail_connect/models/emp_grade.dart';
import 'package:gail_connect/models/department.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpFiltersController extends GetxController {
  static EmpFiltersController get to => Get.find<EmpFiltersController>();
  EmpListController empListController = Get.put(EmpListController());

  static bool isFilterSelected = true;

  static Location? selectedLocation;
  static EmpGrade? selectedEmpGrade;
  static Department? selectedDepartment;
  String? selectedValue,selectedDepartmentstr,selectedDirectoratestr,selectedEmpGradestr,selectedSection;

  List<EmpGrade> empGradeList = [];
  List<String> empGradeListstr = [];
  List<Department> departmentList = [];
  List<String> departmentListfil = [];
  List<String> directorateListfil = [];
  List<String> empSection = [];
  List<Location> _locationList = [], filteredLocationList = [];
  List<String> filteredLocationList1 = [];

  @override
  void onInit() {
    super.onInit();

    // calling get location list method
    getLocationList();

    // calling get department list method
    getDepartmentList();

    // get emp grade list
    getEmpGradeList();

    getDirectorate();

    getSection();
  }

  getLocationList() async {
    // calling get location details from db method
    filteredLocationList.clear();
    filteredLocationList1.clear();
    _locationList.clear();
    _locationList = await LocationDb.getLocationDetailsFromDb(selectedDepartmentstr??"",selectedDirectoratestr??'',selectedEmpGradestr??'', selectedSection??'');
    for (final Location _location in _locationList) {
      if (_location.locationName.toLowerCase() ==
          'DELHI-CORPORATE'.toLowerCase()) {
        filteredLocationList.add(_location);
        filteredLocationList1.add(_location.locationName);
      } else if (_location.locationName.toLowerCase() ==
          'NOIDA'.toLowerCase()) {
        filteredLocationList.add(_location);
        filteredLocationList1.add(_location.locationName);
      } else if (_location.locationName.toLowerCase() == 'PATA'.toLowerCase()) {
        filteredLocationList.add(_location);
        filteredLocationList1.add(_location.locationName);
      } else if (_location.locationName.toLowerCase() ==
          'VIJAIPUR'.toLowerCase()) {
        filteredLocationList.add(_location);
        filteredLocationList1.add(_location.locationName);
      } else if (_location.locationName.toLowerCase() ==
          'GTI-NOIDA'.toLowerCase()) {
        filteredLocationList.add(_location);
        filteredLocationList1.add(_location.locationName);
      }
    }

    for (final Location _location in _locationList) {
      if (_location.locationName.toLowerCase() !=
              'DELHI-CORPORATE'.toLowerCase() &&
          _location.locationName.toLowerCase() != 'NOIDA'.toLowerCase() &&
          _location.locationName.toLowerCase() != 'PATA'.toLowerCase() &&
          _location.locationName.toLowerCase() != 'VIJAIPUR'.toLowerCase() &&
          _location.locationName.toLowerCase() != 'GTI-NOIDA'.toLowerCase()) {
        filteredLocationList.add(_location);
        filteredLocationList1.add(_location.locationName);
      }
    }

    update([kSelectFilters]);
  }

  getDepartmentList() async {
    // calling get department details from db method
    departmentListfil.clear();
    departmentList.clear();
    departmentList = await DepartmentDb.getDepartmentDetailsFromDb(selectedValue??"",selectedDirectoratestr??'',selectedEmpGradestr??'',selectedSection??'');
    // await DepartmentDb.getDepartmentDetailsFromDbOnBasis("");
    for(int i = 0; i<departmentList.length; i++) {
      departmentListfil.add(departmentList[i].department);
    }

    update([kSelectFilters]);
  }

  getDirectorate() async{
    directorateListfil.clear();
    directorateListfil =  await EmployeeDb.getDirectorateFromDepartment(selectedDepartmentstr??"",selectedValue??'',selectedEmpGradestr??'',selectedSection??'');
    update([kSelectFilters]);
  }

  getSection() async{
    empSection.clear();
    empSection =  await EmployeeDb.getEmployeeSection(selectedDepartmentstr??"",selectedValue??'',selectedEmpGradestr??'',selectedDirectoratestr??'');
    update([kSelectFilters]);
  }

  getEmpGradeList() async {
    // calling get emp grade details from db method
    empGradeList.clear();
    empGradeListstr.clear();
    empGradeList = await EmpGradeDb.getGradeDetailsFromDb(selectedDepartmentstr??'',selectedDirectoratestr??'',selectedValue??'',selectedSection??'');

    for(int i = 0; i<empGradeList.length; i++) {
      empGradeListstr.add(empGradeList[i].empGrade);
    }

    update([kSelectFilters]);
  }

  onLocationSelected(Location? _location) {
    print("Location_location ${_location}");
    isFilterSelected = true;
    selectedLocation = _location;
    update([kSelectFilters]);
  }

  onDepartmentSelected(Department? _department) async {
    isFilterSelected = true;
    selectedDepartment = _department;
    update([kSelectFilters]);
  }

  onEmpGradeSelected(EmpGrade? _empGrade) {
    isFilterSelected = true;
    selectedEmpGrade = _empGrade;
    update([kSelectFilters]);
  }



  clearFilters() async {
    isFilterSelected = false;
    // selectedEmpGrade = null;
    // selectedLocation = null;
    // selectedDepartment = null;
    ///reset dropdown value
    selectedValue = null;
    selectedDepartmentstr=null;
    selectedDirectoratestr = null;
    selectedEmpGradestr = null;
    selectedSection = null;
    getDirectorate();
    getSection();
    getLocationList();
    getDepartmentList();
    getEmpGradeList();
    // calling get employees list method
    // await EmpListController.to.getEmployeesList();
    // Get.back();

    update([kSelectFilters]);
  }

  advanceSearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('filter', true);
    isFilterSelected = true;

    empListController.getEmpDataByFilter(isFilterSelected,selectedEmpGradestr,selectedValue,selectedDepartmentstr,selectedDirectoratestr,selectedSection);
    update([]);
    Get.back();
  }

  void onLocationSelected1(String? value) async{
    isFilterSelected = true;
    selectedValue = value;
    getDirectorate();
    getSection();
    getLocationList();
    getDepartmentList();
    getEmpGradeList();
    update([kSelectFilters]);
  }

  void onDepartmentSelected1(String? value) async{
    isFilterSelected = true;
    selectedDepartmentstr = value;
    getDirectorate();
    getSection();
    getLocationList();
    getDepartmentList();
    getEmpGradeList();
    update([kSelectFilters]);
  }

  void onSubDepartmentSelected(String? value){
    isFilterSelected = true;
    selectedDirectoratestr = value;
    getDirectorate();
    getSection();
    getLocationList();
    getDepartmentList();
    getEmpGradeList();
    update([kSelectFilters]);
  }

  void onEmpGradeSelected1(String? value) async{
    isFilterSelected = true;
    selectedEmpGradestr = value;
    getDirectorate();
    getSection();
    getLocationList();
    getDepartmentList();
    getEmpGradeList();
    update([kSelectFilters]);
  }

  void onEmpSectionSelected(String? value) async{
    isFilterSelected = true;
    selectedSection = value;
    getDirectorate();
    getSection();
    getLocationList();
    getDepartmentList();
    getEmpGradeList();
    update([kSelectFilters]);
  }

}
