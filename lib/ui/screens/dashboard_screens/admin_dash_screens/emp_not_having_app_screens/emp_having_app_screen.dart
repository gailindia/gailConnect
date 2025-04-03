/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

// Created By Amit Jangid on 26/11/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:multiutillib/animations/slide_animation.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/admin_controllers/emp_not_having_app_controllers/emp_not_having_app_controller.dart';
import 'package:gail_connect/core/controllers/dash_controllers/admin_controllers/emp_not_having_app_controllers/emp_not_having_app_filters_controller.dart';

import '../../../../styles/color_controller.dart';

class EmpHavingAppScreen extends StatelessWidget {
  const EmpHavingAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      // appBar: CustomAppBar(
      //     title: kEmpNotHavingApp, isEmpNotHavingAppListScreen: true),
      body: GetBuilder<EmpNotHavingAppController>(
        id: kEmpNotHavingApp,
        init: EmpNotHavingAppController(),
        builder: (_controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialCard(
                borderRadius: 12,
                padding: const EdgeInsets.only(),
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        // calling search employee method
                        onChanged: _controller.searchEmployee,
                        controller: _controller.searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: kEnterEmpNameCpf,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(Feather.search),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      color: colorController.kBlackShadeColor,
                      icon: const Icon(MaterialIcons.clear),
                      onPressed: () {
                        Get.focusScope!.unfocus();
                        // _controller.searchController.text = '';
                        // calling search employee method
                        _controller.searchEmployee(_controller.searchController.text );
                      },
                    ),
                  ],
                ),
              ),
              verticalSpace12,
              Padding(
                padding: const EdgeInsets.only(left: 80.0, right: 80),
                child: MaterialCard(
                  borderRadius: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Center(
                    child: Text(
                      '$kSearchResult - ${_controller.filteredEmpHavingAppList.length}',
                      style: textStyle14Normal,
                    ),
                  ),
                ),
              ),
              if (_controller.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_controller
                  .filteredEmpHavingAppList.isNotEmpty) ...[
                verticalSpace12,
                if (EmpNotHavingAppFiltersController.isFilterSelected ||
                    _controller.fromSearchQuery) ...[
                  // MaterialCard(
                  //   borderRadius: 12,
                  //   margin: const EdgeInsets.symmetric(horizontal: 12),
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  //   child: Text(
                  //     '$kSearchResult - ${_controller.filteredEmpNotHavingAppList.length}',
                  //     style: textStyle14Normal,
                  //   ),
                  // ),
                  verticalSpace12,
                ],
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 48),
                    itemCount: _controller.filteredEmpHavingAppList.length,
                    itemBuilder: (context, _position) {
                      final Employee _employee =
                      _controller.filteredEmpHavingAppList[_position];

                      final int _itemCount =
                      _controller.filteredEmpHavingAppList.length > 15
                          ? 15
                          : _controller.filteredEmpHavingAppList.length;

                      return SlideAnimation(
                        position: _position,
                        itemCount: _itemCount,
                        animationController: _controller.animationController,
                        child: MaterialCard(
                          borderRadius: 12,
                          margin: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(_employee.empName!,
                                            style: textStyle15Bold),
                                        const SizedBox(height: 3),
                                        Text(_employee.designation!,
                                            style: textStyle13Normal),
                                        verticalSpace6,
                                        RichTextWidget(
                                          caption: kCpfNo,
                                          description: _employee.empNo!,
                                          captionStyle: textStyle13Bold,
                                          descriptionStyle: textStyle13Normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                const Expanded(child: NoRecordsFound()),
              ],
            ],
          );
        },
      ),
    );
  }
}
