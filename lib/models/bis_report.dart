// Created By Amit Jangid on 08/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class BISReport {
  int? callsLoggedDuringPeriod;
  int? previousOpenCalls;
  int? totalCalls;
  int? callsClosedDuringPeriod;
  int? pendingForAssignmentWithHelpdesk;
  int? pendingWithAdminForAssignment;
  int? pendingWithEng;
  int? pendingForCloserWithAdmin;
  int? pendingForCloserWithUser;
  int? revertedByUser;
  String? averageResolutionTime;

  BISReport({
    required this.callsLoggedDuringPeriod,
    required this.previousOpenCalls,
    required this.totalCalls,
    required this.callsClosedDuringPeriod,
    required this.pendingForAssignmentWithHelpdesk,
    required this.pendingWithAdminForAssignment,
    required this.pendingWithEng,
    required this.pendingForCloserWithAdmin,
    required this.pendingForCloserWithUser,
    required this.revertedByUser,
    required this.averageResolutionTime,
  });

  factory BISReport.fromJson(Map<String, dynamic> _bisReportJson) => BISReport(
        callsLoggedDuringPeriod: _bisReportJson[kJsonCallsLoggedDuringPeriod],
        previousOpenCalls: _bisReportJson[kJsonPreviousOpenCalls],
        totalCalls: _bisReportJson[kJsonTotalCalls],
        callsClosedDuringPeriod: _bisReportJson[kJsonCallsClosedDuringPeriod],
        pendingForAssignmentWithHelpdesk: _bisReportJson[kJsonPendingForAssignmentWithHelpdesk],
        pendingWithAdminForAssignment: _bisReportJson[kJsonPendingWithAdminForAssignment],
        pendingWithEng: _bisReportJson[kJsonPendingWithEng],
        pendingForCloserWithAdmin: _bisReportJson[kJsonPendingForCloserWithAdmin],
        pendingForCloserWithUser: _bisReportJson[kJsonPendingForCloserWithUser],
        revertedByUser: _bisReportJson[kJsonRevertedByUser],
        averageResolutionTime: _bisReportJson[kJsonAverageResolutionTime],
      );
}

class BISReportData {
  int count;
  Color color;
  String title;
  String axisTitle;

  BISReportData({required this.count, required this.color, required this.title, this.axisTitle = ''});
}
