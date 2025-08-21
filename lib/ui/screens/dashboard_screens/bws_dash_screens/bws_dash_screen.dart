// Created By Amit Jangid 16/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:gail_connect/models/bws_dash_count.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/count_card.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/pie_chart_legends.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/bws_no_records_found.dart';
import 'package:gail_connect/core/controllers/dash_controllers/bws_controllers/bws_dash_controller.dart';

import '../../../styles/color_controller.dart';

class BwsDashScreen extends StatelessWidget {
  const BwsDashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar:  CustomAppBar(title: kBwsDashboard),
      body: GetBuilder<BwsDashController>(
        id: kBwsDashboard,
        init: BwsDashController(),
        builder: (_bwsDashController) => SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialCard(
                borderRadius: 12,
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: TextWidget(status: kBillWatchSystem,fontSize: 20,
                        letterSpacing: 0.55,
                        color: colorController.kPrimaryDarkColor,
                        fontWeight: FontWeight.w600,),
                    ),
                     // Text(kBillWatchSystem, style: textStyle20Bold, textAlign: TextAlign.center),
                    verticalSpace18,
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            // calling select date filter method
                            onTap: () => _bwsDashController.selectDateFilter(),
                            controller: _bwsDashController.fromDateController,
                            decoration: const InputDecoration(labelText: kFromDate),
                          ),
                        ),
                        horizontalSpace12,
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _bwsDashController.toDateController,
                            decoration: const InputDecoration(labelText: kToDate),
                            // calling select date filter method
                            onTap: () => _bwsDashController.selectDateFilter(isToDate: true),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace12,
                    DropdownButtonFormField(
                      isExpanded: true,
                      value: _bwsDashController.selectedUserType,
                      // calling on bill filter selected method
                      onChanged: _bwsDashController.onUserTypeSelected,
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(width: 2, color: colorController.kBlackShadeColor),
                        ),
                      ),
                      items: [kIndividual, kSubOrdinate]
                          .map((String _value) =>
                              DropdownMenuItem(value: _value, child: Text(_value, style: textStyle14Normal)))
                          .toList(),
                    ),
                    if (_bwsDashController.selectedUserType == kSubOrdinate) ...[
                      verticalSpace12,
                      DropdownButtonFormField<ReportingEmp>(
                        value: _bwsDashController.selectedReportingEmp,
                        hint:  Text(kSelectEmployee, style: textStyle14Normal),
                        // calling on sub ordinated selected method
                        onChanged: _bwsDashController.onSubOrdinateSelected,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(width: 2, color: colorController.kBlackShadeColor),
                          ),
                        ),
                        items: _bwsDashController.reportingEmpList
                            .map((ReportingEmp _reportingEmp) => DropdownMenuItem<ReportingEmp>(
                                value: _reportingEmp, child: Text(_reportingEmp.empName!, style: textStyle14Normal)))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
              if (_bwsDashController.isLoading) ...[
                const LoadingWidget(),
              ] else if (_bwsDashController.bwsDashCount != null) ...[
                MaterialCard(
                  borderRadius: 12,
                  margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Text(
                    '$kSummaryOfBills (${_bwsDashController.selectedUserType})',
                    textAlign: TextAlign.center,
                    style: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Row(
                    children: [
                      CountCard(
                        color: colorController.kPrimaryColor,
                        title: kPendingBills,
                        count: _bwsDashController.bwsDashCount!.deptPendingCount,
                        onTap: () {
                          if (_bwsDashController.bwsDashCount!.deptPendingCount > 0) {
                            // calling open bws dash details screen
                            _bwsDashController.openBwsDashDetailsScreen(
                              status: kPendingStatus,
                              dept: _bwsDashController.bwsDashCount!.dept,
                              title: '$kPendingBills (${_bwsDashController.selectedUserType})',
                            );
                          }
                        },
                      ),
                      CountCard(
                        color: colorController.kPrimaryColor,
                        title: kReturnedBills,
                        count: _bwsDashController.bwsDashCount!.deptReturnCount,
                        onTap: () {
                          if (_bwsDashController.bwsDashCount!.deptReturnCount > 0) {
                            // calling open bws dash details screen
                            _bwsDashController.openBwsDashDetailsScreen(
                              status: kReturnedStatus,
                              dept: _bwsDashController.bwsDashCount!.dept,
                              title: '$kReturnedBills (${_bwsDashController.selectedUserType})',
                            );
                          }
                        },
                      ),
                      CountCard(
                        color: colorController.kPrimaryColor,
                        title: kClosedBills,
                        count: _bwsDashController.bwsDashCount!.deptCloseCount,
                        onTap: () {
                          if (_bwsDashController.bwsDashCount!.deptCloseCount > 0) {
                            // calling open bws dash details screen
                            _bwsDashController.openBwsDashDetailsScreen(
                              status: kCloseStatus,
                              dept: _bwsDashController.bwsDashCount!.dept,
                              title: '$kClosedBills (${_bwsDashController.selectedUserType})',
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                if (_bwsDashController.bwsDashCount != null) ...[
                  if (_bwsDashController.bwsDashCount!.deptCloseCount > 0 ||
                      _bwsDashController.bwsDashCount!.deptReturnCount > 0 ||
                      _bwsDashController.bwsDashCount!.deptPendingCount > 0) ...[
                    MaterialCard(
                      borderRadius: 12,
                      margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                      child: Column(
                        children: [
                          Row(
                            children:  [
                              PieChartLegends(color: colorController.kPrimaryColor, legendTitle: kPendingBills),
                              Spacer(),
                              PieChartLegends(color: colorController.kPrimaryColor, legendTitle: kReturnedBills),
                            ],
                          ),
                          verticalSpace12,
                           PieChartLegends(color: colorController.kPrimaryColor, legendTitle: kClosedBills),
                          SizedBox(
                            height: 300,
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                PieSeries<BwsChartData, String>(
                                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                                  xValueMapper: (BwsChartData _bwsChartData, _) => _bwsChartData.title,
                                  yValueMapper: (BwsChartData _bwsChartData, _) => _bwsChartData.count,
                                  pointColorMapper: (BwsChartData _bwsChartData, _) => _bwsChartData.color,
                                  onPointTap: (ChartPointDetails pointInteractionDetails) {
                                    debugPrint('pointInteractionDetails value is: ${pointInteractionDetails.pointIndex}');
                                    // debugPrint('pointInteractionDetails value is: ${pointInteractionDetails.seriesIndex}');
                                  },
                                  dataSource: [
                                    BwsChartData(
                                      color: colorController.kPrimaryColor,
                                      title: kPendingBills,
                                      count: 2 /*_bwsDashController.bwsDashCount!.deptPendingCount*/,
                                    ),
                                    BwsChartData(
                                      color: colorController.kPrimaryColor,
                                      title: kReturnedBills,
                                      count: _bwsDashController.bwsDashCount!.deptReturnCount,
                                    ),
                                    BwsChartData(
                                      color: colorController.kPrimaryColor,
                                      title: kClosedBills,
                                      count: _bwsDashController.bwsDashCount!.deptCloseCount,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    verticalSpace30,
                    const BwsNoRecordsFound(),
                  ],
                ],
              ] else ...[
                verticalSpace30,
                const BwsNoRecordsFound(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
