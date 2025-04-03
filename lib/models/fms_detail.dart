// Created By Amit Jangid 16/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class FmsDetail {
  String? fileNo;
  String? subject;
  String? status;
  String? id;
  String? sender;
  String? receiver;
  String? daysInTransit;
  String? pendingWithRecipient;
  String? actionTakenCode;
  String? sentFor;
  String? sentDate;
  String? recDate;

  FmsDetail({
    required this.fileNo,
    required this.subject,
    required this.status,
    required this.id,
    required this.sender,
    required this.receiver,
    required this.daysInTransit,
    required this.pendingWithRecipient,
    required this.actionTakenCode,
    required this.sentFor,
    required this.sentDate,
    required this.recDate,
  });

  factory FmsDetail.fromJson(Map<String, dynamic> _fmsDetailJson) => FmsDetail(
        fileNo: _fmsDetailJson[kJsonFileNo],
        subject: _fmsDetailJson[kJsonSubject],
        status: _fmsDetailJson[kJsonStatus],
        id: _fmsDetailJson[kJsonId],
        sender: _fmsDetailJson[kJsonSender],
        receiver: _fmsDetailJson[kJsonReceiver],
        daysInTransit: _fmsDetailJson[kJsonDaysInTransit],
        pendingWithRecipient: _fmsDetailJson[kJsonPendingWithRecipient],
        actionTakenCode: _fmsDetailJson[kJsonActionTakenCode],
        sentFor: _fmsDetailJson[kJsonSentFor],
        sentDate: _fmsDetailJson[kJsonSentDate],
        recDate: _fmsDetailJson[kJsonRecDate],
      );
}
