// Created By Amit Jangid 13/07/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/rest/auth_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:health/health.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class LoginController extends GetxController {
  static const String _tag = 'LoginController';

  final FocusNode userIdFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static LoginController get to => Get.find<LoginController>();

  String userId = '';
  String password = '';
  final _showPassword = false.obs;

  bool get showPassword => _showPassword.value;

  set showPassword(bool showPassword) => _showPassword.value = showPassword;

  @override
  void onInit() async {
    // TODO: implement onInit
    // Health().configure(useHealthConnectIfAvailable: true);
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    try {
      print(
          "controller init ${userIdController.text} ${passwordController.text}");
      userIdController.text =
          (await pref.getString("userName", isEncrypted: true)) ?? "";
      passwordController.text =
          (await pref.getString("password", isEncrypted: true)) ?? "";
    } catch (e) {
      print(e);
    }
    super.onInit();

    if (Platform.isIOS) {
      print("into the authorize method");
      await Future.delayed(Duration(seconds: 10));
      print("into the authorize method after 10 second");
      authorize();
    }
  }

  static final types = [HealthDataType.STEPS];

  final permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();
  // create a HealthFactory for use in the app
  final health = Health();

  // HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  Future authorize() async {
    print("into the authorize method inside authorised");
    await Permission.activityRecognition.request();
    await Permission.location.request();
    await health.configure();
    // Check if we have health permissions
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);

    hasPermissions = false;

    bool authorized = false;

    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
        authorized =
            await health.requestAuthorization(types, permissions: permissions);
      } catch (error) {}
    }

    // setState(() => _state =
    // (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED);

    // if(authorized){
    //   HealthController().fetchStepData();
    // }

    print("end the authorize method");
  }

  @override
  void onReady() async {
    super.onReady();

    _checkIfLoggedInAndLogin();
    // calling check if logged in and login
    final SecureSharedPref pref = await SecureSharedPref.getInstance();
    // await pref.putString("userName", userIdController.text,isEncrypted: true);
    // await pref.putString("password", passwordController.text,isEncrypted: true);
    try {
      userIdController.text =
          (await pref.getString("userName", isEncrypted: true)) ?? "";
      passwordController.text =
          (await pref.getString("password", isEncrypted: true)) ?? "";
    } catch (e) {
      print(e);
    }
  }

  _checkIfLoggedInAndLogin() async {
    try {
      SecureSharedPref pref = await SecureSharedPref.getInstance();
      bool? isLoggedIn = await pref.getBool("isLoggedIn");
      String? _userName = await pref.getString("userName", isEncrypted: true);
      String? _password = await pref.getString("password", isEncrypted: true);

      print(
          "_checkIfLoggedInAndLogin *** $isLoggedIn ** $_userName ** $_password");
      if (isLoggedIn ?? false) {
        if (_userName!.isNotEmpty && _password!.isNotEmpty) {
          userId = (await pref.getString("userName", isEncrypted: true))!;
          password = (await pref.getString("password", isEncrypted: true))!;

          // calling authenticate user method
          authenticateUser(context: Get.context!);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  authenticateUser({required BuildContext context}) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    try {
      late String _result;

      // calling show progress dialog method
      await showProgressDialog(context);

      if (await checkConnectivity()) {
        // calling authenticate user api method
        _result = await AuthServices.to
            .authenticateUserApi(userId: userId.trim(), password: password);

        // calling on fcm token refresh method
        // _onFcmTokenRefresh();
      } else {
        // calling get logged in employee from db method
        final Employee? _employee =
            await EmployeeDb.getLoggedInEmployeeFromDb();

        if (_employee != null) {
          _result = kSuccess;
        } else {
          if (await checkConnectivity() == true) {
            _result = kMsgInvalidUserIdOrPassword;
          } else {
            _result = kMsgNetworkIssue;
          }
          //kMsgInvalidUserIdOrPassword;
        }
      }

      // calling hide progress dialog method
      await hideProgressDialog();

      if (_result == kSuccess) {
        // await _initOneSignalSdk();
        pref.putString("userName", userId, isEncrypted: true);
        pref.putString("password", password, isEncrypted: true);

        userId = '';
        password = '';
        if (pref.getString('noti', isEncrypted: true) == "true") {
          pref.putString('noti', "false", isEncrypted: true);
          Get.toNamed(kNotifyScreenRoute);
        } else {
          pref.putString('noti', "false", isEncrypted: true);
          Get.offNamedUntil(kMainDashRoute, (route) => false);
        }
        Get.offNamedUntil(kMainDashRoute, (route) => false);
      } else if (_result == kMsgNetworkIssue) {
        showCustomDialogBox(
            context: context, title: kError, description: kMsgNetworkIssue);
      } else {
        // calling show custom dialog box method
        showCustomDialogBox(
            context: context, title: kError, description: _result);
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while authenticating user',
      );
    }
  }

  requestFocus({required BuildContext context, required FocusNode focusNode}) {
    FocusScope.of(context).requestFocus(focusNode);
    update([kLogin]);
  }

  // _onFcmTokenRefresh() {
  //   try {
  //     FirebaseMessaging.instance.onTokenRefresh.listen((_fcmToken) {
  //       debugPrint(
  //           'onTokenRefresh: on token refresh method called, token refreshed');
  //       debugPrint('onTokenRefresh: new fcm token is: $_fcmToken');
  //
  //       if (_fcmToken != SharedPrefs.to.fcmToken) {
  //         SharedPrefs.to.fcmToken = _fcmToken;
  //
  //         // callig send fcm token api method
  //         // GailConnectServices.to.sendFcmTokenApi(fcmToken: _fcmToken);
  //       }
  //     });
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg: 'exception while listening to on token refresh',
  //     );
  //   }
  // }

  @override
  void dispose() {
    userIdFocusNode.dispose();
    passwordFocusNode.dispose();
    userIdController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  ///TODO :: not used
  // Future<void> _initOneSignalSdk() async {
  //   try {
  //     //Remove this method to stop OneSignal Debugging
  //     OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  //
  //     // setting one signal app id for receiving notification
  //     OneSignal.shared.setAppId(kOneSignalAppId);
  //
  //     debugPrint("OneSignal APP ID : $kOneSignalAppId");
  //
  //     // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt.
  //     // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  //     OneSignal.shared
  //         .promptUserForPushNotificationPermission()
  //         .then((accepted) {
  //       debugPrint("Accepted permission1: $accepted");
  //       debugPrint("promptUserForPushNotificationPermission: $accepted");
  //     });
  //
  //     OneSignal.shared.setNotificationWillShowInForegroundHandler(
  //         (OSNotificationReceivedEvent event) async {
  //       // Will be called whenever a notification is received in foreground
  //       // Display Notification, pass null param for not displaying the notification
  //       final SharedPreferences prefs = await SharedPreferences.getInstance();
  //       final Map<dynamic, dynamic>? data2 = event.notification.additionalData;
  //       debugPrint("OPEN NOTIFICATION PAYLOAD data1: " + data2.toString());
  //       await prefs.setString('noti', data2!["isNotification"]);
  //       event.complete(event.notification);
  //       debugPrint("Accepted permission2: ${event.notification}");
  //       // debugPrint("Accepted permission2: ${prefs.getBool('noti')}");
  //     });
  //
  //     OneSignal.shared.setNotificationOpenedHandler((result) async {
  //       final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //       debugPrint(
  //           "OPEN NOTIFICATION : ${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
  //       Map<dynamic, dynamic>? data = result.notification.rawPayload;
  //       Map<dynamic, dynamic>? data2 = result.notification.additionalData;
  //
  //       debugPrint("OPEN NOTIFICATION PAYLOAD data: " + data.toString());
  //       debugPrint("OPEN NOTIFICATION PAYLOAD data1: " + data2.toString());
  //
  //       debugPrint("${data2!["isNotification"]}");
  //       await prefs.setString('noti', data2["isNotification"]);
  //
  //       globals.appNavigator?.currentState!.push(
  //         MaterialPageRoute(
  //           builder: (context) => const NotificationListScreen(),
  //         ),
  //       );
  //     });
  //
  //     OneSignal.shared
  //         .setPermissionObserver((OSPermissionStateChanges changes) {
  //       // Will be called whenever the permission changes
  //       // (ie. user taps Allow on the permission prompt in iOS)
  //     });
  //
  //     OneSignal.shared
  //         .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
  //       // Will be called whenever the subscription changes
  //       // (ie. user gets registered with OneSignal and gets a user ID)
  //       debugPrint(
  //           'setSubscriptionObserver: user id of current user is: ${changes.from}');
  //       debugPrint(
  //           'setSubscriptionObserver: user id of current user is: ${changes.to}');
  //     });
  //
  //     // OneSignal.shared.setNotificationReceivedHandler((notification) {
  //     //   this.setState(() {
  //     //     _debugLabelString =
  //     //         "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
  //     //     newNotificationTitle = notification.payload.title;
  //     //     newNotificationBody = notification.payload.body;
  //     //   });
  //     // });
  //
  //     final _status = await OneSignal.shared.getDeviceState();
  //     SharedPrefs.to.notificationTokenId = _status?.userId ?? '';
  //     debugPrint('Onesignal Player ID: ${_status?.userId}');
  //     // final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // debugPrint('NOTI:' + prefs.getBool('noti').toString());
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: 'main',
  //       exceptionMsg: 'exception while initializing one signal sdk',
  //     );
  //   }
  // }
}
