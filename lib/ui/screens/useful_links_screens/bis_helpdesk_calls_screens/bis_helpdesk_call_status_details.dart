// Created By Amit Jangid on 25/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/bis_helpdesk_calls_controllers/bis_helpdesk_call_status_details_controller.dart';
import 'package:gail_connect/models/attachment.dart';

import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/ui/widgets/hyper_link_text_widget.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';

import '../../../styles/color_controller.dart';

class BISHelpdeskCallStatusDetailsScreen extends StatelessWidget {
  const BISHelpdeskCallStatusDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return Scaffold(
      appBar:  CustomAppBar(title: kBISHelpdeskCallDetails),
      body: GetBuilder<BISHelpdeskCallStatusDetailsController>(
        id: kBISHelpdeskCallStatusDetails,
        init: BISHelpdeskCallStatusDetailsController(),
        builder: (_controller) {
          if (_controller.isLoading) {
            return const LoadingWidget();
          } else if (_controller.userCall != null) {
            final Color _callIdColor = (_controller.userCall!.status!.toString().toLowerCase() == kOpen.toLowerCase())
                ? colorController.kPrimaryColor
                : Colors.green;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MaterialCard(
                    borderRadius: 6,
                    padding: const EdgeInsets.only(),
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: RichTextWidget(
                            caption: kCallId,
                            textAlign: TextAlign.center,
                            description: _controller.userCall!.callId!,
                            captionStyle: textStyle18Bold.copyWith(color: _callIdColor),
                            descriptionStyle: textStyle18Bold.copyWith(color: _callIdColor),
                          ),
                        ),
                        const Divider(height: 1, color: Colors.black),
                        verticalSpace6,
                        HeadingRowItem(caption: kType, desc: _controller.userCall!.type!,icon: "",),
                        HeadingRowItem(caption: kDescription, desc: _controller.userCall!.desc!,icon: "",),
                        HeadingRowItem(caption: kLoggingDate, desc: _controller.userCall!.date!,icon: "",),
                        HeadingRowItem(caption: kStatus, desc: _controller.userCall!.status!,icon: "",),
                        if (_controller.userCall!.status!.toLowerCase() == kClose.toLowerCase() &&
                            _controller.userCall!.actionDate!.isNotEmpty) ...[
                          HeadingRowItem(caption: kClosedDate, desc: _controller.userCall!.actionDate!,icon: "",),
                          HeadingRowItem(caption: kRemarks, desc: _controller.userCall!.actionDesc!,icon: "",),
                        ],
                        verticalSpace12,
                      ],
                    ),
                  ),
                  if (_controller.userCall!.attachmentsList.isNotEmpty &&
                      _controller.userCall!.attachmentsList[0].fileName != null) ...[
                    MaterialCard(
                      borderRadius: 6,
                      padding: const EdgeInsets.only(),
                      margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                      child: Column(
                        children: [
                          verticalSpace12,
                           Text(kAttachments, style: textStyle18Bold),
                          verticalSpace12,
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                            itemCount: _controller.userCall?.attachmentsList.length,
                            itemBuilder: (context, _position) {
                              final Attachment _attachment = _controller.userCall!.attachmentsList[_position];

                              if (_attachment.fileName != null) {
                                return Row(
                                  children: [
                                    Text('${_position + 1}.', style: textStyle18Normal),
                                    Expanded(
                                      child: HyperLinkTextWidget(
                                        url: _attachment.fileName ?? '',
                                        text: '$kAttachment - ${_position + 1}',
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
