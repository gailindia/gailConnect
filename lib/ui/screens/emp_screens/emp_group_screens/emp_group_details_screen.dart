// Created By Amit Jangid on 20/12/21

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/ui/screens/full_image_screen.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/open_container_transition.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_details_controller.dart';

import '../../../styles/color_controller.dart';

class EmpGroupDetailsScreen extends StatelessWidget {
  const EmpGroupDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return Scaffold(
      appBar:  CustomAppBar(title: kGroupDetails),
      body: GetBuilder<EmpGroupDetailsController>(
        id: kGroupDetails,
        init: EmpGroupDetailsController(),
        builder: (_controller) {
          if (_controller.isLoading) {
            return const LoadingWidget();
          } else if (_controller.empGroup != null) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MaterialCard(
                    child: Column(
                      children: [
                        OpenContainerTransition(
                          tappable: (_controller.empGroup!.groupIcon.isNotEmpty),
                          closedBuilder: (context, action) {
                            return Stack(
                              children: [
                                CircularNetworkImageWidget(
                                  imageWidth: 140,
                                  imageHeight: 140,
                                  showGroupImage: true,
                                  imageUrl: _controller.empGroup!.groupIcon,
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                      kUpdateEmpGroupIconNameRoute,
                                      arguments: {
                                        kGroupId: _controller.empGroup!.id,
                                        kTitle: _controller.empGroup!.groupName,
                                        kImageUrl: _controller.empGroup!.groupIcon,
                                      },
                                    ),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
                                      child: const Icon(AntDesign.edit),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          openBuilder: (context, action) {
                            if (_controller.empGroup?.groupIcon != null && _controller.empGroup!.groupIcon.isNotEmpty) {
                              return FullImageScreen(
                                title: _controller.empGroup!.groupName,
                                imageUrl: _controller.empGroup!.groupIcon,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        verticalSpace12,
                        Text(_controller.empGroup!.groupName, style: textStyle20Bold),
                        verticalSpace6,
                        Text(
                          '$kMembers: ${_controller.groupEmployeesList.length}',
                          style: textStyle13Normal,
                        ),
                        verticalSpace6,
                        Text('$kCreatedBy: ${_controller.getCreatedByName()}', style: textStyle13Normal),
                        Text('$kCreatedOn: ${_controller.empGroup!.createDate}', style: textStyle13Normal),
                      ],
                    ),
                  ),
                  PrimaryButton(
                    text: kAddMembers,
                    shape: const RoundedRectangleBorder(),
                    onPressed: () => Get.toNamed(
                      kCreateEmpGroupSelectEmpRoute,
                      arguments: {
                        kAddMembers: true,
                        kGroupId: _controller.empGroup!.id,
                        kTitle: _controller.empGroup!.groupName,
                        kGroupMembers: _controller.groupEmployeesList,
                      },
                    ),
                  ),
                  if (_controller.groupEmployeesList.isNotEmpty) ...[
                    MaterialCard(
                      padding: const EdgeInsets.only(),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _controller.groupEmployeesList.length,
                        separatorBuilder: (context, _position) =>    Divider(height: 2, color: colorController.kPrimaryDarkColor),
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        itemBuilder: (context, _position) {
                          final Employee _employee = _controller.groupEmployeesList[_position];

                          return Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OpenContainerTransition(
                                      tappable: (_employee.image != null && _employee.image!.isNotEmpty),
                                      closedBuilder: (context, action) => CircularNetworkImageWidget(
                                        imageUrl: _employee.image!,
                                      ),
                                      closedShape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(100)),
                                      ),
                                      openBuilder: (context, action) {
                                        if (_employee.image != null && _employee.image!.isNotEmpty) {
                                          return FullImageScreen(title: _employee.empName!, imageUrl: _employee.image!);
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ),
                                    horizontalSpace12,
                                    Expanded(
                                      child: Column(
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
                                    // calling check if logged in emp is admin for group method
                                    if (_controller.checkIfLoggedInEmpIsAdminForGroup()) ...[
                                      IconButton(
                                        color: colorController
                                        .kPrimaryColor,
                                        padding: const EdgeInsets.only(),
                                        icon: const Icon(AntDesign.delete),
                                        // calling remove member from group method
                                        onPressed: () => _controller.removeMemberFromGroup(
                                          groupMembers: _employee.empNo!,
                                        ),
                                      ),
                                    ],
                                  ],
                                ).paddingSymmetric(vertical: 6),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // calling check if logged in emp is admin for group
                    if (_controller.checkIfLoggedInEmpIsAdminForGroup()) ...[
                      PrimaryButton(
                        text: kDeleteGroup,
                        btnColor: colorController.kPrimaryColor,
                        // calling delete group method
                        onPressed: _controller.deleteGroup,
                        shape: const RoundedRectangleBorder(),
                      ),
                    ],
                  ],
                ],
              ),
            );
          } else {
            return const NoRecordsFound();
          }
        },
      ),
    );
  }
}
