// Created By Amit Jangid on 17/12/21

import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/emp_group.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_list_controller.dart';

import '../../../styles/color_controller.dart';

class EmpGroupListScreen extends StatelessWidget {
  const EmpGroupListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return Scaffold(
      appBar:  CustomAppBar(title: kEmpGroups),
      floatingActionButton: Visibility(
        child: FloatingActionButton.extended(
          label: const Text(kCreateGroup),
          backgroundColor: colorController.kPrimaryDarkColor,
          icon: const Icon(MaterialIcons.group_add),
          onPressed: () => Get.toNamed(kCreateEmpGroupSelectEmpRoute),
        ),
        // visible: SharedPrefs.to.isGroupAdmin,
      ),
      body: GetBuilder<EmpGroupListController>(
        id: kEmpGroups,
        init: EmpGroupListController(),
        builder: (_controller) {
          if (_controller.isLoading) {
            return const LoadingWidget();
          } else if (_controller.empGroupList.isNotEmpty) {
            return ListView.builder(
              itemCount: _controller.empGroupList.length,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 84),
              itemBuilder: (context, _position) {
                final EmpGroup _empGroup = _controller.empGroupList[_position];
                return MaterialCard(
                  borderRadius: 12,
                  onTap: () => Get.toNamed(kEmpGroupSendMsgRoute,
                      arguments: _empGroup.id),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularNetworkImageWidget(
                          showGroupImage: true, imageUrl: _empGroup.groupIcon),
                      horizontalSpace12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_empGroup.groupName, style: textStyle20Normal),
                            verticalSpace6,
                            Text(
                                '$kCreatedBy: ${_controller.getCreatedByName(_empGroup)}',
                                style: textStyle13Normal),
                            Text('$kCreatedOn: ${_empGroup.createDate}',
                                style: textStyle13Normal),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const NoRecordsFound();
        },
      ),
    );
  }
}
