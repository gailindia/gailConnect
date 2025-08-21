// Created By Amit Jangid on 09/11/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class EnggInfo {
  String? actionDate;
  String? actionDesc;
  String? enggId;
  String? enggName;

  EnggInfo({required this.actionDate, required this.actionDesc, required this.enggId, required this.enggName});

  factory EnggInfo.fromJson(Map<String, dynamic> _enggInfoJson) => EnggInfo(
        actionDate: _enggInfoJson[kJsonActionDate],
        actionDesc: _enggInfoJson[kJsonActionDesc],
        enggId: _enggInfoJson[kJsonEnggId],
        enggName: _enggInfoJson[kJsonEnggName],
      );
}
