// Created By Amit Jangid 22/10/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/no_files_found.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/e_note_sheet/e_note_sheet_inbox_list.dart';
import 'package:gail_connect/ui/widgets/e_note_sheet/e_note_sheet_sent_box_list.dart';
import 'package:gail_connect/core/controllers/dash_controllers/e_note_sheet_controllers/e_note_sheet_chart_details_controller.dart';

class ENoteSheetChartDetailsScreen extends StatelessWidget {
  const ENoteSheetChartDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ENoteSheetChartDetailsController>(
      id: kENoteSheetChartDetails,
      init: ENoteSheetChartDetailsController(),
      builder: (_eNoteController) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(title: _eNoteController.screenTitle ?? ''),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_eNoteController.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_eNoteController.eNoteSheetChartDetailsList.isNotEmpty) ...[
                if (_eNoteController.screenTitle == kENoteSheetInbox) ...[
                  ENoteSheetInboxList(
                    eNoteSheetInboxList: _eNoteController.eNoteSheetChartDetailsList,
                  ),
                ] else ...[
                  ENoteSheetSentBoxList(
                    eNoteSheetSentBoxList: _eNoteController.eNoteSheetChartDetailsList,
                  ),
                ]
              ] else ...[
                verticalSpace24,
                const Expanded(child: NoFilesFound()),
                verticalSpace24,
              ],
            ],
          ),
        );
      },
    );
  }
}

/*class ENoteSheetChartDetailsScreen extends StatelessWidget {
  const ENoteSheetChartDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: kENoteSheetChartDetails),
      body: GetBuilder<ENoteSheetChartDetailsController>(
        id: kENoteSheetChartDetails,
        init: ENoteSheetChartDetailsController(),
        builder: (_eNoteSheetChartDetailsController) {
          if (_eNoteSheetChartDetailsController.isLoading) {
            return const LoadingWidget();
          } else if (_eNoteSheetChartDetailsController.eNoteSheetChartDetailsList.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: kPrimaryLightColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                      child: Row(
                        children: const [
                          TableTitle(flex: 1, title: kSNo),
                          TableTitle(title: kENoteSheetNo),
                          TableTitle(title: kInitiator),
                          TableTitle(title: kSubject, showRightBorder: false),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 48),
                      itemCount: _eNoteSheetChartDetailsController.eNoteSheetChartDetailsList.length,
                      itemBuilder: (context, _position) {
                        final ENoteSheetChartDetails _eNoteSheetChartDetails =
                            _eNoteSheetChartDetailsController.eNoteSheetChartDetailsList[_position];

                        return InkWell(
                          onTap: () => Get.toNamed(
                            kENoteSheetFullDetailsRoute,
                            arguments: {kTitle: kENoteSheetInboxDetails, kFileId: _eNoteSheetChartDetails.fileId},
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
                            ),
                            child: Row(
                              children: [
                                TableContent(flex: 1, description: '${_position + 1}'),
                                TableContent(showLink: true, description: _eNoteSheetChartDetails.fileNo!),
                                TableContent(description: _eNoteSheetChartDetails.initiatorName!),
                                TableContent(
                                  trim: true,
                                  showRightBorder: false,
                                  description: _eNoteSheetChartDetails.fileSubject!,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const NoFilesFound();
        },
      ),
    );
  }
}*/
