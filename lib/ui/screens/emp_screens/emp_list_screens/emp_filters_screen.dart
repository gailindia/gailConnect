// Created By Amit Jangid 31/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_list_controller.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/location.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/emp_grade.dart';
import 'package:gail_connect/ui/styles/colors.dart';
import 'package:gail_connect/models/department.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_filters_controller.dart';

import '../../../../models/employee.dart';
import '../../../styles/color_controller.dart';

class EmpFiltersScreen extends StatelessWidget {
  const EmpFiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        appBar:  CustomAppBar(title: kSelectFilters),
        body: GetBuilder<EmpListController>(
          id: kSelectFilters,
          init: EmpListController(),
          builder: (_filtersController) => MaterialCard(
            borderRadius: 12,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownSearch<String>(
                    //GATypeModel
                    items: _filtersController.directorateListfil,
                    selectedItem: _filtersController.selectedDirectoratestr,
                    onChanged: (value) {
                      _filtersController.onSubDepartmentSelected(value);
                    },
                    popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      showSelectedItems: true,
                      // itemBuilder: _customPopupItemBuilderExample2,
                      showSearchBox: true,
                    ),
                    // compareFn: (item, sItem) => item.type == sItem.type,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // ignore: prefer_const_constructors
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: kSelectDierectorate,
                        hintText: kSelectDierectorate,
                        // filled: true,
                      ),
                    ),

                  ),
                  verticalSpace24,
                  DropdownSearch<String>(
                    //GATypeModel
                    items: _filtersController.filteredLocationList1,
                    selectedItem: _filtersController.selectedValue,
                    onChanged: (value) {
                      _filtersController.onLocationSelected1(value);

                    },
                    popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      showSelectedItems: true,
                      // itemBuilder: _customPopupItemBuilderExample2,
                      showSearchBox: true,
                    ),
                    // compareFn: (item, sItem) => item.type == sItem.type,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // ignore: prefer_const_constructors
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: kSelectLocation,
                        hintText: kSelectLocation,
                        // filled: true,
                      ),
                    ),

                  ),
                  verticalSpace24,
                  DropdownSearch<String>(
                    //GATypeModel
                    items: _filtersController.departmentListfil,
                    // asyncItems: (String? filter) =>
                    //     _prmsServices.GAtypepostfilter(filter),

                    selectedItem: _filtersController.selectedDepartmentstr,
                    onChanged: (value) async {
                      _filtersController.onDepartmentSelected1(value);

                    },
                    popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      showSelectedItems: true,
                      // itemBuilder: _customPopupItemBuilderExample2,
                      showSearchBox: true,
                    ),
                    // compareFn: (item, sItem) => item.type == sItem.type,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // ignore: prefer_const_constructors
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: kSelectDepartment,
                        hintText: kSelectDepartment,
                        // filled: true,
                      ),
                    ),

                  ),
                  verticalSpace24,
                  DropdownSearch<String>(
                    //GATypeModel
                    items: _filtersController.empGradeListstr,
                    // asyncItems: (String? filter) =>
                    //     _prmsServices.GAtypepostfilter(filter),
                    selectedItem: _filtersController.selectedEmpGradestr,
                    onChanged: (value) {
                      _filtersController.onEmpGradeSelected1(value);
                    },
                    popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      showSelectedItems: true,
                      // itemBuilder: _customPopupItemBuilderExample2,
                      showSearchBox: true,
                    ),
                    // compareFn: (item, sItem) => item.type == sItem.type,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // ignore: prefer_const_constructors
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: kSelectGradeOfEmp,
                        hintText: kSelectGradeOfEmp,
                        // filled: true,
                      ),
                    ),

                  ),
                  verticalSpace24,
                  DropdownSearch<String>(
                    //GATypeModel
                    items: _filtersController.empSection,
                    selectedItem: _filtersController.selectedSection,
                    onChanged: (value) {
                      _filtersController.onEmpSectionSelected(value);
                    },
                    popupProps: PopupPropsMultiSelection.modalBottomSheet(
                      showSelectedItems: true,
                      showSearchBox: true,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: kSelectSectionOfEmp,
                        hintText: kSelectSectionOfEmp,
                        // filled: true,
                      ),
                    ),
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
                        child: PrimaryButton(
                          text: kSearch,
                          onPressed: () {
                            if(_filtersController.fromSearchQuery){
                              print("_filtersController.fromSearchQuery ${_filtersController.searchController.value.text}");
                              _filtersController.advanceSearchwithfiltersearch(
                                  _filtersController.searchController.value.text);


                            }else{
                              if(_filtersController.searchController.value.text.isNotEmpty){
                                print("_filtersController.fromSearchQuery ${_filtersController.searchController.value.text}");
                                _filtersController.advanceSearchwithfiltersearch(
                                    _filtersController.searchController.value.text);
                              }else{
                                _filtersController
                                    .advanceSearch();
                              }
                              // print("_filtersController.fromSearchQue ${_filtersController.fromSearchQuery}");
                              // _filtersController
                              //     .advanceSearch();
                            }


                          }
                        ),
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
