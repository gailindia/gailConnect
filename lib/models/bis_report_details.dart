// Created By Amit Jangid on 08/11/21

import 'package:gail_connect/models/engg_info.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class BISReportDetails {
  String? cpfNumber;
  String? userName;
  String? designation;
  String? userLocation;
  String? area;
  String? areaName;
  String? empName;
  String? type;
  String? typeName;
  String? logDate;
  String? description;
  String? status;
  String? intState;
  String? engg;
  String? engId;
  String? engineerName;
  String? callId;
  String? userId;
  String? fileAttachment;
  String? userState;
  String? fileCount;
  String? actionTakenBy;
  List<EnggInfo> enggInfoList;

  BISReportDetails({
    required this.cpfNumber,
    required this.userName,
    required this.designation,
    required this.userLocation,
    required this.area,
    required this.areaName,
    required this.empName,
    required this.type,
    required this.typeName,
    required this.logDate,
    required this.description,
    required this.status,
    required this.intState,
    required this.engg,
    required this.engId,
    required this.engineerName,
    required this.callId,
    required this.userId,
    required this.fileAttachment,
    required this.userState,
    required this.fileCount,
    required this.actionTakenBy,
    this.enggInfoList = const [],
  });

  factory BISReportDetails.fromJson(Map<String, dynamic> _bisReportDetailsJson) => BISReportDetails(
        cpfNumber: _bisReportDetailsJson[kJsonCpfNumberCaps].toString(),
        userId: _bisReportDetailsJson[kJsonUserIdCaps],
        userName: _bisReportDetailsJson[kJsonUserName],
        designation: _bisReportDetailsJson[kJsonDesignationCaps],
        userLocation: _bisReportDetailsJson[kJsonUserLocation],
        area: _bisReportDetailsJson[kJsonAreaCaps],
        areaName: _bisReportDetailsJson['AREANAME'],
        empName: _bisReportDetailsJson[kJsonEmpNameFullCaps],
        type: _bisReportDetailsJson[kJsonTypeCaps],
        typeName: _bisReportDetailsJson['TYPENAME'],
        logDate: _bisReportDetailsJson[kJsonLogDate],
        description: _bisReportDetailsJson[kJsonDescriptionCaps],
        status: _bisReportDetailsJson[kJsonStatusCaps],
        intState: _bisReportDetailsJson[kJsonIntState],
        engg: _bisReportDetailsJson[kJsonEngg].toString(),
        engId: _bisReportDetailsJson[kJsonEngId].toString(),
        engineerName: _bisReportDetailsJson[kJsonEngineerName],
        callId: _bisReportDetailsJson[kJsonCallId].toString().replaceAll('.0', ''),
        fileAttachment: _bisReportDetailsJson[kJsonFileAttachment],
        userState: _bisReportDetailsJson[kJsonUserState],
        fileCount: _bisReportDetailsJson[kJsonFileCount],
        actionTakenBy: _bisReportDetailsJson[kJsonActionTakenBy],
        enggInfoList: (_bisReportDetailsJson[kJsonEnggInfo] != null && _bisReportDetailsJson[kJsonEnggInfo].isNotEmpty)
            ? _bisReportDetailsJson[kJsonEnggInfo]
                .map<EnggInfo>((_enggInfoJson) => EnggInfo.fromJson(_enggInfoJson))
                .toList()
            : [],
      );
}
