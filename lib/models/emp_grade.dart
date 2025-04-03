// Created By Amit Jangid 31/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib.dart';

class EmpGrade {
  String empGrade;
  String? exec;

  EmpGrade({required this.empGrade});

  factory EmpGrade.fromJson(Map<String, dynamic> _empGradeJson) => EmpGrade(empGrade: _empGradeJson[kColumnGrade]);
}


class EmpGradeDb {
  static const String _tag = 'EmpGradeDb';

  static Future<List<EmpGrade>> getGradeDetailsFromDb(String department, String directorate, String location, String section) async {
    try {
      final _db = await DbProvider.db.database;
      String whereClause='';

      if(section!=''){
        String findSection = "select $kSection from $kTableSectionMaster where $kSectionDes = '$section'";
        final _result = await _db!.rawQuery(findSection);
        final subDepartmentList = _result
            .map<String>((s) => s['SECTION'].toString());
        section = subDepartmentList.first;
      }

      if(department.isNullOrEmpty && directorate.isNullOrEmpty && location.isNullOrEmpty && section.isNullOrEmpty) {
        whereClause='';
      }
      if(department!='' && directorate!='' && location!='' && section!=''){
        whereClause = "WHERE $kColumnLocation = '$location' AND $kColumnDepartment = '$department' AND $kColumnSDirectorate = '$directorate' AND $kColumnSection = '$section'";
      }
      if(department != '' && directorate.isNullOrEmpty && location.isNullOrEmpty && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnDepartment = '$department'";
      }
      if(department.isNullOrEmpty  && directorate != '' && location.isNullOrEmpty && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnSDirectorate = '$directorate'";
      }
      if(department.isNullOrEmpty && directorate.isNullOrEmpty && location !='' && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnLocation = '$location'";
      }
      if(department.isNullOrEmpty && directorate!='' && location !='' && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnLocation = '$location' AND $kColumnSDirectorate = '$directorate'";
      }
      if(department!='' && directorate!='' && location.isNullOrEmpty && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnDepartment = '$department' AND $kColumnSDirectorate = '$directorate'";
      }
      if(department!='' && directorate.isNullOrEmpty && location!='' && section.isNullOrEmpty){
        whereClause = "WHERE $kColumnDepartment = '$department' AND $kColumnLocation = '$location'";
      }
      if(department.isNullOrEmpty && location!='' && directorate.isNullOrEmpty && section !='')
      {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnLocation = '$location'";
      }
      if(department.isNullOrEmpty && location!='' && directorate.isNullOrEmpty && section !='')
      {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnLocation = '$location'";
      }
      if(department.isNullOrEmpty && location!='' && directorate!='' && section !='')
      {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnSDirectorate = '$directorate' AND $kColumnLocation = '$location' ";
      }
      if(department.isNullOrEmpty && location.isNullOrEmpty && directorate!='' && section !='')
      {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnSDirectorate = '$directorate'";
      }
      if(department!='' && location!='' && directorate!='' && section.isNullOrEmpty)
      {
        whereClause = "WHERE $kColumnDepartment = '$department' AND $kColumnSDirectorate = '$directorate' AND $kColumnLocation = '$location'";
      }


      // String _query = "SELECT DISTINCT $kColumnGrade FROM $kTableEmployees  $whereClause ORDER BY $kColumnGrade ASC";
      String _query = "SELECT DISTINCT $kColumnGrade FROM $kTableEmployees $whereClause UNION ALL select DISTINCT case when $kColumnGrade between 'S0' AND 'S7' then 'Non-Executives' when $kColumnGrade between 'E0' AND 'E9' then 'Executives' else '' end as exe FROM $kTableEmployees $whereClause ORDER BY $kColumnGrade ASC";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting emp grade list is: $_query');
      debugPrint('result for getting emp grade list is: $_result');

      if (_result.isNotEmpty ) {
        final List<EmpGrade> _empGradeList =
            _result.map<EmpGrade>((_empGradeJson) => EmpGrade.fromJson(_empGradeJson)).toList();

        for(int i=0;i<_empGradeList.length;i++)
        {
          print("_empGradeList[i] :: --${_empGradeList[i].empGrade}--");
            if(_empGradeList[i].empGrade==""){
              _empGradeList.removeAt(i);
            }else{

            }
        }


        return _empGradeList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting emp grade details from db',
      );

      return [];
    }
  }
}
