// Created By Amit Jangid 22/10/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/e_note_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/no_files_found.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/pie_chart_legends.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/e_note_sheet_controllers/e_note_sheet_chart_controller.dart';

import '../../../styles/color_controller.dart';

class ENoteSheetChartScreen extends StatelessWidget {
  const ENoteSheetChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar: CustomAppBar(title: kENoteSheetChart),
      body: GetBuilder<ENoteSheetChartController>(
        id: kENoteSheetChart,
        init: ENoteSheetChartController(),
        builder: (_eNoteSheetChartController) {
          return Column(
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
                      value: _eNoteSheetChartController.userType,
                      // calling on inbox type selected method
                      onChanged: _eNoteSheetChartController.onUserTypeSelected,
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
                    if (_eNoteSheetChartController.userType ==
                        kSubOrdinate) ...[
                      verticalSpace12,
                      DropdownButtonFormField<ReportingEmp>(
                        value: _eNoteSheetChartController.selectedReportingEmp,
                        hint: Text(kSelectEmployee, style: textStyle14Normal),
                        // calling on sub ordinated selected method
                        onChanged:
                            _eNoteSheetChartController.onSubOrdinateSelected,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                width: 2,
                                color: colorController.kBlackShadeColor),
                          ),
                        ),
                        items: _eNoteSheetChartController.reportingEmpList
                            .map((ReportingEmp _reportingEmp) =>
                                DropdownMenuItem<ReportingEmp>(
                                    value: _reportingEmp,
                                    child: Text(_reportingEmp.empName!,
                                        style: textStyle14Normal)))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
              if (_eNoteSheetChartController.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_eNoteSheetChartController.eNoteSheetInbox == null &&
                  _eNoteSheetChartController.eNoteSheetSentBox == null) ...[
                const Expanded(child: NoFilesFound()),
              ] else ...[
                verticalSpace12,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _ENoteSheetChart(
                          title: kENoteSheetInbox,
                          eNoteSheetChartController: _eNoteSheetChartController,
                          openCount: _eNoteSheetChartController
                                  .eNoteSheetInbox?.openCount ??
                              0,
                          closeCount: _eNoteSheetChartController
                                  .eNoteSheetInbox?.closeCount ??
                              0,
                        ),
                        verticalSpace12,
                        _ENoteSheetChart(
                          title: kENoteSheetSentBox,
                          eNoteSheetChartController: _eNoteSheetChartController,
                          openCount: _eNoteSheetChartController
                                  .eNoteSheetSentBox?.openCount ??
                              0,
                          closeCount: _eNoteSheetChartController
                                  .eNoteSheetSentBox?.closeCount ??
                              0,
                        ),
                        verticalSpace48,
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ENoteSheetChart extends StatelessWidget {
  final String title;
  final int openCount, closeCount;
  final ENoteSheetChartController eNoteSheetChartController;

  const _ENoteSheetChart({
    Key? key,
    required this.title,
    required this.openCount,
    required this.closeCount,
    required this.eNoteSheetChartController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ColorController colorController = Get.put(ColorController());
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (colorController) {
          return MaterialCard(
            borderRadius: 12,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: textStyle18Bold.copyWith(
                        color: colorController.kBgColor)),
                verticalSpace24,
                Row(
                  children: [
                    PieChartLegends(
                        color: colorController.kPrimaryColor,
                        legendTitle: kOpen),
                    horizontalSpace12,
                    PieChartLegends(
                        color: colorController.kchartcloseColor,
                        legendTitle: kClose),
                  ],
                ),
                verticalSpace12,
                if (openCount > 0 || closeCount > 0) ...[
                  AspectRatio(
                    aspectRatio: 1,
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        PieSeries<ENoteSheetData, String>(
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (ENoteSheetData _eNoteSheetData, _) =>
                              _eNoteSheetData.title,
                          yValueMapper: (ENoteSheetData _eNoteSheetData, _) =>
                              _eNoteSheetData.count,
                          pointColorMapper:
                              (ENoteSheetData _eNoteSheetData, _) =>
                                  _eNoteSheetData.color,
                          dataSource: [
                            ENoteSheetData(
                                title: kOpen,
                                color: colorController.kPrimaryColor,
                                count: openCount),
                            ENoteSheetData(
                                title: kClosed,
                                count: closeCount,
                                color: colorController.kchartcloseColor),
                          ],
                          onPointTap:
                              (ChartPointDetails pointInteractionDetails) {
                            late String _status, _partUrl;

                            if (pointInteractionDetails.pointIndex == 0) {
                              _status = kOpen;
                            } else if (pointInteractionDetails.pointIndex ==
                                1) {
                              _status = kClosed;
                            }

                            if (title == kENoteSheetInbox) {
                              _partUrl = 'get_inboxcountdetails';
                            } else {
                              _partUrl = 'get_sentboxcountdetails';
                            }

                            Get.toNamed(
                              kENoteSheetChartDetailsRoute,
                              arguments: {
                                kTitle: title,
                                kStatus: _status,
                                kPartUrl: _partUrl,
                                kType: eNoteSheetChartController.selectedType,
                                kCpfNo:
                                    eNoteSheetChartController.selectedCpfNumber,
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  verticalSpace12,
                  const NoFilesFound(),
                ],
              ],
            ),
          );
        });
  }
}
