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
import 'package:gail_connect/ui/widgets/e_note_sheet/e_note_sheet_sent_box_list.dart';
import 'package:gail_connect/core/controllers/dash_controllers/e_note_sheet_controllers/e_note_sheet_sent_box_controller.dart';

import '../../../styles/color_controller.dart';

class ENoteSheetSentBoxScreen extends StatelessWidget {
  const ENoteSheetSentBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      body: GetBuilder<ENoteSheetSentBoxController>(
        id: kENoteSheetSentBox,
        init: ENoteSheetSentBoxController(),
        builder: (_eNoteSheetSentController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialCard(
                borderRadius: 12,
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Column(
                  children: [
                    Text(kENoteSheetSentBox,
                        style: textStyle20Bold, textAlign: TextAlign.center),
                    verticalSpace12,
                    DropdownButtonFormField(
                      isExpanded: true,
                      value: _eNoteSheetSentController.userType,
                      // calling on inbox type selected method
                      onChanged: _eNoteSheetSentController.onUserTypeSelected,
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
                    if (_eNoteSheetSentController.userType == kSubOrdinate) ...[
                      verticalSpace12,
                      DropdownButtonFormField<ReportingEmp>(
                        value: _eNoteSheetSentController.selectedReportingEmp,
                        hint: Text(kSelectEmployee, style: textStyle14Normal),
                        // calling on sub ordinated selected method
                        onChanged:
                            _eNoteSheetSentController.onSubOrdinateSelected,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                width: 2,
                                color: colorController.kBlackShadeColor),
                          ),
                        ),
                        items: _eNoteSheetSentController.reportingEmpList
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
                            value: _eNoteSheetSentController.selectedStatus,
                            hint: Text(kStatus, style: textStyle14Normal),
                            // calling on inbox type selected method
                            onChanged:
                                _eNoteSheetSentController.onENoteStatusSelected,
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
                                    child:
                                        Text(_value, style: textStyle14Normal)))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (_eNoteSheetSentController.isLoading) ...[
                const Expanded(
                    child: SingleChildScrollView(child: LoadingWidget())),
              ] else if (_eNoteSheetSentController
                  .eNoteSheetSentBoxList.isNotEmpty) ...[
                ENoteSheetSentBoxList(
                    eNoteSheetSentBoxList:
                        _eNoteSheetSentController.eNoteSheetSentBoxList),
              ] else ...[
                verticalSpace24,
                const Expanded(child: NoFilesFound()),
                verticalSpace24,
              ],
            ],
          );
        },
      ),
    );
  }
}
