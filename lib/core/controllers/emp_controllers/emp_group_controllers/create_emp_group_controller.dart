// Created By Amit Jangid on 17/12/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:get/get.dart';
import 'package:gail_connect/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_filters_controller.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_list_controller.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_details_controller.dart';

class CreateEmpGroupController extends GetxController {
  final String _tag = 'CreateEmpGroupController';

  static CreateEmpGroupController get to =>
      Get.find<CreateEmpGroupController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController searchEmployeeController =
      TextEditingController();

  String? title, empGroupId;

  bool isLoading = true,
      partialEmpSelected = false,
      selectAllEmployees = false,
      fromGroupDetails = false,
      fromSearchQuery = false;

  File? selectedGroupIconFile;

  List<Employee> _employeesList = [];
  List<Employee> filteredEmployeesList = [];
  List<Employee> selectedEmployeesList = [];

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      empGroupId = Get.arguments[kGroupId];
      fromGroupDetails = Get.arguments[kAddMembers];
      title = '${Get.arguments[kTitle]}\n$kAddMembers';
      selectedEmployeesList = Get.arguments[kGroupMembers];
    }

    // calling get employees list method
    getEmployeesList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kCreateEmployeeGroupScreen);
  }

  getEmployeesList() async {
    isLoading = true;
    update([kCreateGroup]);

    if (EmpFiltersController.selectedEmpGrade == null &&
        EmpFiltersController.selectedLocation == null &&
        EmpFiltersController.selectedDepartment == null) {
      EmpFiltersController.isFilterSelected = false;
    }

    // calling get employees list from db method
    _employeesList = await EmployeeDb.getEmployeesListFromDb(
      allEmployees: !EmpFiltersController.isFilterSelected,
      isFilterSelected: EmpFiltersController.isFilterSelected,
      empGrade: EmpFiltersController.selectedEmpGrade?.empGrade ?? '',
      location: EmpFiltersController.selectedLocation?.locationName ?? '',
      department: EmpFiltersController.selectedDepartment?.department ?? '',
    );

    isLoading = false;
    filteredEmployeesList = _employeesList;

    update([kCreateGroup]);
  }

  searchEmployee(String _query) {
    final List<Employee> _tempEmployeeList = [];

    if (_query.isNotEmpty) {
      fromSearchQuery = true;

      for (final Employee _employee in _employeesList) {
        if (_employee.empNo!
                .toLowerCase()
                .replaceAll(' ', '')
                .contains(_query.toLowerCase().replaceAll(' ', '')) ||
            _employee.empName!
                .toLowerCase()
                .replaceAll(' ', '')
                .contains(_query.toLowerCase().replaceAll(' ', ''))) {
          _tempEmployeeList.add(_employee);
        }
      }

      filteredEmployeesList = _tempEmployeeList;
      update([kCreateGroup]);
    } else {
      fromSearchQuery = false;
      filteredEmployeesList = _employeesList;
      update([kCreateGroup]);
    }
  }

  clearEmployeeSearch() {
    searchEmployeeController.clear();

    // calling search employee method
    searchEmployee('');
  }

  onEmployeeSelected(Employee _selectedEmployee) {
    bool _isAlreadyExists = false;

    for (final Employee _employee in selectedEmployeesList) {
      if (_employee.empNo!.padLeft(8, '0') ==
          _selectedEmployee.empNo!.padLeft(8, '0')) {
        _isAlreadyExists = true;
      }
    }

    if (!_isAlreadyExists) {
      selectedEmployeesList.add(_selectedEmployee);

      // calling clear employee search method
      clearEmployeeSearch();

      // calling scroll to end method
      _scrollToEnd();
    }
  }

  onSelectedEmployeeRemoved(int _position) {
    selectedEmployeesList.removeAt(_position);

    update([kCreateGroup]);
  }

  _scrollToEnd() async {
    await Future.delayed(const Duration(milliseconds: 400));

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
    );
  }

  onSelectAllCheckBoxChecked() {
    selectAllEmployees = !selectAllEmployees;

    for (final Employee _employee in filteredEmployeesList) {
      _employee.isEmployeeSelected = selectAllEmployees;

      if (selectAllEmployees) {
        // calling on employee selected method
        onEmployeeSelected(_employee);
      } else {
        for (int i = 0; i < selectedEmployeesList.length; i++) {
          // calling on selected employee removed method
          onSelectedEmployeeRemoved(i);
        }
      }
    }

    update([kCreateGroup]);
  }

  navigateToEnterNameScreen() => Get.toNamed(kCreateEmpGroupEnterNameRoute);

  chooseGroupIcon() async {
    try {
      final ImagePicker _imagePicker = ImagePicker();

      // calling pick image method
      final XFile? _selectedGroupIcon = await _imagePicker.pickImage(
          imageQuality: 50, source: ImageSource.gallery);

      if (_selectedGroupIcon != null) {
        selectedGroupIconFile = File(_selectedGroupIcon.path);
        update([kCreateGroup]);
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while choosing group icon for new group',
      );
    }
  }

  createNewGroup() async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        String _groupParticipants = '';
        final String _groupName = groupNameController.value.text;

        for (final Employee _employee in selectedEmployeesList) {
          _groupParticipants += _employee.empNo! + ',';
        }

        _groupParticipants =
            _groupParticipants.substring(0, _groupParticipants.length - 1);

        // calling show progress dialog method
        await showProgressDialog(Get.context!);

        // calling create new group api method
        final _response = await GailConnectServices.to.createNewGroupApi(
          groupName: _groupName,
          selectedGroupIcon: selectedGroupIconFile,
          groupMembers: _groupParticipants.toString(),
        );

        // calling hide progress dialog method
        await hideProgressDialog();

        // calling get emp groups list method
        EmpGroupListController.to.getEmpGroupsList();

        // calling show custom dialog box method
        await showCustomDialogBox(
            context: Get.context!, title: kInfo, description: _response!);

        Get.back();
        Get.back();
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while creating new group',
      );
    }
  }

  addNewMembersToGroup() async {
    String _groupParticipants = '';

    for (final Employee _employee in selectedEmployeesList) {
      _groupParticipants += _employee.empNo! + ',';
    }

    _groupParticipants =
        _groupParticipants.substring(0, _groupParticipants.length - 1);

    // calling show progress dialog method
    await showProgressDialog(Get.context!);

    // calling add new members to group api method
    final _response = await GailConnectServices.to.addNewMembersToGroupApi(
      empGroupId: empGroupId!,
      groupMembers: _groupParticipants,
    );

    // calling hide progress dialog method
    await hideProgressDialog();

    // calling get emp group details method
    await EmpGroupDetailsController.to.getEmpGroupDetails();

    // calling show custom dialog box method
    await showCustomDialogBox(
        context: Get.context!, title: kInfo, description: _response!);

    Get.back();
  }

  @override
  void dispose() {
    scrollController.dispose();
    groupNameController.dispose();
    searchEmployeeController.dispose();

    super.dispose();
  }
}
