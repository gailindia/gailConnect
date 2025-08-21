// Created By Amit Jangid 22/10/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/logo_widget.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/ui/widgets/material_indicator.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/e_note_sheet_screens/e_note_sheet_sent_box_screen.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/e_note_sheet_screens/e_note_sheet_inbox_screen.dart';
import 'package:gail_connect/ui/screens/dashboard_screens/e_note_sheet_screens/e_note_sheet_search_screen.dart';

class ENoteSheetBoxScreen extends StatelessWidget {
  const ENoteSheetBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(children: [
          ENoteSheetInboxScreen(),
          ENoteSheetSentBoxScreen(),
          ENoteSheetSearchScreen()
        ]),
        appBar: AppBar(
          backgroundColor: colorController.kPrimaryColor,
          elevation: 4,
          titleSpacing: 0,
          title: InkWell(
            onTap: () => Get.offNamedUntil(kMainDashRoute, (route) => false),
            child: Row(
              children: [
                const LogoWidget(height: 36),
                horizontalSpace6,
                Expanded(
                    child: Text(kENoteSheet,
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
