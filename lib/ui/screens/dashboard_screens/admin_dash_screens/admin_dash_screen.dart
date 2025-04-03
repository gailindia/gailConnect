// Created By Amit Jangid on 15/12/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/assets_icon_widget.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/admin_controllers/admin_dash_controller.dart';

import '../../../styles/color_controller.dart';

class AdminDashScreen extends StatelessWidget {
  const AdminDashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar: CustomAppBar(title: kAdminDashboard),
      body: GetBuilder<AdminDashController>(
        id: kAdminDashboard,
        init: AdminDashController(),
        builder: (_controller) {
          return Row(
            children: [
              AssetsIconWidget(
                title: kUtilization,
                iconColor: colorController.kPrimaryColor,
                showIconColor: false,
                iconName: kIconPieChart,
                scale: _controller.carouselAnimation,
                onTap: () => Get.toNamed(kUtilizationRoute),
              ),
              horizontalSpace12,
              AssetsIconWidget(
                title: kEmpNotHavingApp,
                iconColor: colorController.kPrimaryColor,
                iconName: kIconStatistics,
                scale: _controller.carouselAnimation,
                // onTap: () => Get.toNamed(kEmpNotHavingAppRoute),
                onTap: () => Get.toNamed(kEmpNotHavingAppRouteCount),
              ),
            ],
          ).paddingAll(12);
        },
      ),
    );
  }
}
