// Created By Amit Jangid 25/08/21

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gail_connect/models/active_news.dart';
import 'package:gail_connect/models/address_details_model.dart';
import 'package:gail_connect/models/app_store_model.dart';
import 'package:gail_connect/models/chat_notification.dart';
import 'package:gail_connect/models/consent_model.dart';
import 'package:gail_connect/models/contact_details.dart';
import 'package:gail_connect/models/dashboard_list.dart';
import 'package:gail_connect/models/delivery_mode.dart';
import 'package:gail_connect/models/dependant_list.dart';
import 'package:gail_connect/models/dispensary_details_url.dart';
import 'package:gail_connect/models/dispensary_history.dart';
import 'package:gail_connect/models/dispensary_history_details.dart';
import 'package:gail_connect/models/emp_attendance.dart';
import 'package:gail_connect/models/emp_group.dart';
import 'package:gail_connect/models/emp_wishes.dart';
import 'package:gail_connect/models/feedback_questions_model.dart';
import 'package:gail_connect/models/fresher_zone_model.dart';
import 'package:gail_connect/models/health_data_model.dart';
import 'package:gail_connect/models/id_view_model.dart';
import 'package:gail_connect/models/insert_whats_new.dart';
import 'package:gail_connect/models/most_used.dart';
import 'package:gail_connect/models/my_notes_model.dart';
import 'package:gail_connect/models/notification_model.dart';
import 'package:gail_connect/models/ohc_screen_model.dart';
import 'package:gail_connect/models/pharmacy_list.dart';
import 'package:gail_connect/models/side_drawer_elements.dart';
import 'package:gail_connect/models/super_annuation_model.dart';
import 'package:gail_connect/models/whatsnew_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:gail_connect/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:multiutillib/utils/utils.dart';
import 'package:gail_connect/models/city.dart';
import 'package:gail_connect/models/areas.dart';
import 'package:gail_connect/models/types.dart';
import 'package:gail_connect/models/office.dart';
import 'package:gail_connect/models/banners.dart';
import 'package:gail_connect/models/engineer.dart';
import 'package:gail_connect/models/fms_mail.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/models/feedback.dart';
import 'package:gail_connect/models/hospital.dart';
import 'package:gail_connect/models/fms_chart.dart';
import 'package:gail_connect/rest/api_services.dart';
import 'package:gail_connect/models/bis_report.dart';
import 'package:gail_connect/models/fms_detail.dart';
import 'package:gail_connect/models/live_event.dart';
import 'package:gail_connect/models/utilization.dart';
import 'package:gail_connect/models/guest_house.dart';
import 'package:gail_connect/models/e_note_sheet.dart';
import 'package:gail_connect/models/control_room.dart';
import 'package:gail_connect/models/news_category.dart';

import 'package:gail_connect/models/reporting_emp.dart';
import 'package:multiutillib/utils/date_time_utils.dart';
import 'package:gail_connect/models/banner_details.dart';
import 'package:gail_connect/models/bws_dash_count.dart';
import 'package:gail_connect/models/bws_bill_details.dart';
import 'package:gail_connect/models/bws_dash_details.dart';
import 'package:gail_connect/models/bis_report_details.dart';
import 'package:gail_connect/models/bis_helpdesk_calls.dart';
import 'package:gail_connect/models/e_note_sheet_by_file.dart';
import 'package:gail_connect/models/e_note_sheet_details.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:share_plus/share_plus.dart';

import '../config/routes.dart';
import '../models/feedback_answer_model.dart';
import '../models/installed_uninstalled_count_model.dart';
import '../ui/widgets/acknowledge_dialog.dart';
import 'package:http/io_client.dart';

class GailConnectServices extends ApiServices {
  static const String _tag = 'GailConnectServices';

  bool isBoth = false;
  bool isFile = false;
  bool isPicture = false;

  // Map<String, String> urlValues = {};
  final urlValues = Map<String, String>();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static GailConnectServices get to => Get.find<GailConnectServices>();

  // Future<String> sendFcmTokenApi({required String fcmToken}) async {
  //   try {
  //     final String token = SharedPrefs.to.authToken;
  //     var header = {
  //       'Authorization': 'Bearer $token'
  //     };
  //     final String _cpfNumber = SharedPrefs.to.cpfNumber;
  //     debugPrint(
  //         'sendFcmTokenApi: api is $BaseURLS$KCheckFCMToken$_cpfNumber&fcmtoken=$fcmToken');
  //     final _response = await httpClient
  //         .get('$BaseURLS$KCheckFCMToken$_cpfNumber&fcmtoken=$fcmToken',headers: header);
  //     // final _response =
  //     // await httpClient.get('$kFcmTokenApi$_cpfNumber&fcmtoken=$fcmToken');
  //
  //     debugPrint('sendFcmTokenApi: status code is: ${_response.statusCode}');
  //     debugPrint('sendFcmTokenApi: response body is: ${_response.body}');
  //
  //     if (_response.statusCode == 200) {
  //       SharedPrefs.to.isFcmTokenSent = true;
  //       return kSuccess;
  //     }else if(_response.status.code == 401){
  //       showCustomDialogAcknowledge(Get.context!,
  //           title: 'Alert',
  //           description:kAlertMessage,
  //           onNegativePressed: () {}, onPositivePressed: () async{
  //             await GetStorage().erase();
  //
  //             // signing out from firebase on app log out
  //             await _firebaseAuth.signOut();
  //             Get.offNamedUntil(kLoginRoute, (route) => false);
  //           });
  //
  //
  //       // update();
  //     }
  //
  //     return '';
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg: 'exception while making api call for sending fcm token',
  //     );
  //
  //     return '';
  //   }
  // }

  // Future<dynamic> getSslPinnedHttpClient() async {
  //   // Load the certificate
  //   final sslCert =
  //       await rootBundle.load('assets/certificate/ServerCertificate.cer');
  //
  //   SecurityContext context = SecurityContext(withTrustedRoots: false);
  //
  //   // Trust the provided certificate
  //   context.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());
  //
  //   // Create an HTTP client with SSL pinning enabled
  //   final httpClient = HttpClient(context: context);
  //   return IOClient(httpClient);
  // }

  Future<List<ActiveNews>> getActiveNewsAPI() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    // if(s != null) {
    //   headerData = {
    //     'Authorization': 'Bearer $s'
    //   };
    // }
    try {
      // final String token = SharedPrefs.to.authToken;
      // final String? token = await prefData().getAuthToken();
      var headerData = {'Authorization': 'Bearer $s'};
      // final _response = await httpClient.get(kGetGailNewsApi);
      final _response =
          await httpClient.get('$BaseURLS$kGetGailnews', headers: headerData);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<ActiveNews> _activeNewsList = _response.body["dtEvents"]
            .map<ActiveNews>((_bannerJson) => ActiveNews.fromJson(_bannerJson))
            .toList();
        return _activeNewsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<ActiveNews>> getActiveINDNewsAPI() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    // if(s != null) {
    //   headerData = {
    //     'Authorization': 'Bearer $s'
    //   };
    // }
    try {
      // final String token = SharedPrefs.to.authToken;
      // final String? token = await prefData().getAuthToken();
      var headerData = {'Authorization': 'Bearer $s'};
      // final _response = await httpClient.get(kGetINDNewsApi);
      final _response = await httpClient.get('$BaseURLS$kGetGailIndustryNews',
          headers: headerData);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<ActiveNews> _activeNewsList = _response.body["dtEvents"]
            .map<ActiveNews>((_bannerJson) => ActiveNews.fromJson(_bannerJson))
            .toList();
        return _activeNewsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<MostUsedLinksModel>> getMostUsedAPI() async {
    //kMostUsedLinksApi
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    // if(s != null) {
    //   headerData = {
    //     'Authorization': 'Bearer $s'
    //   };
    // }
    try {
      // final String token = SharedPrefs.to.authToken;
      // final String? token = await prefData().getAuthToken();
      var headerData = {'Authorization': 'Bearer $s'};
      String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);
      // final _response = await httpClient.get('$kMostUsedLinksApi$_cpfNumber');
      final _response = await httpClient
          .get('$BaseURLS$kgetMostUsedLinks$_cpfNumber', headers: headerData);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<MostUsedLinksModel> _mostUsedList = _response
            .body["dtEvents"]
            .map<MostUsedLinksModel>(
                (_bannerJson) => MostUsedLinksModel.fromJson(_bannerJson))
            .toList();
        return _mostUsedList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<String> getEmployeesListApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient.get('$BaseURLS$KGetTelInfoUsingOracle',
          headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<Employee> _employeeList = _response.body
            .map<Employee>((_employeeJson) => Employee.fromJson(_employeeJson))
            .toList();

        print("_employeeList :: $_employeeList");

        final DefaultCacheManager _defaultCacheManager = DefaultCacheManager();
        await _defaultCacheManager.emptyCache();

        _employeeList.map((e) async =>
            await _defaultCacheManager.removeFile(getImageUrl(e.image)));

        await EmployeeDb.batchInsertIntoEmployeesTable(_employeeList);
        pref.putBool("isEmployeeDataSyncedAfterAlter", true);

        return kSuccess;
      } else if (_response.status.code == 401) {}

      return kMsgInvalidUserIdOrPassword;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting employees list from server',
      );

      return kMsgInvalidUserIdOrPassword;
    }
  }

  Future<String> getEmployeesSectionListApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {
        'Authorization': 'Bearer $s',
      };

      final _response =
          await httpClient.get('$BaseURLS$KGetSectionList', headers: header);

      debugPrint(
          'getEmployeesListApi: status code is: ${_response.statusCode}');
      debugPrint('getEmployeesListApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<Section> _employeeList = _response.body['lstInfo']
            .map<Section>((_employeeJson) => Section.fromJson(_employeeJson))
            .toList();

        await EmployeeDb.batchInsertIntoSectionTable(_employeeList);

        return kSuccess;
      } else if (_response.status.code == 401) {}

      return kMsgInvalidUserIdOrPassword;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting employees list from server',
      );

      return kMsgInvalidUserIdOrPassword;
    }
  }

  Future<List<LiveEvent>> getLiveEventsApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);
      final _response = await httpClient
          .get('$BaseURLS$kGetLiveEvents$_cpfNumber', headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<LiveEvent> _liveEventList = _response.body[kJsonData]
            .map<LiveEvent>(
                (_liveEventJson) => LiveEvent.fromJson(_liveEventJson))
            .toList();
        return _liveEventList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();
          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
        // update();
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting live event from server',
      );

      return [];
    }
  }

  Future<List<GuestHouse>> getGuestHouseDetailsApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};

      //kGuestHouseDetails
      // final _response = await httpClient.get(kGuestHouseApi);
      final _response =
          await httpClient.get('$BaseURLS$kGuestHouseDetails', headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<GuestHouse> _guestHousesList = _response.body[kJsonData]
            .map<GuestHouse>(
                (_guestHouseJson) => GuestHouse.fromJson(_guestHouseJson))
            .toList();

        // calling batch insert into guest houses table method
        // await GuestHouseDb.batchInsertIntoGuestHousesTable(_guestHousesList);

        return _guestHousesList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting guest house from server',
      );

      return [];
    }
  }

  Future<List<Hospital>> getHospitalsListApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      debugPrint('getHospitalsCitiesListApi: api is $kHospitalApi');
      // final _response = await httpClient.get(kHospitalApi);
      final _response = await httpClient
          .get('$BaseURLS$kGetMobileGailHospitalMaster', headers: header);

      debugPrint(
          'getHospitalsCitiesListApi: status code is: ${_response.statusCode}');
      debugPrint(
          'getHospitalsCitiesListApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<Hospital> _hospitalsList = _response.body[0]
                [kJsonHospitalList]
            .map<Hospital>((_hospitalJson) => Hospital.fromJson(_hospitalJson))
            .toList();

        // final List<City> _citiesList = _response.body[0][kJsonStateList]
        //     .map<City>((_stateJson) => City.fromJson(_stateJson))
        //     .toList();

        // calling batch insert into cities table method
        // await CityDb.batchInsertIntoCitiesTable(_citiesList);

        // calling batch insert into hospitals table method
        // await HospitalDb.batchInsertIntoHospitalsTable(_hospitalsList);

        // calling get current date time format
        pref.putString("lastSyncDate",
            getCurrentDate(newDateTimeFormat: kFullDateTimeFormat),
            isEncrypted: true);

        return _hospitalsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting hospital and cities list from server',
      );

      return [];
    }
  }
  Future<List<City>> getCitiesListApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      debugPrint('getHospitalsCitiesListApi: api is $kHospitalApi');
      // final _response = await httpClient.get(kHospitalApi);
      final _response = await httpClient
          .get('$BaseURLS$kGetMobileGailHospitalMaster', headers: header);

      debugPrint(
          'getHospitalsCitiesListApi: status code is: ${_response.statusCode}');
      debugPrint(
          'getHospitalsCitiesListApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {


        final List<City> _citiesList = _response.body[0][kJsonStateList]
            .map<City>((_stateJson) => City.fromJson(_stateJson))
            .toList();

        // calling batch insert into cities table method
        // await CityDb.batchInsertIntoCitiesTable(_citiesList);

        // calling batch insert into hospitals table method
        // await HospitalDb.batchInsertIntoHospitalsTable(_hospitalsList);

        // calling get current date time format
        pref.putString("lastSyncDate",
            getCurrentDate(newDateTimeFormat: kFullDateTimeFormat),
            isEncrypted: true);

        return _citiesList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
              await GetStorage().erase();

              // signing out from firebase on app log out
              // await _firebaseAuth.signOut();
              Get.offNamedUntil(kLoginRoute, (route) => false);
            });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
        'exception while getting hospital and cities list from server',
      );

      return [];
    }
  }
  // Future<String> getStoreListApi() async {
  //   try {
  //     debugPrint('getHospitalsCitiesListApi: api is $kHospitalApi');
  //     final _response = await httpClient.get(kHospitalApi);

  //     debugPrint(
  //         'getHospitalsCitiesListApi: status code is: ${_response.statusCode}');
  //     debugPrint(
  //         'getHospitalsCitiesListApi: response body is: ${_response.body}');

  //     if (_response.statusCode == 200 && _response.body.isNotEmpty) {
  //       final List<Hospital> _hospitalsList = _response.body[0]
  //               [kJsonHospitalList]
  //           .map<Hospital>((_hospitalJson) => Hospital.fromJson(_hospitalJson))
  //           .toList();

  //       final List<City> _citiesList = _response.body[0][kJsonStateList]
  //           .map<City>((_stateJson) => City.fromJson(_stateJson))
  //           .toList();

  //       // calling batch insert into cities table method
  //       await CityDb.batchInsertIntoCitiesTable(_citiesList);

  //       // calling batch insert into hospitals table method
  //       await HospitalDb.batchInsertIntoHospitalsTable(_hospitalsList);

  //       // calling get current date time format
  //       SharedPrefs.to.lastSyncDate =
  //           getCurrentDate(newDateTimeFormat: kFullDateTimeFormat);

  //       return kSuccess;
  //     }

  //     return '';
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg:
  //           'exception while getting hospital and cities list from server',
  //     );

  //     return '';
  //   }
  // }

  Future<String> getHolidayListApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);
      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient
          .get('$BaseURLS$KGetHolidayListPDFS$_cpfNumber', headers: header);
      // final _response = await httpClient.get('$kHolidayListApi$_cpfNumber');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final String _pdfLink = _response.body[kJsonPdfLink];

        return _pdfLink;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return '';
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting holiday list from server',
      );

      return '';
    }
  }

  Future<String> getEmpGroupAdminCheckApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);
      var header = {'Authorization': 'Bearer $s'};

      debugPrint('getHolidayListApi: api is $kEmpIsAdminApi$_cpfNumber');
      // final _response = await httpClient.get('$kEmpIsAdminApi$_cpfNumber');
      final _response = await httpClient
          .get('$BaseURLS$kcheckChatAdmin$_cpfNumber', headers: header);

      debugPrint(
          'EmpGroupAdminCheckApi: status code is: ${_response.statusCode}');
      debugPrint('EmpGroupAdminCheckApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        pref.putBool("isGroupAdmin",
            _response.body[kJsonRequestId].toLowerCase() == 'true');
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return kSuccess;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting emp group admin check list from server',
      );

      return '';
    }
  }

  Future<List<FeedbackQuestionsModel>> getFeedbackQuestionsApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};

      debugPrint('getFeedbackApi: api is $kGetFeedbackQuestionsApi');
      // final _response = await httpClient.get(kGetFeedbackQuestionsApi);
      //kGetFeedback
      final _response =
          await httpClient.get('$BaseURLS$kGetFeedback', headers: header);

      debugPrint('getFeedbackApi: status code is: ${_response.statusCode}');
      debugPrint('getFeedbackApi: response body is: ${_response.body}');

      if (_response.body != null && _response.body.isNotEmpty) {
        // final FeedbackQuestionsModel _feedbackData =
        //     FeedbackQuestionsModel.fromJson(_response.body);
        final List<FeedbackQuestionsModel> _feedbackData = _response
            .body["lstInfo"]
            .map<FeedbackQuestionsModel>((_fmsInboxJson) =>
                FeedbackQuestionsModel.fromJson(_fmsInboxJson))
            .toList();

        return _feedbackData;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting feedback from server',
      );

      return [];
    }
  }

  Future<FeedbackData?> getFeedbackApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);
      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient
          .get('$BaseURLS$kGetFeedbackSurvey$_cpfNumber', headers: header);
      // final _response = await httpClient.get('$kFeedbackApi$_cpfNumber');

      if (_response.body != null && _response.body.isNotEmpty) {
        final FeedbackData _feedbackData =
            FeedbackData.fromJson(_response.body);

        return _feedbackData;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting feedback from server',
      );

      return null;
    }
  }

  Future<Response?> submitSurveyApi({required body}) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};

      // final _response = await httpClient.post(kSubmitFeedbackApi, body: body);
      final _response = await httpClient.post('$BaseURLS$KSubmitSurvey',
          body: body, headers: header);

      if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );

      return null;
    }
  }

  Future<List<Office>> getOfficesListApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      debugPrint(
          'getOfficesListApi: api is ${kBaseUrl}GetGailCodesUsingOracle');
      final _response = await httpClient
          .get('$BaseURLS$KGetGailCodeUsingOracle', headers: header);
      // final _response =
      // await httpClient.get('${kBaseUrl}GetGailCodesUsingOracle');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<Office> _officesList = _response.body
            .map<Office>((_officeJson) => Office.fromJson(_officeJson))
            .toList();

        // calling batch insert into offices table method
        // await OfficeDb.batchInsertIntoOfficesTable(_officesList);

        return _officesList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting offices list from server',
      );

      return [];
    }
  }

  Future<List<ControlRoom>> getControlRoomListApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient.get('$BaseURLS$kgetTellSubLocation',
          headers: header);
      // final _response =
      // await httpClient.get('${kBaseUrl}GetTEL_SUBLOCATION_DETAIL');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<ControlRoom> _controlRoomsList = _response.body
            .map<ControlRoom>(
                (_controlRoomJson) => ControlRoom.fromJson(_controlRoomJson))
            .toList();

        // calling batch insert into control rooms table method
        // await ControlRoomDb.batchInsertIntoControlRoomsTable(_controlRoomsList);

        return _controlRoomsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting control room list from server',
      );

      return [];
    }
  }

  Future<List<FmsMail>> getFmsMailListApi(
      {required String id, required String api}) async {
    try {
      final _body = {kJsonUserId: id};

      final _response = await httpClient.post(api, body: _body);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<FmsMail> _fmsInboxList = _response.body[kJsonData]
            .map<FmsMail>((_fmsInboxJson) => FmsMail.fromJson(_fmsInboxJson))
            .toList();

        return _fmsInboxList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting fms inbox list from server',
      );

      return [];
    }
  }

  Future<Map<String, String>> sendOtpApi({bool reOtp = false}) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      // final String _cpfNumber = SharedPrefs.to.cpfNumber;
      final _response = await httpClient
          .get('$BaseURLS$kSendOTPS$_cpfNumber&Reotp=$reOtp', headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final _responseBody = _response.body;

        final Map<String, String> _map = {
          kJsonPhoneNo: _responseBody[kJsonPhoneNo].toString(),
          kJsonMessage: _responseBody[kJsonMessage].toString(),
        };

        return _map;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return {};
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while making send otp api call from server',
      );

      return {};
    }
  }

  Future<String> validateOtpApi(
      {required String otp, required String mobileNo}) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      debugPrint('validateOtpApi: api is $kValidateOtpApi$mobileNo/$otp');
      //kValidateOTP
      final _response = await httpClient
          .get('$BaseURLS$kValidateOTP$mobileNo/$otp', headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        return _response.body['success'].toString();
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
        return kAlertMessage;

        // update();
      } else {
        final _responseBody = _response.body;
        return _responseBody[kJsonMessage].toString();
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while making validate otp api call from server',
      );

      return '';
    }
  }

  Future<List<FmsDetail>> getFmsDetailByIdApi({required String id}) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _body = {kJsonUserId: id};

      // final _response = await httpClient.post(kFmsDetailsByIdApi, body: _body);
      final _response = await httpClient.post('$BaseURLS$kFMSShowID',
          body: _body, headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<FmsDetail> _fmsDetailList = _response.body[kJsonData]
            .map<FmsDetail>(
                (_fmsDetailJson) => FmsDetail.fromJson(_fmsDetailJson))
            .toList();

        return _fmsDetailList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting fms detail by id from server',
      );

      return [];
    }
  }

  Future<List<ReportingEmp>> getReportingEmpApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // const String _id = "575";
      var header = {'Authorization': 'Bearer $s'};
      // final _response = await httpClient.get('$kGetReportingEmployeeApi$_id');
      final _response = await httpClient.get('$BaseURLS$kFMSgetReportingEmp',
          headers: header);

      debugPrint('getReportingEmpApi: status code is: ${_response.statusCode}');
      debugPrint('getReportingEmpApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<ReportingEmp> _reportingEmpList = _response.body[kJsonData]
            .map<ReportingEmp>(
                (_reportingEmpJson) => ReportingEmp.fromJson(_reportingEmpJson))
            .toList();

        return _reportingEmpList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting reporting employee from server',
      );

      return [];
    }
  }

  Future<FmsChart?> getFmsChartDataApi() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      String? _id = await pref.getString("cpfNumber", isEncrypted: true);
      ;

      var header = {'Authorization': 'Bearer $s'};
      // final String _id = '575';
      final _body = {kJsonUserId: _id};

      // final _response = await httpClient.post(kFmsChartCountApi, body: _body);
      final _response = await httpClient.post('$BaseURLS$FMSBarCount',
          body: _body, headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final FmsChart _fmsChart = FmsChart.fromJson(_response.body);

        return _fmsChart;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting fms chart from server',
      );

      return null;
    }
  }

  Future<List<FmsMail>> getFmsChartDetailsListApi(
      {required int pendingDays}) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // const String _id = "575";
      String? _id = await pref.getString("cpfNumber", isEncrypted: true);
      ;

      var header = {'Authorization': 'Bearer $s'};
      final _body = {kJsonUserId: _id, kJsonPendingDays: pendingDays};

      debugPrint('getFmsChartDetailsListApi: api is $kFmsChartDetailsApi');
      debugPrint('getFmsChartDetailsListApi: body is $_body');

      // final _response = await httpClient.post(kFmsChartDetailsApi, body: _body);
      final _response = await httpClient.post('$BaseURLS$kGetFMSbarDetailsS',
          body: _body, headers: header);

      debugPrint(
          'getFmsChartDetailsListApi: status code is: ${_response.statusCode}');
      debugPrint(
          'getFmsChartDetailsListApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<FmsMail> _fmsInboxList = _response.body[kJsonData]
            .map<FmsMail>((_fmsInboxJson) => FmsMail.fromJson(_fmsInboxJson))
            .toList();

        return _fmsInboxList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting fms chart details list from server',
      );

      return [];
    }
  }

  Future<BwsDashCount?> getBwsDashCountApi({
    required String userId,
    required String toDate,
    required String fromDate,
  }) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _queryParams =
          '$kJsonCpf=$userId&$kJsonFromDate=$fromDate&$kJsonToDate=$toDate';

      debugPrint('getBwsDashCountApi: api is $kBwsDashCountApi$_queryParams');
      // final _response = await httpClient.get('$kBwsDashCountApi$_queryParams');
      final _response = await httpClient
          .get('$BaseURLS$kGetdepcounts$_queryParams', headers: header);

      debugPrint('getBwsDashCountApi: status code is: ${_response.statusCode}');
      debugPrint('getBwsDashCountApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final BwsDashCount _bwsDashCount =
            BwsDashCount.fromJson(_response.body);

        return _bwsDashCount;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting bws dash count from server',
      );

      return null;
    }
  }

  Future<List<BwsDashDetails>> getBwsDashDetailsApi({
    required String userId,
    required String department,
    required String status,
    required String toDate,
    required String fromDate,
  }) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _body = {
        kJsonCpf: userId,
        kJsonUser: department,
        kJsonDays: "0",
        kJsonStatus: status,
        kJsonFromDate: fromDate,
        kJsonToDate: toDate,
      };
      var header = {'Authorization': 'Bearer $s'};

      debugPrint('getBwsDashDetailsApi: api is $kBwsDashDetailsApi');
      debugPrint('getBwsDashDetailsApi: body is $_body');

      // final _response = await httpClient.post(kBwsDashDetailsApi, body: _body);
      final _response = await httpClient.post('$BaseURLS$kGetCountDetails',
          body: _body, headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<BwsDashDetails> _bwsDashDetailsList = _response
            .body[kJsonData]
            .map<BwsDashDetails>((_bwsDashDetailsJson) =>
                BwsDashDetails.fromJson(_bwsDashDetailsJson))
            .toList();

        return _bwsDashDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting bws dash details from server',
      );

      return [];
    }
  }

  Future<List<BwsBillDetails>> getBwsBillDetailsApi(
      {required String receiptNo}) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      debugPrint('getBwsBillDetailsApi: api is $kBwsBillDetailsApi$receiptNo');
      // final _response = await httpClient.get('$kBwsBillDetailsApi$receiptNo');
      final _response = await httpClient
          .get('$BaseURLS$kgetDetailsByrecno$receiptNo', headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<BwsBillDetails> _bwsBillDetailsList = _response
            .body[kJsonData]
            .map<BwsBillDetails>((_bwsBillDetailsJson) =>
                BwsBillDetails.fromJson(_bwsBillDetailsJson))
            .toList();

        return _bwsBillDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting bws bill details from server',
      );

      return [];
    }
  }

  Future<List<EmpAttendance>> getAttendanceDetails() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      String? _cpf = await pref.getString("cpfNumber", isEncrypted: true);
      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient.get('$BaseURLS$kGetAttendance$_cpf',
          headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<EmpAttendance> _EmpAttendanceList = _response
            .body[kDependentdata]
            .map<EmpAttendance>((_empAttendanceJson) =>
                EmpAttendance.fromJson(_empAttendanceJson))
            .toList();

        return _EmpAttendanceList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting Attendance details from server',
      );

      return [];
    }
  }

  Future<List<EmpAttendanceAverage>> getAttendanceAverage() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      String? _cpf = await pref.getString("cpfNumber", isEncrypted: true);
      // final String token = SharedPrefs.to.authToken;
      var header = {'Authorization': 'Bearer $s'};

      debugPrint(
          'EmpAttendanceApi: api is $BaseURLS$kGetAttendanceAverage$_cpf');
      final _response = await httpClient
          .get('$BaseURLS$kGetAttendanceAverage$_cpf', headers: header);
      // final _response = await httpClient.get('$kAttendanceRequest$_cpf');

      debugPrint(
          'getAttendanceAverage: status code is: ${_response.statusCode}');
      debugPrint('getAttendanceAverage: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<EmpAttendanceAverage> _EmpAttendanceList = _response
            .body[kDependentdata]
            .map<EmpAttendanceAverage>((_empAttendanceJson) =>
                EmpAttendanceAverage.fromJson(_empAttendanceJson))
            .toList();

        return _EmpAttendanceList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting Attendance details from server',
      );

      return [];
    }
  }

  Future<List<EmpWishesModel>> getwishesList() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      String? _cpf = await pref.getString("cpfNumber", isEncrypted: true);

      //kGetWishes
      final _response =
          await httpClient.get('$BaseURLS$kGetWishes$_cpf', headers: header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<EmpWishesModel> _EmpAttendanceList = _response
            .body[kDependentdata]
            .map<EmpWishesModel>((_empAttendanceJson) =>
                EmpWishesModel.fromJson(_empAttendanceJson))
            .toList();

        return _EmpAttendanceList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting Attendance details from server',
      );

      return [];
    }
  }

  hitCountApi({required String activity, String? activityScreen}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final String token = SharedPrefs.to.authToken;

      var header = {'Authorization': 'Bearer $s'};
      String _deviceType = '';

      // calling get app version method
      final String _appVersion = await getAppVersion();

      if (Platform.isAndroid) {
        _deviceType = 'Android';
      } else {
        _deviceType = 'iOS';
      }

      // const String _cpf = '00004891';
      String? _cpf = await pref.getString("cpfNumber", isEncrypted: true);
      final String _parameter =
          'device_type=$_deviceType&app_version=$_appVersion&cpf=$_cpf&activity=$activity&activityScreen=$activityScreen';

      debugPrint('hitCountApi: api is $BaseURLS$kCNTPHitScreen$_parameter');
      //kCNTPHitScreen
      final _response = await httpClient
          .get('$BaseURLS$kCNTPHitScreen$_parameter', headers: header);
      // final _response = await httpClient.get('$kHitCountApi?$_parameter');

      if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      debugPrint('hitCountApi: status code is: ${_response.statusCode}');
      debugPrint('hitCountApi: response body is: ${_response.body}');
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while making hit count api call',
      );
    }
  }

  Future<List<int>> getConsentSavedApi(String cpfNo) async {
    List<int> lst = [];
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response =
          await httpClient.get('$kGetConsentSavedApi$cpfNo', headers: header);

      debugPrint('getConsentSavedApi: status code is: ${_response.statusCode}');
      debugPrint('getConsentSavedApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        lst.add(int.parse(_response.body['PHONE_CONSENT']));
        lst.add(int.parse(_response.body['EMAIl_CONSENT']));
        lst.add(int.parse(_response.body['DOB_CONSENT']));
        lst.add(int.parse(_response.body['Superannuation_CONSENT']));
        // final SharedPrefs _sharedPrefs = SharedPrefs.to;
        // await pref.putInt("isPhoneConsent", int.parse(_response.body['PHONE_CONSENT']),
        //     isEncrypted: true);
        // await pref.putInt("isEmailConsent", int.parse(_response.body['EMAIl_CONSENT']),
        //     isEncrypted: true);
        // await pref.putInt("isDobConsent", int.parse(_response.body['DOB_CONSENT']),
        //     isEncrypted: true);
        // await pref.putInt(
        //     "isSuperannuationConsent", int.parse(_response.body['Superannuation_CONSENT']),
        //     isEncrypted: true);

        return lst;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<SideDrawerElements>> getSideDrawerListApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final String token = SharedPrefs.to.authToken;

      var header = {'Authorization': 'Bearer $s'};
      debugPrint('getBannerApi: api is $kGetSideDrawerElements');
      final _response =
          await httpClient.get('$BaseURLS$kGetSideDrawer', headers: header);
      // final _response = await httpClient
      //     .get(kGetSideDrawerElements); //kGetBannerNewApi); //kGetBannerApi);

      debugPrint('getBannerApi: status code is: ${_response.statusCode}');
      debugPrint('getBannerApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<SideDrawerElements> _sideDrawerList = _response
            .body["lstInfo"]
            .map<SideDrawerElements>((_sideDrawerJson) =>
                SideDrawerElements.fromJson(_sideDrawerJson))
            .toList();

        return _sideDrawerList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<Banners>> getBannerApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final String token = SharedPrefs.to.authToken;

      var header = {'Authorization': 'Bearer $s'};

      debugPrint('getBannerApi: api is $BaseURLS$kBannerS');
      final _response = await httpClient.get('$BaseURLS$kBannerS',
          headers: header); //kGetBannerNewApi); //kGetBannerApi);

      debugPrint('getBannerApi: status code is: ${_response.statusCode}');
      debugPrint('getBannerApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<Banners> _bannersList = _response.body["dtEvents"]
            .map<Banners>((_bannerJson) => Banners.fromJson(_bannerJson))
            .toList();

        return _bannersList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: 'Alert',
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<SuperAnnuationModel>> getsuperannuationApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final String token = SharedPrefs.to.authToken;

      var header = {'Authorization': 'Bearer $s'};
      debugPrint('getSuperAnnuation: api is $BaseURLS$kSuperannuationS');
      final _response = await httpClient.get('$BaseURLS$kSuperannuationS',
          headers: header); //kGetBannerNewApi); //kGetBannerApi);
      // final _response = await httpClient
      //     .get(kSuperAnnuation); //kGetBannerNewApi); //kGetBannerApi);

      debugPrint('getSuperAnnuation: status code is: ${_response.statusCode}');
      debugPrint('getSuperAnnuation: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<SuperAnnuationModel> _bannersList = _response.body
            .map<SuperAnnuationModel>(
                (_bannerJson) => SuperAnnuationModel.fromJson(_bannerJson))
            .toList();
        print(_bannersList);
        print("SuperAnnuation");

        return _bannersList;
      } else if (_response.status.code == 401) {
        // showCustomDialogAcknowledge(Get.context!,
        //     title: 'Alert',
        //     description:
        //     'Your session has been Expired\n'
        //         'Please Re-Login to fetch data.',
        //     onNegativePressed: () {}, onPositivePressed: () async{
        //       await GetStorage().erase();
        //
        //       // signing out from firebase on app log out
        //       await _firebaseAuth.signOut();
        //       Get.offNamedUntil(kLoginRoute, (route) => false);
        //     });

        // update();
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<NotificationModel>> getNotificationApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final String token = SharedPrefs.to.authToken;

      var header = {'Authorization': 'Bearer $s'};
      // debugPrint('getBannerDetailsApi: api is $kGetBannerDetailsApi$serialNo');
      final _response = await httpClient.get('$BaseURLS$kNotificationDetails',
          headers: header);
      // final _response = await httpClient.get(kGetNotificationApi);

      // debugPrint(
      //     'getBannerDetailsApi: status code is: ${_response.statusCode}');
      debugPrint(
          'getNotificationDetailsApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<NotificationModel> _notificationData = _response
            .body["lstInfo"]
            .map<NotificationModel>((_bannerDetailsJson) =>
                NotificationModel.fromJson(_bannerDetailsJson))
            .toList();

        return _notificationData;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });

        // update();
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get notification details from server',
      );

      return [];
    }
  }

  Future<List<WhatsNewModel>> getWhatsNewApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final String token = SharedPrefs.to.authToken;

      var header = {'Authorization': 'Bearer $s'};

      final _response =
          await httpClient.get('$BaseURLS$kWhatsNewS', headers: header);
      // debugPrint('getBannerDetailsApi: api is $kGetBannerDetailsApi$serialNo');
      // final _response = await httpClient.get(kGetWhatsNewApi);

      // debugPrint(
      //     'getBannerDetailsApi: status code is: ${_response.statusCode}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<WhatsNewModel> _bannerDetailsList = _response.body["lstInfo"]
            .map<WhatsNewModel>((_bannerDetailsJson) =>
                WhatsNewModel.fromJson(_bannerDetailsJson))
            .toList();

        return _bannerDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner details from server',
      );

      return [];
    }
  }

  Future<List<FresherZoneModel>> getFresherZoneApi(String type) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _response;

      var header = {'Authorization': 'Bearer $s'};

      if (type == "search") {
        _response = await httpClient.get('$BaseURLS$kGetFresherZoneSearchS',
            headers: header);
      } else {
        _response = await httpClient.get('$BaseURLS$kGetFresherZoneType$type',
            headers: header);
      }

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<FresherZoneModel> _bannerDetailsList = _response
            .body["lstInfo"]
            .map<FresherZoneModel>((_bannerDetailsJson) =>
                FresherZoneModel.fromJson(_bannerDetailsJson))
            .toList();

        return _bannerDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner details from server',
      );

      return [];
    }
  }

  Future<List<BannerDetails>> getBannerDetailsApi(
      {required String serialNo}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      print('getBannerDetailsApi: api is $BaseURLS$kGetSubbaner$serialNo');
      final _response = await httpClient.get('$BaseURLS$kGetSubbaner$serialNo',
          headers: header);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<BannerDetails> _bannerDetailsList = _response.body[kJsonData]
            .map<BannerDetails>((_bannerDetailsJson) =>
                BannerDetails.fromJson(_bannerDetailsJson))
            .toList();

        return _bannerDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner details from server',
      );

      return [];
    }
  }

  Future<List<ENoteSheetDetails>> getENoteSheetCountDetailsApi({
    required String type,
    required String status,
    required String partUrl,
    required String cpfNumber,
  }) async {
    try {
      final String _type = type.toLowerCase();
      final String _status = status.toLowerCase().replaceFirst('c', 'C');
      final _response = await httpClient
          .get('$kENoteBoxApi$partUrl/$cpfNumber?status=$_status&type=$_type');
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<ENoteSheetDetails> _eNoteSheetDetailsList = _response
            .body[kJsonData]
            .map<ENoteSheetDetails>((_eNoteSheetDetailsJson) =>
                ENoteSheetDetails.fromJson(_eNoteSheetDetailsJson))
            .toList();

        return _eNoteSheetDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting e note sheet count details for $partUrl from server',
      );

      return [];
    }
  }

  Future<ENoteSheetByFile?> getENoteSheetByFileIdApi(
      {required String fileId}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient
          .get('$BaseURLS$kGetFileInfoByIDS$fileId', headers: header);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final ENoteSheetByFile _eNoteSheetByFile =
            ENoteSheetByFile.fromJson(_response.body[kJsonData]);

        return _eNoteSheetByFile;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting e note sheet by file id from server',
      );

      return null;
    }
  }

  // kInsertWhatsNew
  Future<List<WhatsNewIsClickedModel>> getWhatsNewIsClickedApi(
      {required String cpfNo}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient
          .get('$BaseURLS$kGetWhatsNewIsClickedS$cpfNo', headers: header);
      if (_response.statusCode == 200) {
        final List<WhatsNewIsClickedModel> _whatsnewIsClicked = _response
            .body["lstInfo"]
            .map<WhatsNewIsClickedModel>(
                (json) => WhatsNewIsClickedModel.fromJson(json))
            .toList();
        return _whatsnewIsClicked;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting e note sheet by file id from server',
      );

      return [];
    }
  }

  Future<List<ENoteSheetDetails>> getENoteSheetSearchApi(
      {required String text}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _body = {kJsonText: text};
      final _response = await httpClient.post('$BaseURLS$ksearchFilesS',
          body: _body, headers: header);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<ENoteSheetDetails> _eNoteSheetDetailsList = _response
            .body[kJsonData]
            .map<ENoteSheetDetails>((_eNoteSheetDetailsJson) =>
                ENoteSheetDetails.fromJson(_eNoteSheetDetailsJson))
            .toList();

        return _eNoteSheetDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting e note sheet search from server',
      );

      return [];
    }
  }

  Future<ENoteSheet?> getENoteSheetChartCountApi({
    required String type,
    required String partUrl,
    required String cpfNumber,
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final String token = SharedPrefs.to.authToken;

      var header = {'Authorization': 'Bearer $s'};
      final String _type = type.toLowerCase();

      final _response = await httpClient.get(
          '$BaseURLS$kEnotesGetInboxCountS$cpfNumber?type=$_type',
          headers: header);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final ENoteSheet _eNoteSheet = ENoteSheet.fromJson(_response.body);

        return _eNoteSheet;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while get e note sheet bar count for from server',
      );

      return null;
    }
  }

  Future<List<ENoteSheetDetails>> getENoteSheetChartDetailsApi({
    required String type,
    required String status,
    required String partUrl,
    required String cpfNumber,
  }) async {
    try {
      // calling get e note sheet count details api method
      return await getENoteSheetCountDetailsApi(
          type: type, status: status, partUrl: partUrl, cpfNumber: cpfNumber);
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting e note sheet chart details for from server',
      );

      return [];
    }
  }

  /*Future<List<ENoteSheetChartDetails>> getENoteSheetChartDetailsApi({required String status, required String partUrl,}) async {
    try {
      String _cpfNumber = SharedPrefs.to.cpfNumber;
      _cpfNumber = '575';
      final String _status = status.toLowerCase().replaceFirst('c', 'C');

      debugPrint('getENoteSheetChartDetailsApi: api is $kENoteBarCountDetailsApi$_cpfNumber&status=$_status&type=all');
      final _response = await httpClient.get('$kENoteBarCountDetailsApi$_cpfNumber&status=$_status&type=all');

      debugPrint('getENoteSheetChartDetailsApi: status code is: ${_response.statusCode}');
      debugPrint('getENoteSheetChartDetailsApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<ENoteSheetChartDetails> _eNoteSheetDetailsList = _response.body[kJsonData]
            .map<ENoteSheetChartDetails>((_chartDetailsJson) => ENoteSheetChartDetails.fromJson(_chartDetailsJson))
            .toList();

        return _eNoteSheetDetailsList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting e note sheet chart details for from server',
      );

      return [];
    }
  }*/

  downloadImage({required String imageUrl}) async {
    try {
      debugPrint('downloadImage: api is $imageUrl');
      final _response = await http.get(Uri.parse(imageUrl));
      debugPrint('downloadImage: status code is: ${_response.statusCode}');

      if (_response.statusCode == 200) {
        //   final Uint8List _image = _response.bodyBytes.buffer.asUint8List();
        //   final String _imageName = imageUrl.split('/').last;
        //   log('image name is: downloading $_imageName');
        //   // final box = context.findRenderObject() as RenderBox?;

        //   await Share.shareUri(
        //     Uri.parse(imageUrl),
        //     // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        //   );

        //   ///TODO :: wc_flutter_share in android giving error
        //   // await WcFlutterShare.share(
        //   //   mimeType: 'image/*',
        //   //   bytesOfFile: _image,
        //   //   fileName: _imageName,
        //   //   sharePopupTitle: 'Share',
        //   // );
        // }
        final Uint8List _image = _response.bodyBytes;
        final String _imageName = imageUrl.split('/').last;
        log('image name is: downloading $_imageName');

        // Get the application's temporary directory to save the image
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/$_imageName';

        // Write the image bytes to the file
        final File imageFile = File(filePath);
        await imageFile.writeAsBytes(_image);

        // Share the file
        await Share.shareFiles(
          [imageFile.path],
        );
      } else {
        debugPrint(
            'Failed to download image. Status code: ${_response.statusCode}');
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while downloading image for ${Uri.parse(imageUrl).toString()} url',
      );
    }
  }

  // sendUserData() async {
  //   var pref = await SecureSharedPref.getInstance();
  //   String? s = await pref.getString("token", isEncrypted: true);
  //
  //   try {
  //
  //     var header = {'Authorization': 'Bearer $s'};
  //     var _body;
  //     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //     if (Platform.isAndroid) {
  //       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //       _body = {
  //         "name": "true",
  //         "cpfNo": SharedPrefs.to.cpfNumber,
  //         "version_no": SharedPrefs.to.apkVersion,
  //         "device_name": "" + androidInfo.model.toString(),
  //         "player_id": SharedPrefs.to.notificationTokenId,
  //       };
  //     }
  //     if (Platform.isIOS) {
  //       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //       _body = {
  //         "is_clicked": "true",
  //         "cpfNo": SharedPrefs.to.cpfNumber,
  //         "version_no": SharedPrefs.to.iosVersion,
  //         "device_name": "" + iosInfo.model.toString(),
  //         "player_id": SharedPrefs.to.notificationTokenId,
  //       };
  //     }
  //     final _response = await httpClient.post(
  //         '$BaseURLS$kWhstanewInsertUpdateS',
  //         body: _body,
  //         headers: header);
  //     // final _response = await httpClient.post(kInsertWhatsNew, body: _body);
  //     if (_response.status.code == 401) {
  //       showCustomDialogAcknowledge(Get.context!,
  //           title: kAlert,
  //           description: kAlertMessage,
  //           onNegativePressed: () {}, onPositivePressed: () async {
  //         await GetStorage().erase();
  //
  //         // signing out from firebase on app log out
  //         await _firebaseAuth.signOut();
  //         Get.offNamedUntil(kLoginRoute, (route) => false);
  //       });
  //     }
  //
  //     debugPrint('Insert Whats New: status code is: ${_response.statusCode}');
  //     debugPrint('Insert Whats New: response body is: ${_response.body}');
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg: 'exception while sending error logs to server',
  //     );
  //   }
  // }

  sendFeedback(FeedbackAnswer queAnsList, String ans5) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var _body = {};
      String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);
      String? apkVersion =
          await pref.getString("apkVersion", isEncrypted: true);
      String? iosVersion =
          await pref.getString("iosVersion", isEncrypted: true);

      var header = {'Authorization': 'Bearer $s'};
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _body = {
          "CPF_NO": cpfNumber,
          "VERSION_NO": apkVersion,
          "DEVICE": "" + androidInfo.model.toString(),
          "SUGGESTION": ans5.toString()
        };
      }
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _body = {
          "CPF_NO": cpfNumber,
          "VERSION_NO": iosVersion,
          "DEVICE": "" + iosInfo.model.toString(),
          "SUGGESTION": ans5.toString()
        };
      }

      _body.addAll(queAnsList.toJson());
      print(_body);
      final _response = await httpClient.post(
          '$BaseURLS$kfeedbackinsertupdateS',
          body: _body,
          headers: header);
      // final _response = await httpClient.post(kFeedbackAPI, body: _body);
      if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      debugPrint('Insert Whats New: status code is: ${_response.statusCode}');
      debugPrint('Insert Whats New: response body is: ${_response.body}');
      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while sending error logs to server',
      );
    }
  }

  ///TODO :: player id need to check
  // sendPlayerId() async {
  //   try {
  //     final String token = SharedPrefs.to.authToken;
  //
  //     var header = {'Authorization': 'Bearer $token'};
  //     Map<String, String> _body;
  //     _body = {
  //       "cpfNo": SharedPrefs.to.cpfNumber,
  //       "player_id": SharedPrefs.to.notificationTokenId,
  //       "firebase_id": SharedPrefs.to.fcmToken,
  //     };
  //     // final _response = await httpClient.post(kSendPlayerId, body: _body);
  //     final _response = await httpClient.post(
  //         '$BaseURLS$kPlayerIDInsertUpdateS',
  //         body: _body,
  //         headers: header);
  //
  //     if (_response.status.code == 401) {
  //       showCustomDialogAcknowledge(Get.context!,
  //           title: kAlert,
  //           description: kAlertMessage,
  //           onNegativePressed: () {}, onPositivePressed: () async {
  //         await GetStorage().erase();
  //
  //         // signing out from firebase on app log out
  //         await _firebaseAuth.signOut();
  //         Get.offNamedUntil(kLoginRoute, (route) => false);
  //       });
  //     }
  //
  //     debugPrint('Insert Whats New: status code is: ${_response.statusCode}');
  //     debugPrint('Insert Whats New: response body is: ${_response.body}');
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg: 'exception while sending error logs to server',
  //     );
  //   }
  // }

  sendMyNotesData(String message, String image) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final String token = SharedPrefs.to.authToken;
      String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

      var header = {'Authorization': 'Bearer $s'};
      Map<String, String> _body;
      _body = {
        "cpf_no": "$cpfNumber",
        "text": message,
        "attach": image,
        "filetype": "image"
      };
      // }
      final _response = await httpClient.post('$BaseURLS$kGailCOnnectmyNotesS',
          body: _body, headers: header);
      // final _response = await httpClient.post(kMyNotesSendDataAPI, body: _body);
      if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      // debugPrint('Insert Whats New: status code is: ${_response.statusCode}');
      // debugPrint(
      //     'Insert Whats New: response body is: ${_response.body["Message"]}');

      // if (_response.body["StatusCode"] == 200 && _response.body["Message"] == "Inserted Successfully") {
      return _response.body["Message"];
      // }
      // return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while sending error logs to server',
      );
    }
  }

  Future<List<MyNotesModel>> getMyNotesApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      //   debugPrint('getNewsByCategoryApi: api is $kNewsCatApi$newsCategory');
      String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

      // final SharedPrefs _sharedPrefs = SharedPrefs.to;
      // final String token = _sharedPrefs.authToken;

      var header = {'Authorization': 'Bearer $s'};
      debugPrint('$kMyNotesGetDataAPI${cpfNumber}');
      final _response =
          await httpClient.get('$BaseURLS$kGetMyNotes${cpfNumber}');
      // final _response =
      //     await httpClient.get('$kMyNotesGetDataAPI${_sharedPrefs.cpfNumber}');

      // debugPrint(
      //     'getNewsByCategoryApi: status code is: ${_response.statusCode}');
      // debugPrint('getNewsByCategoryApi: response body is: ${_response.body}');

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<MyNotesModel> _mynotesList = _response.body["lstInfo"]
            .map<MyNotesModel>((json) => MyNotesModel.fromJson(json))
            .toList();

        return _mynotesList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting news category from server',
      );

      return [];
    }
  }

  ///TODO:what new need to check
  // insertWhatsNew() async {
  //   try {
  //     final String token = SharedPrefs.to.authToken;
  //
  //     var header = {'Authorization': 'Bearer $token'};
  //     var _body;
  //     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //     if (Platform.isAndroid) {
  //       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //       _body = {
  //         "is_clicked": "true",
  //         "cpfNo": SharedPrefs.to.cpfNumber,
  //         "version_no": SharedPrefs.to.apkVersion,
  //         "device_name": "" + androidInfo.model.toString(),
  //         "player_id": SharedPrefs.to.notificationTokenId,
  //       };
  //     }
  //     if (Platform.isIOS) {
  //       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //       _body = {
  //         "is_clicked": "true",
  //         "cpfNo": SharedPrefs.to.cpfNumber,
  //         "version_no": SharedPrefs.to.iosVersion,
  //         "device_name": "" + iosInfo.model.toString(),
  //         "player_id": SharedPrefs.to.notificationTokenId,
  //       };
  //     }
  //     final _response = await httpClient.post(
  //         '$BaseURLS$kWhstanewInsertUpdateS',
  //         body: _body,
  //         headers: header);
  //     // final _response = await httpClient.post(kInsertWhatsNew, body: _body);
  //     if (_response.status.code == 401) {
  //       showCustomDialogAcknowledge(Get.context!,
  //           title: kAlert,
  //           description: kAlertMessage,
  //           onNegativePressed: () {}, onPositivePressed: () async {
  //         await GetStorage().erase();
  //
  //         // signing out from firebase on app log out
  //         await _firebaseAuth.signOut();
  //         Get.offNamedUntil(kLoginRoute, (route) => false);
  //       });
  //     }
  //
  //     debugPrint('Insert Whats New: status code is: ${_response.statusCode}');
  //     debugPrint('Insert Whats New: response body is: ${_response.body}');
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg: 'exception while sending error logs to server',
  //     );
  //   }
  // }

//   Future<String> getDeviceName()  {
//     final String deviceInfo = (DeviceInfoPlugin().androidInfo).device;
//     String? brand = deviceInfo['brand'];
//     String? model = deviceInfo['model'];
//     String? name = deviceInfo['name'];

//     return name ?? '$manufacturer $model';
// }

  sendErrorLogs({
    required String apiName,
    required int statusCode,
    required String className,
    required String message,
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _body = {
        "ApiName": apiName,
        "Message": message,
        "ClassName": className,
        "StatusCode": statusCode,
        "CpfNumber": cpfNumber,
      };

      final _response = await httpClient.post(kSendErrorLogsApi, body: _body);
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while sending error logs to server',
      );
    }
  }

  Future<List<NewsCategory>> getNewsByCategoryApi(
      {required String newsCategory}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient.get(
          "$BaseURLS$kGetGailNewsByCategory$newsCategory",
          headers: header);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<NewsCategory> _newsCategoryList = _response.body[kJsonData]
            .map<NewsCategory>(
                (_newsCategoryJson) => NewsCategory.fromJson(_newsCategoryJson))
            .toList();

        return _newsCategoryList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting news category from server',
      );

      return [];
    }
  }

  Future<List<ContactDetailsModel>> getContactDetailsApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);
    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient
          .get("$BaseURLS$KMedContactDetailS${cpfNumber}", headers: header);

      debugPrint('getAllAreasListApi: status code is: ${_response.statusCode}');
      debugPrint('getAllAreasListApi: response body is: ${_response.body}');

      if (_response.statusCode == 200) {
        final List<ContactDetailsModel> _contactDetails = _response
            .body["lstInfo"]
            .map<ContactDetailsModel>(
                (json) => ContactDetailsModel.fromJson(json))
            .toList();

        return _contactDetails;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting areas list from server',
      );

      return [];
    }
  }

  Future<List<DependantListModel>> getAllDependantListApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient
          .get("$BaseURLS$kEMPDependDetailsS${cpfNumber}", headers: header);

      if (_response.statusCode == 200) {
        final List<DependantListModel> _dependantList = _response
            .body["lstInfo"]
            .map<DependantListModel>(
                (json) => DependantListModel.fromJson(json))
            .toList();

        return _dependantList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting areas list from server',
      );

      return [];
    }
  }

  Future<List<AddressDetailsModel>> getAllAddressDetails() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient
          .get("$BaseURLS$kPharmacyApolloS${cpfNumber}", headers: header);
      if (_response.statusCode == 200) {
        final List<AddressDetailsModel> _dependantList = _response
            .body["lstInfo3"]
            .map<AddressDetailsModel>(
                (json) => AddressDetailsModel.fromJson(json))
            .toList();

        return _dependantList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting areas list from server',
      );

      return [];
    }
  }

  Future<List<DeliveryMode>> getDeliveryModeApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response =
          await httpClient.get("$BaseURLS$kMedDeliveryModeS", headers: header);
      if (_response.statusCode == 200) {
        final List<DeliveryMode> _medicalStoreList = _response.body["lstInfo"]
            .map<DeliveryMode>((json) => DeliveryMode.fromJson(json))
            .toList();
        return _medicalStoreList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting areas list from server',
      );

      return [];
    }
  }

  Future<List<PharmacyList>> getAllMedicalStoreListApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    try {
      var header = {'Authorization': 'Bearer $s'};
      // final _response =
      //     await httpClient.get('$kGetDependantsApi${_sharedPrefs.cpfNumber}');
      final _response =
          await httpClient.get("$BaseURLS$kMedPharmacy", headers: header);
      if (_response.statusCode == 200) {
        final List<PharmacyList> _medicalStoreList = _response.body["lstInfo"]
            .map<PharmacyList>((json) => PharmacyList.fromJson(json))
            .toList();
        return _medicalStoreList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting areas list from server',
      );

      return [];
    }
  }

  Future<List<Areas>> getAllAreasListApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response =
          await httpClient.get("$BaseURLS$kGetAreaS", headers: header);
      if (_response.statusCode == 200) {
        final List<Areas> _areasList = _response.body[kJsonData]
            .map<Areas>((_areaJson) => Areas.fromJson(_areaJson))
            .toList();

        return _areasList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting areas list from server',
      );

      return [];
    }
  }

  Future<List<Types>> getTypesListByAreaApi({required String? area}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _body = {kJsonArea: area};

      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient.post("$BaseURLS$kTypeByArea",
          headers: header, body: _body);
      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        final List<Types> _typesList = _response.body[kJsonData]
            .map<Types>((json) => Types.fromJson(json))
            .toList();

        return _typesList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting getting types list from server',
      );

      return [];
    }
  }

  Future<List<Engineer>> getEngineersListApi(
      {required String selectedArea}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _body = {kJsonArea: selectedArea};
      final _response = await httpClient.post("$BaseURLS$kGetAreaS",
          headers: header, body: _body);
      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        final List<Engineer> _engineersList = _response.body[kJsonData]
            .map<Engineer>((_engineerJson) => Engineer.fromJson(_engineerJson))
            .toList();

        return _engineersList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting engineers list from server',
      );

      return [];
    }
  }

  Future<String?> getPinCodeVerifyApi({required String pincode}) async {
    bool? deliverystatus;
    String? city;
    String? stateCode;
    String? state;
    try {
      final _body = {"params": pincode, "vendor": "gail"};
      final _header = {
        "Token": "wyDovjsafdadadhdgsRWncACA==",
      };
      // https://online.apollopharmacy.org/PINCODE/Apollo/PinCodeService
      final _response = await httpClient.post(
          "https://onlcnc.apollopharmacyconnect.in/PINCODE/Apollo/PinCodeService",
          body: _body,
          headers: _header);
      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        deliverystatus = _response.body["Status"];
        city = _response.body["City"];
        stateCode = _response.body["StateCode"];
        state = _response.body["State"];
        // city = _response.body["result"][0]["state"];
        print(stateCode);
        print("asdfghjkoiuytrt");

        // final List<Engineer> _engineersList = _response.body[kJsonData]
        //     .map<Engineer>((_engineerJson) => Engineer.fromJson(_engineerJson))
        //     .toList();
        return city! +
            "," +
            deliverystatus.toString() +
            "," +
            stateCode.toString() +
            "," +
            state.toString();
      }
      return kMsgNetworkIssue;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting engineers list from server',
      );

      return kMsgNetworkIssue; //kMsgSomethingWentWrong;
    }

    /*catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting engineers list from server',
      );

      return city! +
          "," +
          deliverystatus.toString() +
          stateCode!.toString() +
          "," +
          state.toString();
    }*/
  }

  Future<BISReport?> getBISReportsCountApi({
    required String selectedArea,
    required String selectedType,
    required String selectedToDate,
    required String selectedFromDate,
    required String selectedEngineer,
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _body = {
        "area": selectedArea,
        "type": selectedType,
        "todate": selectedToDate,
        "ENGG_ID": selectedEngineer,
        "fromdate": selectedFromDate,
      };

      final _response = await httpClient.post("$BaseURLS$kGetReportCount",
          headers: header, body: _body);
      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        final BISReport _bisReport =
            BISReport.fromJson(_response.body[kJsonData]);

        return _bisReport;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting reports count from server',
      );

      return null;
    }
  }

  Future<List<BISReportDetails>> getBISReportsCountDetailsApi({
    required String reportType,
    required String selectedArea,
    required String selectedType,
    required String selectedToDate,
    required String selectedFromDate,
    required String selectedEngineer,
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _body = {
        "area": selectedArea,
        "type": selectedType,
        "todate": selectedToDate,
        "report_type": reportType,
        "ENGG_ID": selectedEngineer,
        "fromdate": selectedFromDate,
      };

      final _response = await httpClient.post(
          "$BaseURLS$kGetReportCountDetails",
          headers: header,
          body: _body);
      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        final List<BISReportDetails> _bisReportDetailsList = _response
            .body[kJsonData]
            .map<BISReportDetails>((_bisReportDetailsJson) =>
                BISReportDetails.fromJson(_bisReportDetailsJson))
            .toList();

        return _bisReportDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting reports count details from server',
      );

      return [];
    }
  }

  Future<List<BISReportDetails>> getBISReportsCallDetailsApi(
      {required String callId}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response =
          await httpClient.get("$BaseURLS$kCallDetailS", headers: header);
      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        final List<BISReportDetails> _bisReportDetailsList = _response
            .body[kJsonData]
            .map<BISReportDetails>((_bisReportDetailsJson) =>
                BISReportDetails.fromJson(_bisReportDetailsJson))
            .toList();

        return _bisReportDetailsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting reports call details from server',
      );

      return [];
    }
  }

  Future<http.StreamedResponse?> requestCallApi({
    required String area,
    required String type,
    required String description,
    XFile? capturedImage,
    List<PlatformFile> uploadedFilesList = const [],
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};

      final _request = http.MultipartRequest(
          "POST", Uri.parse('$BaseURLS${kHelpDeskAddCall}'))
        ..fields['area'] = area
        ..fields['type'] = type
        ..fields['desc'] = description
        ..fields['userid'] = "$cpfNumber"
        ..fields['location'] =
            MainDashController.to.loggedInEmployee!.location!;
      _request.headers.addAll({"Authorization": "Bearer $s"});

      if (capturedImage != null) {
        _request.files.add(
            await http.MultipartFile.fromPath('picture', capturedImage.path));
      } else if (uploadedFilesList.isNotEmpty) {
        for (final PlatformFile _platformFile in uploadedFilesList) {
          _request.files.add(await http.MultipartFile.fromPath(
              'picture', _platformFile.path!));
        }
      }

      final _response = await _request.send();

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while adding new call for user',
      );

      return null;
    }
  }

  Future<http.StreamedResponse?> submitExceptionApi({
    required String issue,
    required String screen,
    required String trace,
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _body = {
        "errorMessage": issue,
        "errorTrace": trace,
        "screenName": screen
      };

      final _response = await httpClient.get("$BaseURLS$kExceptionLogS",
          headers: header, query: _body);

      if (_response.statusCode == 200) {
        print(
            "dfghjkl;'fchgvjbknlm;,fchgvjbk ${_response.body["kJsonMessage"]}");
        return _response.body["kJsonMessage"];
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while removing employees from group from server',
      );

      return null;
    }
  }

  Future<http.StreamedResponse?> submitMedicalApi({
    required String dependant,
    required String mobile,
    required String address,
    required String medicalstore,
    required String remarks,
    required String pincode,
    required String deliverymode,
    required String city,
    required String stateCode,
    required String state,
    List<File>? capturedImages,
    List<PlatformFile> uploadedFilesList = const [],
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _request = http.MultipartRequest(
          "POST",
          Uri.parse(
              'https://gailebank.gail.co.in/GAIL_APIs/api/GARMINDailies/MED_SAVE_DETAILS'))
        ..fields['userid'] = "$cpfNumber"
        ..fields['dependent'] = dependant
        ..fields['pharmacyStore'] = "Appolo"
        ..fields['mobileNo'] = mobile
        ..fields['deliveryMode'] = deliverymode
        ..fields['pin'] = pincode
        ..fields['remarks'] = remarks
        ..fields['area'] = address
        ..fields['stateCode'] = stateCode
        ..fields['state'] = state
        ..fields['city'] = city;
      print("fields :: ${_request.fields}");
      _request.headers.addAll({"Authorization": "Bearer $s"});
      if (capturedImages!.isNotEmpty && uploadedFilesList.isEmpty) {
        isPicture = true;
        for (int i = 0; i < capturedImages.length; i++) {
          var str = capturedImages[i].path.split("/");
          String a = str[str.length - 1];

          /// TODO IMAGE PATH NEED TO CHECK FOR AUDIT
          urlValues.putIfAbsent(
              "url",
              () =>
                  "https://gailebank.gail.co.in/GAIL_APIs/CallImages/" +
                  a.toString());
          _request.files.add(await http.MultipartFile.fromPath(
              'picture', capturedImages[i].path));
        }
      } else if (capturedImages.isEmpty && uploadedFilesList.isNotEmpty) {
        isFile = true;
        for (final PlatformFile _platformFile in uploadedFilesList) {
          _request.files.add(await http.MultipartFile.fromPath(
              'picture', _platformFile.path!));
        }
      } else if (capturedImages.isNotEmpty && uploadedFilesList.isNotEmpty) {
        isBoth = true;
        for (final PlatformFile _platformFile in uploadedFilesList) {
          _request.files.add(await http.MultipartFile.fromPath(
              'picture', _platformFile.path!));

          for (int i = 0; i < capturedImages.length; i++) {
            _request.files.add(await http.MultipartFile.fromPath(
                'picture', capturedImages[i].path));
          }
        }
      }

      final _response = await _request.send();

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while adding new call for user',
      );

      return null;
    }
  }

  Future<http.StreamedResponse?> submitPlaceOrderApi({
    required String dependant,
    required String mobile,
    required String address,
    required String medicalstore,
    required String remarks,
    required String pincode,
    required String deliverymode,
    required String reqID,
    required String city,
    List<File>? capturedImages,
    List<PlatformFile> uploadedFilesList = const [],
  }) async {
    try {
      var headers = {
        'Token': 'rXc8jCeDyuNnckMCx7LvGAI/VQ2q771gal',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
        'POST',
        Uri.parse(
            'https://online.apollopharmacy.org/UAT/OrderPlace.svc/Place_orders'),
      );
      request.body = json.encode(
        {
          "tpdetails": {
            "OrderId": reqID,
            "ShopId": "16001",
            "ShippingMethod": "Home Delivery",
            "PaymentMethod": "PREPAID",
            "VendorName": "GAIL",
            "DotorName": "Apollo",
            "StateCode": "TS",
            "TAT": "",
            "OrderType": "PHARMA",
            "CouponCode": "MED10",
            "OrderDate": "2020-11-26",
            "RequestType": "NON-CART",
            "UserId": "AP36695",
            "CustomerDetails": {
              "MobileNo": mobile,
              "Comm_addr": address,
              "Del_addr": address,
              "FirstName": dependant,
              "LastName": "",
              "UHID": "APJ0000000001806",
              "City": city,
              "PostCode": pincode,
              "MailID": "",
              "Age": 25,
              "CardNo": "",
              "PatientName": dependant,
              "Latitude": 0,
              "Longitude": 0,
              "Remarks": remarks
            },
            "PaymentDetails": {
              "TotalAmount": "",
              "PaymentSource": "",
              "PaymentStatus": "",
              "PaymentOrderId": ""
            },
            "ItemDetails": [
              {
                "ItemDetails": "",
                "ItemID": "CRO0091",
                "ItemName": "",
                "Qty": 30,
                "MOU": 15,
                "Pack": "2",
                "Price": 217.55,
                "Status": true,
                "Remarks": remarks
              }
            ],
            "PrescUrl": [urlValues]
          }
        },
      );

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      return response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while adding new call for user',
      );

      return null;
    }
  }

  Future<List<DispensaryHistoryDetailsModel>>
      getDispensaryHistoryDetailsListApi(reqNodis) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient
          .get("$BaseURLS$kRequestnoDetails${reqNodis}", headers: header);

      print("$kRequestnoDetails :: ${_response.body}");
      // final _response =
      //     await httpClient.get("$kGetDispensaryRequestDetailsApi${reqNodis}");
      if (_response.statusCode == 200) {
        final List<DispensaryHistoryDetailsModel> allsList = _response
            .body["lstInfo"]
            .map<DispensaryHistoryDetailsModel>((_dispensaryHistoryJSON) =>
                DispensaryHistoryDetailsModel.fromJson(_dispensaryHistoryJSON))
            .toList();
        pref.putString("reqNumber", "", isEncrypted: true);

        return allsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<DispensaryHistoryDetailsModelUrl>>
      getDispensaryHistoryDetailsListApi1(String sno) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient
          .get("$BaseURLS$kRequestnoDetails${sno}", headers: header);
      if (_response.statusCode == 200) {
        final List<DispensaryHistoryDetailsModelUrl> allsList = _response
            .body["lstInfo2"]
            .map<DispensaryHistoryDetailsModelUrl>((_dispensaryHistoryJSON) =>
                DispensaryHistoryDetailsModelUrl.fromJson(
                    _dispensaryHistoryJSON))
            .toList();

        return allsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AddressDetailsModel>> getRequestHistoryAPI(String sno) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient
          .get("$BaseURLS$kPharmacyRequestHistory${sno}", headers: header);
      if (_response.statusCode == 200) {
        final List<AddressDetailsModel> allsList = _response.body["lstInfo3"]
            .map<AddressDetailsModel>((_dispensaryHistoryJSON) =>
                AddressDetailsModel.fromJson(_dispensaryHistoryJSON))
            .toList();
        return allsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<String?> getacknowledeApi(
      {required String SNO,
      required String remarks,
      required String rcvStatus}) async {
    int? deliverystatus;
    String? message;
    String? stateCode;
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};

      final _response = await httpClient.get(
          "$BaseURLS$kpharmacyRequestAckStatus" +
              SNO.toString() +
              "&remarks=" +
              remarks +
              "&ackVal=" +
              rcvStatus,
          headers: _header);
      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        deliverystatus = _response.body["StatusCode"];
        message = _response.body["Message"];
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return message! + "," + deliverystatus.toString();
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting engineers list from server',
      );
      return message! + "," + deliverystatus.toString();
    }
  }

  Future<String?> getpharmacyCancelApi({required String SNO}) async {
    int? deliverystatus;
    String? message;
    String? stateCode;
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient
          .get("$BaseURLS$kPharmacyRequestCancelS${SNO}", headers: _header);
      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        deliverystatus = _response.body["StatusCode"];
        message = _response.body["Message"];
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return message! + "," + deliverystatus.toString();
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting engineers list from server',
      );
      return message! + "," + deliverystatus.toString();
    }
  }

  Future<List<DispensaryHistoryModel>> getDispensaryHistoryListApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};

      final _response = await httpClient
          .get("$BaseURLS$kEMPrequestDetails${cpfNumber}", headers: _header);
      if (_response.statusCode == 200) {
        final List<DispensaryHistoryModel> allsList = _response.body["lstInfo"]
            .map<DispensaryHistoryModel>((_dispensaryHistoryJSON) =>
                DispensaryHistoryModel.fromJson(_dispensaryHistoryJSON))
            .toList();
        return allsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting bis helpdesk calls list from server',
      );

      return [];
    }
  }

  Future<List<BISHelpdeskCalls>> getBISHelpdeskCallsListApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient
          .get("$BaseURLS$kHelpdeskgetCall${cpfNumber}", headers: _header);
      if (_response.statusCode == 200) {
        final List<BISHelpdeskCalls> _bisHelpdeskCallsList = _response
            .body[kJsonData]
            .map<BISHelpdeskCalls>((_bisHelpdeskCallsJson) =>
                BISHelpdeskCalls.fromJson(_bisHelpdeskCallsJson))
            .toList();
        return _bisHelpdeskCallsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting bis helpdesk calls list from server',
      );
      return [];
    }
  }

  Future<List<BISHelpdeskCalls>> getBISHelpdeskCallByIdApi(
      {required String callId}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient
          .get('$BaseURLS$kHelpDeskGetCallById$callId', headers: _header);

      if (_response.statusCode == 200) {
        final List<BISHelpdeskCalls> _bisHelpdeskCallsList = _response
            .body[kJsonData]
            .map<BISHelpdeskCalls>((_bisHelpdeskCallsJson) =>
                BISHelpdeskCalls.fromJson(_bisHelpdeskCallsJson))
            .toList();

        return _bisHelpdeskCallsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting bis helpdesk call by id from server',
      );

      return [];
    }
  }

  Future<List<Utilization>> getDispensaryCancelOrderApi() async {
    try {
      final _response = await httpClient.get(kGetDispensaryCancelOrderApi);

      if (_response.statusCode == 200) {
        final List<Utilization> _utilizationList = _response.body[kJsonData]
            .map<Utilization>(
                (_utilizationJson) => Utilization.fromJson(_utilizationJson))
            .toList();

        return _utilizationList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting utilization list from server',
      );

      return [];
    }
  }

  Future<List<Utilization>> getUtilizationApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient.get("$BaseURLS$kGetAppUtilization",
          headers: _header);
      if (_response.statusCode == 200) {
        final List<Utilization> _utilizationList = _response.body[kJsonData]
            .map<Utilization>(
                (_utilizationJson) => Utilization.fromJson(_utilizationJson))
            .toList();

        return _utilizationList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting utilization list from server',
      );

      return [];
    }
  }

  Future<List<Employee>> getEmpNotHavingAppApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response =
          await httpClient.get("$BaseURLS$kNonGCPAUser", headers: _header);
      if (_response.statusCode == 200) {
        final List<Employee> _employeeList = _response
            .body[kJsonUninstalledGailConnectAppUsers]
            .map<Employee>((_employeeJson) => Employee.fromJson(_employeeJson))
            .toList();

        return _employeeList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employee not having app list from server',
      );

      return [];
    }
  }

  Future<List<Employee>> getEmpHavingAppApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response =
          await httpClient.get("$BaseURLS$kGCAppUser", headers: _header);
      // final _response = await httpClient.get(kEmpHavingAppApi);

      debugPrint(
          'getEmpHavingAppApi: response status code is ${_response.statusCode}');
      debugPrint('getEmpHavingAppApi: response body is ${_response.body}');

      if (_response.statusCode == 200) {
        final List<Employee> _employeeList = _response.body["data"]
            .map<Employee>((_employeeJson) => Employee.fromJson(_employeeJson))
            .toList();

        return _employeeList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employee having app list from server',
      );

      return [];
    }
  }

  Future<List<EmpGroup>> getEmpGroupsListApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      // final _response = await httpClient.get("$BaseURLS$kGCAppUser",headers: _header);
      final _response = await httpClient.get('$kGetGroupsApi$cpfNumber');

      if (_response.statusCode == 200) {
        final List<EmpGroup> _empGroupList = _response.body[kJsonData]
            .map<EmpGroup>((_empGroupJson) => EmpGroup.fromJson(_empGroupJson))
            .toList();

        return _empGroupList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employees groups list from server',
      );

      return [];
    }
  }

  Future<EmpGroup?> getEmpGroupDetailsApi({required String empGroupId}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      // final SharedPrefs _sharedPrefs = SharedPrefs.to;
      // final String token = _sharedPrefs.authToken;

      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient.get("$BaseURLS$kGCAppUser$empGroupId",
          headers: _header);

      if (_response.statusCode == 200) {
        final EmpGroup _empGroup = EmpGroup.fromJson(_response.body[kJsonData]);

        return _empGroup;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employees groups list from server',
      );

      return null;
    }
  }

  removeMemberFromGroupApi(
      {required String empGroupId, required String groupMembers}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _body = {kJsonIdCaps: empGroupId, "GROUP_Members": groupMembers};

      final _response = await httpClient.post(
        "$BaseURLS$kRemoveMemberFromGroup",
        body: _body,
        headers: _header,
      );
      if (_response.statusCode == 200) {
        return _response.body[kJsonMessage];
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while removing employees from group from server',
      );

      return null;
    }
  }

  Future<Response?> getWishesApi({required body}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient.post(
        "$BaseURLS$kSubmitSurveyS",
        body: body,
        headers: _header,
      );
      // final _response = await httpClient.post(kSubmitFeedbackApi, body: body);
      if (_response.statusCode == 200) {
        return _response;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );

      return null;
    }
  }

  Future<String?> addNewMembersToGroupApi(
      {required String empGroupId, required String groupMembers}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _body = {kJsonIdCaps: empGroupId, "GROUP_Members": groupMembers};

      final _response = await httpClient.post(
        "$BaseURLS$kAddmembertoGroup",
        body: _body,
        headers: _header,
      );
      if (_response.statusCode == 201) {
        return _response.body[kJsonMessage];
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while making api call for adding new employees to group',
      );

      return null;
    }
  }

  Future<String?> createNewGroupApi({
    File? selectedGroupIcon,
    required String groupName,
    required String groupMembers,
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _request = http.MultipartRequest(
          "POST", Uri.parse(/*kCreateNewGroupApi*/ "$BaseURLS$kNewGroupS"))
        ..fields['GroupName'] = groupName
        ..fields['members'] = groupMembers
        ..fields['CreatedBy'] = "$cpfNumber";

      _request.headers.addAll({"Authorization": "Bearer $s"});

      if (selectedGroupIcon != null) {
        _request.files.add(await http.MultipartFile.fromPath(
            'picture', selectedGroupIcon.path));
      }

      final _response = await _request.send();

      if (_response.statusCode == 201) {
        final _responseBytesToString = await _response.stream.bytesToString();

        final String _data =
            json.decode(_responseBytesToString)[kJsonMessage].toString();

        return _data;
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while making api call for creating new group',
      );

      return null;
    }
  }

  Future<String?> updateGroupIconNameApi({
    File? selectedGroupIcon,
    required String groupName,
    required String empGroupId,
  }) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _request = http.MultipartRequest("POST",
          Uri.parse(/*kUpdateGroupIconNameApi*/ "$BaseURLS$KUpdateGroupIconS"))
        ..fields['ID'] = empGroupId
        ..fields['NAME'] = groupName;
      _request.headers.addAll({"Authorization": "Bearer $s"});

      if (selectedGroupIcon != null) {
        _request.files.add(await http.MultipartFile.fromPath(
            'picture', selectedGroupIcon.path));
      }

      final _response = await _request.send();

      if (_response.statusCode == 200) {
        final _responseBytesToString = await _response.stream.bytesToString();

        final String _data =
            json.decode(_responseBytesToString)[kJsonMessage].toString();

        return _data;
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while making api call for creating new group',
      );

      return null;
    }
  }

  Future<String?> deleteGroupApi(
      {required String empGroupId, required String adminCpf}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient.get(
        "$BaseURLS$kDeleteGroupID$empGroupId&Admincpf=$adminCpf",
        headers: _header,
      );

      if (_response.statusCode == 200) {
        return _response.body[kJsonMessage];
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return null;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while making api call for deleting group',
      );

      return null;
    }
  }

  sendOneSignalNotification(
      {required ChatNotification chatNotification}) async {
    try {
      Map<String, dynamic> _body = {};

      if (chatNotification.imageUrl != null) {
        _body = chatNotification.toImageMap();
      } else {
        _body = chatNotification.toMap();
      }

      final _response =
          await httpClient.post(kOneSignalNotificationApi, body: _body);
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while sending one signal notification method',
      );
    }
  }

  Future<Response?> sendpostwishes({required body}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient.post(
        "$BaseURLS$kGailConnectWishes",
        body: body,
        headers: _header,
      );
      // final _response = await httpClient.post(ksendWishesPost, body: body);

      if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      debugPrint('submitwishApi: status code is: ${_response.statusCode}');
      debugPrint('submitwishApi: response body is: ${_response.body}');

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );

      return null;
    }
  }

  Future<String?> getAcknowledeResponse() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    // final String _cpfNumber = "00015813";
    try {
      final _header = {"Authorization": "Bearer $s"};
      // debugPrint('getEngineersListApi: api is $kGetEngineersByAreaApi');
      // debugPrint('getEngineersListApi: body is $_body');
      final _response = await httpClient.get(
        "$BaseURLS$kcashlessMedicineAcknowledgement$_cpfNumber",
        headers: _header,
      );
      // final _response = await httpClient.get("$kAcknowledgeUrl$_cpfNumber");
      print("$kAcknowledgeUrl$_cpfNumber");

      if (_response.statusCode == 200 &&
          _response.body != null &&
          _response.body.isNotEmpty) {
        // final List<Engineer> _engineersList = _response.body[kJsonData]
        //     .map<Engineer>((_engineerJson) => Engineer.fromJson(_engineerJson))
        //     .toList();
        return _response.body["acknowledgement"];
      }
      print(
          "_response.body[acknowledgement] :: ${_response.body["acknowledgement"]}");
      return _response.body["acknowledgement"];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting engineers list from server',
      );

      return kMsgNetworkIssue; //kMsgSomethingWentWrong;
    }
  }

  Future<List<AppStoreModel>> getAppStoreApiData() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient.get(
        "$BaseURLS$kGetAppData",
        headers: _header,
      );

      if (_response.statusCode == 200) {
        final List<AppStoreModel> allsList = _response.body["lstInfo"]
            .map<AppStoreModel>((_dispensaryHistoryJSON) =>
                AppStoreModel.fromJson(_dispensaryHistoryJSON))
            .toList();

        return allsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employees groups list from server',
      );

      return [];
    }
  }

  Future<List<Employee>> getEmployeesListApiLive() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient
          .get("$BaseURLS$kGetTellInfoUsingOracle", headers: _header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<Employee> _employeeList = _response.body
            .map<Employee>((_employeeJson) => Employee.fromJson(_employeeJson))
            .toList();

        return _employeeList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employees groups list from server',
      );

      return [];
    }
  }

  Future<List<DashboardListModel>> dashboardListData() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient.get("$BaseURLS$kGetDashboardAccess",
          headers: _header);
      if (_response.body != null && _response.body.isNotEmpty) {
        // final FeedbackQuestionsModel _feedbackData =
        //     FeedbackQuestionsModel.fromJson(_response.body);
        final List<DashboardListModel> _feedbackData = _response.body["lstInfo"]
            .map<DashboardListModel>(
                (_fmsInboxJson) => DashboardListModel.fromJson(_fmsInboxJson))
            .toList();

        return _feedbackData;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employees groups list from server',
      );

      return [];
    }
  }

  Future<List<IDViewModel>> getAllIdViewData() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      // debugPrint(
      //     'getAllAreasListApi: api is $kGetDependantsApi${_sharedPrefs.cpfNumber}');
      // final _response = await httpClient.get('$kGetDependantsApi${4911}');
      final _response = await httpClient
          .get("$BaseURLS$kIDViewListS${cpfNumber}", headers: _header);
      // final _response =
      // await httpClient.get("$kIDViewListAPI${_sharedPrefs.cpfNumber}");

      debugPrint('getAllAreasListApi: status code is: ${_response.statusCode}');
      debugPrint('getAllAreasListApi: response body is: ${_response.body}');

      if (_response.statusCode == 200) {
        final List<IDViewModel> _dependantList = _response.body["lstInfo"]
            .map<IDViewModel>((json) => IDViewModel.fromJson(json))
            .toList();

        return _dependantList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting areas list from server',
      );

      return [];
    }
  }

  Future<Response?> sendCMDOpenHosue({required body}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};

      final _response = await httpClient.post("$BaseURLS$KCMDHousePostS",
          body: body, headers: _header);

      if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      // final _response = await httpClient.post(kCMDOpenHouseApi, body: body);

      debugPrint('cmdOpenHouse: status code is: ${_response.statusCode}');
      debugPrint('cmdOpenHouse: response body is: ${_response.body}');

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );

      return null;
    }
  }

  Future<Response?> sendConcentFormData({required body}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      ;
      final _response = await httpClient.post("$BaseURLS$kGCConsentPostS",
          body: body, headers: _header);
      // final _response = await httpClient.post(kConcentFormApi, body: body);

      if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );

      return null;
    }
  }

  Future<List<PhoneConsent>> getConsentDatadetails() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response =
          await httpClient.get("$BaseURLS$kGetConsentData", headers: _header);
      // final _response = await httpClient.get(kGetConsentDataApi);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<PhoneConsent> _activeNewsList = _response
            .body["Phone_Consent"]
            .map<PhoneConsent>(
                (_bannerJson) => PhoneConsent.fromJson(_bannerJson))
            .toList();
        return _activeNewsList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<Superannuation_Consent>> getConsentsuperannuationdetails() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response =
          await httpClient.get("$BaseURLS$kGetConsentData", headers: _header);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<Superannuation_Consent> _activeNewsList = _response
            .body["Superannuation_Consent"]
            .map<Superannuation_Consent>(
                (_bannerJson) => Superannuation_Consent.fromJson(_bannerJson))
            .toList();
        return _activeNewsList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<DOBConsent>> getConsentBdaydetails() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response =
          await httpClient.get("$BaseURLS$kGetConsentData", headers: _header);
      // final _response = await httpClient.get(kGetConsentDataApi);
      print("_response :: ${_response.body}");
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<DOBConsent> _activeNewsList = _response.body["DOB_Consent"]
            .map<DOBConsent>((_bannerJson) => DOBConsent.fromJson(_bannerJson))
            .toList();
        return _activeNewsList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  //getConsentPhonedetails
  Future<List<PhoneConsent>> getConsentPhonedetails() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response =
          await httpClient.get("$BaseURLS$kGetConsentData", headers: _header);

      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<PhoneConsent> _activeNewsList = _response
            .body["Phone_Consent"]
            .map<PhoneConsent>(
                (_bannerJson) => PhoneConsent.fromJson(_bannerJson))
            .toList();
        return _activeNewsList;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );

      return [];
    }
  }

  Future<List<Installed>> getAppCountbyGradeApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response = await httpClient.get(
          "https://gailebank.gail.co.in/GAIL_APIs/api/GailConnect/Get_TotalCount",
          headers: _header);

      if (_response.statusCode == 200) {
        final List<Installed> _employeeList = _response.body['Installed']
            .map<Installed>(
                (_employeeJson) => Installed.fromJson(_employeeJson))
            .toList();

        return _employeeList;
        // return _response;
      }

      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employee having app list from server',
      );

      return [];
    }
  }

  Future<List<Uninstalled>> getAppCountUninstalledbyGradeApi() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};

      final _response = await httpClient.get(
          "https://gailebank.gail.co.in/GAIL_APIs/api/GailConnect/Get_TotalCount",
          headers: _header);

      if (_response.statusCode == 200) {
        final List<Uninstalled> _employeeList = _response.body['Uninstalled']
            .map<Uninstalled>(
                (_employeeJson) => Uninstalled.fromJson(_employeeJson))
            .toList();

        return _employeeList;
        // return _response;
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employee having app list from server',
      );
      return [];
    }
  }

  Future<List<String>> getLiveEvents() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);

    try {
      final _header = {"Authorization": "Bearer $s"};
      final _response =
          await httpClient.get("$BaseURLS$kGetUrlS", headers: _header);

      if (_response.statusCode == 200) {
        final List<String> _liveEventsList =
            _response.body['result'].cast<String>();
        return _liveEventsList;
        // return _response;
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg:
            'exception while getting employee having app list from server',
      );
      return [];
    }
  }

  Future<List<OHCMODEL>> getOhcScreenData() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient.get("$BaseURLS$kOHCView${_cpfNumber}",
          headers: header);

      if (_response.statusCode == 200) {
        final List<OHCMODEL> _medicalStoreList = _response.body["lstInfo"]
            .map<OHCMODEL>((json) => OHCMODEL.fromJson(json))
            .toList();
        return _medicalStoreList;
      } else if (_response.status.code == 401) {
        showCustomDialogAcknowledge(Get.context!,
            title: kAlert,
            description: kAlertMessage,
            onNegativePressed: () {}, onPositivePressed: () async {
          await GetStorage().erase();

          // signing out from firebase on app log out
          // await _firebaseAuth.signOut();
          Get.offNamedUntil(kLoginRoute, (route) => false);
        });
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while getting areas list from server',
      );

      return [];
    }
  }

  Future<Response?> sendOHCScreenData({required body}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient.post("$BaseURLS$kOHCPostData",
          body: body, headers: header);

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );

      return null;
    }
  }

  Future<Response?> updateOHCScreenData({required body}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient.post("$BaseURLS$kOHCUpdateData",
          body: body, headers: header);

      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );

      return null;
    }
  }

  Future<Response?> stepDataInsertLive({required body}) async {
    double v = 0;
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      await showProgressDialog(Get.context!, message: "Uploading");

      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient.post("$BaseURLS$kHealthInsertData",
          body: body, headers: header);
      await hideProgressDialog();
      showCustomDialogAcknowledge(Get.context!,
          title: "",
          description: "Data Uploaded Successfully",
          onNegativePressed: () {}, onPositivePressed: () async {
        Navigator.pop(Get.context!);
      });
      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );
      return null;
    }
  }

  Future<List<HealthDataModel>> getHealthLiveData() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? empno = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      //$kMostUsedLinksApi$_cpfNumber
      final _response = await httpClient.get("$BaseURLS$kgetHealthData$empno",
          headers: header);
      if (_response.statusCode == 200 && _response.body.isNotEmpty) {
        final List<HealthDataModel> _activeNewsList = _response.body["lstInfo"]
            .map<HealthDataModel>(
                (_bannerJson) => HealthDataModel.fromJson(_bannerJson))
            .toList();
        return _activeNewsList;
      }
      return [];
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while get banner from server',
      );
      return [];
    }
  }

  Future<Response?> setTargetDataInsert({required body}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient.post("$BaseURLS$ksetTargetInsertData",
          body: body, headers: header);
      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );
      return null;
    }
  }

  Future<Response?> setTargetDataAchieved({required body}) async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};

      final _response = await httpClient.post(
          "$BaseURLS$ksetTargetAchievedData",
          body: body,
          headers: header);
      return _response;
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while submitting and calling api call',
      );
      return null;
    }
  }

  Future<String> returnCurrentTime() async {
    var pref = await SecureSharedPref.getInstance();
    String? s = await pref.getString("token", isEncrypted: true);
    String? _cpfNumber = await pref.getString("cpfNumber", isEncrypted: true);

    try {
      var header = {'Authorization': 'Bearer $s'};
      final _response = await httpClient.get(
          "https://gailebank.gail.co.in/GAIL_APIs/api/Health/ReturnTime",
          headers: header);
      if (_response.statusCode == 200) {
        final String _data = _response.body["result"];
        print("result _data :: $_data");
        // pref.putString("current_time", _data);
        return _data;
      } else {
        return " ";
      }
    } catch (e) {
      return "";
    }
  }
}
