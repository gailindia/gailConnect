// Created By Amit Jangid 22/10/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class ENoteSheetChartDetails {
  String? fileId;
  String? fileStatus;
  String? fileNo;
  String? fileSubject;
  String? initiator;
  String? slNo;
  String? secondCpfNo;
  String? fileIdMain;
  String? firstCpfNo;
  String? firstSentOn;
  String? financialImp;
  String? firstCpfName;
  String? secondCpfName;
  String? initiatorName;

  ENoteSheetChartDetails({
    required this.fileId,
    required this.fileStatus,
    required this.fileNo,
    required this.fileSubject,
    required this.initiator,
    required this.slNo,
    required this.secondCpfNo,
    required this.fileIdMain,
    required this.firstCpfNo,
    required this.firstSentOn,
    required this.financialImp,
    required this.firstCpfName,
    required this.secondCpfName,
    required this.initiatorName,
  });

  factory ENoteSheetChartDetails.fromJson(Map<String, dynamic> _eNoteSheetChartDetailsJson) => ENoteSheetChartDetails(
        fileId: _eNoteSheetChartDetailsJson[kJsonFileIdCaps],
        fileStatus: _eNoteSheetChartDetailsJson[kJsonFileStatus],
        fileNo: _eNoteSheetChartDetailsJson[kJsonFileNoCaps],
        fileSubject: _eNoteSheetChartDetailsJson[kJsonFileSubject],
        initiator: _eNoteSheetChartDetailsJson[kJsonInitiatorCaps],
        slNo: _eNoteSheetChartDetailsJson[kJsonSlNo].toString(),
        secondCpfNo: _eNoteSheetChartDetailsJson[kJsonSecondCpfNo],
        fileIdMain: _eNoteSheetChartDetailsJson[kJsonFileIdMain],
        firstCpfNo: _eNoteSheetChartDetailsJson[kJsonFirstCpfNo],
        firstSentOn: _eNoteSheetChartDetailsJson[kJsonFirstSentOn],
        financialImp: _eNoteSheetChartDetailsJson[kJsonFinancialImp],
        firstCpfName: _eNoteSheetChartDetailsJson[kJsonFirstCpfName],
        secondCpfName: _eNoteSheetChartDetailsJson[kJsonSecondCpfName],
        initiatorName: _eNoteSheetChartDetailsJson[kJsonInitiatorName],
      );
}
