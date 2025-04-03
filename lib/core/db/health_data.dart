
import 'dart:io';

import 'package:gail_connect/models/weekday.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib.dart';


import '../../main.dart';
import '../../models/health_data_model.dart';

import '../../models/target_achieved.dart';
import '../../ui/screens/health_screens/health_screen.dart';
import 'db_provider.dart';

class HealthDataDb {
  final String tag = 'HealthDataDb';
  final List<SalesData> chartDataTodayDB = [];

//12/21/2023 10:16:36
  static Future<List<Map<String, Object?>>> getHealthListFromDb() async {
    try {
      final _db = await DbProvider.db.database;
      const String _query = "SELECT * FROM $kTableHealthDataRooms";
      final _result = await _db!.rawQuery(_query);
      if (_result.isNotEmpty) {

        return _result;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDataDb().tag,
        exceptionMsg: 'exception while getting cities list from db',
      );

      return [];
    }
  }

  static batchInsertIntoHealthDataTable(HealthDataModel _healthList) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();
      String insertQuery="";
      if(Platform.isIOS){
        String selectQ = "select * from $kTableHealthDataRooms where $kUpdatedDate = '${_healthList.updateDate}'";
        final selectResult = await _db.rawQuery(selectQ);
        if(selectResult.isEmpty) {
         insertQuery =
              "INSERT INTO $kTableHealthDataRooms ( $kEmployeeCpfNo, $kUpdatedDate, $kSteps, $kDate) VALUES('${_healthList
              .empNo}', '${_healthList.updateDate}',"
              "'${_healthList.steps}', '${_healthList
              .date}')";
         await _db.rawQuery(insertQuery);
         await _batch.commit();
        }
      }else{
        if(_healthList.steps=="0"){

        }else {
          insertQuery =
          "INSERT INTO $kTableHealthDataRooms($kEmployeeCpfNo, $kUpdatedDate, $kSteps, $kDate) VALUES('${_healthList
              .empNo}', '${_healthList.updateDate}',"
              "'${_healthList.steps}', '${_healthList.date}')";
          await _db.rawQuery(insertQuery);
          await _batch.commit();
        }
      }


    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDataDb().tag,
        exceptionMsg: 'exception while inserting records in health table',
      );
    }
  }

  static Future<String> batchGetTodaysData() async {
    final _db = await DbProvider.db.database;
     _db!.batch();
    String _query =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms";

    final inserResult = await _db.rawQuery(_query);

    String s = inserResult[0]['Total'].toString() == "null"
        ? "0"
        : inserResult[0]['Total'].toString();
    return '$s';
  }

  static Future<String> batchGetSUMsData() async {
    String startDate = DateFormat('MM/dd/yyyy 00:00:00').format(DateTime.now());
    String enddate = DateFormat('MM/dd/yyyy 23:59:59').format(DateTime.now());

    final _db = await DbProvider.db.database;
    _db!.batch();
    String _query =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$startDate' AND "
        "$kUpdatedDate <= '$enddate' ";
    final inserResult = await _db.rawQuery(_query);

    String s = inserResult[0]['Total'].toString() == "null"
        ? "0"
        : inserResult[0]['Total'].toString();
    return '$s';
  }

  static Future<List<SalesData>> batchGetChartsData() async {
    final List<SalesData> chartDataTodayDB = [];
    String start2Date =
        DateFormat('MM/dd/yyyy 00:00:00').format(DateTime.now());
    String end2date = DateFormat('MM/dd/yyyy 01:59:59').format(DateTime.now());

    String start4Date =
        DateFormat('MM/dd/yyyy 02:00:00').format(DateTime.now());
    String end4date = DateFormat('MM/dd/yyyy 03:59:59').format(DateTime.now());

    String start6Date =
        DateFormat('MM/dd/yyyy 04:00:00').format(DateTime.now());
    String end6date = DateFormat('MM/dd/yyyy 05:59:59').format(DateTime.now());

    String start8Date =
        DateFormat('MM/dd/yyyy 06:00:00').format(DateTime.now());
    String end8date = DateFormat('MM/dd/yyyy 07:59:59').format(DateTime.now());

    String start10Date =
        DateFormat('MM/dd/yyyy 08:00:00').format(DateTime.now());
    String end10date = DateFormat('MM/dd/yyyy 09:59:59').format(DateTime.now());

    String start12Date =
        DateFormat('MM/dd/yyyy 10:00:00').format(DateTime.now());
    String end12date = DateFormat('MM/dd/yyyy 11:59:59').format(DateTime.now());

    String start14Date =
        DateFormat('MM/dd/yyyy 12:00:00').format(DateTime.now());
    String end14date = DateFormat('MM/dd/yyyy 13:59:59').format(DateTime.now());

    String start16Date =
        DateFormat('MM/dd/yyyy 14:00:00').format(DateTime.now());
    String end16date = DateFormat('MM/dd/yyyy 15:59:59').format(DateTime.now());

    String start18Date =
        DateFormat('MM/dd/yyyy 16:00:00').format(DateTime.now());
    String end18date = DateFormat('MM/dd/yyyy 17:59:59').format(DateTime.now());

    String start20Date =
        DateFormat('MM/dd/yyyy 18:00:00').format(DateTime.now());
    String end20date = DateFormat('MM/dd/yyyy 19:59:59').format(DateTime.now());

    String start22Date =
        DateFormat('MM/dd/yyyy 20:00:00').format(DateTime.now());
    String end22date = DateFormat('MM/dd/yyyy 21:59:59').format(DateTime.now());

    String start24Date =
        DateFormat('MM/dd/yyyy 22:00:00').format(DateTime.now());
    String end24date = DateFormat('MM/dd/yyyy 23:59:59').format(DateTime.now());

    final _db = await DbProvider.db.database;
    _db!.batch();

    String _two =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start2Date' AND "
        "$kUpdatedDate <= '$end2date' ";

    String _four =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start4Date' AND "
        "$kUpdatedDate <= '$end4date' ";

    String _six =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start6Date' AND "
        "$kUpdatedDate <= '$end6date' ";

    String _eight =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start8Date' AND "
        "$kUpdatedDate <= '$end8date' ";

    String _ten =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start10Date' AND "
        "$kUpdatedDate <= '$end10date' ";

    String _twelve =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start12Date' AND "
        "$kUpdatedDate <= '$end12date' ";

    String _fourteen =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start14Date' AND "
        "$kUpdatedDate <= '$end14date' ";

    String _sixteen =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start16Date' AND "
        "$kUpdatedDate <= '$end16date' ";

    String _eighteen =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start18Date' AND "
        "$kUpdatedDate <= '$end18date' ";

    String _twenty =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start20Date' AND "
        "$kUpdatedDate <= '$end20date' ";

    String _twentyTwo =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start22Date' AND "
        "$kUpdatedDate <= '$end22date' ";

    String _twentyFour =
        "SELECT SUM($kSteps) as Total FROM $kTableHealthDataRooms WHERE $kUpdatedDate >= '$start24Date' AND "
        "$kUpdatedDate <= '$end24date' ";

    final inserResultTwo = await _db.rawQuery(_two);
    final inserResultFour = await _db.rawQuery(_four);
    final inserResultSix = await _db.rawQuery(_six);
    final inserResultEight = await _db.rawQuery(_eight);
    final inserResultTen = await _db.rawQuery(_ten);
    final inserResultTwelve = await _db.rawQuery(_twelve);
    final inserResultFourTeen = await _db.rawQuery(_fourteen);
    final inserResultSixteen = await _db.rawQuery(_sixteen);
    final inserResultEighteen = await _db.rawQuery(_eighteen);
    final inserResultTwenty = await _db.rawQuery(_twenty);
    final inserResultTwentyTwo = await _db.rawQuery(_twentyTwo);
    final inserResultTwentyFour = await _db.rawQuery(_twentyFour);


    chartDataTodayDB.add(
        SalesData(2.0, double.parse("${inserResultTwo[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(
        SalesData(4.0, double.parse("${inserResultFour[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(
        SalesData(6.0, double.parse("${inserResultSix[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(
        SalesData(8.0, double.parse("${inserResultEight[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(
        SalesData(10.0, double.parse("${inserResultTen[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(
        SalesData(12.0, double.parse("${inserResultTwelve[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(SalesData(
        14.0, double.parse("${inserResultFourTeen[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(SalesData(
        16.0, double.parse("${inserResultSixteen[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(SalesData(
        18.0, double.parse("${inserResultEighteen[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(
        SalesData(20.0, double.parse("${inserResultTwenty[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(SalesData(
        22.0, double.parse("${inserResultTwentyTwo[0]['Total'] ?? 0}")));
    chartDataTodayDB.add(SalesData(
        24.0, double.parse("${inserResultTwentyFour[0]['Total'] ?? 0}")));

    return chartDataTodayDB;
  }

//Future<List<HealthDataModel>>
  static Future<List<HealthDataModel>> batchGetWeekData(
      String startDate, String endDate) async {

    try{
      DateTime a = DateFormat("dd/MMM/yyyy").parse(startDate);
      DateTime b = DateFormat("dd/MMM/yyyy").parse(endDate);
      String WeekFirstDate = DateFormat('MM/dd/yyyy').format(a);
      String WeekLasttDate = DateFormat('MM/dd/yyyy').format(b);

      final _db = await DbProvider.db.database;
      _db!.batch();

      String dateDate =
          "SELECT $kDate, $kUpdatedDate, SUM($kSteps) as STEPS_INT FROM $kTableHealthDataRooms WHERE $kDate BETWEEN '${WeekFirstDate}' AND '${WeekLasttDate}' GROUP BY $kDate";

      final weekDataResult = await _db.rawQuery(dateDate);

        final List<HealthDataModel> _citiesList = weekDataResult
            .map<HealthDataModel>(
                (_cityJson) => HealthDataModel.fromJson(_cityJson))
            .toList();
        return _citiesList;

    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDataDb().tag,
        exceptionMsg: 'exception while getting cities list from db',
      );

      return [];
    }

  }

  static Future<List<Map<String,Object?>>> batchGet3MonthsDataDynamic(
      DateTime dateTimeFrom,String cpf) async {
    DateTime d = DateTime.now().subtract(Duration(days: 90));
    final List<Map<String,Object?>> healthDataTable = [];
    for(int i=0;i<=90;i++)
    {
      DateTime d1 = d.add(Duration(days: i));

      String start2Date = DateFormat('MM/dd/yyyy 00:00:00').format(d1);
      String end2date = DateFormat('MM/dd/yyyy 01:59:59').format(d1);

      String start4Date = DateFormat('MM/dd/yyyy 02:00:00').format(d1);
      String end4date = DateFormat('MM/dd/yyyy 03:59:59').format(d1);

      String start6Date = DateFormat('MM/dd/yyyy 04:00:00').format(d1);
      String end6date = DateFormat('MM/dd/yyyy 05:59:59').format(d1);

      String start8Date = DateFormat('MM/dd/yyyy 06:00:00').format(d1);
      String end8date = DateFormat('MM/dd/yyyy 07:59:59').format(d1);

      String start10Date = DateFormat('MM/dd/yyyy 08:00:00').format(d1);
      String end10date = DateFormat('MM/dd/yyyy 09:59:59').format(d1);

      String start12Date = DateFormat('MM/dd/yyyy 10:00:00').format(d1);
      String end12date = DateFormat('MM/dd/yyyy 11:59:59').format(d1);

      String start14Date = DateFormat('MM/dd/yyyy 12:00:00').format(d1);
      String end14date = DateFormat('MM/dd/yyyy 13:59:59').format(d1);

      String start16Date = DateFormat('MM/dd/yyyy 14:00:00').format(d1);
      String end16date = DateFormat('MM/dd/yyyy 15:59:59').format(d1);

      String start18Date = DateFormat('MM/dd/yyyy 16:00:00').format(d1);
      String end18date = DateFormat('MM/dd/yyyy 17:59:59').format(d1);

      String start20Date = DateFormat('MM/dd/yyyy 18:00:00').format(d1);
      String end20date = DateFormat('MM/dd/yyyy 19:59:59').format(d1);

      String start22Date = DateFormat('MM/dd/yyyy 20:00:00').format(d1);
      String end22date = DateFormat('MM/dd/yyyy 21:59:59').format(d1);

      String start24Date = DateFormat('MM/dd/yyyy 22:00:00').format(d1);
      String end24date = DateFormat('MM/dd/yyyy 23:59:59').format(d1);
      String startDate = DateFormat('MM/dd/yyyy 00:00:00').format(d1);
      String enddate = DateFormat('MM/dd/yyyy 23:59:59').format(d1);
      final _db = await DbProvider.db.database;
      _db!.batch();

      String q = "SELECT "
          "SUM(CASE WHEN $kUpdatedDate >= '$start2Date' AND $kUpdatedDate <= '$end2date' THEN $kSteps ELSE '0' END) AS 'TWO_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start4Date' AND $kUpdatedDate <= '$end4date' THEN $kSteps ELSE '0' END) AS 'FOUR_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start6Date' AND $kUpdatedDate <= '$end6date' THEN $kSteps ELSE '0' END) AS 'SIX_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start8Date' AND $kUpdatedDate <= '$end8date' THEN $kSteps ELSE '0' END) AS 'EIGHT_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start10Date' AND $kUpdatedDate <= '$end10date' THEN $kSteps ELSE '0' END) AS 'TEN_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start12Date' AND $kUpdatedDate <= '$end12date' THEN $kSteps ELSE '0' END) AS 'TWELVE_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start14Date' AND $kUpdatedDate <= '$end14date' THEN $kSteps ELSE '0' END) AS 'FOURTEEN_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start16Date' AND $kUpdatedDate <= '$end16date' THEN $kSteps ELSE '0' END) AS 'SIXTEEN_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start18Date' AND $kUpdatedDate <= '$end18date' THEN $kSteps ELSE '0' END) AS 'EIGHTEEN_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start20Date' AND $kUpdatedDate <= '$end20date' THEN $kSteps ELSE '0' END) AS 'TWENTY_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start22Date' AND $kUpdatedDate <= '$end22date' THEN $kSteps ELSE '0' END) AS 'TTWO_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$start24Date' AND $kUpdatedDate <= '$end24date' THEN $kSteps ELSE '0' END) AS 'TFOUR_STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$startDate' AND $kUpdatedDate <= '$enddate' THEN $kSteps ELSE '0' END) AS 'STEPS', "
          "SUM(CASE WHEN $kUpdatedDate >= '$startDate' AND $kUpdatedDate <= '$enddate' THEN $kSteps ELSE '0' END) / 24 AS 'CAL', "
          "SUM(CASE WHEN $kUpdatedDate >= '$startDate' AND $kUpdatedDate <= '$enddate' THEN $kSteps ELSE '0' END) / 12 AS 'DISTANCE' "
          "FROM $kTableHealthDataRooms";

      final q1 = await _db.rawQuery(q);

      print("Q1:: $q1");

      final List<CardData> _citiesList = q1
          .map<CardData>(
              (_cityJson) => CardData.fromJson(_cityJson))
          .toList();


      CardData data = _citiesList[0];

      HealthDataModel d0 = HealthDataModel();
      d0.steps = data.TWO_STEPS.toString();
      d0.updateDate = end2date;
      d0.empNo = cpf;
      d0.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d01 = HealthDataModel();
      d01.steps = data.FOUR_STEPS.toString();
      d01.updateDate = end4date;
      d01.empNo = cpf;
      d01.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d02 = HealthDataModel();
      d02.steps = data.SIX_STEPS.toString();
      d02.updateDate = end6date;
      d02.empNo = cpf;
      d02.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d03 = HealthDataModel();
      d03.steps = data.EIGHT_STEPS.toString();
      d03.updateDate = end8date;
      d03.empNo = cpf;
      d03.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d04 = HealthDataModel();
      d04.steps = data.TEN_STEPS.toString();
      d04.updateDate = end10date;
      d04.empNo = cpf;
      d04.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d05 = HealthDataModel();
      d05.steps = data.TWELVE_STEPS.toString();
      d05.updateDate = end12date;
      d05.empNo = cpf;
      d05.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d06 = HealthDataModel();
      d06.steps = data.FOURTEEN_STEPS.toString();
      d06.updateDate = end14date;
      d06.empNo = cpf;
      d06.date = DateFormat("MM/dd/yyyy").format(d1);


      HealthDataModel d07 = HealthDataModel();
      d07.steps = data.SIXTEEN_STEPS.toString();
      d07.updateDate = end16date;
      d07.empNo = cpf;
      d07.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d08 = HealthDataModel();
      d08.steps = data.EIGHTEEN_STEPS.toString();
      d08.updateDate = end18date;
      d08.empNo = cpf;
      d08.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d09 = HealthDataModel();
      d09.steps = data.TWENTY_STEPS.toString();
      d09.updateDate = end20date;
      d09.empNo = cpf;
      d09.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d10 = HealthDataModel();
      d10.steps = data.TTWO_STEPS.toString();
      d10.updateDate = end22date;
      d10.empNo = cpf;
      d10.date = DateFormat("MM/dd/yyyy").format(d1);

      HealthDataModel d11 = HealthDataModel();
      d11.steps = data.TFOUR_STEPS.toString();
      d11.updateDate = end24date;
      d11.empNo = cpf;
      d11.date = DateFormat("MM/dd/yyyy").format(d1);

      healthDataTable.add(d0.toJson());
      healthDataTable.add(d01.toJson());
      healthDataTable.add(d02.toJson());
      healthDataTable.add(d03.toJson());
      healthDataTable.add(d04.toJson());
      healthDataTable.add(d05.toJson());
      healthDataTable.add(d06.toJson());
      healthDataTable.add(d07.toJson());
      healthDataTable.add(d08.toJson());
      healthDataTable.add(d09.toJson());
      healthDataTable.add(d10.toJson());
      healthDataTable.add(d11.toJson());
    }

    return healthDataTable;

  }



  static Future<List<CardData>> batchGetChartsDatadynamic(
      DateTime datetime) async {

    String start2Date = DateFormat('MM/dd/yyyy 00:00:00').format(datetime);
    String end2date = DateFormat('MM/dd/yyyy 01:59:59').format(datetime);

    String start4Date = DateFormat('MM/dd/yyyy 02:00:00').format(datetime);
    String end4date = DateFormat('MM/dd/yyyy 03:59:59').format(datetime);

    String start6Date = DateFormat('MM/dd/yyyy 04:00:00').format(datetime);
    String end6date = DateFormat('MM/dd/yyyy 05:59:59').format(datetime);

    String start8Date = DateFormat('MM/dd/yyyy 06:00:00').format(datetime);
    String end8date = DateFormat('MM/dd/yyyy 07:59:59').format(datetime);

    String start10Date = DateFormat('MM/dd/yyyy 08:00:00').format(datetime);
    String end10date = DateFormat('MM/dd/yyyy 09:59:59').format(datetime);

    String start12Date = DateFormat('MM/dd/yyyy 10:00:00').format(datetime);
    String end12date = DateFormat('MM/dd/yyyy 11:59:59').format(datetime);

    String start14Date = DateFormat('MM/dd/yyyy 12:00:00').format(datetime);
    String end14date = DateFormat('MM/dd/yyyy 13:59:59').format(datetime);

    String start16Date = DateFormat('MM/dd/yyyy 14:00:00').format(datetime);
    String end16date = DateFormat('MM/dd/yyyy 15:59:59').format(datetime);

    String start18Date = DateFormat('MM/dd/yyyy 16:00:00').format(datetime);
    String end18date = DateFormat('MM/dd/yyyy 17:59:59').format(datetime);

    String start20Date = DateFormat('MM/dd/yyyy 18:00:00').format(datetime);
    String end20date = DateFormat('MM/dd/yyyy 19:59:59').format(datetime);

    String start22Date = DateFormat('MM/dd/yyyy 20:00:00').format(datetime);
    String end22date = DateFormat('MM/dd/yyyy 21:59:59').format(datetime);

    String start24Date = DateFormat('MM/dd/yyyy 22:00:00').format(datetime);
    String end24date = DateFormat('MM/dd/yyyy 23:59:59').format(datetime);
    String startDate = DateFormat('MM/dd/yyyy 00:00:00').format(datetime);
    String enddate = DateFormat('MM/dd/yyyy 23:59:59').format(datetime);
    final _db = await DbProvider.db.database;
    _db!.batch();

    String q = "SELECT "
        "SUM(CASE WHEN $kUpdatedDate >= '$start2Date' AND $kUpdatedDate <= '$end2date' THEN $kSteps ELSE '0' END) AS 'TWO_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start4Date' AND $kUpdatedDate <= '$end4date' THEN $kSteps ELSE '0' END) AS 'FOUR_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start6Date' AND $kUpdatedDate <= '$end6date' THEN $kSteps ELSE '0' END) AS 'SIX_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start8Date' AND $kUpdatedDate <= '$end8date' THEN $kSteps ELSE '0' END) AS 'EIGHT_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start10Date' AND $kUpdatedDate <= '$end10date' THEN $kSteps ELSE '0' END) AS 'TEN_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start12Date' AND $kUpdatedDate <= '$end12date' THEN $kSteps ELSE '0' END) AS 'TWELVE_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start14Date' AND $kUpdatedDate <= '$end14date' THEN $kSteps ELSE '0' END) AS 'FOURTEEN_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start16Date' AND $kUpdatedDate <= '$end16date' THEN $kSteps ELSE '0' END) AS 'SIXTEEN_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start18Date' AND $kUpdatedDate <= '$end18date' THEN $kSteps ELSE '0' END) AS 'EIGHTEEN_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start20Date' AND $kUpdatedDate <= '$end20date' THEN $kSteps ELSE '0' END) AS 'TWENTY_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start22Date' AND $kUpdatedDate <= '$end22date' THEN $kSteps ELSE '0' END) AS 'TTWO_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$start24Date' AND $kUpdatedDate <= '$end24date' THEN $kSteps ELSE '0' END) AS 'TFOUR_STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$startDate' AND $kUpdatedDate <= '$enddate' THEN $kSteps ELSE '0' END) AS 'STEPS', "
        "SUM(CASE WHEN $kUpdatedDate >= '$startDate' AND $kUpdatedDate <= '$enddate' THEN $kSteps ELSE '0' END) / 24 AS 'CAL', "
        "SUM(CASE WHEN $kUpdatedDate >= '$startDate' AND $kUpdatedDate <= '$enddate' THEN $kSteps ELSE '0' END) / 12 AS 'DISTANCE' "
        "FROM $kTableHealthDataRooms";

    final q1 = await _db.rawQuery(q);

    final List<CardData> _citiesList = q1
        .map<CardData>(
            (_cityJson) => CardData.fromJson(_cityJson))
        .toList();

   return _citiesList;

  }

  static batchInsertSetTarget(SetTarget setTarget) async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();
      String insertQuery =
          "INSERT INTO $kTableSetTargetDataRooms($kEmployeeCpfNo, $kStartDate, $kEndDate, $kUpdatedStartedDate, $kUpdatedEndDate, $kTargetSteps, $kTargetAchieved, $kISTargetAchieved) VALUES('${setTarget.EMP_NO}', '${setTarget.START_DATE}',"
          "'${setTarget.END_DATE}', '${setTarget.START_DATE}', '${setTarget.END_DATE}', '${setTarget.TARGETSTEPS}', '0', 'false' )";
      await _db.rawQuery(insertQuery);
      await _batch.commit();
    } catch (e, s) {


      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDataDb().tag,
        exceptionMsg: 'exception while inserting records in health table',
      );
    }
  }

  static Future<List<SetTarget>> getSetTargetListFromDb() async {
    try {
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();
      const String _query = "SELECT * FROM $kTableSetTargetDataRooms";
      final _result = await _db.rawQuery(_query);
      await _batch.commit();
      if (_result.isNotEmpty) {
        final List<SetTarget> _citiesList = _result
            .map<SetTarget>((_cityJson) => SetTarget.fromJson(_cityJson))
            .toList();

        return _citiesList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDataDb().tag,
        exceptionMsg: 'exception while getting cities list from db',
      );

      return [];
    }
  }

  static updateSetTargetTable(SetTarget setTarget) async {
    try {
      print("updateSetTargetTable :: ${setTarget.TARGETSTEPS}");
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();
      String insertQuery =
          "UPDATE $kTableSetTargetDataRooms SET $kUpdatedStartedDate = '${setTarget.START_DATE}', $kUpdatedEndDate = '${setTarget.END_DATE}', $kTargetSteps = '${setTarget.TARGETSTEPS}' WHERE $kEndDate IN (SELECT $kEndDate FROM $kTableSetTargetDataRooms ORDER BY $kEndDate DESC LIMIT 1)";
      final inserResult = await _db.rawQuery(insertQuery);
      final _resultUpdate = await _batch.commit();
      print("updateSetTargetTable result isNotEmpty:: ${inserResult}");
    } catch (e, s) {


      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDataDb().tag,
        exceptionMsg: 'exception while inserting records in health table',
      );
    }
  }

  static updateTargetAchieved(SetTarget setTarget) async {
    try {
      print("updateSetTargetTable :: ${setTarget.TARGETSTEPS}");
      final _db = await DbProvider.db.database;
      final _batch = _db!.batch();
      String insertQuery =
          "UPDATE $kTableSetTargetDataRooms SET $kTargetAchieved = '${setTarget.TARGETACHIEVED}' WHERE $kEndDate IN (SELECT $kEndDate FROM $kTableSetTargetDataRooms ORDER BY $kEndDate DESC LIMIT 1)";
      final inserResult = await _db.rawQuery(insertQuery);
      final _resultUpdate = await _batch.commit();

      getSetTargetListFromDb();
      print("updateSetTargetTable result isNotEmpty:: ${inserResult}");
    } catch (e, s) {


      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: HealthDataDb().tag,
        exceptionMsg: 'exception while inserting records in health table',
      );
    }
  }


  static Future<String> getSumOfTargetAcheived() async {
    final _db = await DbProvider.db.database;
    _db!.batch();
    String sumSteps = '0';
    String target_step = '0';
    String startDate = "";
    String endDate = "";
    final _result = await _db.rawQuery(
        "Select $kColumnId, $kEmployeeCpfNo, $kUpdatedStartedDate, $kUpdatedEndDate, $kTargetSteps from $kTableSetTargetDataRooms ORDER BY $kColumnId DESC LIMIT 1");
    print("getachievedDatafromdb :: $_result");
    if(_result.isNotEmpty) {
      //const String _queryGetLatest = "SELECT * FROM $kTableTargetAchievedDataRooms ORDER BY $kDate DESC LIMIT 1";
      DateTime sd = DateFormat("yyyy-MM-dd HH:mm:ss.s")
          .parse('${_result[0]['UPDATED_STARTED_DATE']}');
      startDate = DateFormat("MM/dd/yyyy HH:mm:ss").format(sd);
      DateTime ed =
      DateFormat("yyyy-MM-dd HH:mm:ss.s").parse(
          '${_result[0]['UPDATED_END_DATE']}');
      endDate = DateFormat("MM/dd/yyyy 23:59:59").format(ed);

      String _queryGetLatest1 =
          "SELECT sum($kSteps) as Total FROM $kTableHealthDataRooms where $kUpdatedDate between '$startDate' and '$endDate'";
      final sumResult = await _db.rawQuery(_queryGetLatest1);
      print("getachievedDatafromdb :: $sumResult");
      print("getachievedDatafromdb :: $_queryGetLatest1");

      if (sumResult[0]['Total'] == null) {
        sumSteps = '0';
      } else {
        sumSteps = '${sumResult[0]['Total'].toString()}';
      }

      if (_result[0]['TARGETSTEPS'] == null) {
        target_step = '0';
      } else {
        target_step = '${_result[0]['TARGETSTEPS']}';
      }
      print('_result[0]TargetSteps ${sumSteps} - ${target_step}');
      return '${sumSteps} / ${target_step}';
    }
    return '0 / 0';
  }

  // static insertTargetSteps(TargetAchieved targetAchieved) async {
  //   int a = 0;
  //   try {
  //     final _db = await DbProvider.db.database;
  //     print("insertTargetSteps :: $targetAchieved");
  //     final _batch = _db!.batch();
  //     String _query =
  //         "SELECT * FROM $kTableTargetAchievedDataRooms WHERE $kDate = '${DateFormat("MM/dd/yyyy").format(DateTime.now())}' ";
  //     final _result = await _db.rawQuery(_query);
  //     print("insertTargetSteps :: $_result");
  //     List<TargetAchieved> targetAchievedList = [];
  //     if (_result.isEmpty) {
  //       String insertQuery =
  //           "INSERT INTO $kTableTargetAchievedDataRooms($kEmployeeCpfNo, $kSteps, $kDate) VALUES('${targetAchieved.empNo}', '${targetAchieved.steps}', '${targetAchieved.date}' )";
  //       final inserResult = await _db.rawQuery(insertQuery);
  //       final _result1 = await _batch.commit();
  //       print("updateSetTargetTable result isNotEmpty:: ${inserResult}");
  //     } else {
  //       print(
  //           "------------else----------${_result[0]['STEPS'].toString()}  ${targetAchieved.steps}");
  //       String a = (int.parse(targetAchieved.steps!) +
  //               int.parse(_result[0]['STEPS'].toString()))
  //           .toString();
  //       print("------------else----------${targetAchieved.steps}");
  //       String updateQuery =
  //           "UPDATE $kTableTargetAchievedDataRooms SET $kSteps = '${a}' WHERE $kDate = '${DateFormat("MM/dd/yyyy").format(DateTime.now())}' ";
  //       final updateResult = await _db.rawQuery(updateQuery);
  //       final _resultUpdate = await _batch.commit();
  //       print("updateSetTargetTable result isNotEmpty:: ${updateResult}");
  //     }
  //   } catch (e, s) {
  //
  //
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: HealthDataDb().tag,
  //       exceptionMsg: 'exception while inserting records in health table',
  //     );
  //   }
  // }

  static Future<List<Map<String, dynamic>>> gettargetDatafromdb() async {
    final _db = await DbProvider.db.database;
    _db!.batch();
    const String _queryGetAll = "SELECT * FROM $kTableSetTargetDataRooms";
    final _result = await _db.rawQuery(_queryGetAll);
    const String _queryGetLatest =
        "SELECT * FROM $kTableSetTargetDataRooms ORDER BY $kColumnId DESC LIMIT 1";
    final _resultLatest = await _db.rawQuery(_queryGetLatest);
    print("_result[0]['START_DATE'] :: $_result");
    return _resultLatest;
  }

  static Future<List<Map<String, dynamic>>> getachievedDatafromdb() async {
    final _db = await DbProvider.db.database;
    _db!.batch();
    const String _queryGetAll = "SELECT * FROM $kTableTargetAchievedDataRooms";
    final _result = await _db.rawQuery(_queryGetAll);
    const String _queryGetLatest =
        "SELECT * FROM $kTableTargetAchievedDataRooms ORDER BY $kDate DESC LIMIT 1";
    final _resultLatest = await _db.rawQuery(_queryGetLatest);
    print("_result[0]['START_DATE'] :: $_result");
    return _resultLatest;
  }
}
