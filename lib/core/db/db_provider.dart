 // Created By Amit Jangid 25/08/21

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:gail_connect/main.dart';
import 'package:gail_connect/utils/constants/db_constants.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DbProvider {
  DbProvider._();

  static Database? _database;
  static const String _tag = 'DbProvider';
  static final DbProvider db = DbProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDb();

    return _database;
  }

  closeDb() async{
    await _database!.transaction((txn) async {
      await txn.execute('DELETE FROM ' + kTableCities);
      await txn.execute('DELETE FROM ' + kTableOffices);
      await txn.execute('DELETE FROM ' + kTableHospitals);
      await txn.execute('DELETE FROM ' + kTableEmployees);
      await txn.execute('DELETE FROM ' + kTableGuestHouses);
      await txn.execute('DELETE FROM ' + kTableControlRooms);
      await txn.execute('DELETE FROM ' + kTableHealthRooms);
      await txn.execute('DELETE FROM ' + kTableHealthDataRooms);
      await txn.execute('DELETE FROM ' + kTableSetTargetDataRooms);
      await txn.execute('DELETE FROM ' + kTableTargetAchievedDataRooms);
      await txn.execute('DELETE FROM ' + kTableSectionMaster);
    });
    // _database!.close();
  }

  Future<Database> _initDb() async {
    final String _path = join(await getDatabasesPath(), kDatabaseName);

    return await openDatabase(
      _path,
      version: 6,
      password: "",
      onOpen: (db) {
        print("Database db, int version $db");
      },
      onCreate: (Database db, int version) async {
        print("Database db oncreate, int version $version");
        await db.execute(_createCitiesTable);
        await db.execute(_createOfficesTable);
        await db.execute(_createHospitalsTable);
        await db.execute(_createEmployeesTable);
        await db.execute(_createGuestHousesTable);
        await db.execute(_createControlRoomTable);
        await db.execute(_createHealthTable);
        await db.execute(_createHealthDataTable);
        await db.execute(_createSetTargetDataTable);
        await db.execute(_createTargetAchievedDataTable);
        await db.execute(_createSectionTable);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print("oldVersion<newVersion :: $oldVersion $newVersion");
        if (oldVersion<=newVersion || newVersion == 6) {

          await db.execute(_createCitiesTable);
          await db.execute(_createOfficesTable);
          await db.execute(_createHospitalsTable);
          await db.execute(_createEmployeesTable);
          await db.execute(_createGuestHousesTable);
          await db.execute(_createControlRoomTable);
          await db.execute(_createHealthTable);
          await db.execute(_createHealthDataTable);
          await db.execute(_createSetTargetDataTable);
          await db.execute(_createTargetAchievedDataTable);
          await db.execute(_createSectionTable);
          // calling alter employees table method
          await alterEmployeesTable(db);
        }
      },
    );
  }

  final String _createEmployeesTable =
      "CREATE TABLE IF NOT EXISTS $kTableEmployees ("
      "$kColumnEmpNo TEXT PRIMARY KEY, "
      "$kColumnEmpName TEXT, "
      "$kColumnDesignation TEXT, "
      "$kColumnDepartment TEXT, "
      "$kColumnSDirectorate TEXT, "
      "$kColumnSection TEXT, "
      "$kColumnDateOfJoining TEXT, "
      "$kColumnLocation TEXT, "
      "$kColumnTelNo TEXT, "
      "$kColumnMobileNo TEXT, "
      "$kColumnMobileNo1 TEXT, "
      "$kColumnOfficeTel TEXT, "
      "$kColumnOfficeExt TEXT, "
      "$kColumnHBJExt TEXT, "
      "$kColumnLTel TEXT, "
      "$kColumnLGailTel TEXT, "
      "$kColumnFaxNo TEXT, "
      "$kColumnEmails TEXT, "
      "$kColumnGrade TEXT, "
      "$kColumnGradeValue TEXT, "
      "$kColumnDateOfBirth TEXT, "
      "$kColumnImage TEXT, "
      "$kColumnVehicleNo TEXT)";

  final String _createSectionTable = "CREATE TABLE IF NOT EXISTS $kTableSectionMaster ( $kSection TEXT, $kSectionDes TEXT )" ;

  final String _createOfficesTable =
      "CREATE TABLE IF NOT EXISTS $kTableOffices ("
      "$kColumnLocation TEXT, "
      "$kColumnGailNetCode TEXT, "
      "$kColumnAddress TEXT, "
      "$kColumnFax TEXT, "
      "$kColumnLatitude TEXT, "
      "$kColumnLongitude TEXT, "
      "$kColumnEPabX TEXT)";

  final String _createHealthTable =
      "CREATE TABLE IF NOT EXISTS $kTableHealthRooms ("
      "$kEmployeeCpfNo TEXT, "
      "$kUpdatedDate TEXT, "
      "$kSteps TEXT, "
      "$kStartTime TEXT, "
      "$kCalories TEXT, "
      "$kDistance TEXT, "
      "$kTwoSteps TEXT, "
      "$kFourSteps TEXT, "
      "$kSixSteps TEXT, "
      "$kEightSteps TEXT, "
      "$kTenSteps TEXT, "
      "$kTwelveSteps TEXT, "
      "$kFourteenSteps TEXT, "
      "$kSixteenSteps TEXT, "
      "$kEighteenSteps TEXT, "
      "$kTwentySteps TEXT, "
      "$kTTwoSteps TEXT, "
      "$kTFourSteps TEXT)";


  final String _createHealthDataTable ="CREATE TABLE IF NOT EXISTS $kTableHealthDataRooms ("
      "$kColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
      "$kEmployeeCpfNo TEXT, "
      "$kUpdatedDate TEXT, "
      "$kSteps TEXT, "
      "$kDate TEXT)";


  final String _createSetTargetDataTable = "CREATE TABLE IF NOT EXISTS $kTableSetTargetDataRooms ("
      "$kColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
      "$kEmployeeCpfNo TEXT, "
      "$kStartDate TEXT, "
      "$kEndDate TEXT, "
      "$kUpdatedStartedDate TEXT, "
      "$kUpdatedEndDate TEXT, "
      "$kTargetSteps TEXT, "
      "$kTargetAchieved TEXT,"
      "$kISTargetAchieved BOOL)";

  final String  _createTargetAchievedDataTable = "CREATE TABLE IF NOT EXISTS $kTableTargetAchievedDataRooms ("
      "$kColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
      "$kEmployeeCpfNo TEXT, "
      "$kSteps TEXT, "
      "$kDate TEXT)";

  final String _createControlRoomTable =
      "CREATE TABLE IF NOT EXISTS $kTableControlRooms ("
      "$kColumnId INTEGER PRIMARY KEY, "
      "$kColumnCreatedBy TEXT, "
      "$kColumnCreatedOn TEXT, "
      "$kColumnHbjNo TEXT, "
      "$kColumnLocation TEXT, "
      "$kColumnModifiedBy TEXT, "
      "$kColumnModifiedOn TEXT, "
      "$kColumnSubLocation TEXT, "
      "$kColumnTel1 TEXT, "
      "$kColumnTel2 TEXT, "
      "$kColumnTel3 TEXT, "
      "$kColumnTel4 TEXT)";

  final String _createHospitalsTable =
      "CREATE TABLE IF NOT EXISTS $kTableHospitals ("
      "$kColumnId INTEGER PRIMARY KEY, "
      "$kColumnHospitalName TEXT, "
      "$kColumnHospitalLoc TEXT, "
      "$kColumnStartDate TEXT, "
      "$kColumnName TEXT, "
      "$kColumnEndDate TEXT, "
      "$kColumnHospitalAdd TEXT, "
      "$kColumnYYohc TEXT, "
      "$kColumnWerks TEXT, "
      "$kColumnLatitude TEXT, "
      "$kColumnLongitude TEXT, "
      "$kColumnDistance TEXT)";

  final String _createGuestHousesTable =
      "CREATE TABLE IF NOT EXISTS $kTableGuestHouses ("
      "$kColumnUniQID INTEGER PRIMARY KEY, "
      "$kColumnLocation TEXT, "
      "$kColumnAddress TEXT, "
      "$kColumnHvj TEXT, "
      "$kColumnTelephone TEXT, "
      "$kColumnLatitude REAL, "
      "$kColumnLongitude REAL)";

  final String _createCitiesTable =
      "CREATE TABLE IF NOT EXISTS $kTableCities ($kColumnCityName TEXT)";

  /// 2021 August 25 - Wednesday
  /// get record count method
  ///
  /// this method will get count of records for a table
  Future<int?> getRecordCount(
      {required tableName, required whereClause}) async {
    try {
      final db = await database;
      final String _query =
          'SELECT COUNT(*) FROM $tableName WHERE $whereClause';

      final List<Map<String, dynamic>> _result = await db!.rawQuery(_query);
      final int? _count = Sqflite.firstIntValue(_result);



      return _count;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting record count for $tableName table',
      );

      return -1;
    }
  }

/*/// 2021 May 14 - Friday
  /// get max code method
  ///
  /// this method will get max code of the table
  Future<int> getMaxCode({required String tableName}) async {
    final _db = await database;
    final String _query = 'SELECT IFNULL(MAX($kColumnCode), 0) + 1 AS $kColumnCode FROM $tableName';

    // getting max code + 1
    final List<Map<String, dynamic>> _result = await _db!.rawQuery(_query);
    final int _code = _result.first[kColumnCode];

    return _code;
  }*/

  alterEmployeesTable(Database db) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    try {
      String _query =
          "SELECT COUNT(*) FROM pragma_table_info('$kTableEmployees') WHERE name = '$kColumnSDirectorate'";
      String _querySection =
          "SELECT COUNT(*) FROM pragma_table_info('$kTableEmployees') WHERE name = '$kColumnSection'";
      String _queryDateOfJoining =
          "SELECT COUNT(*) FROM pragma_table_info('$kTableEmployees') WHERE name = '$kColumnDateOfJoining'";
      final _result = await db.rawQuery(_query);
      final _resultSection = await db.rawQuery(_querySection);
      final _resultDateOfJoining = await db.rawQuery(_queryDateOfJoining);


      final int? _count = Sqflite.firstIntValue(_result);
      final int? _countSection = Sqflite.firstIntValue(_resultSection);
      final int? _countDateOfJoining = Sqflite.firstIntValue(_resultDateOfJoining);


      if (_count == 0 && _countSection == 0 && _countDateOfJoining == 0) {
        _query =
            "ALTER TABLE $kTableEmployees ADD COLUMN $kColumnSDirectorate TEXT";
        //$kColumnGradeValue TEXT,
         db.execute(_query);

        String q1 =
            "ALTER TABLE $kTableEmployees ADD COLUMN $kColumnSection TEXT";

        db.execute(q1);

        String q2 =
            "ALTER TABLE $kTableEmployees ADD COLUMN $kColumnDateOfJoining TEXT";

       db.execute(q2);

      }else if (_count == 0) {
        _query =
        "ALTER TABLE $kTableEmployees ADD COLUMN $kColumnSDirectorate TEXT";

        final _alterResult = db.execute(_query);

      }else if(_countSection==0 && _countDateOfJoining == 0){
        _query =
        "ALTER TABLE $kTableEmployees ADD COLUMN $kColumnSection TEXT";

        final _alterResult = db.execute(_query);

        String q = "ALTER TABLE $kTableEmployees ADD COLUMN $kColumnDateOfJoining TEXT";
        final _alterResult1 = db.execute(q);

      } else if(_countDateOfJoining == 0){
        String q = "ALTER TABLE $kTableEmployees ADD COLUMN $kColumnDateOfJoining TEXT";
        db.execute(q);
      }else if(_countSection==0){
        _query =
        "ALTER TABLE $kTableEmployees ADD COLUMN $kColumnSection TEXT";

        db.execute(_query);
      }
      else {

      }

      pref.putBool("isEmployeeDataSyncedAfterAlter", false);
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while altering the employee table',
      );
    }
  }
}
