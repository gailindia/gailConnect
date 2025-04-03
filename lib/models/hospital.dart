// Created By Amit Jangid 06/09/21

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/models/city.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class Hospital {
  int? id;
  String? hospitalName;
  String? hospitalLoc;
  String? startDate;
  String? name;
  String? endDate;
  String? hospitalAdd;
  String? yYohc;
  String? werks;
  String? latitude;
  String? longitude;
  String? distance;
  List<City> statesList;

  Hospital({
    this.id,
    this.hospitalName,
    this.hospitalLoc,
    this.startDate,
    this.name,
    this.endDate,
    this.hospitalAdd,
    this.yYohc,
    this.werks,
    this.latitude,
    this.longitude,
    this.distance,
    this.statesList = const [],
  });

  factory Hospital.fromJson(Map<String, dynamic> _hospitalJson) => Hospital(
        id: _hospitalJson[kJsonIdCaps],
        hospitalName: _hospitalJson[kJsonHospitalName],
        hospitalLoc: _hospitalJson[kJsonHospitalLoc],
        startDate: _hospitalJson[kJsonStartDateCaps],
        name: _hospitalJson[kJsonName],
        endDate: _hospitalJson[kJsonEndDateCaps],
        hospitalAdd: _hospitalJson[kJsonHospitalAdd],
        yYohc: _hospitalJson[kJsonYYOHC],
        werks: _hospitalJson[kJsonWerks],
        latitude: _hospitalJson[kJsonLatitudeCaps],
        longitude: _hospitalJson[kJsonLongitudeCaps],
        distance: _hospitalJson[kJsonDistance],
      );

  factory Hospital.fromDbMap(Map<String, dynamic> _hospitalJson) => Hospital(
        id: _hospitalJson[kColumnId],
        hospitalName: _hospitalJson[kColumnHospitalName],
        hospitalLoc: _hospitalJson[kColumnHospitalLoc],
        startDate: _hospitalJson[kColumnStartDate],
        name: _hospitalJson[kColumnName],
        endDate: _hospitalJson[kColumnEndDate],
        hospitalAdd: _hospitalJson[kColumnHospitalAdd],
        yYohc: _hospitalJson[kColumnYYohc],
        werks: _hospitalJson[kColumnWerks],
        latitude: _hospitalJson[kColumnLatitude],
        longitude: _hospitalJson[kColumnLongitude],
        distance: _hospitalJson[kColumnDistance],
      );

  Map<String, dynamic> toMap() => {
        kColumnId: id,
        kColumnHospitalName: hospitalName,
        kColumnHospitalLoc: hospitalLoc,
        kColumnStartDate: startDate,
        kColumnName: name,
        kColumnEndDate: endDate,
        kColumnHospitalAdd: hospitalAdd,
        kColumnYYohc: yYohc,
        kColumnWerks: werks,
        kColumnLatitude: latitude,
        kColumnLongitude: longitude,
        kColumnDistance: distance,
      };
}

class HospitalDb {
  final String tag = 'HospitalDb';

  static Future<List<Hospital>> getHospitalsListFromDb() async {
    try {
      final _db = await DbProvider.db.database;
      const String _query = "SELECT * FROM $kTableHospitals";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting hospitals list is: $_query');
      debugPrint('result for getting hospitals list is: $_result');

      if (_result.isNotEmpty) {
        final List<Hospital> _hospitalsList =
            _result.map<Hospital>((_hospitalsJson) => Hospital.fromDbMap(_hospitalsJson)).toList();

        return _hospitalsList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HospitalDb().tag,
        exceptionMsg: 'exception while getting hospitals list from db',
      );

      return [];
    }
  }

  static Future<List<Object?>> batchInsertIntoHospitalsTable(List<Hospital> _hospitalsList) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();

      const String _deleteQuery = 'DELETE FROM $kTableHospitals';
      final _deleteResult = await _db.rawQuery(_deleteQuery);

      debugPrint('delete result for hospitals table is: $_deleteResult');

      for (final Hospital _hospital in _hospitalsList) {
        _batch.insert(kTableHospitals, _hospital.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      final _result = await _batch.commit();
      debugPrint('result of batch insert for hospitals table is: $_result');

      return _result;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HospitalDb().tag,
        exceptionMsg: 'exception while inserting records in hospitals table',
      );

      return [];
    }
  }
}
