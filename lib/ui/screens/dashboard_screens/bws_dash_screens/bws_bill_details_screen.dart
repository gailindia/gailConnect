// Created By Amit Jangid 20/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/models/bws_bill_details.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/ui/widgets/table_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/bws_no_records_found.dart';
import 'package:gail_connect/core/controllers/dash_controllers/bws_controllers/bws_bill_details_controller.dart';

import '../../../styles/color_controller.dart';

class BwsBillDetailsScreen extends StatelessWidget {
  const BwsBillDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar:  CustomAppBar(title: kBillWatchSystem),
      body: GetBuilder<BwsBillDetailsController>(
        id: kBillDetailsSystem,
        init: BwsBillDetailsController(),
        builder: (_bwsBillDetailsController) => Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingRowItem(
                caption: kReceiptNo,
                desc: _bwsBillDetailsController.bwsDashDetails.receiptNo!,
                icon: "",
                padding: const EdgeInsets.only(top: 6, left: 2, right: 6),
              ),
              HeadingRowItem(
                caption: kBillNo,
                desc: _bwsBillDetailsController.bwsDashDetails.invoiceNo!,
                icon: "",
                padding: const EdgeInsets.only(top: 12, left: 2, right: 6),
              ),
              if (_bwsBillDetailsController.isLoading) ...[
                const Expanded(child: LoadingWidget(margin: EdgeInsets.only(left: 3, right: 3, bottom: 12))),
              ] else if (_bwsBillDetailsController.bwsBillDetailsList.isNotEmpty) ...[
                verticalSpace12,
                Expanded(
                  child: Column(
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
                              TableTitle(title: kForwardedBy),
                              TableTitle(title: kForwardingDate),
                              TableTitle(title: kReason),
                              TableTitle(title: kReceivedBy),
                              TableTitle(title: kReceivingDate, showRightBorder: false),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 36),
                          itemCount: _bwsBillDetailsController.bwsBillDetailsList.length,
                          itemBuilder: (context, _position) {
                            final BwsBillDetails _bwsBillDetails =
                                _bwsBillDetailsController.bwsBillDetailsList[_position];

                            return Container(
                              decoration: const BoxDecoration(
                                border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
                              ),
                              child: Row(
                                children: [
                                  TableContent(description: _bwsBillDetails.forwardedBy!),
                                  TableContent(description: _bwsBillDetails.forwardedDate!),
                                  TableContent(description: _bwsBillDetails.reason!),
                                  TableContent(description: _bwsBillDetails.receivedBy!),
                                  TableContent(description: _bwsBillDetails.receivedDate!, showRightBorder: false),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                const Expanded(child: BwsNoRecordsFound()),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
