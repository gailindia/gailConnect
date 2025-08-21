// Created By Amit Jangid on 09/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/dash_controllers/bis_helpdesk_controllers/bis_helpdesk_call_details_controller.dart';
import 'package:gail_connect/models/bis_report_details.dart';
import 'package:gail_connect/models/engg_info.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/ui/widgets/table_widget.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

import '../../../styles/color_controller.dart';

class BISHelpdeskCallDetailsScreen extends StatelessWidget {
  const BISHelpdeskCallDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      appBar: CustomAppBar(title: kCallDetails),
      body: GetBuilder<BISHelpdeskCallDetailsController>(
        id: kBISHelpdeskCallDetails,
        init: BISHelpdeskCallDetailsController(),
        builder: (_controller) {
          if (_controller.isLoading) {
            return const LoadingWidget();
          } else if (_controller.bisReportCallDetails.isNotEmpty) {
            final BISReportDetails _bisReportDetails =
                _controller.bisReportCallDetails[0];

            return MaterialCard(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.only(),
              borderRadiusGeometry: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: RichTextWidget(
                      caption: kCallId,
                      textAlign: TextAlign.center,
                      description: _bisReportDetails.callId!,
                      captionStyle: textStyle18Bold.copyWith(
                          color: colorController.kPrimaryColor),
                      descriptionStyle: textStyle18Bold.copyWith(
                          color: colorController.kPrimaryColor),
                    ),
                  ),
                  Divider(height: 2, color: colorController.kPrimaryDarkColor),
                  // verticalDividerDark,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HeadingRowItem(
                            caption: kUsername,
                            desc:
                                '${_bisReportDetails.empName!}\n${_bisReportDetails.designation}',
                            icon: "",
                          ),
                          HeadingRowItem(
                            caption: kLogDate,
                            desc: _bisReportDetails.logDate!,
                            icon: "",
                          ),
                          HeadingRowItem(
                            caption: kArea,
                            desc: _bisReportDetails.areaName!,
                            icon: "",
                          ),
                          HeadingRowItem(
                            caption: kType,
                            desc: _bisReportDetails.typeName!,
                            icon: "",
                          ),
                          HeadingRowItem(
                            caption: kLocation,
                            desc: _bisReportDetails.userLocation!,
                            icon: "",
                          ),
                          HeadingRowItem(
                            caption: kUserState,
                            desc: _bisReportDetails.userState!,
                            icon: "",
                          ),
                          HeadingRowItem(
                            caption: kDescription,
                            desc: _bisReportDetails.description!,
                            icon: "",
                          ),
                          verticalSpace24,
                          Divider(
                              height: 2,
                              color: colorController.kPrimaryDarkColor),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: RichTextWidget(
                              caption: kEnggInfo,
                              textAlign: TextAlign.center,
                              description: _bisReportDetails.callId!,
                              captionStyle: textStyle18Bold.copyWith(
                                  color: colorController.kPrimaryColor),
                              descriptionStyle: textStyle18Bold.copyWith(
                                  color: colorController.kPrimaryColor),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: colorController.kPrimaryLightColor,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(5)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(5)),
                              child: Row(
                                children: const [
                                  TableTitle(flex: 1, title: kSNo),
                                  TableTitle(title: kEnggName),
                                  TableTitle(title: kActionDate),
                                  TableTitle(
                                      title: kActionDesc,
                                      showRightBorder: false),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 12),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _bisReportDetails.enggInfoList.length,
                            itemBuilder: (context, _position) {
                              final EnggInfo _enggInfo =
                                  _bisReportDetails.enggInfoList[_position];

                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(),
                                      right: BorderSide(),
                                      bottom: BorderSide()),
                                ),
                                child: Row(
                                  children: [
                                    TableContent(
                                        flex: 1,
                                        description: '${_position + 1}'),
                                    TableContent(
                                        description: _enggInfo.enggName!),
                                    TableContent(
                                        description: _enggInfo.actionDate!),
                                    TableContent(
                                        showRightBorder: false,
                                        description: _enggInfo.actionDesc!),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const NoRecordsFound();
        },
      ),
    );
  }
}
