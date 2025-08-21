// Created By Amit Jangid 21/10/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/no_files_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/e_note_sheet/e_note_sheet_inbox_list.dart';
import 'package:gail_connect/core/controllers/dash_controllers/e_note_sheet_controllers/e_note_sheet_inbox_controller.dart';

import '../../../styles/color_controller.dart';

class ENoteSheetInboxScreen extends StatelessWidget {
  const ENoteSheetInboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      body: GetBuilder<ENoteSheetInboxController>(
        id: kENoteSheetInbox,
        init: ENoteSheetInboxController(),
        builder: (_eNoteSheetInboxController) {
          return Scaffold(
            backgroundColor: colorController.kHomeBgColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MaterialCard(
                  borderRadius: 12,
                  margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Column(
                    children: [
                      Text(kENoteSheetInbox,
                          style: textStyle20Bold, textAlign: TextAlign.center),
                      verticalSpace12,
                      DropdownButtonFormField(
                        isExpanded: true,
                        value: _eNoteSheetInboxController.userType,
                        // calling on inbox type selected method
                        onChanged:
                            _eNoteSheetInboxController.onUserTypeSelected,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                width: 2,
                                color: colorController.kBlackShadeColor),
                          ),
                        ),
                        items: [kSelf, kSubOrdinate]
                            .map((String _value) => DropdownMenuItem(
                                value: _value,
                                child: Text(_value, style: textStyle14Normal)))
                            .toList(),
                      ),
                      if (_eNoteSheetInboxController.userType ==
                          kSubOrdinate) ...[
                        verticalSpace12,
                        DropdownButtonFormField<ReportingEmp>(
                          value:
                              _eNoteSheetInboxController.selectedReportingEmp,
                          hint: Text(kSelectEmployee, style: textStyle14Normal),
                          // calling on sub ordinated selected method
                          onChanged:
                              _eNoteSheetInboxController.onSubOrdinateSelected,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: colorController.kBlackShadeColor),
                            ),
                          ),
                          items: _eNoteSheetInboxController.reportingEmpList
                              .map((ReportingEmp _reportingEmp) =>
                                  DropdownMenuItem<ReportingEmp>(
                                      value: _reportingEmp,
                                      child: Text(_reportingEmp.empName!,
                                          style: textStyle14Normal)))
                              .toList(),
                        ),
                      ],
                      verticalSpace12,
                      Row(
                        children: [
                          Text(kStatus,
                              style: textStyle16Normal,
                              textAlign: TextAlign.center),
                          horizontalSpace12,
                          Expanded(
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              value: _eNoteSheetInboxController.selectedStatus,
                              hint: Text(kStatus, style: textStyle14Normal),
                              // calling on inbox type selected method
                              onChanged: _eNoteSheetInboxController
                                  .onENoteStatusSelected,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: colorController.kBlackShadeColor),
                                ),
                              ),
                              items: [kOpen, kClosed]
                                  .map((String _value) => DropdownMenuItem(
                                      value: _value,
                                      child: Text(_value,
                                          style: textStyle14Normal)))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_eNoteSheetInboxController.isLoading) ...[
                  const Expanded(
                      child: SingleChildScrollView(child: LoadingWidget())),
                ] else if (_eNoteSheetInboxController
                    .eNoteSheetInboxList.isNotEmpty) ...[
                  ENoteSheetInboxList(
                      eNoteSheetInboxList:
                          _eNoteSheetInboxController.eNoteSheetInboxList),
                ] else ...[
                  verticalSpace24,
                  const Expanded(child: NoFilesFound()),
                  verticalSpace24,
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

/*class _PieChartLegends extends StatelessWidget {
  final Color color;
  final String legendTitle;

  const _PieChartLegends({Key? key, required this.color, required this.legendTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 30, height: 18, color: color),
        horizontalSpace6,
        Text(legendTitle, style: textStyle14Normal),
      ],
    );
  }
}*/

/*if (_eNoteSheetInboxController.isLoading) {
  return const LoadingWidget();
} else if (_eNoteSheetInboxController.eNoteSheet != null) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      MaterialCard(
        borderRadius: 12,
        margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Column(
          children: [
            const Text(kENoteSheetInbox, style: textStyle20Bold, textAlign: TextAlign.center),
            DropdownButtonFormField(
              isExpanded: true,
              value: _eNoteSheetInboxController.selectedStatus,
              // calling on inbox type selected method
              onChanged: _eNoteSheetInboxController.onENoteStatusSelected,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 2, color: colorController.kBlackShadeColor),
                ),
              ),
              items: [kOpen, kClosed]
                  .map((String _value) =>
                      DropdownMenuItem(value: _value, child: Text(_value, style: textStyle14Normal)))
                  .toList(),
            ),
          ],
        ),
      ),
      Padding(
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
                    TableTitle(title: kFileNo),
                    TableTitle(title: kReceivedFrom),
                    TableTitle(title: kReceivedOn, showRightBorder: false),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 48),
                itemCount: _eNoteSheetInboxController.eNoteSheetInboxList.length,
                itemBuilder: (context, _position) {
                  final ENoteSheetDetails _eNoteSheetDetails =
                      _eNoteSheetInboxController.eNoteSheetInboxList[_position];

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
      */ /*Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          children: [
            CountCard(
              title: kOpen,
              color: kRedColor,
              count: _eNoteSheetInboxController.eNoteSheet!.openCount,
              onTap: () {
                if (_eNoteSheetInboxController.eNoteSheet!.openCount > 0) {
                  Get.toNamed(
                    kENoteSheetDetailsRoute,
                    arguments: {
                      kStatus: kOpen,
                      kTitle: kENoteSheetInbox,
                      kPartUrl: 'get_inboxcountdetails',
                    },
                  );
                }
              },
            ),
            CountCard(
              title: kClose,
              color: kGreenColor,
              count: _eNoteSheetInboxController.eNoteSheet!.closeCount,
              onTap: () {
                if (_eNoteSheetInboxController.eNoteSheet!.closeCount > 0) {
                  Get.toNamed(
                    kENoteSheetDetailsRoute,
                    arguments: {
                      kStatus: kClosed,
                      kTitle: kENoteSheetInbox,
                      kPartUrl: 'get_inboxcountdetails',
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      MaterialCard(
        borderRadius: 12,
        margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Column(
          children: [
            Row(
              children: const [
                _PieChartLegends(color: kRedColor, legendTitle: kOpen),
                horizontalSpace12,
                _PieChartLegends(color: kGreenColor, legendTitle: kClose),
              ],
            ),
            verticalSpace12,
            SizedBox(
              height: 300,
              child: SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<ENoteSheetData, String>(
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    xValueMapper: (ENoteSheetData _bwsChartData, _) => _bwsChartData.title,
                    yValueMapper: (ENoteSheetData _bwsChartData, _) => _bwsChartData.count,
                    pointColorMapper: (ENoteSheetData _bwsChartData, _) => _bwsChartData.color,
                    */ /* */ /*onPointTap: (ChartPointDetails pointInteractionDetails) {
                      late String _status;

                      if (pointInteractionDetails.pointIndex == 0) {
                        _status = kOpen;
                      } else if (pointInteractionDetails.pointIndex == 1) {
                        _status = kClosed;
                      }

                      Get.toNamed(
                        kENoteSheetDetailsRoute,
                        arguments: {
                          kStatus: _status,
                          kTitle: kENoteSheetInboxDetails,
                          kPartUrl: 'get_inboxcountdetails',
                        },
                      );
                    },*/ /* */ /*
                    dataSource: [
                      ENoteSheetData(
                        title: kOpen,
                        color: kRedColor,
                        count: _eNoteSheetInboxController.eNoteSheet!.openCount,
                      ),
                      ENoteSheetData(
                        title: kClose,
                        color: kGreenColor,
                        count: _eNoteSheetInboxController.eNoteSheet!.closeCount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),*/ /*
    ],
  );
}

return const NoRecordsFound();*/
