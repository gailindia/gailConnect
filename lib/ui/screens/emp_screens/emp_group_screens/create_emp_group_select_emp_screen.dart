// Created By Amit Jangid on 17/12/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_filters_controller.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/create_emp_group_controller.dart';

import '../../../styles/color_controller.dart';

class CreateEmpGroupSelectEmpScreen extends StatelessWidget {
  const CreateEmpGroupSelectEmpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return GetBuilder<CreateEmpGroupController>(
      id: kCreateGroup,
      init: CreateEmpGroupController(),
      builder: (_controller) => Scaffold(
        appBar: CustomAppBar(isCreateEmpGroupScreen: true, title: _controller.title ?? kNewGroupAddMembers),
        floatingActionButton: _controller.selectedEmployeesList.isNotEmpty || _controller.selectAllEmployees
            ? FloatingActionButton(
                tooltip: kNext,
                clipBehavior: Clip.antiAlias,
                backgroundColor: colorController.kPrimaryDarkColor,
                child: const Icon(Ionicons.add, size: 36),
                onPressed: () {
                  if (_controller.fromGroupDetails) {
                    // calling add new members to group method
                    _controller.addNewMembersToGroup();
                  } else {
                    // calling navigate to enter name screen method
                    _controller.navigateToEnterNameScreen();
                  }
                },
              )
            : null,
        body: _controller.isLoading
            ? const LoadingWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_controller.selectedEmployeesList.isNotEmpty) ...[
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _controller.scrollController,
                        padding: const EdgeInsets.only(right: 12),
                        itemCount: _controller.selectedEmployeesList.length,
                        itemBuilder: (context, _position) {
                          final Employee _employee = _controller.selectedEmployeesList[_position];

                          return Stack(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularNetworkImageWidget(imageUrl: _employee.image!),
                                    Text(
                                      _employee.empName!.replaceAll('  ', '\n').replaceAll(' ', '\n'),
                                      maxLines: 2,
                                      style: textStyle12Normal,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 6,
                                child: InkWell(
                                  // calling on selected employee removed method
                                  onTap: () => _controller.onSelectedEmployeeRemoved(_position),
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
                                    child: const Icon(MaterialIcons.clear, size: 24),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                  MaterialCard(
                    borderRadius: 12,
                    padding: const EdgeInsets.only(),
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            autocorrect: false,
                            enableSuggestions: false,
                            // calling search employee method
                            onChanged: _controller.searchEmployee,
                            controller: _controller.searchEmployeeController,
                            decoration:  InputDecoration(
                              border: InputBorder.none,
                              hintText: kEnterEmpNameCpf,
                              hintStyle: textStyle13Normal,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        if (_controller.searchEmployeeController.value.text.isNotEmpty) ...[
                          IconButton(
                            color: colorController.kBlackShadeColor,
                            icon: const Icon(MaterialIcons.clear),
                            // calling clear employee search method
                            onPressed: () => _controller.clearEmployeeSearch(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  verticalSpace12,
                  if (EmpFiltersController.isFilterSelected || _controller.fromSearchQuery) ...[
                    MaterialCard(
                      borderRadius: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '$kSearchResult - ${_controller.filteredEmployeesList.length}',
                              style: textStyle14Normal,
                            ),
                          ),
                          horizontalSpace12,
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Checkbox(
                                visualDensity: VisualDensity.compact,
                                value: _controller.selectAllEmployees,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                // calling on select all check box selected method
                                onChanged: (_value) => _controller.onSelectAllCheckBoxChecked(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace12,
                  ],
                  Expanded(
                    child: ListView.builder(
                      itemCount: _controller.filteredEmployeesList.length,
                      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                      itemBuilder: (context, _position) {
                        final Employee _employee = _controller.filteredEmployeesList[_position];

                        return MaterialCard(
                          borderRadius: 12,
                          margin: const EdgeInsets.only(bottom: 12),
                          // calling on employee selected method
                          onTap: () => _controller.onEmployeeSelected(_employee),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircularNetworkImageWidget(imageUrl: _employee.image!),
                                    horizontalSpace12,
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_employee.empName!, style: textStyle15Bold),
                                          const SizedBox(height: 3),
                                          Text(_employee.designation!, style: textStyle13Normal),
                                          verticalSpace6,
                                          Text(
                                            '${_employee.department!}, ${_employee.location!}',
                                            style: textStyle13Normal,
                                          ),
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
                                    Checkbox(
                                      value: _employee.isEmployeeSelected,
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      // calling on employee selected method
                                      onChanged: (_value) => _controller.onEmployeeSelected(_employee),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
