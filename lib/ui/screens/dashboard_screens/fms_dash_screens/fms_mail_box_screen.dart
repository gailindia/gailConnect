// Created By Amit Jangid 16/09/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/fms_dash_screens/fms_inbox_screen.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/fms_dash_screens/fms_search_screen.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/fms_dash_screens/fms_outbox_screen.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/logo_widget.dart';
import 'package:gail_connect/ui/widgets/material_indicator.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';

class FmsMailBoxScreen extends StatelessWidget {
  const FmsMailBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        body: const TabBarView(
            children: [FmsInboxScreen(), FmsOutboxScreen(), FmsSearchScreen()]),
        appBar: AppBar(
          backgroundColor: colorController.kPrimaryColor,
          elevation: 4,
          titleSpacing: 0,
          title: InkWell(
            onTap: () => Get.offNamedUntil(kMainDashRoute, (route) => false),
            child: Row(
              children: [
                const LogoWidget(height: 36),
                horizontalSpace12,
                Expanded(
                    child: Text(kFmsDashboard,
                        maxLines: 2,
                        style: textStyle16Bold.copyWith(color: Colors.white))),
              ],
            ),
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon:
                Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          ),
          actions: [
            // calling sync emp list from server method
            IconButton(
              icon: const Icon(Ionicons.sync_sharp),
              onPressed: () => MainDashController.to.syncEmpListFromServer(),
            ),
            horizontalSpace12,
          ],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicator: MaterialIndicator(color: Colors.white),
            tabs: [
              Tab(icon: Icon(AntDesign.inbox)),
              Tab(icon: Icon(MaterialCommunityIcons.email_send_outline)),
              Tab(icon: Icon(Feather.search)),
            ],
          ),
        ),
      ),
    );
  }
}
