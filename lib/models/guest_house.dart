// Created By Amit Jangid 03/09/21

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:multiutillib/utils/string_extension.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';

class GuestHouse {
  int? uniQID;
  String? location;
  String? address;
  String? hvj;
  String? telephone;
  double? latitude;
  double? longitude;

  GuestHouse({
    required this.uniQID,
    required this.location,
    required this.address,
    required this.hvj,
    required this.telephone,
    required this.latitude,
    required this.longitude,
  });

  factory GuestHouse.fromJson(Map<String, dynamic> _guestHouseJson) => GuestHouse(
        uniQID: _guestHouseJson['UNIQ_ID'].toString().toInt,
        location: _guestHouseJson['LOCATION'],
        address: _guestHouseJson['ADDRESS'],
        hvj: _guestHouseJson['HVJ'],
        telephone: _guestHouseJson['TELEPHONE'],
        latitude: _guestHouseJson['LATITUDE'],
        longitude: _guestHouseJson['LONGITUDE'],
      );

  factory GuestHouse.fromDbMap(Map<String, dynamic> _guestHouseJson) => GuestHouse(
        uniQID: _guestHouseJson[kColumnUniQID],
        location: _guestHouseJson[kColumnLocation],
        address: _guestHouseJson[kColumnAddress],
        hvj: _guestHouseJson[kColumnHvj],
        telephone: _guestHouseJson[kColumnTelephone],
        latitude: _guestHouseJson[kColumnLatitude],
        longitude: _guestHouseJson[kColumnLongitude],
      );

  Map<String, dynamic> toMap() => {
        kColumnUniQID: uniQID,
        kColumnLocation: location,
        kColumnAddress: address,
        kColumnHvj: hvj,
        kColumnTelephone: telephone,
        kColumnLatitude: latitude,
        kColumnLongitude: longitude,
      };
}

class GuestHouseDb {
  final String tag = 'GuestHouseDb';

  static Future<List<GuestHouse>> getGuestHousesListFromDb() async {
    try {
      final _db = await DbProvider.db.database;
      const String _query = "SELECT * FROM $kTableGuestHouses";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting guest houses list is: $_query');
      debugPrint('result for getting guest houses list is: $_result');

      if (_result.isNotEmpty) {
        final List<GuestHouse> _guestHousesList =
            _result.map<GuestHouse>((_guestHousesJson) => GuestHouse.fromDbMap(_guestHousesJson)).toList();

        return _guestHousesList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: GuestHouseDb().tag,
        exceptionMsg: 'exception while getting guest houses list from db',
      );

      return [];
    }
  }

  static batchInsertIntoGuestHousesTable(List<GuestHouse> _guestHousesList) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();

      const String _deleteQuery = 'DELETE FROM $kTableGuestHouses';
      final _deleteResult = await _db.rawQuery(_deleteQuery);

      debugPrint('delete result for guest houses table is: $_deleteResult');

      for (final GuestHouse _guestHouse in _guestHousesList) {
        _batch.insert(kTableGuestHouses, _guestHouse.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      final _result = await _batch.commit();

      debugPrint('result of batch insert for guest houses table is: $_result');
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: GuestHouseDb().tag,
        exceptionMsg: 'exception while inserting records in guest houses table',
      );
    }
  }
}
