// Created By Amit Jangid 05/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/areas.dart';
import 'package:gail_connect/models/types.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/bis_report.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/bis_helpdesk_controllers/bis_helpdesk_controller.dart';

class BISHelpdeskDashScreen extends StatelessWidget {
  const BISHelpdeskDashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController controller = Get.put(ColorController());
    return Scaffold(
      backgroundColor: controller.kHomeBgColor,
      appBar:  CustomAppBar(title: kBISHelpdesk),
      body: GetBuilder<BISHelpdeskController>(
        id: kBISHelpdesk,
        init: BISHelpdeskController(),
        builder: (_controller) => SingleChildScrollView(
          controller: _controller.scrollController,
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialCard(
                borderRadius: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _controller.fromDateController,
                            // calling show date picker method method
                            onTap: () => _controller.showDatePickerDialog(),
                            decoration: const InputDecoration(labelText: kFromDate),
                          ),
                        ),
                        horizontalSpace12,
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _controller.toDateController,
                            decoration: const InputDecoration(labelText: kToDate),
                            // calling show date picker method method
                            onTap: () => _controller.showDatePickerDialog(isEndDate: true),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace12,
                    Row(
                      children: [
                         Expanded(child: Text('$kArea *', style: textStyle14Bold)),
                        horizontalSpace6,
                        Expanded(
                          flex: 3,
                          child: DropdownSearch<Areas>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: kSelectArea,
                                hintText: kSelectArea,
                              ),
                            ),
                            items: _controller.areasList,
                            itemAsString: (Areas? _area) => _area!.areaName,
                            onChanged: (Areas? _area) => _controller.onAreaSelected(area: _area),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace12,
                    Row(
                      children: [
                         Expanded(child: Text(kType, style: textStyle14Bold)),
                        horizontalSpace6,
                        Expanded(
                          flex: 3,
                          child: DropdownSearch<Types>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: kSelectType,
                                hintText: kSelectType,
                              ),
                            ),
                            items: _controller.typesList,
                            itemAsString: (Types? _type) => _type!.typeName,
                            onChanged: (Types? _types) => _controller.onTypesSelected(_types),
                          ),
                        ),
                      ],
                    ),
                    // calling get reports list method
                    PrimaryButton(text: kSearch, onPressed: () => _controller.getReportsCount()),
                  ],
                ),
              ),
              if (_controller.isLoading) ...[
                const LoadingWidget(margin: EdgeInsets.only(top: 12)),
              ] else ...[
                if (_controller.openClosedPendingCallsList.isNotEmpty) ...[
                  MaterialCard(
                    borderRadius: 12,
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: _controller.openClosedPendingCallsList
                              .map(
                                (BISReportData _bisReportData) => Row(
                                  children: [
                                    Container(width: 18, height: 12, color: _bisReportData.color),
                                    horizontalSpace6,
                                    Text(_bisReportData.title),
                                  ],
                                ).paddingOnly(top: 6, left: 12, right: 12),
                              )
                              .toList(),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: SfCircularChart(
                            // tooltipBehavior: _controller.tooltip,
                            series: <CircularSeries>[
                              DoughnutSeries<BISReportData, String>(
                                radius: "90%",
                                dataSource: _controller.openClosedPendingCallsList,
                                xValueMapper: (BISReportData data, _) => data.title,
                                yValueMapper: (BISReportData data, _) => data.count,
                                pointColorMapper: (BISReportData data, _) => data.color,
                                dataLabelSettings: const DataLabelSettings(isVisible: true),
                                onPointTap: (ChartPointDetails pointInteractionDetails) {
                                  debugPrint('point index value is: ${pointInteractionDetails.pointIndex}');

                                  // calling on open calls section pressed method
                                  _controller.onOpenCallsSectionPressed(pointInteractionDetails.pointIndex!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (_controller.allOpenCallsList.isNotEmpty) ...[
                  MaterialCard(
                    borderRadius: 12,
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: _controller.allOpenCallsList
                              .map(
                                (BISReportData _bisReportData) => Row(
                                  children: [
                                    Container(width: 18, height: 12, color: _bisReportData.color),
                                    horizontalSpace6,
                                    Text(_bisReportData.title),
                                  ],
                                ).paddingOnly(top: 6, left: 12, right: 12),
                              )
                              .toList(),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: SfCircularChart(
                            // tooltipBehavior: _controller.tooltip,
                            series: <CircularSeries>[
                              RadialBarSeries<BISReportData, String>(
                                radius: "90%",
                                maximumValue: 10,
                                cornerStyle: CornerStyle.bothCurve,
                                dataSource: _controller.allOpenCallsList,
                                xValueMapper: (BISReportData data, _) => data.title,
                                yValueMapper: (BISReportData data, _) => data.count,
                                pointColorMapper: (BISReportData data, _) => data.color,
                                dataLabelSettings: const DataLabelSettings(isVisible: true),
                                onPointTap: (ChartPointDetails pointInteractionDetails) {
                                  debugPrint('point index value is: ${pointInteractionDetails.pointIndex}');

                                  if (pointInteractionDetails.pointIndex == 0) {
                                    // calling on report type selected method
                                    _controller.onReportTypeSelected(
                                      reportType: 'Previousopencalls',
                                      screenTitle: kPreviousOpenCallDetails,
                                    );
                                  } else {
                                    // calling on report type selected method
                                    _controller.onReportTypeSelected(
                                      reportType: 'CallsLoggedDuringPeriod',
                                      screenTitle: kCallsLoggedDuringPeriodDetails,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (_controller.allPendingCallsList.isNotEmpty) ...[
                  MaterialCard(
                    borderRadius: 12,
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: _controller.allPendingCallsList
                              .map(
                                (BISReportData _bisReportData) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width: 16, height: 12, color: _bisReportData.color),
                                    horizontalSpace6,
                                    Text('${_bisReportData.count} - '),
                                    Expanded(child: Text(_bisReportData.title)),
                                  ],
                                ).paddingOnly(top: 6, left: 12, right: 12),
                              )
                              .toList(),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: SfCircularChart(
                            // tooltipBehavior: _controller.tooltip,
                            series: <CircularSeries>[
                              RadialBarSeries<BISReportData, String>(
                                radius: "90%",
                                maximumValue: 10,
                                innerRadius: "0%",
                                cornerStyle: CornerStyle.bothCurve,
                                dataSource: _controller.allPendingCallsList,
                                xValueMapper: (BISReportData data, _) => data.title,
                                yValueMapper: (BISReportData data, _) => data.count,
                                pointColorMapper: (BISReportData data, _) => data.color,
                                dataLabelSettings: const DataLabelSettings(isVisible: true),
                                onPointTap: (ChartPointDetails pointInteractionDetails) {
                                  debugPrint('point index value is: ${pointInteractionDetails.pointIndex}');

                                  // calling on pending calls section pressed method
                                  _controller.onPendingCallsSectionPressed(pointInteractionDetails.pointIndex!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*MaterialCard(
                      borderRadius: 12,
                      padding: const EdgeInsets.only(top: 12, bottom: 6),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // tooltipBehavior: _controller.tooltip,
                              series: <ChartSeries>[
                                ColumnSeries<BISReportData, String>(
                                  dataSource: _controller.allPendingCallsList,
                                  yValueMapper: (BISReportData data, _) => data.count,
                                  xValueMapper: (BISReportData data, _) => data.axisTitle,
                                  pointColorMapper: (BISReportData data, _) => data.color,
                                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                                  onPointTap: (ChartPointDetails pointInteractionDetails) {
                                    debugPrint('point index value is: ${pointInteractionDetails.pointIndex}');

                                    // calling on other calls pressed method
                                    _controller.onPendingCallsItemPressed(pointInteractionDetails.pointIndex!);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: _controller.otherCallsList
                                .map(
                                  (BISReportData _bisReportData) => Row(
                                    children: [
                                      Container(width: 18, height: 12, color: _bisReportData.color),
                                      horizontalSpace6,
                                      Text('${_bisReportData.axisTitle} - ${_bisReportData.title}'),
                                    ],
                                  ).paddingSymmetric(vertical: 6, horizontal: 12),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),*/
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

