// Created By Amit Jangid 16/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/fms_mail_box_widget.dart';
import 'package:gail_connect/ui/widgets/fms_no_records_found.dart';
import 'package:gail_connect/core/controllers/dash_controllers/fms_controllers/fms_sent_controller.dart';

import '../../../styles/color_controller.dart';

class FmsOutboxScreen extends StatelessWidget {
  const FmsOutboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      body: GetBuilder<FmsSentController>(
        id: kFmsSent,
        init: FmsSentController(),
        builder: (_fmsSentController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialCard(
                borderRadius: 12,
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField(
                      isExpanded: true,
                      value: _fmsSentController.outboxType,
                      // calling on inbox type selected method
                      onChanged: _fmsSentController.onInboxTypeSelected,
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
                    if (_fmsSentController.outboxType == kSubOrdinate) ...[
                      verticalSpace12,
                      DropdownButtonFormField<ReportingEmp>(
                        value: _fmsSentController.selectedReportingEmp,
                        hint: Text(kSelectEmployee, style: textStyle14Normal),
                        // calling on sub ordinated selected method
                        onChanged: _fmsSentController.onSubOrdinateSelected,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                width: 2,
                                color: colorController.kBlackShadeColor),
                          ),
                        ),
                        items: _fmsSentController.reportingEmpList
                            .map((ReportingEmp _reportingEmp) =>
                                DropdownMenuItem<ReportingEmp>(
                                    value: _reportingEmp,
                                    child: Text(_reportingEmp.empName!,
                                        style: textStyle14Normal)))
                            .toList(),
                      ),
                    ]
                  ],
                ),
              ),
              if (_fmsSentController.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_fmsSentController.fmsOutboxList.isNotEmpty) ...[
                Expanded(
                    child: FmsMailBoxWidget(
                        isOutBox: true,
                        fmsMailBoxList: _fmsSentController.fmsOutboxList)),
              ] else ...[
                verticalSpace30,
                const Expanded(child: FmsNoRecordsFound()),
                verticalSpace30,
              ],
            ],
          );
        },
      ),
    );
  }
}
