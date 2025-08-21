// Created By Amit Jangid 09/09/21

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:multiutillib/utils/string_extension.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class ControlRoom {
  String? createdBy;
  String? createdOn;
  String? hbjNo;
  int? id;
  String? location;
  String? modifiedBy;
  String? modifiedOn;
  String? subLocation;
  String? tel1;
  String? tel2;
  String? tel3;
  String? tel4;

  ControlRoom({
    required this.createdBy,
    required this.createdOn,
    required this.hbjNo,
    required this.id,
    required this.location,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.subLocation,
    required this.tel1,
    required this.tel2,
    required this.tel3,
    required this.tel4,
  });

  factory ControlRoom.fromJson(Map<String, dynamic> _controlRoomJson) => ControlRoom(
        createdBy: _controlRoomJson[kJsonCreatedBy],
        createdOn: _controlRoomJson[kJsonCreatedOn],
        hbjNo: _controlRoomJson[kJsonHbjNo],
        id: _controlRoomJson[kJsonIdCaps].toString().toInt,
        location: _controlRoomJson[kJsonLocationFullCaps],
        modifiedBy: _controlRoomJson[kJsonModifiedBy],
        modifiedOn: _controlRoomJson[kJsonModifiedOn],
        subLocation: _controlRoomJson[kJsonSubLocation],
        tel1: _controlRoomJson[kJsonTel1],
        tel2: _controlRoomJson[kJsonTel2],
        tel3: _controlRoomJson[kJsonTel3],
        tel4: _controlRoomJson[kJsonTel4],
      );

  factory ControlRoom.fromDbMap(Map<String, dynamic> _controlRoomJson) => ControlRoom(
        id: _controlRoomJson[kColumnId],
        createdBy: _controlRoomJson[kColumnCreatedBy],
        createdOn: _controlRoomJson[kColumnCreatedOn],
        hbjNo: _controlRoomJson[kColumnHbjNo],
        location: _controlRoomJson[kColumnLocation],
        modifiedBy: _controlRoomJson[kColumnModifiedBy],
        modifiedOn: _controlRoomJson[kColumnModifiedOn],
        subLocation: _controlRoomJson[kColumnSubLocation],
        tel1: _controlRoomJson[kColumnTel1],
        tel2: _controlRoomJson[kColumnTel2],
        tel3: _controlRoomJson[kColumnTel3],
        tel4: _controlRoomJson[kColumnTel4],
      );

  Map<String, dynamic> toMap() => {
        kColumnId: id,
        kColumnCreatedBy: createdBy,
        kColumnCreatedOn: createdOn,
        kColumnHbjNo: hbjNo,
        kColumnLocation: location,
        kColumnModifiedBy: modifiedBy,
        kColumnModifiedOn: modifiedOn,
        kColumnSubLocation: subLocation,
        kColumnTel1: tel1,
        kColumnTel2: tel2,
        kColumnTel3: tel3,
        kColumnTel4: tel4,
      };
}

class ControlRoomDb {
  final String tag = 'ControlRoomDb';

  static Future<List<ControlRoom>> getControlRoomsListFromDb() async {
    try {
      final _db = await DbProvider.db.database;
      const String _query = "SELECT * FROM $kTableControlRooms ORDER BY $kColumnLocation ASC;";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting control rooms list is: $_query');
      debugPrint('result for getting control rooms list is: $_result');

      if (_result.isNotEmpty) {
        final List<ControlRoom> _controlRoomsList =
            _result.map<ControlRoom>((_controlRoomJson) => ControlRoom.fromDbMap(_controlRoomJson)).toList();

        return _controlRoomsList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: ControlRoomDb().tag,
        exceptionMsg: 'exception while getting control rooms list from db',
      );

      return [];
    }
  }

  static batchInsertIntoControlRoomsTable(List<ControlRoom> _controlRoomsList) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();

      for (final ControlRoom _controlRoom in _controlRoomsList) {
        _batch.insert(kTableControlRooms, _controlRoom.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      final _result = await _batch.commit();

      debugPrint('result of batch insert for control rooms table is: $_result');
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: ControlRoomDb().tag,
        exceptionMsg: 'exception while inserting records int control rooms table',
      );
    }
  }
}
