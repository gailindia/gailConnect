// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/fms_mail.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class FmsMailBoxWidget extends StatelessWidget {
  final bool isOutBox;
  final List<FmsMail> fmsMailBoxList;

  const FmsMailBoxWidget({Key? key, this.isOutBox = false, required this.fmsMailBoxList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Column(
      children: [
        verticalSpace12,
        Expanded(
          child: ListView.builder(
            itemCount: fmsMailBoxList.length,
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36),
            itemBuilder: (context, _position) {
              final FmsMail _fmsInbox = fmsMailBoxList[_position];

              return MaterialCard(
                borderRadius: 12,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(vertical: 6),
                onTap: () => Get.toNamed(kFmsDetailRoute, arguments: _fmsInbox.id),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: RichTextWidget(
                        caption: kFileId,
                        textAlign: TextAlign.center,
                        description: _fmsInbox.fileNo!,
                        captionStyle: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
                        descriptionStyle: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
                      ),
                    ),
                     Divider(height: 1, color: colorController.kPrimaryDarkColor),
                    verticalSpace12,
                    HeadingRowItem(caption: kSubject, desc: _fmsInbox.subject!,icon: "",),
                    if (!isOutBox) ...[
                      HeadingRowItem(caption: kReceivedDate, desc: _fmsInbox.receivedDate ?? '',icon: "",),
                    ] else ...[
                      HeadingRowItem(caption: kSentTo, desc: _fmsInbox.presentlyWith ?? '',icon: "",),
                    ],
                    verticalSpace6,
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
