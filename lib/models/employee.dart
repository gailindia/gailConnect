// Created By Amit Jangid 25/08/21

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/utils/shared_prefs.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:multiutillib/utils/date_time_extension.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';

class Employee {
  String? empNo;
  String? empName;
  String? designation;
  String? department;
  String? directorate;
  String? section;
  String? DateOfJoining;
  String? location;
  String? telNo;
  String? mobileNo;
  String? mobileNo1;
  String? officeTel;
  String? officeExt;
  String? hBJExt;
  String? lTel;
  String? lGailTel;
  String? faxNo;
  String? emails;
  String? grade;
  String? gradeValue;
  String? dateOfBirth;
  String? image;
  String? vehicleNo;
  int? countByGrade=0;
  bool isEmployeeSelected;

  Employee({
    required this.empNo,
    required this.empName,
    required this.designation,
    required this.department,
    required this.directorate,
    required this.section,
    required this.DateOfJoining,
    required this.location,
    required this.telNo,
    required this.mobileNo,
    required this.mobileNo1,
    required this.officeTel,
    required this.officeExt,
    required this.hBJExt,
    required this.lTel,
    required this.lGailTel,
    required this.faxNo,
    required this.emails,
    required this.grade,
    required this.gradeValue,
    required this.dateOfBirth,
    required this.image,
    required this.vehicleNo,
    this.isEmployeeSelected = false,
  });

  factory Employee.fromJson(Map<String, dynamic> _employeeJson) => Employee(
        empNo: _employeeJson[kJsonEmpNoCaps] ?? _employeeJson[kJsonEmpNoFullCaps],
        empName: _employeeJson[kJsonEmpNameCaps] ?? _employeeJson[kJsonEmpNameFullCaps],
        designation: _employeeJson[kJsonDesignation] ?? _employeeJson[kJsonDesignationCaps],
        department: _employeeJson[kJsonDepartment] ?? _employeeJson[kJsonDepartmentFullCaps],
        directorate: _employeeJson[kJsonDirectorate] ?? _employeeJson[kJsonDirectorate],
        section: _employeeJson[kJsonSection] ?? _employeeJson[kJsonSection],
        DateOfJoining: _employeeJson[kColumnDateOfJoining] ?? _employeeJson[kColumnDateOfJoining],// _employeeJson[kColumnDateOfJoining]
        location: _employeeJson[kJsonLocationCaps] ?? _employeeJson[kJsonLocationFullCaps],
        telNo: _employeeJson[kJsonTelNo],
        mobileNo: _employeeJson[kJsonMobileNo],
        mobileNo1: _employeeJson[kJsonMobileNo1],
        officeTel: _employeeJson[kJsonOfficeTel],
        officeExt: _employeeJson[kJsonOfficeExt],
        hBJExt: _employeeJson[kJsonHBJExt],
        lTel: _employeeJson[kJsonLTel],
        lGailTel: _employeeJson[kJsonLGailTel],
        faxNo: _employeeJson[kJsonFaxNo],
        emails: _employeeJson[kJsonEmails],
        grade: _employeeJson[kJsonGradeCaps] ?? _employeeJson[kJsonGradeFullCaps],
        gradeValue: _gradeValues[_employeeJson[kJsonGradeCaps] ?? _employeeJson[kJsonGradeFullCaps]],
        dateOfBirth: _employeeJson[kJsonDateOfBirth],
        image: _employeeJson[kJsonImage],
        vehicleNo: _employeeJson[kJsonVehicleNo],
      );

  factory Employee.fromDbMap(Map<String, dynamic> _employeeJson) => Employee(
        empNo: _employeeJson[kColumnEmpNo],
        empName: _employeeJson[kColumnEmpName].replaceAll(RegExp(r"\s+\b|\b\s"), ' '),
        designation: _employeeJson[kColumnDesignation],
        department: _employeeJson[kColumnDepartment],
        directorate: _employeeJson[kJsonDirectorate],
        section: _employeeJson[kJsonSection],
        DateOfJoining: _employeeJson[kColumnDateOfJoining],
        location: _employeeJson[kColumnLocation],
        telNo: _employeeJson[kColumnTelNo],
        mobileNo: _employeeJson[kColumnMobileNo],
        mobileNo1: _employeeJson[kColumnMobileNo1],
        officeTel: _employeeJson[kColumnOfficeTel],
        officeExt: _employeeJson[kColumnOfficeExt],
        hBJExt: _employeeJson[kColumnHBJExt],
        lTel: _employeeJson[kColumnLTel],
        lGailTel: _employeeJson[kColumnLGailTel],
        faxNo: _employeeJson[kColumnFaxNo],
        emails: _employeeJson[kColumnEmails],
        grade: _employeeJson[kColumnGrade],
        gradeValue: _employeeJson[kColumnGradeValue],
        dateOfBirth: _employeeJson[kColumnDateOfBirth],
        image: _employeeJson[kColumnImage],
        vehicleNo: _employeeJson[kColumnVehicleNo],
      );

  Map<String, dynamic> toMap() => {
        kColumnEmpNo: empNo,
        kColumnEmpName: empName,
        kColumnDesignation: designation,
        kColumnDepartment: department,
        kColumnSDirectorate: directorate,
        kColumnSection: section,
        kColumnDateOfJoining:DateOfJoining,
        kColumnLocation: location,
        kColumnTelNo: telNo,
        kColumnMobileNo: mobileNo,
        kColumnMobileNo1: mobileNo1,
        kColumnOfficeTel: officeTel,
        kColumnOfficeExt: officeExt,
        kColumnHBJExt: hBJExt,
        kColumnLTel: lTel,
        kColumnLGailTel: lGailTel,
        kColumnFaxNo: faxNo,
        kColumnEmails: emails,
        kColumnGrade: grade,
        kColumnGradeValue: gradeValue,
        kColumnDateOfBirth: dateOfBirth,
        kColumnImage: image,
        kColumnVehicleNo: vehicleNo,
      };
}

class Section {
  String? empSection;
  String? empSectionDesc;

  Section({this.empSection, this.empSectionDesc});

  factory Section.fromJson(Map<String, dynamic> _sectionJson) => Section(
    empSection: _sectionJson[kSection],
    empSectionDesc: _sectionJson[kSectionDes],
  );
  factory Section.fromDbMap(Map<String, dynamic> _sectionJson) => Section(
    empSection: _sectionJson[kSection],
    empSectionDesc: _sectionJson[kSectionDes],
  );

  Map<String, dynamic> toMap() => {
    kSection: empSection,
    kSectionDes: empSectionDesc,
  };
}

class EmployeeDb {
  final String tag = 'EmployeeDb';

  static Future<Employee?> getLoggedInEmployeeFromDb() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String? _cpfNumber = await pref.getString("cpfNumber",isEncrypted: true);

    try {
      final _db = await DbProvider.db.database;


      final String _query = "SELECT * FROM $kTableEmployees WHERE $kColumnEmpNo = '$_cpfNumber'";
      final _result = await _db!.rawQuery(_query);


      if (_result.isNotEmpty) {
        final List<Employee> _employeeList =
            _result.map<Employee>((_employeeJson) => Employee.fromDbMap(_employeeJson)).toList();

        return _employeeList.first;
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while getting employee logged in from db',
      );

      return null;
    }
  }

  static Future<List<Employee>> getGroupEmployees({required String groupMembers}) async {
    try {
      final _db = await DbProvider.db.database;
      final String _groupMembers = groupMembers.split(',').map((_member) => "'${_member.padLeft(8, '0')}'").join(',');

      final String _query = "SELECT * FROM $kTableEmployees WHERE $kColumnEmpNo IN ($_groupMembers)";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting employee logged in is: $_query');
      debugPrint('result for getting employee logged in is: $_result');

      if (_result.isNotEmpty) {
        final List<Employee> _employeeList =
            _result.map<Employee>((_employeeJson) => Employee.fromDbMap(_employeeJson)).toList();

        return _employeeList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while getting employee logged in from db',
      );

      return [];
    }
  }

  static Future<List<Employee>> getEmployeesListBySearchQueryFromDb({required String searchQuery}) async {
    try {
      final _db = await DbProvider.db.database;
      final String _searchQuery = searchQuery.replaceAll(' ', '%');

      final String _query = "SELECT * FROM $kTableEmployees "
          "WHERE $kColumnEmpName LIKE '%$_searchQuery%' "
          "OR $kColumnEmpNo LIKE '%$_searchQuery%' "
          "OR $kColumnTelNo LIKE '%$_searchQuery%' "
          "OR $kColumnMobileNo LIKE '%$_searchQuery%' "
          "ORDER BY $kColumnEmpName ASC;";

      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting employees list is: $_query');
      debugPrint('result for getting employees list is: $_result');

      if (_result.isNotEmpty) {
        final List<Employee> _employeeList =
            _result.map<Employee>((_employeeJson) => Employee.fromDbMap(_employeeJson)).toList();

        return _employeeList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while getting employees list from db',
      );

      return [];
    }
  }

  static Future<List<Employee>> getEmployeesListBySearchQuerywithfilterFromDb({required String searchQuery,
    String empGrade = '',
    String location = '',
    String department = '',
    String directorate = '',
    String section ='',
    bool allEmployees = false,
    bool forBirthdayList = false,
    required bool isFilterSelected,
  }) async {
    try {
      final _db = await DbProvider.db.database;
      final String _searchQuery = searchQuery.replaceAll(' ', '%');
      String _whereClause = "", _sortingOrder = '';

      if(section!=''){
        String findSection = "select $kSection from $kTableSectionMaster where $kSectionDes = '$section'";
        final _result = await _db!.rawQuery(findSection);
        final subDepartmentList = _result
            .map<String>((s) => s['SECTION'].toString());
        section = subDepartmentList.first;
      }
      if(empGrade=='Executives'){
        _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade between 'E0' and 'E9' and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end) AND $kColumnEmpName LIKE '%$_searchQuery%' "
            "OR $kColumnEmpNo LIKE '%$_searchQuery%' "
            "OR $kColumnTelNo LIKE '%$_searchQuery%' "
            "OR $kColumnMobileNo LIKE '%$_searchQuery%' "
            "ORDER BY $kColumnEmpName ASC;";
        String q = "select count(*) from $kTableEmployees where $kColumnGrade between 'E0' AND 'E9' ";
        final _result1 = await _db!.rawQuery(q);
        print("count from executive :: $_result1");
      }else if(empGrade=='Non-Executives'){
        _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade between 'S0' and 'S7' and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end) AND $kColumnEmpName LIKE '%$_searchQuery%' "
            "OR $kColumnEmpNo LIKE '%$_searchQuery%' "
            "OR $kColumnTelNo LIKE '%$_searchQuery%' "
            "OR $kColumnMobileNo LIKE '%$_searchQuery%' "
            "ORDER BY $kColumnEmpName ASC;";
        String q = "select count(*) from $kTableEmployees where $kColumnGrade between 'S0' AND 'S7' ";
        final _result1 = await _db!.rawQuery(q);
        print("count from non executive :: $_result1");
      }
      else{
        _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade = (case when '$empGrade' = '' then $kColumnGrade else '$empGrade' end) and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end) AND $kColumnEmpName LIKE '%$_searchQuery%' "
            "OR $kColumnEmpNo LIKE '%$_searchQuery%' "
            "OR $kColumnTelNo LIKE '%$_searchQuery%' "
            "OR $kColumnMobileNo LIKE '%$_searchQuery%' "
            "ORDER BY $kColumnEmpName ASC;";
        print("count from else");
      }

      final String query = "SELECT * FROM $kTableEmployees $_whereClause";
      // "WHERE $kColumnEmpName LIKE '%$_searchQuery%' "
      // "OR $kColumnEmpNo LIKE '%$_searchQuery%' "
      // "OR $kColumnTelNo LIKE '%$_searchQuery%' "
      // "OR $kColumnMobileNo LIKE '%$_searchQuery%' "
      // "ORDER BY $kColumnEmpName ASC;";



      final _result = await _db!.rawQuery(query);

      debugPrint('query for getting employees list is: $query');
      debugPrint('result for getting employees list is: $_result');

      if (_result.isNotEmpty) {
        final List<Employee> _employeeList =
        _result.map<Employee>((_employeeJson) => Employee.fromDbMap(_employeeJson)).toList();

        return _employeeList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while getting employees list from db',
      );

      return [];
    }
  }

  static Future<List<Employee>> getEmployeesListWithVehicleFromDb() async {
    try {
      final _db = await DbProvider.db.database;

      const String _query = "SELECT * FROM $kTableEmployees "
          "WHERE $kColumnVehicleNo <> '' ORDER BY $kColumnEmpName ASC;";

      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting employees list is: $_query');
      debugPrint('result for getting employees list is: $_result');

      if (_result.isNotEmpty) {
        final List<Employee> _employeeList =
            _result.map<Employee>((_employeeJson) => Employee.fromDbMap(_employeeJson)).toList();

        return _employeeList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while getting employees list from db',
      );

      return [];
    }
  }


  static Future<List<Employee>> getEmployeesListFromDbwithfiltersearch({
    required String searchQuery,
    String empGrade = '',
    String location = '',
    String department = '',
    String directorate = '',
    String section ='',
    bool allEmployees = false,
    bool forBirthdayList = false,
    required bool isFilterSelected,
  }) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String? _cpfNumber = await pref.getString("cpfNumber",isEncrypted: true);
    final String? _contactListBy = await pref.getString("contactListBy")??kMyLocationAndDepartment;
    final String? _sortListBy = await pref.getString("sortContactListBy")??kAlphabetWiseSorting;
    print("jhge e gew f fwkgyfk wkuyg ffku fkgu fu fku ff fiewuifbds fsjvfd   ${_contactListBy}   ${_sortListBy}");

    try {
      String _whereClause = "", _sortingOrder = '';
      debugPrint('all emp value is: $allEmployees && is filter selected value is: $isFilterSelected');

      final _db = await DbProvider.db.database;
      final String? _location = MainDashController.to.loggedInEmployee?.location;
      final String? _department = MainDashController.to.loggedInEmployee?.department;

      if (forBirthdayList) {
        final String _currentDateTime = DateTime.now().formatDateTime(newDateTimeFormat: kDateOfBirthFormat);
        _sortingOrder = "ORDER BY $kColumnEmpName ASC";
        _whereClause = "WHERE $kColumnDateOfBirth LIKE '%$_currentDateTime%'";
      } else {
        if (allEmployees) {
          _whereClause = "WHERE EmpNo <> '${_cpfNumber}'";
          _sortingOrder = "ORDER BY $kColumnEmpName ASC";
        } else if (isFilterSelected) {
          print("isFilterSelected ${isFilterSelected}");
          print("department ${department}");
          print("location ${location}");
          print("empGrade ${empGrade}");
          if(section!=''){
            String findSection = "";
            if(searchQuery == ""){
              findSection = "select $kSection from $kTableSectionMaster where $kSectionDes = '$section' ";
            }else{
              findSection = "select $kSection from $kTableSectionMaster where $kSectionDes = '$section' AND $kColumnEmpName LIKE '%$searchQuery%' "
                  "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                  "OR $kColumnTelNo LIKE '%$searchQuery%' "
                  "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                  "ORDER BY $kColumnEmpName ASC";
            }

            final _result = await _db!.rawQuery(findSection);
            final subDepartmentList = _result
                .map<String>((s) => s['SECTION'].toString());
            section = subDepartmentList.first;
          }
          if(empGrade=='Executives'){
            _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade between 'E0' and 'E9' and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end) AND $kColumnEmpName LIKE '%$searchQuery%' "
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";
            String q = "select count(*) from $kTableEmployees where $kColumnGrade between 'E0' AND 'E9'"
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";
            final _result1 = await _db!.rawQuery(q);
            print("count from executive :: $_result1");
          }else if(empGrade=='Non-Executives'){
            _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade between 'S0' and 'S7' and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end) AND $kColumnEmpName LIKE '%$searchQuery%' "
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";
            String q = "select count(*) from $kTableEmployees where $kColumnGrade between 'S0' AND 'S7'";
            final _result1 = await _db!.rawQuery(q);
            print("count from non executive :: $_result1");
          }
          else{
            if(searchQuery == ''){
              _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade = (case when '$empGrade' = '' then $kColumnGrade else '$empGrade' end) and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end) ORDER BY $kColumnEmpName ASC";
            }else {
              _whereClause =
              "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade = (case when '$empGrade' = '' then $kColumnGrade else '$empGrade' end) and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end) AND $kColumnEmpName LIKE '%$searchQuery%' "
                  "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                  "OR $kColumnTelNo LIKE '%$searchQuery%' "
                  "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                  "ORDER BY $kColumnEmpName ASC";
            }
            print("count from else");
          }

        } else {
          // final String _contactListBy = contactListBy!;
          print("hcgvjbkn mjcvm kvj ${kColumnLocation }  ${_location}");
          final String _searchQuery = 'Ashish';



          if (_contactListBy == kMyLocationAndDepartment) {
            _whereClause = "WHERE $kColumnDepartment = '$_department' AND $kColumnLocation = '$_location'  AND $kColumnEmpName LIKE '%$searchQuery%' "
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";

          } else if (_contactListBy == kMyLocation) {
            _whereClause = "WHERE $kColumnLocation = '$_location' AND $kColumnEmpName LIKE '%$searchQuery%' "
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";
          } else if (_contactListBy == kMyDepartment) {
            _whereClause = "WHERE $kColumnDepartment = '$_department' AND $kColumnEmpName LIKE '%$searchQuery%' "
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";
          } else if (_contactListBy == kAllDGMAndAbove) {
            _whereClause = "WHERE $kColumnGrade = 'E7' OR $kColumnGrade = 'E8' OR "
                "$kColumnGrade = 'E9' OR $kColumnGrade= 'A' OR $kColumnGrade = 'B' AND $kColumnEmpName LIKE '%$searchQuery%' "
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";
          } else if (_contactListBy == kAllGMAndAbove) {
            _whereClause = "WHERE $kColumnGrade = 'E8' OR $kColumnGrade = 'E9' OR "
                "$kColumnGrade = 'A' OR $kColumnGrade = 'B' AND $kColumnEmpName LIKE '%$searchQuery%' "
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";
          } else if (_contactListBy == kAllEDAndAbove) {
            _whereClause = "WHERE $kColumnGrade = 'E9' OR $kColumnGrade = 'A' OR $kColumnGrade = 'B' AND $kColumnEmpName LIKE '%$searchQuery%' "
                "OR $kColumnEmpNo LIKE '%$searchQuery%' "
                "OR $kColumnTelNo LIKE '%$searchQuery%' "
                "OR $kColumnMobileNo LIKE '%$searchQuery%' "
                "ORDER BY $kColumnEmpName ASC";
          }
        }

        // final String _sortListBy = sortListBy!;

        // if (_sortListBy == kAlphabetWiseSorting) {
        //   _sortingOrder = "ORDER BY $kColumnEmpName ASC";
        // } else {
        //   _sortingOrder = "ORDER BY ABS($kColumnGradeValue), $kColumnEmpName";
        // }
      }

      final String _query = "SELECT * FROM $kTableEmployees $_whereClause $_sortingOrder";
      final _result = await _db!.rawQuery(_query);


      debugPrint('query for getting employees list is: $_query');
      debugPrint('result for getting employees list is: $_result');

      if (_result.isNotEmpty) {
        final List<Employee> _employeeList =
        _result.map<Employee>((_employeeJson) => Employee.fromDbMap(_employeeJson)).toList();

        return _employeeList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while getting employees list from db',
      );

      return [];
    }
  }


  static Future<List<Employee>> getEmployeesListFromDb({
    String empGrade = '',
    String location = '',
    String department = '',
    String directorate = '',
    String section ='',
    bool allEmployees = false,
    bool forBirthdayList = false,
    required bool isFilterSelected,
  }) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String? _cpfNumber = await pref.getString("cpfNumber",isEncrypted: true);
    final String? _contactListBy = await pref.getString("contactListBy")??kMyLocationAndDepartment;
    final String? _sortListBy = await pref.getString("sortContactListBy")??kAlphabetWiseSorting;
    print("_contactListBy------ :: $_contactListBy");
    try {
      String _whereClause = "", _sortingOrder = '';

      final _db = await DbProvider.db.database;
      final String? _location = MainDashController.to.loggedInEmployee?.location;
      final String? _department = MainDashController.to.loggedInEmployee?.department;

      if (forBirthdayList) {
        final String _currentDateTime = DateTime.now().formatDateTime(newDateTimeFormat: kDateOfBirthFormat);
        _sortingOrder = "ORDER BY $kColumnEmpName ASC";
        _whereClause = "WHERE $kColumnDateOfBirth LIKE '%$_currentDateTime%'";
      } else {
        if (allEmployees) {
          _whereClause = "WHERE EmpNo <> '${_cpfNumber}'";
          _sortingOrder = "ORDER BY $kColumnEmpName ASC";
        } else if (isFilterSelected) {

          if(section!=''){
            String findSection = "select $kSection from $kTableSectionMaster where $kSectionDes = '$section'";
            final _result = await _db!.rawQuery(findSection);
            final subDepartmentList = _result
                .map<String>((s) => s['SECTION'].toString());
            section = subDepartmentList.first;
          }
          if(empGrade=='Executives'){
            _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade between 'E0' and 'E9' and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end)";
             String q = "select count(*) from $kTableEmployees where $kColumnGrade between 'E0' AND 'E9' ";
            final _result1 = await _db!.rawQuery(q);
          }else if(empGrade=='Non-Executives'){
            _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade between 'S0' and 'S7' and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end) ";
            String q = "select count(*) from $kTableEmployees where $kColumnGrade between 'S0' AND 'S7' ";
            final _result1 = await _db!.rawQuery(q);
          }
          else{
            _whereClause = "where $kColumnLocation = (case when '$location' = '' then $kColumnLocation else '$location' end) and $kColumnGrade = (case when '$empGrade' = '' then $kColumnGrade else '$empGrade' end) and $kColumnDepartment = (case when '$department' = '' then $kColumnDepartment else '$department' end) and $kColumnSDirectorate = (case when '$directorate' = '' then $kColumnSDirectorate else '$directorate' end) and $kColumnSection = (case when '$section' = '' then $kColumnSection else '$section' end)";
          }

        } else {
          // final String _contactListBy = contactListBy!;

          if (_contactListBy == kMyLocationAndDepartment) {
            _whereClause = "WHERE $kColumnDepartment = '$_department' AND $kColumnLocation = '$_location'";
          } else if (_contactListBy == kMyLocation) {
            _whereClause = "WHERE $kColumnLocation = '$_location'";
          } else if (_contactListBy == kMyDepartment) {
            _whereClause = "WHERE $kColumnDepartment = '$_department'";
          } else if (_contactListBy == kAllDGMAndAbove) {
            _whereClause = "WHERE $kColumnGrade = 'E7' OR $kColumnGrade = 'E8' OR "
                "$kColumnGrade = 'E9' OR $kColumnGrade= 'A' OR $kColumnGrade = 'B'";
          } else if (_contactListBy == kAllGMAndAbove) {
            _whereClause = "WHERE $kColumnGrade = 'E8' OR $kColumnGrade = 'E9' OR "
                "$kColumnGrade = 'A' OR $kColumnGrade = 'B'";
          } else if (_contactListBy == kAllEDAndAbove) {
            _whereClause = "WHERE $kColumnGrade = 'E9' OR $kColumnGrade = 'A' OR $kColumnGrade = 'B'";
          }
        }

        // final String _sortListBy = sortListBy!;

        if (_sortListBy == kAlphabetWiseSorting) {
          _sortingOrder = "ORDER BY $kColumnEmpName ASC";
        } else {
          _sortingOrder = "ORDER BY ABS($kColumnGradeValue), $kColumnEmpName";
        }
      }

      final String _query = "SELECT * FROM $kTableEmployees $_whereClause $_sortingOrder";

      final _result = await _db!.rawQuery(_query);


      final String _searchQuery = "Prince";



      final alpha =  "SELECT * FROM $kTableEmployees $_whereClause  UNION SELECT * FROM $kTableEmployees "
          "WHERE $kColumnEmpName LIKE '%$_searchQuery%' "
          "OR $kColumnEmpNo LIKE '%$_searchQuery%' "
          "OR $kColumnTelNo LIKE '%$_searchQuery%' "
          "OR $kColumnMobileNo LIKE '%$_searchQuery%' "
          "ORDER BY $kColumnEmpName ASC";

      print("QUERY :: $alpha");

      final _resultS = await _db.rawQuery(alpha);

      print("Aplhaaa :: $_resultS");

      if (_result.isNotEmpty) {
        final List<Employee> _employeeList =
            _result.map<Employee>((_employeeJson) => Employee.fromDbMap(_employeeJson)).toList();

        return _employeeList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while getting employees list from db',
      );

      return [];
    }
  }


  static Future<List<Employee>> getNewJoinedEmployeesList() async {
    String _whereClause = "",
        _sortingOrder = '';
    final String _currentMonthTime = DateTime.now()
        .add(Duration(days: -30))
        .formatDateTime(newDateTimeFormat: kDateOfJoiningFormat);
    final String _currentYearTime = DateTime.now()
        .add(Duration(days: -30))
        .formatDateTime(newDateTimeFormat: kYearOfJoiningFormat);
    _sortingOrder = "ORDER BY $kColumnEmpName ASC";


    DateTime firstDayCurrentMonth = DateTime.now()
        .add(Duration(days: -30));

    DateTime lastDayCurrentMonth = DateTime.now();

    String FD = DateFormat("dd.MM.yyyy").format(DateTime.now()
        .add(Duration(days: -30)));
    String LD = DateFormat("dd.MM.yyyy").format(DateTime.now());

    _whereClause = "WHERE $kColumnDateOfJoining between '$FD' and '$LD'";

    print("last day of the current month ::${DateFormat("dd.MM.yyyy").format(
        firstDayCurrentMonth)} $firstDayCurrentMonth $lastDayCurrentMonth");

    final String _query = "SELECT * FROM $kTableEmployees "; //$_whereClause $_sortingOrder

    final _db = await DbProvider.db.database;
    final _result = await _db!.rawQuery(_query);

    try {
      if (_result.isNotEmpty) {
        List<Employee> newJoinedEmployees = [];
        final List<Employee> _employeeList =
        _result.map<Employee>((_employeeJson) =>
            Employee.fromDbMap(_employeeJson)).toList();
        print("_employeeList date od joining :: ${_employeeList[0]
            .DateOfJoining}");
        for (int i = 0; i < _employeeList.length; i++) {
          DateTime d = DateFormat("dd.MM.yyyy").parse(
              _employeeList[i].DateOfJoining!);

          if(d.isBefore(lastDayCurrentMonth) && d.isAfter(firstDayCurrentMonth)){
            // print("_employeeList :: ${d.year}  ${d.month} ${_employeeList[i].DateOfJoining}");
            newJoinedEmployees.add(_employeeList[i]);
          }

          // if (_currentMonthTime.toInt == months &&
          //     _currentYearTime.toInt == years) {
          //
          // }
        }
        print(
            "length of new joined employess from DB :: ${newJoinedEmployees}");
        return newJoinedEmployees;
      }
    } catch (e, s) {
      print(
          "length of new joined employess from DB :: ${e}");
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while inserting records int employees table',
      );
    }
    return [];
  }

  static Future<int?> insertIntoEmployeesTable(Employee _employee) async {
    try {
      final _db = await DbProvider.db.database;

      final _result = await _db!.insert(kTableEmployees, _employee.toMap());
      debugPrint('insert result for employees table is: $_result');

      return _result;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while inserting records int employees table',
      );

      return -1;
    }
  }

  static batchInsertIntoEmployeesTable(List<Employee> _employeeList) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();

      const String _deleteQuery = 'DELETE FROM $kTableEmployees';
      final _deleteResult = await _db.rawQuery(_deleteQuery);

      debugPrint('delete result for employees table is: $_deleteResult');

      for (final Employee _employee in _employeeList) {
        _batch.insert(kTableEmployees, _employee.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

        /*// calling get record count method
        final int? _result = await DbProvider.db.getRecordCount(
          tableName: kTableEmployees,
          whereClause: '$kColumnEmpNo = ${_employee.empNo}',
        );

        if (_result != null && _result > 0) {
          // calling update employees table method
          await EmployeeDb.updateEmployeesTable(_employee);
        } else {
          // calling insert into employees table method
          await EmployeeDb.insertIntoEmployeesTable(_employee);
        }*/
      }

      final _result = await _batch.commit();
      /*final _result = await _db!.insert(kTableEmployees, _employee.toMap());
      debugPrint('insert result for employees table is: $_result');

      return _result;*/

      debugPrint('result of batch insert is: $_result');
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while inserting records int employees table',
      );
    }
  }

  static batchInsertIntoSectionTable(List<Section> _sectionList) async{
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();

      const String _deleteQuery = 'DELETE FROM $kTableSectionMaster';
      final _deleteResult = await _db.rawQuery(_deleteQuery);

      debugPrint('delete result for employees table is: $_deleteResult');

      for (final Section _employee in _sectionList) {
        _batch.insert(kTableSectionMaster, _employee.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

        /*// calling get record count method
        final int? _result = await DbProvider.db.getRecordCount(
          tableName: kTableEmployees,
          whereClause: '$kColumnEmpNo = ${_employee.empNo}',
        );

        if (_result != null && _result > 0) {
          // calling update employees table method
          await EmployeeDb.updateEmployeesTable(_employee);
        } else {
          // calling insert into employees table method
          await EmployeeDb.insertIntoEmployeesTable(_employee);
        }*/
      }

      final _result = await _batch.commit();

      final String _query1 = "SELECT * FROM $kTableSectionMaster";
      final _result1 = await _db.rawQuery(_query1);
      debugPrint('insert result for kTableSectionMaster: $_result1');

      /*final _result = await _db!.insert(kTableEmployees, _employee.toMap());

      return _result;*/

      debugPrint('result of batch section insert is: $_result');
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while inserting records int employees table',
      );
    }
  }

  static Future<int> updateEmployeesTable(Employee _employee) async {
    try {
      final _db = await DbProvider.db.database;

      final _result = await _db!.update(
        kTableEmployees,
        _employee.toMap(),
        where: '$kColumnEmpNo = ?',
        whereArgs: [_employee.empNo],
      );

      debugPrint('update result for employees table is: $_result');

      return _result;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: EmployeeDb().tag,
        exceptionMsg: 'exception while updating records in employees table',
      );

      return -1;
    }
  }

  static Future<List<String>> getDirectorateFromDepartment(String department, String location, String grade, String section) async {
    print("getSubFunction directorate department $department location $location grade $grade");
    final _db = await DbProvider.db.database;
    // String setSection = "";
    if(section!=''){
     String findSection = "select $kSection from $kTableSectionMaster where $kSectionDes = '$section'";
      final _result = await _db!.rawQuery(findSection);
     final subDepartmentList = _result
         .map<String>((s) => s['SECTION'].toString());
     section = subDepartmentList.first;
    }

    String whereClause='';
    if(department.isNullOrEmpty && location.isNullOrEmpty && grade.isNullOrEmpty && section.isNullOrEmpty) {
      whereClause='';
    }
    if(department!='' && location!='' && grade!='' && section!='') {
      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnDepartment = '$department' AND $kColumnLocation = '$location' AND $kColumnSection = '$section'";
      } else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnDepartment == '$department' AND $kColumnLocation == '$location' AND $kColumnSection = '$section'";
      } else {
        whereClause =
        "WHERE $kColumnGrade == '$grade' AND $kColumnDepartment == '$department' AND $kColumnLocation == '$location' AND $kColumnSection = '$section'";
      }
    }
    if(department != '' && location.isNullOrEmpty && grade.isNullOrEmpty && section.isNullOrEmpty){

      whereClause = "WHERE $kColumnDepartment == '$department'";
    }
    if(department.isNullOrEmpty  && location != '' && grade.isNullOrEmpty && section.isNullOrEmpty){
      whereClause = "WHERE $kColumnLocation == '$location'";
    }
    if(department.isNullOrEmpty && location.isNullOrEmpty && grade !='' && section.isNullOrEmpty){
      if (grade == 'Executives') {
        whereClause = "WHERE $kColumnGrade between 'E0' and 'E9' ";
      }else if (grade == 'Non-Executives') {
        whereClause = "WHERE $kColumnGrade between 'S0' and 'S7'";
      }else {
        whereClause = "WHERE $kColumnGrade == '$grade'";
      }
    }
    if(department.isNullOrEmpty && location!='' && grade !='' && section.isNullOrEmpty){
      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnLocation == '$location'";
      }else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnLocation == '$location'";
      }else {
        whereClause =
        "WHERE $kColumnGrade == '$grade' AND $kColumnLocation == '$location'";
      }
    }
    if(department!='' && location!='' && grade.isNullOrEmpty && section.isNullOrEmpty){
      whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnLocation == '$location'";
    }
    if(department!='' && location.isNullOrEmpty && grade!='' && section.isNullOrEmpty){
      if (grade == 'Executives') {
        whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade between 'E0' and 'E9'";
      }else if (grade == 'Non-Executives') {
        whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade between 'S0' and 'S7'";
      }else{
      whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade == '$grade'";
      }
    }
    if(department.isNullOrEmpty && location.isNullOrEmpty && grade.isNullOrEmpty && section!='')
    {
      whereClause = "WHERE $kColumnSection == '$section'";
    }
    if(department.isNullOrEmpty && location!='' && grade.isNullOrEmpty && section !='')
    {
      whereClause = "WHERE $kColumnSection = '$section' AND $kColumnLocation = '$location'";
    }
    if(department.isNullOrEmpty && location!='' && grade.isNullOrEmpty && section !='')
    {
      whereClause = "WHERE $kColumnSection = '$section' AND $kColumnLocation = '$location'";
    }
    if(department.isNullOrEmpty && location!='' && grade!='' && section !='')
    {
      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9'  AND $kColumnLocation = '$location' AND $kColumnSection = '$section'";
      } else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnLocation == '$location' AND $kColumnSection = '$section'";
      } else {
        whereClause = "WHERE $kColumnSection = '$section' AND $kColumnGrade = '$grade' AND $kColumnLocation = '$location' ";
      }
    }
    if(department.isNullOrEmpty && location.isNullOrEmpty && grade!='' && section !='')
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
    if(department!='' && location!='' && grade!='' && section.isNullOrEmpty)
    {
      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9'  AND $kColumnLocation = '$location' AND $kColumnDepartment = '$department'";
      } else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnLocation == '$location' AND $kColumnDepartment = '$department'";
      } else {
        whereClause = "WHERE $kColumnDepartment = '$department' AND $kColumnGrade = '$grade' AND $kColumnLocation = '$location'";
      }

    }

    String _query = "select distinct($kColumnSDirectorate) from $kTableEmployees $whereClause ORDER BY $kColumnSDirectorate ASC";
   print("query to find directorate :: $_query");
    final _result = await _db!.rawQuery(_query);
    print("query to find directorate :: $_result");
    if (_result.isNotEmpty) {
      final List<String> subDepartmentList = _result
          .map<String>((s) => s['Directorate'].toString())
          .toList();
      print("health list length :: ${subDepartmentList.length}");
      print("health list length :: ${_result}");

      return subDepartmentList;
    }
    return [];
  }

  static Future<List<String>> getEmployeeSection(String department, String location, String grade, String directorate) async{
    final _db = await DbProvider.db.database;

    String whereClause='';
    if(department.isNullOrEmpty && location.isNullOrEmpty && grade.isNullOrEmpty && directorate.isNullOrEmpty) {
      whereClause='';
    }
    if(department!='' && location!='' && grade!='' && directorate!='') {
      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnDepartment = '$department' AND $kColumnLocation = '$location' AND $kColumnSDirectorate = '$directorate'";
      } else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnDepartment == '$department' AND $kColumnLocation == '$location' AND $kColumnSDirectorate = '$directorate'";
      } else {
        whereClause =
        "WHERE $kColumnGrade == '$grade' AND $kColumnDepartment == '$department' AND $kColumnLocation == '$location' AND $kColumnSDirectorate = '$directorate'";
      }
    }
    if(department != '' && location.isNullOrEmpty && grade.isNullOrEmpty && directorate.isNullOrEmpty){

      whereClause = "WHERE $kColumnDepartment == '$department'";
    }
    if(department.isNullOrEmpty  && location != '' && grade.isNullOrEmpty && directorate.isNullOrEmpty){
      whereClause = "WHERE $kColumnLocation == '$location'";
    }
    if(department.isNullOrEmpty && location.isNullOrEmpty && grade !='' && directorate.isNullOrEmpty){
      if (grade == 'Executives') {
        whereClause = "WHERE $kColumnGrade between 'E0' and 'E9' ";
      }else if (grade == 'Non-Executives') {
        whereClause = "WHERE $kColumnGrade between 'S0' and 'S7'";
      }else {
        whereClause = "WHERE $kColumnGrade == '$grade'";
      }
    }
    if(department.isNullOrEmpty && location!='' && grade !='' && directorate.isNullOrEmpty){
      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnLocation == '$location'";
      }else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnLocation == '$location'";
      }else {
        whereClause =
        "WHERE $kColumnGrade == '$grade' AND $kColumnLocation == '$location'";
      }
    }
    if(department!='' && location!='' && grade.isNullOrEmpty && directorate.isNullOrEmpty){
      whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnLocation == '$location'";
    }
    if(department!='' && location.isNullOrEmpty && grade!='' && directorate.isNullOrEmpty){
      if (grade == 'Executives') {
        whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade between 'E0' and 'E9'";
      }else if (grade == 'Non-Executives') {
        whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade between 'S0' and 'S7'";
      }else{
        whereClause = "WHERE $kColumnDepartment == '$department' AND $kColumnGrade == '$grade'";
      }
    }
    if(department.isNullOrEmpty && location.isNullOrEmpty && grade.isNullOrEmpty && directorate!='')
    {
      whereClause = "WHERE $kColumnSDirectorate == '$directorate'";
    }
    if(department.isNullOrEmpty && location!='' && grade.isNullOrEmpty && directorate !='')
    {
      whereClause = "WHERE $kColumnSDirectorate = '$directorate' AND $kColumnLocation = '$location'";
    }
    if(department.isNullOrEmpty && location!='' && grade.isNullOrEmpty && directorate !='')
    {
      whereClause = "WHERE $kColumnSDirectorate = '$directorate' AND $kColumnLocation = '$location'";
    }
    if(department.isNullOrEmpty && location!='' && grade!='' && directorate !='')
    {
      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnLocation = '$location' AND $kColumnSDirectorate = '$directorate'";
      } else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnLocation == '$location' AND $kColumnSDirectorate = '$directorate'";
      } else {
        whereClause = "WHERE $kColumnSDirectorate = '$directorate' AND $kColumnGrade = '$grade' AND $kColumnLocation = '$location' ";
      }

    }
    if(department.isNullOrEmpty && location.isNullOrEmpty && grade!='' && directorate !='')
    {

      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnSDirectorate = '$directorate'";
      } else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnSDirectorate = '$directorate'";
      } else {
        whereClause = "WHERE $kColumnSDirectorate = '$directorate' AND $kColumnGrade = '$grade'";
      }

    }
    if(department!='' && location!='' && grade!='' && directorate.isNullOrEmpty)
    {

      if (grade == 'Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'E0' and 'E9' AND $kColumnDepartment = '$department' AND $kColumnLocation = '$location'";
      } else if (grade == 'Non-Executives') {
        whereClause =
        "WHERE $kColumnGrade between 'S0' and 'S7' AND $kColumnDepartment = '$department' AND $kColumnLocation = '$location'";
      } else {
        whereClause = "WHERE $kColumnDepartment = '$department' AND $kColumnGrade = '$grade' AND $kColumnLocation = '$location'";

      }
    }


    String _query = "select distinct($kColumnSection) from $kTableEmployees $whereClause ORDER BY $kColumnSection ASC";
    print("_query to find section in employess :: $_query");
    final _result = await _db!.rawQuery(_query);
    print("_query to find section in employess :: $_result");
    if (_result.isNotEmpty) {
      final List<String> employeeSection = _result
          .map<String>((s) => s['Section'].toString())
          .toList();


      List<String> sectionDes = [];
      for(int i = 0 ; i<employeeSection.length;i++){

        if(employeeSection[i]==""){
          // employeeSection.removeAt(i);
        }else{
          print("employeeSection[i] :: ${employeeSection[i]}----");
          String q1 = "select * from $kTableSectionMaster";
          String q = "select $kSectionDes from $kTableSectionMaster where $kSection = '${employeeSection[i]}'";
          final _result = await _db.rawQuery(q);
          final _result1 = await _db.rawQuery(q1);
          final employeeSectionDes = _result
              .map<String>((s) => s[kSectionDes].toString());

          sectionDes.add(employeeSectionDes.first);

          print("Description from abbribation :: ${_result}  ${employeeSectionDes}  ${_result1}");
        }

      }

      print("health list length :: ${employeeSection.length}");
      print("health list length :: ${_result}");
      return sectionDes;
    }
    return [];

  }
}

final _gradeValues = {
  'CMD': '1',
  'DIRECTORS': '2',
  'E9': '3',
  'E8': '4',
  'E7': '5',
  'E6': '6',
  'E5': '7',
  'E4': '8',
  'E3': '9',
  'E2': '10',
  'E1': '11',
  'E0': '12',
  'S7': '13',
  'S6': '14',
  'S5': '15',
  'S4': '16',
  'S3': '17',
  'S2': '18',
  'S1': '19',
  'S0': '20',
};
