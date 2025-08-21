// Created By Amit Jangid 26/08/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/colors.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/emp_list_widget.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_list_controller.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_filters_controller.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../../../config/routes.dart';
import '../../../styles/color_controller.dart';

class EmpListScreen extends StatelessWidget {
  const EmpListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return WillPopScope(
      onWillPop: () {
        // calling update is multiple checked method
        EmpListController.to.updateIsMultipleChecked(fromBackButton: true);

        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar:  CustomAppBar(title: kEmployees, isEmpListScreen: true),
          body: GetBuilder<EmpListController>(
            id: kEmployees,
            init: EmpListController(),
            builder: (_empListController) {
              return Container(
                color: Colors.transparent,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MaterialCard(
                            borderRadius: 12,
                            padding: const EdgeInsets.only(),
                            margin: const EdgeInsets.only(
                                top: 12, left: 12, right: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    autocorrect: false,
                                    controller:
                                        _empListController.searchController,
                                    decoration: InputDecoration(
                                      hintText: kEnterEmpName,
                                      border: InputBorder.none,
                                      hintStyle: textStyle13Normal,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                if (_empListController.searchController.value
                                    .text.isNotEmpty) ...[
                                  IconButton(
                                    color: colorController.kBlackShadeColor,
                                    icon: const Icon(MaterialIcons.clear),
                                    onPressed: () {

                                      if(_empListController.fromSearchQuery){

                                        _empListController.searchController.text =
                                        '';
                                        // _empListController.advanceSearchwithfiltersearch('');
                                        if(_empListController.searchController.text.isEmpty){

                                          _empListController.searchEmployee('');
                                        }else{

                                          _empListController.advanceSearchwithfiltersearch('');
                                        }


                                      }else{
                                        _empListController.searchController.text =
                                        '';
                                        // calling search emp by name method
                                        _empListController.searchEmployee('');
                                        // _empListController.getEmployeesList(false);
                                      }




                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        MaterialCard(
                          borderRadius: 12,
                          margin: const EdgeInsets.only(top: 12, right: 12),
                          // calling search employee method
                          onTap: () {
                            if(_empListController.searchController.value.text.isEmpty){

                            }else {
                              if (_empListController.fromSearchQuery) {
                                _empListController.searchEmployeewithfilter(
                                    _empListController.searchController.value
                                        .text);
                              } else {
                                _empListController.searchEmployee(
                                    _empListController.searchController.value
                                        .text);
                              }
                            }


              },


                          child: Icon(Feather.search,
                              color: colorController.kPrimaryDarkColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () async {

                              await Get.toNamed(kFiltersRoute);
                              // calling get employees list method

                              EmpListController.to.getEmployeesList(true);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 12.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                                child: Image.asset(
                                  'assets/icons/filter_bg.png',
                                  width: 85,
                                  fit: BoxFit.fill, // Optional: to ensure the image covers the area
                                ),
                              ),
                              // child: Container(
                              //     width: 80,
                              //     height: 20,
                              //     decoration: BoxDecoration(
                              //         color: colorController.kSelectedColor,
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(5))),
                              //     child: Image.asset(
                              //         'assets/icons/filter_bg.png')),
                            )),
                      ],
                    ),
                    if (_empListController.isLoading) ...[

                      const Expanded(
                          child: SingleChildScrollView(child: LoadingWidget())),
                    ] else if (_empListController
                        .filteredEmployeesList.isEmpty) ...[
                      const Expanded(child: NoRecordsFound()),
                    ] else ...[
                      verticalSpace12,
                      if (EmpFiltersController.isFilterSelected ||
                          _empListController.fromSearchQuery) ...[
                        MaterialCard(
                          borderRadius: 12,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Text(
                            '$kSearchResult - ${_empListController.filteredEmployeesList.length}',
                            style: textStyle14Normal,
                          ),
                        ),

                      ],
                      Expanded(
                        child: EmpListWidget(
                          imageHeight: 120,
                          isEmpListScreen: true,
                          employeeList:
                              _empListController.filteredEmployeesList,
                          superannuationmodel: [],
                          phoneConsent: _empListController.phoneConsentList,
                          animationController:
                              _empListController.animationController,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
