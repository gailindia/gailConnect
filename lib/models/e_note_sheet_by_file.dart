// Created By Amit Jangid 22/10/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class ENoteSheetByFile {
  String? subject;
  String? fileId;
  String? fileNo;
  String? dateOfInitiation;
  String? initiator;
  List<FileMovementDetails> fileMovementDetailsList;

  ENoteSheetByFile({
    required this.subject,
    required this.fileId,
    required this.fileNo,
    required this.dateOfInitiation,
    required this.initiator,
    required this.fileMovementDetailsList,
  });

  factory ENoteSheetByFile.fromJson(Map<String, dynamic> _eNoteSheetByFileJson) => ENoteSheetByFile(
        subject: _eNoteSheetByFileJson[kJsonSubjectCaps],
        fileId: _eNoteSheetByFileJson['FileId'],
        fileNo: _eNoteSheetByFileJson['FileNo'],
        dateOfInitiation: _eNoteSheetByFileJson[kJsonDateOfInitiation],
        initiator: _eNoteSheetByFileJson[kJsonInitiator],
        fileMovementDetailsList: _eNoteSheetByFileJson[kJsonFileMovementDetails] != null &&
                _eNoteSheetByFileJson[kJsonFileMovementDetails].isNotEmpty
            ? _eNoteSheetByFileJson[kJsonFileMovementDetails]
                .map<FileMovementDetails>(
                    (_fileMovementDetailsJson) => FileMovementDetails.fromJson(_fileMovementDetailsJson))
                .toList()
            : [],
      );
}

class FileMovementDetails {
  String? sentBy;
  String? sentOn;
  String? sentTo;
  String? sentFor;

  FileMovementDetails({
    required this.sentBy,
    required this.sentOn,
    required this.sentTo,
    required this.sentFor,
  });

  factory FileMovementDetails.fromJson(Map<String, dynamic> _fileMovementDetailsJson) => FileMovementDetails(
        sentBy: _fileMovementDetailsJson[kJsonSentBy],
        sentOn: _fileMovementDetailsJson[kJsonSentOn],
        sentTo: _fileMovementDetailsJson[kJsonSentTo],
        sentFor: _fileMovementDetailsJson[kJsonSentForCaps],
      );
}
