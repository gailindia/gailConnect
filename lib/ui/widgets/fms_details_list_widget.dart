// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/models/fms_detail.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/ui/widgets/table_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class FmsDetailsListWidget extends StatelessWidget {
  final List<FmsDetail> fmsDetailsList;

  const FmsDetailsListWidget({Key? key, required this.fmsDetailsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return MaterialCard(
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(),
      child: Column(
        children: [
          verticalSpace6,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: RichTextWidget(
              caption: kFileId,
              textAlign: TextAlign.center,
              description: fmsDetailsList[0].id!,
              captionStyle: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
              descriptionStyle: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
            ),
          ),
           Divider(height: 1, color: colorController.kPrimaryDarkColor),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeadingRowItem(caption: kFileNo, desc: fmsDetailsList[0].fileNo!,icon: "",),
                  HeadingRowItem(caption: kSubject, desc: fmsDetailsList[0].subject!,icon: "",),
                  verticalSpace12,
                  Container(
                    margin: const EdgeInsets.only(left: 6, right: 6),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              TableTitle(title: kSender),
                              TableTitle(title: kActionTaken),
                              TableTitle(title: kSentTo),
                              TableTitle(title: kSentFor),
                              TableTitle(title: kReceivedDate, showRightBorder: false),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: fmsDetailsList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, _position) {
                              final FmsDetail _fmsDetails = fmsDetailsList[_position];

                              return Container(
                                decoration: const BoxDecoration(border: Border(top: BorderSide())),
                                child: Row(
                                  children: [
                                    TableContent(description: _fmsDetails.sender!),
                                    TableContent(description: _fmsDetails.actionTakenCode!),
                                    TableContent(description: _fmsDetails.receiver!),
                                    TableContent(description: _fmsDetails.sentFor!),
                                    TableContent(description: _fmsDetails.recDate!, showRightBorder: false),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace12,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
