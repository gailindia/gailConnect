// Created By Amit Jangid 21/10/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/ui/widgets/table_widget.dart';
import 'package:gail_connect/ui/widgets/no_files_found.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/models/e_note_sheet_by_file.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/e_note_sheet_controllers/e_note_sheet_full_details_controller.dart';

import '../../../styles/color_controller.dart';

class ENoteSheetFullDetailsScreen extends StatelessWidget {
  const ENoteSheetFullDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return GetBuilder<ENoteSheetFullDetailsController>(
      id: kENoteSheetFullDetails,
      init: ENoteSheetFullDetailsController(),
      builder: (_detailsController) {
        return Scaffold(
          appBar: CustomAppBar(title: _detailsController.screenTitle ?? ''),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_detailsController.isLoading) ...[
                  const LoadingWidget(),
                ] else if (_detailsController.eNoteSheetByFile != null) ...[
                  MaterialCard(
                    padding: const EdgeInsets.only(top: 12),
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    borderRadiusGeometry: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 12, right: 12),
                          child: Text(
                            _detailsController.eNoteSheetByFile!.fileNo!,
                            textAlign: TextAlign.center,
                            style: textStyle18Bold.copyWith(color: colorController.kPrimaryColor),
                          ),
                        ),
                        verticalSpace12,
                        // verticalDividerDark,
                        Divider(height: 2, color: colorController.kPrimaryDarkColor),
                        HeadingRowItem(
                          caption: kDateOfInitiation,
                          desc: _detailsController.eNoteSheetByFile!.dateOfInitiation!,
                          icon: "",
                        ),
                        HeadingRowItem(
                          caption: kInitiator,
                          desc: _detailsController.eNoteSheetByFile!.initiator!,
                          icon: "",
                        ),
                        HeadingRowItem(
                          caption: kSubject,
                          desc: _detailsController.eNoteSheetByFile!.subject!,
                          icon: "",
                        ),
                        verticalSpace24,
                        Divider(height: 2, color: colorController.kPrimaryDarkColor),
                        // verticalDividerDark,
                        verticalSpace12,
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 12, right: 12),
                          child: Text(
                            kENoteMovementDetails,
                            textAlign: TextAlign.center,
                            style: textStyle18Bold.copyWith(color: colorController.kPrimaryColor),
                          ),
                        ),
                        verticalSpace12,
                        if (_detailsController.eNoteSheetByFile!.fileMovementDetailsList.isNotEmpty) ...[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: colorController.kPrimaryLightColor,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                              child: Row(
                                children: const [
                                  TableTitle(title: kSentBy),
                                  TableTitle(title: kSentTo),
                                  TableTitle(title: kSentFor),
                                  TableTitle(title: kSentOn, showRightBorder: false),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _detailsController.eNoteSheetByFile!.fileMovementDetailsList.length,
                            itemBuilder: (context, _position) {
                              final FileMovementDetails _fileMovementDetails =
                                  _detailsController.eNoteSheetByFile!.fileMovementDetailsList[_position];

                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
                                ),
                                child: Row(
                                  children: [
                                    TableContent(height: 160, description: _fileMovementDetails.sentBy!),
                                    TableContent(height: 160, description: _fileMovementDetails.sentTo!),
                                    TableContent(height: 160, description: _fileMovementDetails.sentFor!),
                                    TableContent(
                                      height: 160,
                                      showRightBorder: false,
                                      description: _fileMovementDetails.sentOn!,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ] else ...[
                  const NoFilesFound(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
