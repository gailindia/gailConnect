// Created By Amit Jangid on 26/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/utilization.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/admin_controllers/utilization_controllers/utilization_controller.dart';

class UtilizationScreen extends StatelessWidget {
  const UtilizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar: CustomAppBar(title: kUtilization),
      body: GetBuilder<UtilizationController>(
        id: kUtilization,
        init: UtilizationController(),
        builder: (_controller) {
          if (_controller.isLoading) {
            return const LoadingWidget();
          } else if (_controller.pieChartUtilizationList.isNotEmpty) {
            return SingleChildScrollView(
              controller: _controller.scrollController,
              padding: const EdgeInsets.only(bottom: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MaterialCard(
                    borderRadius: 12,
                    padding: const EdgeInsets.only(),
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: AspectRatio(
                      aspectRatio: .7,
                      child: SfCircularChart(
                        legend: Legend(
                          itemPadding: 2,
                          isVisible: true,
                          isResponsive: true,
                          alignment: ChartAlignment.near,
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.scroll,
                          orientation: LegendItemOrientation.vertical,
                        ),
                        series: <CircularSeries>[
                          PieSeries<Utilization, String>(
                            dataSource: _controller.pieChartUtilizationList,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            yValueMapper: (Utilization _utilization, _) =>
                                _utilization.count,
                            xValueMapper: (Utilization _utilization, _) =>
                                '${_utilization.screen} - ${_utilization.count}',
                            onPointTap:
                                (ChartPointDetails pointInteractionDetails) {
                              // calling on pie chart section selected method
                              _controller.onPieChartSectionSelected(
                                  pointIndex:
                                      pointInteractionDetails.pointIndex!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_controller
                      .pieChartDetailsUtilizationList.isNotEmpty) ...[
                    MaterialCard(
                      borderRadius: 12,
                      padding: const EdgeInsets.only(top: 12),
                      margin:
                          const EdgeInsets.only(top: 12, left: 12, right: 12),
                      child: Column(
                        children: [
                          Text(_controller.selectedListTitle,
                              style: textStyle16Bold),
                          AspectRatio(
                            aspectRatio: (_controller
                                        .pieChartDetailsUtilizationList
                                        .length <=
                                    5)
                                ? .6
                                : .55,
                            child: SfCircularChart(
                              legend: Legend(
                                itemPadding: 2,
                                isVisible: true,
                                isResponsive: true,
                                alignment: ChartAlignment.near,
                                position: LegendPosition.bottom,
                                overflowMode: LegendItemOverflowMode.scroll,
                                orientation: LegendItemOrientation.vertical,
                              ),
                              series: <CircularSeries>[
                                PieSeries<Utilization, String>(
                                  dataSource: _controller
                                      .pieChartDetailsUtilizationList,
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true,labelAlignment: ChartDataLabelAlignment.middle),
                                  yValueMapper: (Utilization _utilization, _) =>
                                      _utilization.count,
                                  xValueMapper: (Utilization _utilization, _) =>
                                      '${_utilization.screen} - ${_utilization.count}',
                                  /*onPointTap: (ChartPointDetails pointInteractionDetails) {
                                    // calling on pie chart section selected method
                                    _controller.onPieChartSectionSelected(
                                      pointIndex: pointInteractionDetails.pointIndex!,
                                    );
                                  },*/
                                ),
                              ],
                            ),
                          ),
                          /*Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _controller.pieChartDetailsUtilizationList
                                .map((e) => Text('${e.screen} - ${e.count}'))
                                .toList(),
                          ),*/
                        ],
                      ),
                    ),
                  ],



                  /*GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.utilizationList.length,
                    padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 48),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (context, _position) {
                      final Utilization _utilization = _controller.utilizationList[_position];

                      return MaterialCard(
                        borderRadius: 12,
                        margin: const EdgeInsets.only(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${_utilization.count}', style: textStyle30Bold),
                            verticalSpace12,
                            Text(_utilization.screen, style: textStyle16Normal, textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    },
                  ),*/
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

/*GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: _controller.pieChartUtilizationList.length,
  padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 48),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
  ),
  itemBuilder: (context, _position) {
    final Utilization _utilization = _controller.pieChartUtilizationList[_position];

    return MaterialCard(
      borderRadius: 12,
      margin: const EdgeInsets.only(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${_utilization.count}', style: textStyle30Bold),
          verticalSpace12,
          Text(_utilization.screen, style: textStyle16Normal, textAlign: TextAlign.center),
        ],
      ),
    );
  },
),*/
