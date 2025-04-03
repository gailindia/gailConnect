// Created By Amit Jangid on 08/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:get/get.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/models/bis_report_details.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/bis_helpdesk_controllers/bis_helpdesk_details_controller.dart';

import '../../../styles/color_controller.dart';

class BISHelpdeskDetailsScreen extends StatelessWidget {
  const BISHelpdeskDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GetBuilder<BISHelpdeskDetailsController>(
      id: kBISHelpdeskDetails,
      init: BISHelpdeskDetailsController(),
      builder: (_controller) {
        return Scaffold(
          appBar: CustomAppBar(title: _controller.screenTitle),
          body: _controller.isLoading
              ? const LoadingWidget()
              : _controller.bisReportDetailsList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _controller.bisReportDetailsList.length,
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 48,
                      ),
                      itemBuilder: (context, _position) {
                        final BISReportDetails _bisReportDetails =
                            _controller.bisReportDetailsList[_position];

                        /*final Color _callIdColor = (_bisReportDetails.status!.toString().toLowerCase() == 'O'.toLowerCase())
                        ? kRedColor
                        : Colors.green;*/

                        return MaterialCard(
                          borderRadius: 12,
                          padding: const EdgeInsets.only(bottom: 12),
                          onTap: () => Get.toNamed(kBISHelpdeskCallDetailsRoute,
                              arguments: _bisReportDetails.callId!),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
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
                              // verticalDividerDark,
                              Divider(
                                  height: 2,
                                  color: colorController.kPrimaryDarkColor),
                              _bisReportDetails.userName != null
                                  ? HeadingRowItem(
                                      caption: kUsername,
                                      desc:
                                          '${_bisReportDetails.userName!}\n${_bisReportDetails.designation}',
                                      icon: "",
                                    )
                                  : HeadingRowItem(
                                      caption: kUsername,
                                      desc: 'FMS',
                                      icon: "",
                                    ),
                              HeadingRowItem(
                                maxLines: 3,
                                caption: kDescription,
                                overflow: TextOverflow.ellipsis,
                                desc: _bisReportDetails.description!,
                                icon: "",
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const NoRecordsFound(),
        );
      },
    );
  }
}
