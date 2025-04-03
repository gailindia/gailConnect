// Created By Amit Jangid 21/10/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class ENoteSheetDetails {
  String? fileId;
  String? fileNo;
  String? fileSubject;
  String? secondCpfNo;
  String? fileIdMain;
  String? firstCpfNo;
  String? receivedOn;
  String? receivedFrom;
  String? sentOn;
  String? sentTo;
  String? fileDate;
  String? initiator;

  ENoteSheetDetails({
    required this.fileId,
    required this.fileNo,
    required this.fileSubject,
    required this.secondCpfNo,
    required this.fileIdMain,
    required this.firstCpfNo,
    required this.receivedOn,
    required this.receivedFrom,
    required this.sentOn,
    required this.sentTo,
    required this.fileDate,
    required this.initiator,
  });

  factory ENoteSheetDetails.fromJson(Map<String, dynamic> _eNoteSheetDetailsJson) => ENoteSheetDetails(
        fileId: _eNoteSheetDetailsJson[kJsonFileIdCaps],
        fileNo: _eNoteSheetDetailsJson[kJsonFileNoCaps],
        fileSubject: _eNoteSheetDetailsJson[kJsonFileSubject],
        secondCpfNo: _eNoteSheetDetailsJson[kJsonSecondCpfNo],
        fileIdMain: _eNoteSheetDetailsJson[kJsonFileIdMain],
        firstCpfNo: _eNoteSheetDetailsJson[kJsonFirstCpfNo],
        receivedOn: _eNoteSheetDetailsJson[kJsonReceivedOn],
        receivedFrom: _eNoteSheetDetailsJson[kJsonReceivedFromCaps],
        sentOn: _eNoteSheetDetailsJson[kJsonSentOn],
        sentTo: _eNoteSheetDetailsJson[kJsonSentTo],
        fileDate: _eNoteSheetDetailsJson[kJsonFileDate],
        initiator: _eNoteSheetDetailsJson[kJsonInitiatorCaps],
      );
}
