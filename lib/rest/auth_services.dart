// Created By Amit Jangid 24/08/21

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/rest/api_services.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../core/db/health_data.dart';
import '../models/health_data_model.dart';
import 'package:http/io_client.dart';

class AuthServices extends ApiServices {
  static const String _tag = 'AuthServices';
  late List<HealthDataModel> healthdatalist = [];
  static AuthServices get to => Get.find<AuthServices>();




  Future<String> authenticateUserApi(
      {required String userId, required String password}) async {
    var pref = await SecureSharedPref.getInstance();

    try {
      final _body = {
        kJsonUserId: userId,
        kJsonDeviceModel: '',
        kJsonDeviceToken: '',
        kJsonPassword: password,
        kJsonDeviceProperties: '',
        kJsonFcmToken: '',
      };
        final _response = await httpClient
          .post('$kSecureBaseUrl$kIsValidUserApi', body: json.encode(_body))
            .timeout(const Duration(seconds: 30));//

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {

        final _responseBody = _response.body[0];
        final bool _responseVal = _responseBody[kJsonResponse];


        if (_responseVal) {
          print("_responseVal :: $_responseVal");
          pref.putString("token", _responseBody['token'],isEncrypted: true);
          pref.putString("dbProtected", "dbProtected",isEncrypted: true);
          pref.putString("email", _responseBody[kJsonEmail],isEncrypted: true);
          pref.putString("baName", _responseBody[kJsonBaName],isEncrypted: true);
          pref.putString("gstInNumber", _responseBody[kJsonGstIn],isEncrypted: true);
          pref.putString("cpfNumber", _responseBody[kJsonCpfNumber],isEncrypted: true);
          pref.putString("userAccess", _responseBody[kJsonUserAccess],isEncrypted: true);
          pref.putString("gstLocation", _responseBody[kJsonGstLocation],isEncrypted: true);
          pref.putString("businessArea", _responseBody[kJsonBusinessArea],isEncrypted: true);
          pref.putString("gstLocation", _responseBody[kJsonGstLocation],isEncrypted: true);

          pref.putString("isFcmToken", _responseBody[kJsonToken],isEncrypted: true);
          pref.putString("authtoken",  _responseBody['token'],isEncrypted: true);


          if (Platform.isAndroid) {
            // _sharedPrefs.apkVersion = _responseBody[kJsonApkVersionNo];
            pref.putString("apkVersion",  _responseBody[kJsonApkVersionNo],isEncrypted: true);
          } else if (Platform.isIOS) {
            pref.putString("iosVersion",  _responseBody[kJsonIpaVersion],isEncrypted: true);
            // _sharedPrefs.iosVersion = _responseBody[kJsonIpaVersion];
          }

          bool? isEmployeeDataSyncedAfterAlter = await pref.getBool("isEmployeeDataSyncedAfterAlter")??false;
          print("isEmployeeDataSyncedAfterAlter :: $isEmployeeDataSyncedAfterAlter");
          if (!isEmployeeDataSyncedAfterAlter) {
            final _db = await DbProvider.db.database;

            // calling alter employees table method
            await DbProvider.db.alterEmployeesTable(_db!);

            // calling get employees list api method
            await GailConnectServices.to.getEmployeesListApi();
          }


          // calling is dashboard admin api method
          String? cpf = await pref.getString("cpfNumber",isEncrypted: true);

          String _result =
              await _isDashboardAdmin(cpfNumber: cpf!);
          late List<Map<String, Object?>> healthlist = [];
          bool? isLoggedIn = await pref.getBool("isLoggedIn")??false;
          print("isLoggedIn :: $isLoggedIn");

          if (!isLoggedIn) {
            healthlist = await HealthDataDb.getHealthListFromDb();
            print("healthlist :: $healthlist");
            if(healthlist.isEmpty){
              healthdatalist.clear();
              healthdatalist = await GailConnectServices.to.getHealthLiveData();
              HealthDataModel healthModel = HealthDataModel();
              for(int i =0; i<healthdatalist.length; i++){
                healthModel.empNo = healthdatalist[i].empNo;
                healthModel.steps = healthdatalist[i].steps;
                healthModel.date = healthdatalist[i].date;
                healthModel.updateDate = healthdatalist[i].updateDate;
                await HealthDataDb.batchInsertIntoHealthDataTable(healthModel);
              }
            }

            // calling get employees list api method
            _result = await GailConnectServices.to.getEmployeesListApi();

            _result = await GailConnectServices.to.getEmployeesSectionListApi();

            // calling get offices list api method
            _result = await GailConnectServices.to.getOfficesListApi();

            // calling get control room list api method
            _result = await GailConnectServices.to.getControlRoomListApi();

            // calling get guest house details api method
            _result = await GailConnectServices.to.getGuestHouseDetailsApi();

            // calling get hospitals cities list api method
            _result = await GailConnectServices.to.getHospitalsCitiesListApi();

            _result = await GailConnectServices.to.getEmpGroupAdminCheckApi();

            pref.putBool("isLoggedIn", true);


            return _result;
          } else {
            print("else side in isLogged");
            healthlist = await HealthDataDb.getHealthListFromDb();
            if(healthlist.isEmpty){
              healthdatalist.clear();
              healthdatalist = await GailConnectServices.to.getHealthLiveData();
              HealthDataModel healthModel = HealthDataModel();
              for(int i =0; i<healthdatalist.length; i++){
                healthModel.empNo = healthdatalist[i].empNo;
                healthModel.steps = healthdatalist[i].steps;
                healthModel.date = healthdatalist[i].date;
                healthModel.updateDate = healthdatalist[i].updateDate;
                await HealthDataDb.batchInsertIntoHealthDataTable(healthModel);
              }
            }
            return kSuccess;
          }
        }
      }

      // calling send error logs method
      GailConnectServices.to.sendErrorLogs(
        className: _tag,
        apiName: kIsValidUserApi,
        statusCode: _response.statusCode ?? 0,
        message: "exception while authenticating user",
      );

      // return kMsgInvalidUserIdOrPassword;
      return _response.body[0]['Notification'];
    } on TimeoutException catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        apiName: kIsValidUserApi,
        exceptionMsg:
            "exception while authenticating user by making api call for authentication user",
      );

      return kMsgNetworkIssue; //kMsgSomethingWentWrong;
    }
  }

  Future<String> _isDashboardAdmin({required String cpfNumber}) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var headerData = {
        'Authorization': 'Bearer $s'
      };
      final _response = await httpClient.get('$kIsDashboardAdminApi$cpfNumber',headers: headerData);


      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        pref.putBool("isDashboardAdmin", _response.body['Isadmin']);

        pref.putString(
            "isBISHelpdeskAdmin", _response.body['ISBISHelpdesk_Admin']);
        // SharedPrefs.to.isDashboardAdmin = false;
        // SharedPrefs.to.isBISHelpdeskAdmin = 'User';

        return kSuccess;
      }

      // calling send error logs method
      GailConnectServices.to.sendErrorLogs(
        className: _tag,
        statusCode: _response.statusCode!,
        apiName: '$kIsDashboardAdminApi$cpfNumber',
        message: "exception while check if user is admin",
      );

      return kMsgInvalidUserIdOrPassword;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        apiName: kIsValidUserApi,
        exceptionMsg:
            "exception while making api call to check if user is admin",
      );

      return kMsgSomethingWentWrong;
    }
  }

  // _getFcmToken(SharedPrefs _sharedPrefs) async {
  //   try {
  //     if (!_sharedPrefs.isFcmTokenSent) {
  //       final String? _fcmToken = await FirebaseMessaging.instance.getToken();
  //       _sharedPrefs.fcmToken = _fcmToken;
  //       debugPrint('authenticateUserApi: fcm token is: $_fcmToken');
  //
  //       if (_fcmToken != null && _fcmToken.isNotEmpty) {
  //         // calling send fcm token api method
  //         await GailConnectServices.to.sendFcmTokenApi(fcmToken: _fcmToken);
  //       }
  //     }
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg: 'exception while getting fcm token from firebase',
  //     );
  //   }
  // }
}
