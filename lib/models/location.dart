  // Created By Amit Jangid 31/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:multiutillib/multiutillib.dart';

class Location {
  String locationName;

  Location({required this.locationName});

  factory Location.fromJson(Map<String, dynamic> _locationJson) => Location(
        locationName: _locationJson[kColumnLocation],
      );
}

class LocationDb {
  static const String _tag = 'LocationDb';

  static Future<List<Location>> getLocationDetailsFromDb(String department, String directorate, String grade, String section) async {
    try {
      final _db = await DbProvider.db.database;
      if(section!=''){
        String findSection = "select $kSection from $kTableSectionMaster where $kSectionDes = '$section'";
        final _result = await _db!.rawQuery(findSection);
        final subDepartmentList = _result
            .map<String>((s) => s['SECTION'].toString());
        section = subDepartmentList.first;
      }
      String whereClause='';
      if(department.isNullOrEmpty && directorate.isNullOrEmpty && grade.isNullOrEmpty && grade.isNullOrEmpty) {
        whereClause='';
      }
      if(department!='' && directorate!='' && grade!='' && section!='') {
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnDepartment == '$department' AND $kColumnSDirectorate == '$directorate' AND $kColumnSection = '$section'";

        } else if (grade == 'Non-Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnDepartment == '$department' AND $kColumnSDirectorate == '$directorate' AND $kColumnSection = '$section'";
        } else {
          whereClause =
          "WHERE $kColumnGrade == '$grade' AND $kColumnDepartment == '$department' AND $kColumnSDirectorate == '$directorate' AND $kColumnSection = '$section'";
        }
      }
      if(department != '' && directorate.isNullOrEmpty && grade.isNullOrEmpty && grade.isNullOrEmpty){
        whereClause = "WHERE $kColumnDepartment == '$department'";
      }
      if(department.isNullOrEmpty  && directorate != '' && grade.isNullOrEmpty && grade.isNullOrEmpty){
        whereClause = "WHERE $kColumnSDirectorate == '$directorate'";
      }
      if(department.isNullOrEmpty && directorate.isNullOrEmpty && grade !='' && grade.isNullOrEmpty){
        if (grade == 'Executives') {
          whereClause = "WHERE $kColumnGrade between 'E0' and 'E9'";
        }else if (grade == 'Non-Executives') {
          whereClause = "WHERE $kColumnGrade between 'S0' and 'S7'";
        }else {
          whereClause = "WHERE $kColumnGrade == '$grade'";
        }
      }
      if(department.isNullOrEmpty && directorate!='' && grade !='' && grade.isNullOrEmpty){
        if (grade == 'Executives') {
          whereClause = "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnSDirectorate == '$directorate'";
        }else if (grade == 'Non-Executives') {
          whereClause = "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnSDirectorate == '$directorate'";
        }else {
          whereClause =
          "WHERE $kColumnGrade == '$grade' AND $kColumnSDirectorate == '$directorate'";
        }
      }
      if(department!='' && directorate!='' && grade.isNullOrEmpty && grade.isNullOrEmpty){
        whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnSDirectorate == '$directorate'";
      }
      if(department!='' && directorate.isNullOrEmpty && grade!='' && grade.isNullOrEmpty){
        if(grade == 'Executives'){
          whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade between 'E1' and 'E9'";
        }
        else if(grade == 'Non-Executives'){
          whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade between 'S0' and 'S7'";
        }
        else{
          whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade == '$grade'";
        }
      }
      if(department.isNullOrEmpty && directorate!='' && grade.isNullOrEmpty && section !='')
      {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnSDirectorate = '$directorate'";
      }
      if(department.isNullOrEmpty && directorate!='' && grade.isNullOrEmpty && section !='')
      {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnSDirectorate = '$directorate'";
      }
      if(department.isNullOrEmpty && directorate!='' && grade!='' && section !='')
      {
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'E0' and 'E9'  AND $kColumnSDirectorate = '$directorate' AND $kColumnSection = '$section'";
        } else if (grade == 'Non-Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnSDirectorate == '$directorate' AND $kColumnSection = '$section'";
        } else {
          whereClause = "WHERE $kColumnSection = '$section' AND $kColumnGrade = '$grade' AND $kColumnSDirectorate = '$directorate' ";
        }
      }
      if(department.isNullOrEmpty && directorate.isNullOrEmpty && grade!='' && section !='')
      {
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnSection = '$section'";
        } else if (grade == 'Non-Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnSection = '$section'";
        } else {
          whereClause = "WHERE $kColumnSection = '$section' AND $kColumnGrade = '$grade'";
        }

      }
      if(department!='' && directorate!='' && grade!='' && section.isNullOrEmpty)
      {
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'E0' and 'E9'  AND $kColumnSDirectorate = '$directorate' AND $kColumnDepartment = '$department'";
        } else if (grade == 'Non-Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnSDirectorate = '$directorate' AND $kColumnDepartment = '$department'";
        } else {
          whereClause = "WHERE $kColumnDepartment = '$department' AND $kColumnGrade = '$grade' AND $kColumnSDirectorate = '$directorate'";
        }

      }

      String _query = "SELECT DISTINCT $kColumnLocation FROM $kTableEmployees $whereClause ORDER BY $kColumnLocation ASC";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting locations list is: $_query');
      debugPrint('result for getting locations list is: $_result');

      if (_result.isNotEmpty) {
        final List<Location> _locationList =
            _result.map<Location>((_locationJson) => Location.fromJson(_locationJson)).toList();
        return _locationList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting location details from db',
      );

      return [];
    }
  }
}
