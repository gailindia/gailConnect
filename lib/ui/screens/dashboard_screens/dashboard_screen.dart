// Created By Amit Jangid 16/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/assets_icon_widget.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/dash_controller.dart';

import '../../styles/color_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar: CustomAppBar(title: kDashboard),
      body: GetBuilder<DashController>(
        id: kFmsBwsDashboard,
        init: DashController(),
        builder: (_dashController) {
          return SingleChildScrollView(
            padding:
                const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 48),
            child: Column(
              children: [

                if (_dashController.isBISHelpdeskAdmin.toLowerCase() ==
                    kAdmin.toLowerCase() &&
                    _dashController.isDashboardAdmin) ...[
                  verticalSpace12,
                  Row(
                    children: [
                      _DashboardAdminTile(dashController: _dashController),
                      horizontalSpace12,
                      // const Expanded(child: SizedBox.shrink()),
                      AssetsIconWidget(
                        title: kInOuttime,
                        iconName: kIconInOutTime,
                        iconColor: colorController.kPrimaryColor,
                        padding: const EdgeInsets.all(18),
                        scale: _dashController.carouselAnimation,
                        onTap: () => Get.toNamed(kInOutTime),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DashboardAdminTile extends StatelessWidget {
  final DashController dashController;

  const _DashboardAdminTile({Key? key, required this.dashController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return AssetsIconWidget(
      title: kAdminDashboard,
      iconName: kIconAdminDash,
      iconColor: colorController.kPrimaryColor,
      padding: const EdgeInsets.all(18),
      scale: dashController.carouselAnimation,
      onTap: () => Get.toNamed(kAdminDashRoute),
    );
  }
}
