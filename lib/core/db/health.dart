import 'package:flutter/cupertino.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:intl/intl.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';


import '../../main.dart';
import '../../models/healthdbModel.dart';
import 'db_provider.dart';

class HealthDb {
  final String tag = 'HealthDb';

  static Future<List<HealthModel>> getHealthListFromDb() async {
    try {
      final _db = await DbProvider.db.database;
      const String _query = "SELECT * FROM $kTableHealthRooms";
      final _result = await _db!.rawQuery(_query);

      if (_result.isNotEmpty) {
        final List<HealthModel> _citiesList = _result
            .map<HealthModel>((_cityJson) => HealthModel.fromJson(_cityJson))
            .toList();
        for (int i = 0; i < _citiesList.length; i++) {
        }
        return _citiesList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDb().tag,
        exceptionMsg: 'exception while getting cities list from db',
      );

      return [];
    }
  }

  static batchInsertIntoHealthTable(HealthModel _healthList) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();
      String checkDatafromDate =
          'SELECT * FROM $kTableHealthRooms WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}';
      final _searchResult = await _db.rawQuery(
          checkDatafromDate);

      if (_searchResult.length == 0) {
        DateTime time2 = DateFormat('HH:mm:ss').parseLoose('00:16:00');
        DateTime time2end = DateFormat('HH:mm:ss').parseLoose('02:59:59');

        DateTime time4 = DateFormat('HH:mm:ss').parseLoose('03:00:00');
        DateTime time4end = DateFormat('HH:mm:ss').parseLoose('04:59:59');

        DateTime time6 = DateFormat('HH:mm:ss').parseLoose('05:00:00');
        DateTime time6end = DateFormat('HH:mm:ss').parseLoose('06:59:59');

        DateTime time8 = DateFormat('HH:mm:ss').parseLoose('07:00:00');
        DateTime time8end = DateFormat('HH:mm:ss').parseLoose('08:59:59');

        DateTime time10 = DateFormat('HH:mm:ss').parseLoose('09:00:00');
        DateTime time10end = DateFormat('HH:mm:ss').parseLoose('10:59:59');

        DateTime time12 = DateFormat('HH:mm:ss').parseLoose('11:00:00');
        DateTime time12end = DateFormat('HH:mm:ss').parseLoose('12:59:59');

        DateTime time14 = DateFormat('HH:mm:ss').parseLoose('13:00:00');
        DateTime time14end = DateFormat('HH:mm:ss').parseLoose('14:59:59');

        DateTime time16 = DateFormat('HH:mm:ss').parseLoose('15:00:00');
        DateTime time16end = DateFormat('HH:mm:ss').parseLoose('16:59:59');

        DateTime time18 = DateFormat('HH:mm:ss').parseLoose('17:00:00');
        DateTime time18end = DateFormat('HH:mm:ss').parseLoose('18:59:59');

        DateTime time20 = DateFormat('HH:mm:ss').parseLoose('19:00:00');
        DateTime time20end = DateFormat('HH:mm:ss').parseLoose('20:59:59');

        DateTime time22 = DateFormat('HH:mm:ss').parseLoose('21:00:00');
        DateTime time22end = DateFormat('HH:mm:ss').parseLoose('22:59:59');

        DateTime time24 = DateFormat('HH:mm:ss').parseLoose('23:00:00');
        DateTime time24end = DateFormat('HH:mm:ss').parseLoose('00:15:59');

        var dt = DateTime.fromMicrosecondsSinceEpoch(
            int.parse(_healthList.sTARTTIME!) * 1000);
        String s = '${dt.hour}:${dt.minute}:${dt.second}';
        DateTime timeSpan = DateFormat('HH:mm:ss').parseLoose(s);

        if (timeSpan.isAfter(time2) && timeSpan.isBefore(time2end)) {
          _healthList.tWOSTEPS = _healthList.sTEPS;
          print("object :: ${_healthList.tWOSTEPS}   ${_healthList.sTEPS}");
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              " ${_healthList.tWOSTEPS}, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)";

          await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
        if (timeSpan.isAfter(time4) && timeSpan.isBefore(time4end)) {
          _healthList.fOURSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, ${_healthList.fOURSTEPS}, 0, 0, 0, 0, 0, 0,0, 0, 0, 0)";

           await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
        if (timeSpan.isAfter(time6) && timeSpan.isBefore(time6end)) {
          _healthList.sIXSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, ${_healthList.sIXSTEPS}, 0, 0, 0, 0, 0,0, 0, 0, 0)";

         await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
        if (timeSpan.isAfter(time8) && timeSpan.isBefore(time8end)) {
          _healthList.eIGHTSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, ${_healthList.eIGHTSTEPS}, 0, 0, 0, 0,0, 0, 0, 0)";

          await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
        if (timeSpan.isAfter(time10) && timeSpan.isBefore(time10end)) {
          _healthList.tENSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, 0, ${_healthList.tENSTEPS}, 0, 0, 0,0, 0, 0, 0)";

          await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
        if (timeSpan.isAfter(time12) && timeSpan.isBefore(time12end)) {
          _healthList.tWELVESTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, 0, 0, ${_healthList.tWELVESTEPS}, 0, 0,0, 0, 0, 0)";

          await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
        if (timeSpan.isAfter(time14) && timeSpan.isBefore(time14end)) {
          _healthList.fOURTEENSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, 0, 0, 0, ${_healthList.fOURTEENSTEPS}, 0,0, 0, 0, 0)";

           await _db.rawQuery(insertQuery);
           await _batch.commit();

        }
        if (timeSpan.isAfter(time16) && timeSpan.isBefore(time16end)) {
          _healthList.sIXTEENSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, 0, 0, 0, 0, ${_healthList.sIXTEENSTEPS}, 0, 0, 0, 0)";

          await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
        if (timeSpan.isAfter(time18) && timeSpan.isBefore(time18end)) {
          _healthList.eIGHTEENSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, 0, 0, 0, 0, 0, ${_healthList.eIGHTEENSTEPS}, 0, 0, 0)";

         await _db.rawQuery(insertQuery);
           await _batch.commit();

        }
        if (timeSpan.isAfter(time20) && timeSpan.isBefore(time20end)) {
          _healthList.tWENTYSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, 0, 0, 0, 0, 0, 0, ${_healthList.tWENTYSTEPS}, 0, 0)";

           await _db.rawQuery(insertQuery);
           await _batch.commit();

        }
        if (timeSpan.isAfter(time22) && timeSpan.isBefore(time22end)) {
          _healthList.tTWOSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, 0, 0, 0, 0, 0,0, 0, ${_healthList.tTWOSTEPS}, 0)";

          await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
        if (timeSpan.isAfter(time24) && timeSpan.isBefore(time24end)) {
          _healthList.tFOURSTEPS = _healthList.sTEPS;
          String insertQuery =
              "INSERT INTO $kTableHealthRooms($kEmployeeCpfNo, "
              "$kUpdatedDate, $kSteps, $kStartTime, $kCalories, $kDistance,"
              "$kTwoSteps, $kFourSteps, $kSixSteps, $kEightSteps, $kTenSteps,"
              "$kTwelveSteps, $kFourteenSteps, $kSixteenSteps, $kEighteenSteps,"
              "$kTwentySteps, $kTTwoSteps, $kTFourSteps) VALUES(${_healthList.eMPNO}, ${_healthList.uPDATEDDATE},"
              "${_healthList.sTEPS}, ${_healthList.sTARTTIME}, ${_healthList.cAL}, ${_healthList.dISTANCE},"
              "0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, ${_healthList.tFOURSTEPS})";

          await _db.rawQuery(insertQuery);
          await _batch.commit();

        }
      } else {
        var stepsInDb = _searchResult[0]['STEPS'];
        String steps = stepsInDb.toString();
        String todaySteps =
            (int.parse(_healthList.sTEPS!) - int.parse(steps)).toString();

        if (todaySteps != "0") {
          DateTime time2 = DateFormat('HH:mm:ss').parseLoose('00:16:00');
          DateTime time2end = DateFormat('HH:mm:ss').parseLoose('02:59:59');

          DateTime time4 = DateFormat('HH:mm:ss').parseLoose('03:00:00');
          DateTime time4end = DateFormat('HH:mm:ss').parseLoose('04:59:59');

          DateTime time6 = DateFormat('HH:mm:ss').parseLoose('05:00:00');
          DateTime time6end = DateFormat('HH:mm:ss').parseLoose('06:59:59');

          DateTime time8 = DateFormat('HH:mm:ss').parseLoose('07:00:00');
          DateTime time8end = DateFormat('HH:mm:ss').parseLoose('08:59:59');

          DateTime time10 = DateFormat('HH:mm:ss').parseLoose('09:00:00');
          DateTime time10end = DateFormat('HH:mm:ss').parseLoose('10:59:59');

          DateTime time12 = DateFormat('HH:mm:ss').parseLoose('11:00:00');
          DateTime time12end = DateFormat('HH:mm:ss').parseLoose('12:59:59');

          DateTime time14 = DateFormat('HH:mm:ss').parseLoose('13:00:00');
          DateTime time14end = DateFormat('HH:mm:ss').parseLoose('14:59:59');

          DateTime time16 = DateFormat('HH:mm:ss').parseLoose('15:00:00');
          DateTime time16end = DateFormat('HH:mm:ss').parseLoose('16:59:59');

          DateTime time18 = DateFormat('HH:mm:ss').parseLoose('17:00:00');
          DateTime time18end = DateFormat('HH:mm:ss').parseLoose('18:59:59');

          DateTime time20 = DateFormat('HH:mm:ss').parseLoose('19:00:00');
          DateTime time20end = DateFormat('HH:mm:ss').parseLoose('20:59:59');

          DateTime time22 = DateFormat('HH:mm:ss').parseLoose('21:00:00');
          DateTime time22end = DateFormat('HH:mm:ss').parseLoose('22:59:59');

          DateTime time24 = DateFormat('HH:mm:ss').parseLoose('23:00:00');
          DateTime time24end = DateFormat('HH:mm:ss').parseLoose('00:15:59');

          var dt = DateTime.fromMicrosecondsSinceEpoch(
              int.parse(_healthList.sTARTTIME!) * 1000);

          String s = '${dt.hour}:${dt.minute}:${dt.second}';
          DateTime timeSpan = DateFormat('HH:mm:ss').parseLoose(s);

          if (timeSpan.isAfter(time2) && timeSpan.isBefore(time2end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kTwoSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
          if (timeSpan.isAfter(time4) && timeSpan.isBefore(time4end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kFourSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);

          }
          if (timeSpan.isAfter(time6) && timeSpan.isBefore(time6end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kSixSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
          if (timeSpan.isAfter(time8) && timeSpan.isBefore(time8end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kEightSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
             await _batch.commit();

          }
          if (timeSpan.isAfter(time10) && timeSpan.isBefore(time10end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kTenSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

             await _db.rawQuery(updateQuery);
             await _batch.commit();

          }
          if (timeSpan.isAfter(time12) && timeSpan.isBefore(time12end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kTwelveSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
          if (timeSpan.isAfter(time14) && timeSpan.isBefore(time14end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kFourteenSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

             await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
          if (timeSpan.isAfter(time16) && timeSpan.isBefore(time16end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kSixteenSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
          if (timeSpan.isAfter(time18) && timeSpan.isBefore(time18end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kEighteenSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
          if (timeSpan.isAfter(time20) && timeSpan.isBefore(time20end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kTwentySteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
          if (timeSpan.isAfter(time22) && timeSpan.isBefore(time22end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kTTwoSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
          if (timeSpan.isAfter(time24) && timeSpan.isBefore(time24end)) {
            String updateQuery =
                "UPDATE $kTableHealthRooms SET $kSteps = ${_healthList.sTEPS}, $kStartTime= ${_healthList.sTARTTIME}, $kCalories = ${_healthList.cAL}, $kDistance = ${_healthList.dISTANCE},$kTFourSteps = ${todaySteps} WHERE $kEmployeeCpfNo = ${_healthList.eMPNO} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}";

            await _db.rawQuery(updateQuery);
            await _batch.commit();

          }
        } else {}
      }
    } catch (e, s) {


      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDb().tag,
        exceptionMsg: 'exception while inserting records in health table',
      );
    }
  }

  static Future<List<HealthModel>> getTodaysData() async {
    final _db = await DbProvider.db.database;
    final _batch = _db!.batch();
    SecureSharedPref preferences = await SecureSharedPref.getInstance();
    final String cpfNumber = (await  preferences.getString("cpfNumber",isEncrypted: true))!;

    String checkDatafromDate =
        'SELECT * FROM $kTableHealthRooms WHERE $kEmployeeCpfNo = ${cpfNumber} AND $kUpdatedDate = ${int.parse(DateFormat('ddMMyyyy').format(DateTime.now()))}';
    final _searchResult = await _db.rawQuery(checkDatafromDate);

    List<HealthModel> _citiesList = [];
    if (_searchResult.isNotEmpty) {
      _citiesList = _searchResult
          .map<HealthModel>((_cityJson) => HealthModel.fromJson(_cityJson))
          .toList();

    }

    return _citiesList;
  }
}
