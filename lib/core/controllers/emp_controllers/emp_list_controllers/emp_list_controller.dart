// Created By Amit Jangid 26/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/consent_model.dart';
import 'package:gail_connect/models/department.dart';
import 'package:gail_connect/models/emp_grade.dart';
import 'package:gail_connect/models/location.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_filters_controller.dart';
import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  static EmpListController get to => Get.find<EmpListController>();
  final TextEditingController searchController = TextEditingController();

  final _isMultipleChecked = false.obs;
  bool isLoading = true, fromSearchQuery = false,resetsearch = false;
  Employee? selectedEmployee;
  List<Employee> employeesList = [];
  List<Employee> filteredEmployeesList = [];
  List<PhoneConsent> phoneConsentList = [];

  bool get isMultipleChecked => _isMultipleChecked.value;

  set isMultipleChecked(value) => _isMultipleChecked.value = value;

  bool isFilterSelected = true;

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

  // @override
  // void onReady() {
  //   super.onReady();
  //
  //   // calling init emp list controller for data method
  //   initEmpListControllerForData();
  //
  // }
  @override
  void onInit() {
    super.onInit();
    initEmpListControllerForData();

    // calling get location list method
    getLocationList();

    // calling get department list method
    getDepartmentList();

    // get emp grade list
    getEmpGradeList();

    getDirectorate();

    getSection();
  }

  initEmpListControllerForData() {
    searchController.clear();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // calling clear filters method
    clearFilter();
    getConsentData();

    // calling get employees list method
    getEmployeesList(false);

    // calling hit count api method
    GailConnectServices.to.hitCountApi(
        activity: kEmployeesScreen, activityScreen: "/employeesDash");
  }

  updateIsMultipleChecked({bool fromBackButton = false}) {
    if (fromBackButton) {
      isMultipleChecked = false;
    } else {
      isMultipleChecked = !isMultipleChecked;
    }

    if (!isMultipleChecked || fromBackButton) {
      for (final Employee employee
      in EmpListController.to.filteredEmployeesList) {
        employee.isEmployeeSelected = false;
      }
    }
  }

  updateIsEmployeeSelected({required Employee employee}) {
    employee.isEmployeeSelected = !employee.isEmployeeSelected;
    update([kEmployees]);
  }

  clearFilter() {
    EmpFiltersController.selectedEmpGrade = null;
    EmpFiltersController.selectedLocation = null;
    EmpFiltersController.isFilterSelected = false;
    EmpFiltersController.selectedDepartment = null;
  }

  getEmpDataByFilter(bool isFilterSelected, String? selectedEmpGradestr, String? selectedValue, String? selectedDepartmentstr, String? selectedDirectorate, String? selectedSection) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('filter', true);
    fromSearchQuery = true;
    employeesList = await EmployeeDb.getEmployeesListFromDb(
        isFilterSelected: isFilterSelected,
        empGrade: selectedEmpGradestr ?? '',
        location: selectedValue ?? '',
        department: selectedDepartmentstr ?? '',
        directorate: selectedDirectorate ?? '',
        section : selectedSection ?? ''
    );
    filteredEmployeesList = employeesList;
    for (int j = 0; j < phoneConsentList.length; j++) {
      // print(
      // "bdayConsentList getSupoperAnnuation  empcontroller:: ${phoneConsentList[j].cpfNo}");
      for (int i = 0; i < filteredEmployeesList.length; i++) {
        // print(
        //     "filteredEmployeesList[i].empNo :: ${filteredEmployeesList[i].empNo!.toInt}");
        if (filteredEmployeesList[i].empNo.toInt.toString() ==
            phoneConsentList[j].cpfNo!.round().toString()) {
          filteredEmployeesList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";//assets/icons/logo.png
          employeesList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";
          // print("bdayConsentList index :: $i ${filteredEmployeesList[i].image}");
          // filteredEmployeesList.removeAt(i).image;
          update([kEmployees]);
        }
      }
    }
    // print("employeesList gfhj ${employeesList[0].empName}");
  }

  getEmpDataByFiltersearch(bool isFilterSelected, String? selectedEmpGradestr, String? selectedValue, String? selectedDepartmentstr, String? selectedDirectorate, String? selectedSection, String? searchquery) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('filter', true);
    fromSearchQuery = true;
    employeesList = await EmployeeDb.getEmployeesListFromDbwithfiltersearch(
        searchQuery: searchController.text,
        isFilterSelected: isFilterSelected,
        empGrade: selectedEmpGradestr ?? '',
        location: selectedValue ?? '',
        department: selectedDepartmentstr ?? '',
        directorate: selectedDirectorate ?? '',
        section : selectedSection ?? ''
    );
    filteredEmployeesList = employeesList;
    for (int j = 0; j < phoneConsentList.length; j++) {
      // print(
      // "bdayConsentList getSupoperAnnuation  empcontroller:: ${phoneConsentList[j].cpfNo}");
      for (int i = 0; i < filteredEmployeesList.length; i++) {
        // print(
        //     "filteredEmployeesList[i].empNo :: ${filteredEmployeesList[i].empNo!.toInt}");
        if (filteredEmployeesList[i].empNo.toInt.toString() ==
            phoneConsentList[j].cpfNo!.round().toString()) {
          filteredEmployeesList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";//assets/icons/logo.png
          employeesList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";
          // print("bdayConsentList index :: $i ${filteredEmployeesList[i].image}");
          // filteredEmployeesList.removeAt(i).image;
          update([kEmployees]);
        }
      }
    }
    // print("employeesList gfhj ${employeesList[0].empName}");
  }

  getEmployeesList(bool isFrom) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('filter', false);
    isLoading = true;
    update([kEmployees]);
    await Future.delayed(const Duration(milliseconds: 1500));

    if (EmpFiltersController.selectedEmpGrade == null &&
        EmpFiltersController.selectedLocation == null &&
        EmpFiltersController.selectedDepartment == null) {
      EmpFiltersController.isFilterSelected = false;
    }

    if(isFrom == true){

    }else {
      // if (!await checkConnectivity()) {
      //   _employeesList = await EmployeeDb.getEmployeesListFromDb(
      //     isFilterSelected: EmpFiltersController.isFilterSelected,
      //     empGrade: EmpFiltersController.selectedEmpGrade?.empGrade ?? '',
      //     location: EmpFiltersController.selectedLocation?.locationName ?? '',
      //     department: EmpFiltersController.selectedDepartment?.department ?? '',
      //   );
      //   print(_employeesList);
      //   print("_employeesListdfghj");
      // } else {
      //   _employeesList = await GailConnectServices.to.getEmployeesListApiLive();
      //   print(_employeesList);
      //   print("_employeesList");
      // }
      // calling get employees list from db method

      employeesList = await EmployeeDb.getEmployeesListFromDb(
        isFilterSelected: EmpFiltersController.isFilterSelected,
        empGrade: EmpFiltersController.selectedEmpGrade?.empGrade ?? '',
        location: EmpFiltersController.selectedLocation?.locationName ?? '',
        department: EmpFiltersController.selectedDepartment?.department ?? '',
      );
      filteredEmployeesList = employeesList;
      for (int j = 0; j < phoneConsentList.length; j++) {
        // print(
        // "bdayConsentList getSupoperAnnuation  empcontroller:: ${phoneConsentList[j]
        //     .cpfNo}");
        for (int i = 0; i < filteredEmployeesList.length; i++) {
          // print(
          //     "superannuationmodel :: ${filteredEmployeesList[i].empNo!
          //         .toInt}");
          if (filteredEmployeesList[i].empNo.toInt.toString() ==
              phoneConsentList[j].cpfNo!.round().toString()) {
            filteredEmployeesList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png"; //assets/icons/logo.png
            employeesList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";
            print("without search:: $i ${filteredEmployeesList[i]
                .image}");
            // filteredEmployeesList.removeAt(i).image;
            update([kEmployees]);
          }
        }
      }
    }


    // _employeesList = await GailConnectServices.to.getEmployeesListApiLive();




    isLoading = false;
    update([kEmployees]);
  }

  getEmployeeListBySearchQuery(String _searchQuery) async {
    isLoading = true;
    update([kEmployees]);
    await Future.delayed(const Duration(milliseconds: 1500));

    // calling get employee list by search query from db method
    employeesList = await EmployeeDb.getEmployeesListBySearchQueryFromDb(
        searchQuery: _searchQuery);
    filteredEmployeesList = employeesList;
    // print(filteredEmployeesList);
    // print("filteredEmployeesList");
    for (int j = 0; j < phoneConsentList.length; j++) {
      // print(
      //     "bdayConsentList getSupoperAnnuation  empcontroller:: ${phoneConsentList[j].cpfNo}");
      for (int i = 0; i < filteredEmployeesList.length; i++) {
        print(
            "from search list :: ${filteredEmployeesList[i].empNo!.toInt}");
        if (filteredEmployeesList[i].empNo.toInt.toString() ==
            phoneConsentList[j].cpfNo!.round().toString()) {
          filteredEmployeesList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";//assets/icons/logo.png
          employeesList[i].image = "https://gailebank.gail.co.in/WebServices/Consolidated/icon.png";//assets/icons/logo.png
          // print("bdayConsentList index :: $i ${filteredEmployeesList[i].image}");
          // filteredEmployeesList.removeAt(i).image;
          update([kEmployees]);
        }
      }
    }
    isLoading = false;
    update([kEmployees]);
  }

  searchEmployee(String _searchQuery) async {
    if (_searchQuery.isNotEmpty) {
      fromSearchQuery = true;
      // calling get employee list by search query method
      await getEmployeeListBySearchQuery(_searchQuery);
    } else {
      fromSearchQuery = false;

      // calling get employees list method
      // await getEmployeeListBySearchQuerywithfilter("");
      advanceSearch();
      // await getEmployeesList(false);
    }
  }

  String getBirthdayFormat(String date) {
    var inputFormat = DateFormat('dd.MM.yyyy');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd MMM');
    return outputFormat.format(inputDate);
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
    print("XXXXXXXXXX Phone COnsent XXXXXXXXXX" + phoneConsentList.toString());
    update([kDashboard]);
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
    fromSearchQuery = false;
    resetsearch = true;
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
    if(resetsearch){
      getEmployeesList(false);
    }else{
      getEmpDataByFilter(isFilterSelected,selectedEmpGradestr,selectedValue,selectedDepartmentstr,selectedDirectoratestr,selectedSection);
    }
    resetsearch = false;
    // getEmpDataByFilter(isFilterSelected,selectedEmpGradestr,selectedValue,selectedDepartmentstr,selectedDirectoratestr,selectedSection);
    update([kEmployees]);
    Get.back();
  }

  advanceSearchwithfiltersearch(String searchquery) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('filter', true);
    isFilterSelected = true;
    getEmpDataByFiltersearch(isFilterSelected,selectedEmpGradestr,selectedValue,selectedDepartmentstr,selectedDirectoratestr,selectedSection,searchquery);
    update([kEmployees]);
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

  void searchEmployeewithfilter(String _searchQuery) async{
    await getEmployeeListBySearchQuerywithfilter(_searchQuery);
  }

  getEmployeeListBySearchQuerywithfilter(String searchQuery) async{
    isLoading = true;
    update([kEmployees]);
    await Future.delayed(const Duration(milliseconds: 1500));

    // calling get employee list by search query from db method
    employeesList = await EmployeeDb.getEmployeesListBySearchQuerywithfilterFromDb(
        searchQuery: searchQuery,
        isFilterSelected: isFilterSelected,
        empGrade: selectedEmpGradestr ?? '',
        location: selectedValue ?? '',
        department: selectedDepartmentstr ?? '',
        directorate: selectedDirectoratestr ?? '',
        section : selectedSection ?? '');
    filteredEmployeesList = employeesList;

    isLoading = false;
    update([kEmployees]);

  }






}

/*
class EmployeeListSearch extends SearchDelegate<Employee> {
  final List<Employee> employeesList;
  List<Employee> _filteredEmployeesList = [];

  EmployeeListSearch({required this.employeesList});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: const Icon(Icons.close))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, const Employee()), icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    _filteredEmployeesList = employeesList.where((Employee _employee) {
      return _employee.empName!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return _filteredEmployeesList;
  }
}
*/
