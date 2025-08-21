// Created By Amit Jangid 09/09/21

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';

class Office {
  int? id;
  String? location;
  String? gailNetCode;
  String? address;
  String? fax;
  String? latitude;
  String? longitude;
  String? ePabX;

  Office({
    this.id,
    required this.location,
    required this.gailNetCode,
    required this.address,
    required this.fax,
    required this.latitude,
    required this.longitude,
    required this.ePabX,
  });

  factory Office.fromJson(Map<String, dynamic> _officeJson) => Office(
        location: _officeJson['LOCATION']??"",
        gailNetCode: _officeJson['GAILNET_CODE']??"",
        address: _officeJson['ADDRESS']??"",
        fax: _officeJson['FAX']??"",
        latitude: _officeJson['LATITUDE']??"",
        longitude: _officeJson['LONGITUDE']??"",
        ePabX: _officeJson['EPABX'].toString().replaceAll(';', ','),
      );

  factory Office.fromDbMap(Map<String, dynamic> _officeJson) => Office(
        location: _officeJson[kColumnLocation]??"",
        gailNetCode: _officeJson[kColumnGailNetCode]??"",
        address: _officeJson[kColumnAddress]??"",
        fax: _officeJson[kColumnFax]??"",
        latitude: _officeJson[kColumnLatitude]??"",
        longitude: _officeJson[kColumnLongitude]??"",
        ePabX: _officeJson[kColumnEPabX],
      );

  Map<String, dynamic> toMap() => {
        kColumnLocation: location,
        kColumnGailNetCode: gailNetCode,
        kColumnAddress: address,
        kColumnFax: fax,
        kColumnLatitude: latitude,
        kColumnLongitude: longitude,
        kColumnEPabX: ePabX,
      };
}

class OfficeDb {
  final String tag = 'OfficeDb';

  static Future<List<Office>> getOfficesListFromDb() async {
    try {
      final _db = await DbProvider.db.database;
      const String _query = "SELECT * FROM $kTableOffices ORDER BY $kColumnLocation ASC;";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting offices list is: $_query');
      debugPrint('result for getting offices list is: $_result');

      if (_result.isNotEmpty) {
        final List<Office> _officesList = _result.map<Office>((officesJson) => Office.fromDbMap(officesJson)).toList();

        return _officesList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: OfficeDb().tag,
        exceptionMsg: 'exception while getting offices list from db',
      );

      return [];
    }
  }

  static batchInsertIntoOfficesTable(List<Office> _officesList) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();

      const String _deleteQuery = 'DELETE FROM $kTableOffices';
      final _deleteResult = await _db.rawQuery(_deleteQuery);

      debugPrint('delete result for offices table is: $_deleteResult');

      for (final Office _office in _officesList) {
        _batch.insert(kTableOffices, _office.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      final _result = await _batch.commit();

      debugPrint('result of batch insert for offices table is: $_result');
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: OfficeDb().tag,
        exceptionMsg: 'exception while inserting records int offices table',
      );
    }
  }
}
