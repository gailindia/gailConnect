// Created By Amit Jangid 20/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class BwsBillDetails {
  String? forwardedBy;
  String? forwardedDate;
  String? reason;
  String? receivedBy;
  String? receivedDate;

  BwsBillDetails({
    required this.forwardedBy,
    required this.forwardedDate,
    required this.reason,
    required this.receivedBy,
    required this.receivedDate,
  });

  factory BwsBillDetails.fromJson(Map<String, dynamic> _bwsBilLDetailsJson) => BwsBillDetails(
        forwardedBy: _bwsBilLDetailsJson[kJsonForwardedBy],
        forwardedDate: _bwsBilLDetailsJson[kJsonForwardedDate],
        reason: _bwsBilLDetailsJson[kJsonReason],
        receivedBy: _bwsBilLDetailsJson[kJsonReceivedBy],
        receivedDate: _bwsBilLDetailsJson[kJsonReceivedDate],
      );
}
