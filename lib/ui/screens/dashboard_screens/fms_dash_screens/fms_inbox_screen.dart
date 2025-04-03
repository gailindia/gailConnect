// Created By Amit Jangid 16/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/reporting_emp.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/fms_mail_box_widget.dart';
import 'package:gail_connect/ui/widgets/fms_no_records_found.dart';
import 'package:gail_connect/core/controllers/dash_controllers/fms_controllers/fms_inbox_controller.dart';

import '../../../styles/color_controller.dart';

class FmsInboxScreen extends StatelessWidget {
  const FmsInboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      body: GetBuilder<FmsInboxController>(
        id: kInbox,
        init: FmsInboxController(),
        builder: (_fmsInboxController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialCard(
                borderRadius: 12,
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(kFileMovementSystem,
                        style: textStyle20Bold, textAlign: TextAlign.center),
                    verticalSpace12,
                    DropdownButtonFormField(
                      isExpanded: true,
                      value: _fmsInboxController.userType,
                      // calling on inbox type selected method
                      onChanged: _fmsInboxController.onUserTypeSelected,
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
                    if (_fmsInboxController.userType == kSubOrdinate) ...[
                      verticalSpace12,
                      DropdownButtonFormField<ReportingEmp>(
                        value: _fmsInboxController.selectedReportingEmp,
                        hint: Text(kSelectEmployee, style: textStyle14Normal),
                        // calling on sub ordinated selected method
                        onChanged: _fmsInboxController.onSubOrdinateSelected,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                width: 2,
                                color: colorController.kBlackShadeColor),
                          ),
                        ),
                        items: _fmsInboxController.reportingEmpList
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
              if (_fmsInboxController.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_fmsInboxController.fmsInboxList.isNotEmpty) ...[
                Expanded(
                    child: FmsMailBoxWidget(
                        fmsMailBoxList: _fmsInboxController.fmsInboxList)),
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
