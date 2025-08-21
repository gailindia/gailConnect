// Created By Amit Jangid on 30/11/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/location.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/emp_grade.dart';
import 'package:gail_connect/models/department.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/admin_controllers/emp_not_having_app_controllers/emp_not_having_app_filters_controller.dart';

import '../../../../styles/color_controller.dart';

class EmpNotHavingAppFiltersScreen extends StatelessWidget {
  const EmpNotHavingAppFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar:  CustomAppBar(title: kSelectFilters),
        body: GetBuilder<EmpNotHavingAppFiltersController>(
          id: kSelectEmpFilters,
          init: EmpNotHavingAppFiltersController(),
          builder: (_filtersController) => MaterialCard(
            borderRadius: 12,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownSearch<Location>(
                    // maxHeight: 500,
                    // showSearchBox: true,
                    // showClearButton: true,
                    // label: kSelectLocation,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: kSelectLocation,
                        hintText: kSelectLocation,
                      ),
                    ),
                    // mode: Mode.BOTTOM_SHEET,
                    // showAsSuffixIcons: true,
                    // dropdownSearchBaseStyle: textStyle16Normal,
                    items: _filtersController.filteredLocationList,
                    // calling on location selected method
                    onChanged: _filtersController.onLocationSelected,
                    itemAsString: (Location? _location) => _location!.locationName,
                    selectedItem: EmpNotHavingAppFiltersController.selectedLocation,
                    // emptyBuilder: (context, _searchString) => const Scaffold(body: NoRecordsFound()),
                    // popupShape: const RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    // ),
                  ),
                  verticalSpace24,
                  DropdownSearch<Department>(
                    // maxHeight: 500,
                    // showSearchBox: true,
                    // showClearButton: true,
                    // mode: Mode.BOTTOM_SHEET,
                    // showAsSuffixIcons: true,
                    // hint: kSelectDepartment,
                    items: _filtersController.departmentList,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: kSelectDepartment,
                        hintText: kSelectDepartment,
                      ),
                    ),
                    // dropdownSearchBaseStyle: textStyle16Normal,
                    // calling on department selected method
                    onChanged: _filtersController.onDepartmentSelected,
                    selectedItem: EmpNotHavingAppFiltersController.selectedDepartment,
                    itemAsString: (Department? _department) => _department!.department,
                    // emptyBuilder: (context, _searchString) => const Scaffold(body: NoRecordsFound()),
                    // popupShape: const RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    // ),
                  ),
                  verticalSpace24,
                  DropdownSearch<EmpGrade>(
                    // maxHeight: 500,
                    // showSearchBox: true,
                    // showClearButton: true,
                    // mode: Mode.BOTTOM_SHEET,
                    // showAsSuffixIcons: true,
                    // hint: kSelectGradeOfEmp,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: kSelectGradeOfEmp,
                        hintText: kSelectGradeOfEmp,
                      ),
                    ),
                    items: _filtersController.empGradeList,
                    // dropdownSearchBaseStyle: textStyle16Normal,
                    // calling on emp grade selected method
                    onChanged: _filtersController.onEmpGradeSelected,
                    itemAsString: (EmpGrade? _empGrade) => _empGrade!.empGrade,
                    selectedItem: EmpNotHavingAppFiltersController.selectedEmpGrade,
                    // emptyBuilder: (context, _searchString) => const Scaffold(body: NoRecordsFound()),
                    // popupShape: const RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    // ),
                  ),
                  verticalSpace6,
                  // calling advance search method
                  Row(
                    children: [
                      // calling clear filters method
                      Expanded(
                        child: PrimaryButton(
                          text: kReset,
                          btnColor: colorController.kPrimaryColor,
                          // calling clear filters method
                          onPressed: () => _filtersController.clearFilters(),
                        ),
                      ),
                      horizontalSpace12,
                      // calling advance search method
                      Expanded(
                        child: PrimaryButton(text: kSearch, onPressed: () => _filtersController.advanceSearch()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
