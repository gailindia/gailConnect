// Created By Amit Jangid on 21/12/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_icon_name_update_controller.dart';

import '../../../styles/color_controller.dart';

class EmpGroupIconNameUpdateScreen extends StatelessWidget {
  const EmpGroupIconNameUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return Scaffold(
      appBar:  CustomAppBar(title: kUpdateGroupDetails),
      body: GetBuilder<EmpGroupIconNameUpdateController>(
        id: kUpdateGroupDetails,
        init: EmpGroupIconNameUpdateController(),
        builder: (_controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    // calling choose group icon method
                    onTap: () => _controller.chooseGroupIcon(),
                    child: Center(
                      child: Stack(
                        children: [
                          if (_controller.imageUrl != null) ...[
                            CircularNetworkImageWidget(
                              imageWidth: 140,
                              imageHeight: 140,
                              imageUrl: _controller.imageUrl!,
                            ),
                          ] else if (_controller.selectedGroupIconFile == null) ...[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: colorController.kPrimaryDarkColor),
                                borderRadius: const BorderRadius.all(Radius.circular(100)),
                              ),
                              child:  Icon(Icons.supervised_user_circle_sharp, size: 140, color: colorController.kDarkGreyColor),
                            ),
                          ] else ...[
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2, color: colorController.kPrimaryDarkColor),
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Image(
                                  width: 140,
                                  height: 140,
                                  image: FileImage(_controller.selectedGroupIconFile!),
                                ),
                              ),
                            ),
                          ],
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
                              child: const Icon(AntDesign.edit),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace24,
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    controller: _controller.groupNameController,
                    validator: (_groupName) => _groupName!.isEmpty ? kMsgGroupNameIsRequired : null,
                    decoration: const InputDecoration(labelText: kGroupName, hintText: kEnterGroupName),
                  ),
                  verticalSpace6,
                  // calling update group name icon method
                  PrimaryButton(text: kUpdateGroupDetails, onPressed: () => _controller.updateGroupNameIcon()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
