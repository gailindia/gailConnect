// Created By Amit Jangid 16/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/fms_chart.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/fms_no_records_found.dart';
import 'package:gail_connect/core/controllers/dash_controllers/fms_controllers/fms_charts_controller.dart';

import '../../../styles/color_controller.dart';

class FmsChartScreen extends StatelessWidget {
  const FmsChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar: CustomAppBar(title: kFmsDashboard),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 48),
        child: GetBuilder<FmsChartsController>(
          id: kFmsChart,
          init: FmsChartsController(),
          builder: (_fmsChartController) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_fmsChartController.isLoading) ...[
                const LoadingWidget(),
              ] else if (_fmsChartController.fmsChart != null) ...[
                MaterialCard(
                  borderRadius: 12,
                  padding: const EdgeInsets.only(top: 12),
                  margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Column(
                    children: [
                      Text(kDashboardForOpenFiles,
                          style: textStyle18Bold.copyWith(
                              color: colorController.kPrimaryDarkColor)),
                      verticalSpace12,
                      SizedBox(
                        height: 300,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                              title: AxisTitle(
                                  text: kNoOfDays,
                                  textStyle: textStyle14Normal)),
                          primaryYAxis: NumericAxis(
                            decimalPlaces: 0,
                            maximumLabels: 1,
                            title: AxisTitle(
                                text: kCount, textStyle: textStyle14Normal),
                          ),
                          series: <ColumnSeries<FmsChartData, String>>[
                            ColumnSeries(
                              pointColorMapper: (_, __) =>
                                  colorController.kPrimaryColor,
                              dataSource: _fmsChartController.fmsChartDataList,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              yValueMapper: (FmsChartData _fmsChartData, _) =>
                                  _fmsChartData.count,
                              xValueMapper: (FmsChartData _fmsChartData, _) =>
                                  '${_fmsChartData.label} : ${_fmsChartData.count}',
                              selectionBehavior: SelectionBehavior(
                                enable: true,
                                unselectedOpacity: 1,
                                unselectedColor: colorController.kPrimaryColor,
                                selectedColor:
                                    colorController.kPrimaryDarkColor,
                              ),
                            ),
                          ],
                          onSelectionChanged: (selectionArgs) {
                            debugPrint(
                                'legend tap args is: ${selectionArgs.pointIndex}');

                            final int _pendingDays = _fmsChartController
                                .fmsChartDataList[selectionArgs.pointIndex]
                                .pendingDays;

                            Get.toNamed(kFmsChartDetailRoute,
                                arguments: _pendingDays);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialCard(
                  borderRadius: 12,
                  padding: const EdgeInsets.only(bottom: 12),
                  margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RowItem(
                          caption: kLessThan7Days,
                          description: _fmsChartController.fmsChart!.dataA!),
                      _RowItem(
                          caption: k7To14Days,
                          description: _fmsChartController.fmsChart!.dataB!),
                      _RowItem(
                          caption: k14To21Days,
                          description: _fmsChartController.fmsChart!.dataC!),
                      _RowItem(
                          caption: k21To28Days,
                          description: _fmsChartController.fmsChart!.dataD!),
                      _RowItem(
                          caption: kMoreThan28Days,
                          description: _fmsChartController.fmsChart!.dataE!),
                    ],
                  ),
                ),
              ] else ...[
                const Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: FmsNoRecordsFound()),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final String caption, description;

  const _RowItem({Key? key, required this.caption, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Row(
        children: [
          Icon(Entypo.dot_single, color: colorController.kPrimaryDarkColor),
          Expanded(child: Text(caption, style: textStyle14Bold)),
          Text(':', style: textStyle14Bold),
          horizontalSpace12,
          Expanded(child: Text(description, style: textStyle14Bold)),
        ],
      ),
    );
  }
}
