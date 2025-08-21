// Created By Amit Jangid 16/09/21

import 'package:multiutillib/utils/string_extension.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class FmsMail {
  String? id;
  String? fileNo;
  String? subject;
  String? status;
  String? receivedFrom;
  String? presentlyWith;
  String? receivedDate;

  FmsMail({
    required this.id,
    required this.fileNo,
    required this.subject,
    required this.status,
    required this.receivedFrom,
    required this.presentlyWith,
    required this.receivedDate,
  });

  factory FmsMail.fromJson(Map<String, dynamic> _fmsInbox) => FmsMail(
        id: _fmsInbox[kJsonId],
        fileNo: _fmsInbox[kJsonFileNo],
        subject: _fmsInbox[kJsonSubject],
        status: _fmsInbox[kJsonStatus],
        receivedFrom: _fmsInbox[kJsonReceivedFrom],
        presentlyWith: _fmsInbox[kJsonPresentlyWith],
        receivedDate: _fmsInbox[kJsonReceivedDate]?.toString().replaceNullWithEmpty,
      );
}
