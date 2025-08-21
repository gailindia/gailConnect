// Created By Amit Jangid 21/10/21

import 'package:flutter/material.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class ENoteSheet {
  int openCount;
  int closeCount;

  ENoteSheet({required this.openCount, required this.closeCount});

  factory ENoteSheet.fromJson(Map<String, dynamic> _eNoteSheetJson) => ENoteSheet(
        openCount: _eNoteSheetJson[kJsonOpenCount],
        closeCount: _eNoteSheetJson[kJsonCloseCount],
      );
}

class ENoteSheetData {
  int count;
  String title;
  Color color;

  ENoteSheetData({required this.count, required this.title, required this.color});
}
