// Created By Amit Jangid 29/10/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/ui/widgets/table_widget.dart';
import 'package:multiutillib/utils/date_time_extension.dart';
import 'package:gail_connect/models/e_note_sheet_details.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

import '../../styles/color_controller.dart';

class ENoteSheetInboxList extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final List<ENoteSheetDetails> eNoteSheetInboxList;

  const ENoteSheetInboxList({
    Key? key,
    required this.eNoteSheetInboxList,
    this.padding = const EdgeInsets.only(top: 12, left: 12, right: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());//colorController.
    return Expanded(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    TableTitle(flex: 1, title: kSNo),
                    TableTitle(title: kENoteSheetNo),
                    TableTitle(title: kReceivedFrom),
                    TableTitle(title: kReceivedOn, showRightBorder: false),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: eNoteSheetInboxList.length,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 48),
                itemBuilder: (context, _position) {
                  final ENoteSheetDetails _eNoteSheetDetails = eNoteSheetInboxList[_position];

                  return InkWell(
                    onTap: () => Get.toNamed(
                      kENoteSheetFullDetailsRoute,
                      arguments: {kTitle: kENoteSheetInboxDetails, kFileId: _eNoteSheetDetails.fileId},
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
                      ),
                      child: Row(
                        children: [
                          TableContent(flex: 1, description: '${_position + 1}'),
                          TableContent(showLink: true, description: _eNoteSheetDetails.fileNo!),
                          TableContent(description: _eNoteSheetDetails.receivedFrom!),
                          TableContent(
                            showRightBorder: false,
                            description: _eNoteSheetDetails.receivedOn!
                                .formatDateTime(newDateTimeFormat: kFullDateTimeFormat)
                                .replaceFirst(' ', '\n'),
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
      ),
    );
  }
}
