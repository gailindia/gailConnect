// Created By Amit Jangid 31/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:multiutillib/multiutillib.dart';

class Department {
  String department;

  Department({required this.department});

  factory Department.fromJson(Map<String, dynamic> _departmentJson) => Department(
        department: _departmentJson[kColumnDepartment],
      );
}

class DepartmentDb {
  static const String _tag = 'DepartmentDb';

  static Future<List<Department>> getDepartmentDetailsFromDb(String location, String directorate, String grade, String section) async {
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
      if(location.isNullOrEmpty && directorate.isNullOrEmpty && grade.isNullOrEmpty && section.isNullOrEmpty) {
        whereClause='';
      }
      if(location!='' && directorate!='' && grade!='' && section!='') {
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnLocation == '$location' AND $kColumnSection = '$section' AND $kColumnSDirectorate == '$directorate'";
        } else if (grade == 'Non-Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnLocation == '$location' AND $kColumnSection = '$section' AND $kColumnSDirectorate == '$directorate'";
        } else {
          whereClause =
          "WHERE $kColumnGrade == '$grade' AND $kColumnLocation == '$location' AND $kColumnSection = '$section' AND $kColumnSDirectorate == '$directorate'";
        }
      }
      if(location != '' && directorate.isNullOrEmpty && grade.isNullOrEmpty && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnLocation == '$location'";
      }
      if(location.isNullOrEmpty  && directorate != '' && grade.isNullOrEmpty && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnSDirectorate == '$directorate'";
      }
      if(location.isNullOrEmpty && directorate.isNullOrEmpty && grade !='' && section.isNullOrEmpty){
        if (grade == 'Executives') {
          whereClause = "WHERE $kColumnGrade between 'E0' and 'E9'";
        }else if(grade == 'Non-Executives'){
          whereClause = "WHERE $kColumnGrade between 'S0' and 'S7'";
        }else {
          whereClause = "WHERE $kColumnGrade == '$grade'";
        }
      }
      if(location.isNullOrEmpty && directorate!='' && grade !='' && section.isNullOrEmpty){
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnSDirectorate == '$directorate'";

        }else if(grade == 'Non-Executives'){
          whereClause =
          "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnSDirectorate == '$directorate'";

        }else {
          whereClause =
          "WHERE $kColumnGrade == '$grade' AND $kColumnSDirectorate == '$directorate'";
        }
      }
      if(location!='' && directorate!='' && grade.isNullOrEmpty && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnLocation == '$location' AND $kColumnSDirectorate == '$directorate'";
      }
      if(location!='' && directorate.isNullOrEmpty && grade!='' && section.isNullOrEmpty){
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnLocation == '$location' AND $kColumnGrade between 'E0' and 'E9'";
        }else if(grade == 'Non-Executives'){
          whereClause =
          "WHERE $kColumnLocation == '$location' AND $kColumnGrade between 'S0' and 'S7'";
        }else {
          whereClause =
          "WHERE $kColumnLocation == '$location' AND $kColumnGrade == '$grade'";
        }
      }
      if(directorate.isNullOrEmpty && location!='' && grade.isNullOrEmpty && section !='')
      {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnLocation = '$location'";
      }
      if(directorate.isNullOrEmpty && location!='' && grade.isNullOrEmpty && section !='')
      {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnLocation = '$location'";
      }
      if(directorate.isNullOrEmpty && location!='' && grade!='' && section !='')
      {
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnSection = '$section' AND $kColumnLocation = '$location' AND $kColumnGrade between 'E0' and 'E9'";
        }else if(grade == 'Non-Executives'){
          whereClause =
          "WHERE $kColumnSection = '$section' AND $kColumnLocation = '$location' AND $kColumnGrade between 'S0' and 'S7'";
        }else {
          whereClause = "WHERE $kColumnSection = '$section' AND $kColumnGrade = '$grade' AND $kColumnLocation = '$location' ";

        }
      }
      if(directorate.isNullOrEmpty && location.isNullOrEmpty && grade!='' && section !='')
      {
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnSection = '$section' AND $kColumnGrade between 'E0' and 'E9'";
        }else if(grade == 'Non-Executives'){
          whereClause =
          "WHERE $kColumnSection = '$section' AND $kColumnGrade between 'S0' and 'S7'";
        }else {
          whereClause = "WHERE $kColumnSection = '$section' AND $kColumnGrade = '$grade'";
        }
      }
      if(directorate!='' && location!='' && grade!='' && section.isNullOrEmpty)
      {
        if (grade == 'Executives') {
          whereClause =
          "WHERE $kColumnSDirectorate = '$directorate' AND $kColumnLocation = '$location' AND $kColumnGrade between 'E0' and 'E9'";
        }else if(grade == 'Non-Executives'){
          whereClause =
          "WHERE $kColumnSDirectorate = '$directorate' AND $kColumnLocation = '$location' AND $kColumnGrade between 'S0' and 'S7'";
        }else {
          whereClause = "WHERE $kColumnSDirectorate = '$directorate' AND $kColumnGrade = '$grade' AND $kColumnLocation = '$location'";
        }
      }
      String _query = "SELECT DISTINCT $kColumnDepartment FROM $kTableEmployees $whereClause ORDER BY $kColumnDepartment ASC";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting department list is: $_query');
      debugPrint('result for getting department list is: $_result');

      if (_result.isNotEmpty) {
        final List<Department> _departmentList =
            _result.map<Department>((_departmentJson) => Department.fromJson(_departmentJson)).toList();

        return _departmentList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting department details from db',
      );

      return [];
    }
  }


  static Future<List<Department>> getDepartmentDetailsFromDbOnBasis(String location) async {
    try {
      final _db = await DbProvider.db.database;

      String _query = "SELECT DISTINCT $kColumnDepartment FROM $kTableEmployees ORDER BY $kColumnDepartment ASC";

      final _result = await _db!.rawQuery(_query);

      debugPrint('getDepartmentDetailsFromDbOnBasis : $_query');
      debugPrint('result for getting department list is: $_result');

      if (_result.isNotEmpty) {
        final List<Department> _departmentList =
        _result.map<Department>((_departmentJson) => Department.fromJson(_departmentJson)).toList();

        return _departmentList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting department details from db',
      );

      return [];
    }
  }
}
