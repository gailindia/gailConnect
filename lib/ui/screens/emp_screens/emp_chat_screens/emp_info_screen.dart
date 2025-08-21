// Created By Amit Jangid on 28/12/21

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_info_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';

class EmpInfoScreen extends StatelessWidget {
  const EmpInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: kEmployeeDetails),
      body: GetBuilder<EmpInfoController>(
        id: kEmployeeDetails,
        init: EmpInfoController(),
        builder: (_controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 48),
            child: MaterialCard(
              borderRadius: 12,
              margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircularNetworkImageWidget(
                    imageWidth: 140,
                    imageHeight: 140,
                    imageUrl: _controller.chatUser.profileUrl,
                  ),
                  verticalSpace18,
                  Center(child: Text(_controller.chatUser.name, style: textStyle20Bold)),
                  verticalSpace6,
                  Center(
                    child: RichTextWidget(
                      caption: kCpfNo,
                      captionStyle: textStyle13Bold,
                      descriptionStyle: textStyle13Normal,
                      description: _controller.chatUser.cpf,
                    ),
                  ),
                  Center(
                    child: RichTextWidget(
                      caption: kEmailId,
                      captionStyle: textStyle13Bold,
                      descriptionStyle: textStyle13Normal,
                      description: _controller.chatUser.email,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
