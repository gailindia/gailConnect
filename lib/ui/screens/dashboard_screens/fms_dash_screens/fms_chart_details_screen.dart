// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/fms_mail.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/fms_no_records_found.dart';
import 'package:gail_connect/core/controllers/dash_controllers/fms_controllers/fms_chart_details_controller.dart';

import '../../../styles/color_controller.dart';

class FmsChartDetailsScreen extends StatelessWidget {
  const FmsChartDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return Scaffold(
      appBar:  CustomAppBar(title: kFmsDashboard),
      body: GetBuilder<FmsChartDetailsController>(
        id: kFmsChartDetails,
        init: FmsChartDetailsController(),
        builder: (_fmsChartDetailsController) {
          if (_fmsChartDetailsController.isLoading) {
            return const LoadingWidget();
          } else if (_fmsChartDetailsController.fmsChartDetailsList.isNotEmpty) {
            return ListView.builder(
              itemCount: _fmsChartDetailsController.fmsChartDetailsList.length,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36),
              itemBuilder: (context, _position) {
                final FmsMail _fmsInbox = _fmsChartDetailsController.fmsChartDetailsList[_position];

                return MaterialCard(
                  borderRadius: 12,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  onTap: () => Get.toNamed(kFmsDetailRoute, arguments: _fmsInbox.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: RichTextWidget(
                          caption: kFileId,
                          description: _fmsInbox.id!,
                          textAlign: TextAlign.center,
                          captionStyle: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
                          descriptionStyle: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
                        ),
                      ),
                       Divider(height: 1, color: colorController.kPrimaryDarkColor),
                      verticalSpace12,
                      HeadingRowItem(caption: kSubject, desc: _fmsInbox.subject!,icon: "",),
                      HeadingRowItem(caption: kPendingWith, desc: _fmsInbox.presentlyWith!,icon: "",),
                      verticalSpace6,
                    ],
                  ),
                );
              },
            );
          }

          return const FmsNoRecordsFound();
        },
      ),
    );
  }
}
