// Created By Amit Jangid 20/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/models/bws_dash_details.dart';
import 'package:gail_connect/ui/widgets/table_widget.dart';
import 'package:multiutillib/utils/date_time_extension.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/bws_no_records_found.dart';
import 'package:gail_connect/core/controllers/dash_controllers/bws_controllers/bws_dash_details_controller.dart';

import '../../../styles/color_controller.dart';

class BwsDashDetailsScreen extends StatelessWidget {
  const BwsDashDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    final _viewPadding = MediaQuery.of(context).viewPadding;
    debugPrint('bottom padding is: ${_viewPadding.bottom}');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar:  CustomAppBar(title: kBillWatchSystem),
      body: GetBuilder<BwsDashDetailsController>(
        id: kBillWatchSystem,
        init: BwsDashDetailsController(),
        builder: (_bwsDashDetailsController) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_bwsDashDetailsController.isLoading) ...[
              const LoadingWidget(),
            ] else if (_bwsDashDetailsController.bwsDashDetailsList.isNotEmpty) ...[
              Expanded(
                child: Column(
                  children: [
                    verticalSpace18,
                    Text(
                      _bwsDashDetailsController.selectedBillTitle!,
                      style: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
                    ),
                    verticalSpace18,
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: colorController.kPrimaryLightColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                        child: Row(
                          children: [
                            const TableTitle(title: kBillNumber),
                            const TableTitle(title: kBillDate),
                            const TableTitle(title: kBillAmount),
                            if (_bwsDashDetailsController.selectedBillTitle!.contains(kReturnedBills)) ...[
                              const TableTitle(title: kReturnedBy),
                              const TableTitle(title: kReturnedOn, showRightBorder: false),
                            ] else if (_bwsDashDetailsController.selectedBillTitle!.contains(kPendingBills)) ...[
                              const TableTitle(title: kPendingWith),
                              const TableTitle(title: kBillDueDate, showRightBorder: false),
                            ] else ...[
                              const TableTitle(title: kEntryDate, showRightBorder: false),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 36),
                        itemCount: _bwsDashDetailsController.bwsDashDetailsList.length,
                        itemBuilder: (context, _position) {
                          final BwsDashDetails _bwsDashDetails =
                              _bwsDashDetailsController.bwsDashDetailsList[_position];

                          return InkWell(
                            onTap: () => Get.toNamed(kBwsBillDetailRoute, arguments: _bwsDashDetails),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(left: BorderSide(), right: BorderSide(), bottom: BorderSide()),
                              ),
                              child: Row(
                                children: [
                                  TableContent(showLink: true, description: _bwsDashDetails.invoiceNo!),
                                  TableContent(description: _bwsDashDetails.invoiceDate!),
                                  TableContent(description: '${_bwsDashDetails.invoiceAmount}'),
                                  if (_bwsDashDetailsController.selectedBillTitle!
                                      .toLowerCase()
                                      .contains(kReturnedBills.toLowerCase())) ...[
                                    TableContent(description: _bwsDashDetails.empName!),
                                    TableContent(
                                      showRightBorder: false,
                                      description: _bwsDashDetails.transDate!
                                          .formatDateTime(newDateTimeFormat: kDateDisplayFormat),
                                    ),
                                  ] else if (_bwsDashDetailsController.selectedBillTitle!.contains(kPendingBills)) ...[
                                    TableContent(description: _bwsDashDetails.empName!),
                                    TableContent(
                                      showRightBorder: false,
                                      description: _bwsDashDetails.transDate!
                                          .formatDateTime(newDateTimeFormat: kDateDisplayFormat),
                                    ),
                                  ] else ...[
                                    TableContent(showRightBorder: false, description: _bwsDashDetails.dateOfEntry!),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ] else ...[
              const Padding(padding: EdgeInsets.only(top: 120), child: BwsNoRecordsFound()),
            ],
          ],
        ),
      ),
    );
  }
}
