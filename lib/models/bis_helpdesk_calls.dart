// Created By Amit Jangid on 25/11/21

import 'package:gail_connect/models/attachment.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class BISHelpdeskCalls {
  String? callId;
  String? type;
  String? date;
  String? desc;
  String? eng;
  String? status;
  String? action;
  String? email;
  String? mobile;
  String? empName;
  String? actionDate;
  String? actionDesc;
  String? pendingForClose;
  List<Attachment> attachmentsList;

  BISHelpdeskCalls({
    required this.callId,
    required this.type,
    required this.date,
    required this.desc,
    required this.eng,
    required this.status,
    required this.action,
    required this.email,
    required this.mobile,
    required this.empName,
    required this.actionDate,
    required this.actionDesc,
    required this.pendingForClose,
    required this.attachmentsList,
  });

  factory BISHelpdeskCalls.fromJson(Map<String, dynamic> _userCallJson) =>
      BISHelpdeskCalls(
        callId: _userCallJson[kJsonCallIdSmall],
        type: _userCallJson[kJsonType],
        date: _userCallJson[kJsonDate],
        desc: _userCallJson[kJsonDesc],
        eng: _userCallJson[kJsonEng],
        status: _userCallJson[kJsonStatus],
        action: _userCallJson[kJsonAction],
        email: _userCallJson[kJsonEmailSmall],
        mobile: _userCallJson[kJsonMobile],
        empName: _userCallJson[kJsonEmpNameSmall],
        actionDate: _userCallJson[kJsonActionDate],
        actionDesc: _userCallJson[kJsonActionDesc],
        pendingForClose: _userCallJson[kJsonPendingForClose],
        attachmentsList: (_userCallJson[kJsonFile] != null &&
                _userCallJson[kJsonFile].isNotEmpty)
            ? _userCallJson[kJsonFile]
                .map<Attachment>(
                    (_attachmentJson) => Attachment.fromJson(_attachmentJson))
                .toList()
            : [],
      );
}
