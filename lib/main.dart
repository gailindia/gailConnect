// Created By Amit Jangid 24/08/21

import 'dart:async';
import 'dart:developer';

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gail_connect/core/controllers/health_controller.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:gail_connect/utils/utils.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gail_connect/ui/styles/app_theme.dart';
import 'package:health/health.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/core/bindings/app_bindings.dart'; 
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'ui/screens/emp_screens/emp_chat_screens/emp_chat_list_screen.dart';

import 'package:gail_connect/config/globals.dart' as globals;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
ReceivePort port = ReceivePort();

final service = FlutterBackgroundService();

void main() async {
  //****** */ WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //   apiKey: 'AIzaSyAJAG5WIaT9j_6lt7nMqDqMKhtJ3N1prmU',
  //   appId: '1:337354836230:android:033aba584f37e1c6a3f687',
  //   messagingSenderId: 'sendid',
  //   projectId: 'gail-coneect-v2',
  //   storageBucket: 'gail-coneect-v2.appspot.com',
  // ));

  MyFlutterBindings();

  SecureSharedPref prefs = await SecureSharedPref.getInstance();
  prefs.putString("noti", "false", isEncrypted: true);
  requestPermission();
  // Get.put(SharedPrefs());

  // initializing get storage
  await GetStorage.init();
  // calling init firebase method
  // await _initFirebase();

  // Isolate.current.addErrorListener(
  //   RawReceivePort(
  //     (pair) async {
  //       final _errorAndStackTrace = pair;
  //       await FirebaseCrashlytics.instance.recordError(
  //         _errorAndStackTrace.first,
  //         _errorAndStackTrace.last,
  //         printDetails: true,
  //       );
  //     },
  //   ).sendPort,
  // );

  HttpOverrides.global = MyHttpOverrides();
  // ******runApp(const MyApp());
  // globals.appNavigator = GlobalKey<NavigatorState>();
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }, (exception, stackTrace) => "");
}

/// 2021 August 24 - Tuesday
// void main() async {
//   MyFlutterBindings();
//
//   SecureSharedPref prefs = await SecureSharedPref.getInstance();
//   prefs.putString("noti", "false", isEncrypted: true);
//   requestPermission();
//   // Get.put(SharedPrefs());
//
//   // initializing get storage
//   await GetStorage.init();
//   // calling init firebase method
//   await _initFirebase();
//
//   Isolate.current.addErrorListener(
//     RawReceivePort(
//       (pair) async {
//         final _errorAndStackTrace = pair;
//         await FirebaseCrashlytics.instance.recordError(
//           _errorAndStackTrace.first,
//           _errorAndStackTrace.last,
//           printDetails: true,
//         );
//       },
//     ).sendPort,
//   );
//
//   HttpOverrides.global = MyHttpOverrides();
//   // globals.appNavigator = GlobalKey<NavigatorState>();
//   runZonedGuarded<Future<void>>(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     runApp(const MyApp());
//     FlutterError.onError = (FlutterErrorDetails details) {
//       FlutterError.presentError(details);
//     };
//     ErrorWidget.builder = (FlutterErrorDetails details) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.red,
//           title: const Text('An error occurred'),
//         ),
//         body: Center(child: Text(details.toString())),
//       );
//     };
//   }, (exception, stackTrace) => "");
// }

void requestPermission() async {
  await [
    Permission.camera,
    Permission.notification,
    Permission.photos,
    Permission.phone,
    Permission.storage,
    Permission.contacts,
    Permission.locationWhenInUse,
    Permission.location,
    Permission.locationAlways,
    Permission.activityRecognition
  ].request();

  if ((Platform.isAndroid &&
          await Permission.activityRecognition.status.isGranted) ||
      (Platform.isIOS && await Permission.locationWhenInUse.status.isGranted)) {
    await initializeService();
  } else {
    // openAppSettings();
  }
}

Future<void> initializeService() async {
  /// OPTIONAL, using custom notification channel id

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  onDidReceiveLocalNotification() async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('test'),
        content: Text('test'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // openAppSettings();
            },
          )
        ],
      ),
    );
  }

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  final SecureSharedPref preferences = await SecureSharedPref.getInstance();

  final log = await preferences.getStringList('log');
  log.add(DateTime.now().toIso8601String());
  await preferences.putStringList('log', log);
  HealthController().initPlatformState();
  return true;
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print(
      '***************notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  /// you can see this log in logcat
  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  final SecureSharedPref sp = await SecureSharedPref.getInstance();

  await sp.putString("hello", "world", isEncrypted: true);

  HealthController().initPlatformState();

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      print("setAsForeground :: ${event}");

      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    var logs = sp.getStringList('steps_pedo');
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        flutterLocalNotificationsPlugin.show(
          888,
          'Health',
          'App is Active',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "Health",
          content: "App is active",
        );
      }
    }

    // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "steps": '$logs',
        "device": device,
      },
    );
  });
}

handleException({
  String apiName = '',
  int statusCode = 400,
  required exception,
  required stackTrace,
  required String exceptionClass,
  required String exceptionMsg,
}) async {
  // FirebaseCrashlytics.instance.log('$exceptionClass: $exceptionMsg');

  // FirebaseCrashlytics.instance.recordError(
  //   exception,
  //   stackTrace,
  //   printDetails: true,
  //   reason: '$exceptionClass: $exceptionMsg',
  // );

  if (await checkConnectivity() && apiName.isNotEmpty) {
    // calling send error logs method
    GailConnectServices.to.sendErrorLogs(
      apiName: apiName,
      statusCode: statusCode,
      className: exceptionClass,
      message:
          '$exceptionClass - $exceptionMsg: \n${exception.toString()}\n$stackTrace',
    );
  }
}

class MyImageCache extends ImageCache {
  @override
  void clear() {
    final DefaultCacheManager _defaultCacheManager = DefaultCacheManager();
    _defaultCacheManager.emptyCache();

    super.clear();
  }
}

class MyFlutterBindings extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() => MyImageCache();
}

// _initFirebase() async {
//   try {
//     // Initialize Firebase.
//     await Firebase.initializeApp();
//     // Pass all uncaught errors from the framework to Crashlytics.
//     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
//     await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
//   } catch (e, s) {
//     handleException(
//       exception: e,
//       stackTrace: s,
//       exceptionClass: 'main',
//       exceptionMsg: 'exception while initializing firebase',
//     );
//   }
// }

// class AppConst {

//   static const BuildContext mContext;

//   // Future<bool> pushRoute(String androidNotificationId) {
//   // dynamic data = Navigator.of(mContext).push(
//   //   MaterialPageRoute(
//   //     builder: (BuildContext context) {
//   //       return EmpChatRoomScreen();
//   //     },
//   //   ),
//   // );
//   // return data;
//   // }
// }

@override
void initState() {
  ///TODO :: one signal issue
  OneSignal.Notifications.requestPermission(true);

  // AndroidAlarmManager.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  String _debugLabelString = "";
  String? _emailAddress;
  String? _smsNumber;
  String? _externalUserId;
  String? _language;
  bool _enableConsentButton = false;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

// CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = false;

  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.consentRequired(_requireConsent);

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    OneSignal.initialize(kOneSignalAppId);

    // AndroidOnly stat only
    // OneSignal.Notifications.removeNotification(1);
    // OneSignal.Notifications.removeGroupedNotifications("group5");

    OneSignal.Notifications.clearAll();

    OneSignal.User.pushSubscription.addObserver((state) {
      print(OneSignal.User.pushSubscription.optedIn);
      print(OneSignal.User.pushSubscription.id);
      print(OneSignal.User.pushSubscription.token);
      print(state.current.jsonRepresentation());
    });

    OneSignal.Notifications.addPermissionObserver((state) {});

    OneSignal.Notifications.addClickListener((event) {
      this.setState(() {
        _debugLabelString =
            "Clicked notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();

      this.setState(() {
        _debugLabelString =
            "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.InAppMessages.addClickListener((event) {
      this.setState(() {
        _debugLabelString =
            "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });
    OneSignal.InAppMessages.addWillDisplayListener((event) {});
    OneSignal.InAppMessages.addDidDisplayListener((event) {});
    OneSignal.InAppMessages.addWillDismissListener((event) {});
    OneSignal.InAppMessages.addDidDismissListener((event) {});

    this.setState(() {
      _enableConsentButton = _requireConsent;
    });

    // Some examples of how to use In App Messaging public methods with OneSignal SDK
    // oneSignalInAppMessagingTriggerExamples();

    // Some examples of how to use Outcome Events public methods with OneSignal SDK
    // oneSignalOutcomeExamples();

    OneSignal.InAppMessages.paused(true);
  }

  oneSignalInAppMessagingTriggerExamples() async {
    /// Example addTrigger call for IAM
    /// This will add 1 trigger so if there are any IAM satisfying it, it
    /// will be shown to the user
    OneSignal.InAppMessages.addTrigger("trigger_1", "one");

    /// Example addTriggers call for IAM
    /// This will add 2 triggers so if there are any IAM satisfying these, they
    /// will be shown to the user
    Map<String, String> triggers = new Map<String, String>();
    triggers["trigger_2"] = "two";
    triggers["trigger_3"] = "three";
    OneSignal.InAppMessages.addTriggers(triggers);

    // Removes a trigger by its key so if any future IAM are pulled with
    // these triggers they will not be shown until the trigger is added back
    OneSignal.InAppMessages.removeTrigger("trigger_2");

    // Create a list and bulk remove triggers based on keys supplied
    List<String> keys = ["trigger_1", "trigger_3"];
    OneSignal.InAppMessages.removeTriggers(keys);

    // Toggle pausing (displaying or not) of IAMs
    OneSignal.InAppMessages.paused(true);
    var arePaused = await OneSignal.InAppMessages.arePaused();
  }

  oneSignalOutcomeExamples() async {
    OneSignal.Session.addOutcome("normal_1");
    OneSignal.Session.addOutcome("normal_2");

    OneSignal.Session.addUniqueOutcome("unique_1");
    OneSignal.Session.addUniqueOutcome("unique_2");

    OneSignal.Session.addOutcomeWithValue("value_1", 3.2);
    OneSignal.Session.addOutcomeWithValue("value_2", 3.9);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    OneSignal.Notifications.requestPermission(true);
    // MainDashController().requestPermission();
    // healthIosPermission();
    // Health().configure(useHealthConnectIfAvailable: true);
  }

  healthIosPermission() async {
    if (Platform.isIOS) {
      print("into the authorize method");
      Future.delayed(Duration(seconds: 10));
      print("into the authorize method after 10 second");
      await authorize();
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
  }

  @override
  Widget build(BuildContext context) {
    globals.appNavigator = GlobalKey<NavigatorState>();
    var appBindings = AppBindings();

    return GetMaterialApp(
      navigatorKey: globals.appNavigator,

      //NavigationService.navigatorKey,
      // onGenerateRoute: NavigationService.navigatorKey.generator,
      title: kAppName,
      theme: themeData(),
      getPages: getPageList,
      initialRoute: kSplashRoute,
      initialBinding: appBindings,
      // onge
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

// Future<void> _OnClickNotification() async {
//   try {
//     Navigator.of(NavigationService.navigatorKey.currentState!.context).push(
//       MaterialPageRoute(
//         builder: (BuildContext context) {
//           return const EmpChatListScreen();
//         },
//       ),
//     );
//   } catch (e, s) {
//     handleException(
//       exception: e,
//       stackTrace: s,
//       exceptionClass: 'main',
//       exceptionMsg: 'exception while initializing one signal sdk',
//     );
//   }
// }
