// Created By Amit Jangid 06/09/21

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class City {
  String? cityName;

  City({required this.cityName});

  factory City.fromJson(Map<String, dynamic> _cityJson) => City(cityName: _cityJson[kJsonStateDesc]);

  factory City.fromDbMap(Map<String, dynamic> _cityJson) => City(cityName: _cityJson[kColumnCityName]);

  Map<String, dynamic> toMap() => {kColumnCityName: cityName};
}

class CityDb {
  final String tag = 'CityDb';

  static Future<List<City>> getCitiesListFromDb() async {
    try {
      final _db = await DbProvider.db.database;
      const String _query = "SELECT * FROM $kTableCities";
      final _result = await _db!.rawQuery(_query);

      debugPrint('query for getting cities list is: $_query');
      debugPrint('result for getting cities list is: $_result');

      if (_result.isNotEmpty) {
        final List<City> _citiesList = _result.map<City>((_cityJson) => City.fromDbMap(_cityJson)).toList();

        return _citiesList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: CityDb().tag,
        exceptionMsg: 'exception while getting cities list from db',
      );

      return [];
    }
  }

  static batchInsertIntoCitiesTable(List<City> _citiesList) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();

      const String _deleteQuery = 'DELETE FROM $kTableCities';
      final _deleteResult = await _db.rawQuery(_deleteQuery);

      debugPrint('delete result for cities table is: $_deleteResult');

      for (final City _city in _citiesList) {
        _batch.insert(kTableCities, _city.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      final _result = await _batch.commit();

      debugPrint('result of batch insert for cities table is: $_result');
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: CityDb().tag,
        exceptionMsg: 'exception while inserting records in cities table',
      );
    }
  }
}
