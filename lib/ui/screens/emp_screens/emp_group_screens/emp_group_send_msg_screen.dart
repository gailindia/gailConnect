// Created By Amit Jangid on 21/12/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/emp_group_details_controller.dart';

import '../../../styles/color_controller.dart';

class EmpGroupSendMsgScreen extends StatelessWidget {
  const EmpGroupSendMsgScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return GetBuilder<EmpGroupDetailsController>(
      id: kGroupDetails,
      init: EmpGroupDetailsController(),
      builder: (_controller) {
        return Scaffold(
          appBar: CustomAppBar(isEmpGroupSendMsgScreen: true, title: _controller.empGroup?.groupName ?? kGroupDetails),
          body: _controller.isLoading
              ? const LoadingWidget()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Form(
                    key: _controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          maxLines: 12,
                          autocorrect: false,
                          controller: _controller.messageController,
                          textAlignVertical: TextAlignVertical.center,
                          validator: (_message) => _message!.isEmpty ? kMsgMessageIsRequired : null,
                          decoration: const InputDecoration(
                            hintText: kEnterMessage,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                        verticalSpace12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              // calling send message method
                              onTap: _controller.sendMessage,
                              child: Container(
                                margin: const EdgeInsets.only(),
                                padding: const EdgeInsets.only(),
                                decoration:  BoxDecoration(shape: BoxShape.circle, color: colorController.kPrimaryDarkColor),
                                child: const Icon(FontAwesome5Solid.sms, size: 36).marginAll(18),
                              ),
                            ),
                            horizontalSpace12,
                            InkWell(
                              // calling send email method
                              onTap: _controller.sendEmail,
                              child: Container(
                                margin: const EdgeInsets.only(),
                                padding: const EdgeInsets.only(),
                                decoration:  BoxDecoration(shape: BoxShape.circle, color: colorController.kPrimaryDarkColor),
                                child: const Icon(Zocial.email, size: 36).marginAll(18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
