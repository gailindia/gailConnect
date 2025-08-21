// Created By Amit Jangid 25/08/21

import 'dart:io';
import 'dart:ui';
import 'package:contacts_service/contacts_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_intro/flutter_intro.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gail_connect/core/db/db_provider.dart';
import 'package:gail_connect/models/active_news.dart';
import 'package:gail_connect/models/consent_model.dart';
import 'package:gail_connect/models/insert_whats_new.dart';
import 'package:gail_connect/models/most_used.dart';
import 'package:gail_connect/models/side_drawer_elements.dart';
import 'package:gail_connect/models/super_annuation_model.dart';
import 'package:gail_connect/ui/screens/screens.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/apps_screen.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/dispensary_screens/dispensary_dash_screen.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_dialogs/show_address_dialog_box.dart';
import 'package:gail_connect/ui/widgets/marquee_major.dart';
import 'package:get/get.dart';
import 'package:gail_connect/main.dart';
import 'package:multiutillib/multiutillib_flutter.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:gail_connect/models/banners.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gail_connect/models/news_category.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/utils/constants/firebase_constants.dart';
import 'package:multiutillib/widgets/dialogs/custom_confirm_dialog.dart';

import 'package:gail_connect/config/globals.dart' as globals;
import 'package:webview_flutter/webview_flutter.dart';
import '../../ui/screens/dashboard_screens/home_dash_screens/home_screen.dart';
import '../../ui/screens/emp_screens/emp_list_screens/emp_list_screen.dart';
import '../../ui/screens/employee_profile/employee_profile.dart';
import '../../ui/screens/id_view_screen.dart';
import '../../ui/screens/pdfviewer.dart';
import '../../ui/screens/wishlist_screen.dart';
import '../../ui/widgets/custom_dialogs/update_app_dialog.dart';
import '../../ui/widgets/overlay_widget.dart';
import '../../utils/utils.dart';
import 'health_controller.dart';
import 'useful_links_controllers/useful_links_controller.dart';
import 'dart:async';

class MainDashController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  final String _tag = 'MainDashController';

  late AnimationController animationController;

  bool isSnackbarActive = false;

  String image = "";
  // bool phoneConcent = false;

  static MainDashController get to => Get.find<MainDashController>();

  final ScrollController scrollController = ScrollController();
  ColorController colorController = Get.put(ColorController());

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController sendwishController = TextEditingController();
  ColorController controller = Get.put(ColorController());

  String newsLink = '', type = 'B';
  bool isLoading = true;
  int currentBirthdayCard = 0;
  final String _password = 'P@ssw0rd';
  Employee? loggedInEmployee;
  // late final SharedPrefs _sharedPrefs;
  late bool isSwitched;

  bool isLight = true;

  bool isConnected = true;
  List<NewsCategory> newsCategoryList = [];
  List<NewsCategory> newsCategoryListind = [];

  // List<BannersImage> bannersList = [];
  List<Banners> bannersList = [];
  // List bannersstatic = [
  //   'assets/icons/passwordsec.png',
  //   'assets/icons/passwordcode.png',
  //   'assets/icons/banner_keyboard.png',
  //   'assets/icons/banner_screen.png',
  //   'assets/icons/banner_key_lock.png',
  // ];


  List gailEventBanner = [
    'assets/file/facebook.html',
    'https://www.youtube.com/@GAILIndiaLimited',
    'assets/file/twitter.html',
  ];

  List<SideDrawerElements> sideDrawerList = [];

  List<Employee> employeesBirthDayList = [];
  List<Employee> newEmployeesJoinesList = [];

  List<ActiveNews> activeNewsList = [];
  List<ActiveNews> activeNewsListIn = [];
  int? activeNewsLength = 0;
  int? activeNewsLengthIND = 0;

  List<Superannuation_Consent> superannuationConsentList = [];
  List<DOBConsent> bdayConsentList1 = [];
  List<PhoneConsent> phoneConsentList = [];

  List<SuperAnnuationModel> superannuationmodel = [];

  List<MostUsedLinksModel>? mostUsedList = [];

  List<MostUsedLinksModel>? mostUsedListRevised = [];
  List<WhatsNewIsClickedModel>? whatsNewIsClicked = [];
  String? isclickedchecked = "true";
  String? noti, currentAppVersion;

  WebViewController? webViewController;
  WebViewController? webViewController1;
  WebViewController? webViewController2;

  int pageIndex = 2;

  List pages = [
    const UsefulApps(),
    const EmpListScreen(),
    const HomeScreen(),
    DispensaryDashScreen(
      isSearch: false,
    ),
    UsefulLinks(
      isSearch: false,
    ),
  ];

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  final List<String> eventList = [
    "https://web.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FGAILIndia%2F&tabs=timeline&small_header=false&adapt_container_width=false&hide_cover=false&show_facepile=true&appId",
    "https://www.youtube.com/@GAILIndiaLimited",
    "https://twitter.com/gailindia/status/1614228403313594369?ref_src=twsrc%5Etfw%7Ctwcamp%5Eembeddedtimeline%7Ctwterm%5Escreen-name%3Agailindia%7Ctwcon%5Es1",
    "https://gailcoin.sharegetEmployeeBirthDayListpoint.com/sites/GAILVideoPortal"
  ];

  final gridList = [
    // "assets/icons/inouttime.png",
    "assets/icons/calculator.png",
    "assets/icons/formkit_help.png",
    "assets/icons/vehicle.png",
    "assets/icons/health_icon.png",
    // "assets/icons/appstore.png",
    // "assets/icons/feedback.png",
    "assets/icons/offices.png",
    "assets/icons/guest_house_icon.png",
    "assets/icons/cil_hospital.png",
    "assets/icons/open_house.png",
  ];
  final gridListname = [
    "Calculator",
    // "In-Out Time",
    "Helpdesk",
    "Vehicle",
    // "Feedback",
    "Health",
    // "App Store",
    "Offices",
    "Guest Houses",
    "Hospitals",
    "Open House"

    // "Guest house",
    // "App Store",
    // "Hospitals",
    // "Offices",
    // "E-Office",
    // "BWS",
    // "Sugam",
    // "Calculator"
  ];
  bool cashlessSearch = false;
  final List<String> widgets = [
    // kInOutTime,
    kCalculatorRoute,
    kBISHelpdeskDashTabRoute,
    kVehicleSearchRoute,
    // kHealthScreenMed,
    // kAppStore,
    kHealthMed,
    // kFeedbackRoute,
    kOfficeDashRoute,
    kGuestHouseRoute,
    kHospitalsRoute,
    kcmdopenhouse

    // kGuestHouseRoute,
    // kAppStore,
    // kHospitalsRoute,
    // kOfficeDashRoute,
    // kOfficeDashRoute,
    // kBwsDashRoute,
    // kBISHelpdeskDashTabRoute,
    // kCalculatorRoute
  ];

  void getCashlessSearch() async {
    SecureSharedPref prefs = await SecureSharedPref.getInstance();
    prefs.putBool('cashless', cashlessSearch);
  }

  // Future<void> initializeService() async {
  //   /// OPTIONAL, using custom notification channel id
  //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'my_foreground', // id
  //     'MY FOREGROUND SERVICE', // title
  //     description:
  //     'This channel is used for important notifications.', // description
  //     importance: Importance.low, // importance must be at low or higher level
  //   );
  //
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //   FlutterLocalNotificationsPlugin();
  //
  //   if (Platform.isIOS || Platform.isAndroid) {
  //     await flutterLocalNotificationsPlugin.initialize(
  //       const InitializationSettings(
  //         iOS: DarwinInitializationSettings(),
  //         android: AndroidInitializationSettings('ic_bg_service_small'),
  //       ),
  //     );
  //   }
  //
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);
  //
  //   await service.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       // this will be executed when app is in foreground or background in separated isolate
  //       onStart: onStart1,
  //
  //       // auto start service
  //       autoStart: true,
  //       isForegroundMode: true,
  //
  //       notificationChannelId: 'my_foreground',
  //       initialNotificationTitle: 'AWESOME SERVICE',
  //       initialNotificationContent: 'Initializing',
  //       foregroundServiceNotificationId: 888,
  //     ),
  //     iosConfiguration: IosConfiguration(
  //       // auto start service
  //       autoStart: true,
  //
  //       // this will be executed when app is in foreground in separated isolate
  //       onForeground: onStart1,
  //
  //       // you have to enable background fetch capability on xcode project
  //       onBackground: onIosBackground,
  //     ),
  //   );
  //
  //
  // }

  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    SecureSharedPref preferences = await SecureSharedPref.getInstance();
    // await preferences.reload();
    final log = await preferences.getStringList('log');
    log.add(DateTime.now().toIso8601String());
    await preferences.putStringList('log', log);
    // var logs = preferences.getStringList('steps_pedo',isEncrypted: true) ?? [];
    // print('FLUTTER LOGS: $logs');
    HealthController().initPlatformState();
    return true;
  }

  @pragma('vm:entry-point')
  void onStart1(ServiceInstance service) async {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    /// you can see this log in logcat
    // print('FLUTTER BACKGROUND SERVICE: onStart1');
    // For flutter prior to version 3.0.0
    // We have to register the plugin manually

    final SecureSharedPref sp = await SecureSharedPref.getInstance();
    // await sp.reload();
    await sp.putString("hello", "world", isEncrypted: true);

    HealthController().initPlatformState();

    /// OPTIONAL when use custom notification
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    // FlutterLocalNotificationsPlugin();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   var logs = sp.getStringList('steps_pedo');
    //   // print('FLUTTER LOGS: $logs');
    //   if (service is AndroidServiceInstance) {
    //     if (await service.isForegroundService()) {
    //
    //       /// OPTIONAL for use custom notification
    //       /// the notification id must be equals with AndroidConfiguration when you call configure() method.
    //       flutterLocalNotificationsPlugin.show(
    //         888,
    //         'Health',
    //         'App is Active',
    //         const NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             'my_foreground',
    //             'MY FOREGROUND SERVICE',
    //             icon: 'ic_bg_service_small',
    //             ongoing: true,
    //           ),
    //         ),
    //       );
    //
    //       // if you don't using custom notification, uncomment this
    //       service.setForegroundNotificationInfo(
    //         title: "Health",
    //         content: "App is active ${logs}",
    //       );
    //     }
    //   }
    //
    //
    //   // test using external plugin
    //   final deviceInfo = DeviceInfoPlugin();
    //   String? device;
    //   if (Platform.isAndroid) {
    //     final androidInfo = await deviceInfo.androidInfo;
    //     device = androidInfo.model;
    //   }
    //
    //   if (Platform.isIOS) {
    //     final iosInfo = await deviceInfo.iosInfo;
    //     device = iosInfo.model;
    //   }
    //
    //   service.invoke(
    //     'update',
    //     {
    //       "current_date": DateTime.now().toIso8601String(),
    //       "steps": '$logs',
    //       "device": device,
    //     },
    //   );
    // });
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kHomeScreen);

    getCashlessSearch();
    // calling get latest news method
    _getLatestNews();
  }

  // @override
  // // TODO: implement onStart
  // InternalFinalCallback<void> get onStart => checkPermission();

  @override
  void onInit() async {
    super.onInit();
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    isSwitched = (await pref.getBool("isSwitch")) ?? false;

    _getAppVersion();
    getNewsCategoryInd();
    // getLiveEventUrl();
    getNewsCategory();
    getWhatsNewIsClicked();
    globals.appNavigator = GlobalKey<NavigatorState>();
    WidgetsBinding.instance.addObserver(this);
    if (type == "B") {
      sendwishController.text = "Happy Birthday";
      update([kDashboard]);
    } else {
      sendwishController.text = "Happy Retirement";
      update([kDashboard]);
    }
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // calling request permission method
    requestPermission();

    // calling get employee logged in method
    getEmployeeLoggedIn();

    getActiveNews();
    getActiveNewsIND();
    getMostUsedLinks();
    // calling get banners list method
    getBannersList();
    getConsentData();
    getSuperAnnuationData();

    // calling get employees birthday list method
    getEmployeesBirthdayList();

    getNewJoinedEmployeesList();

    getSideDrawerElementsList();

    ///TODO :: uncomment after fix
    // _initOneSignalSdk();

    getCurrentTimeToStartIos();

    getSections();

    // if(Platform.isAndroid) {
    //   checkPermission();
    // }

    // calling hit count api method
    GailConnectServices.to
        .hitCountApi(activity: kHomeScreen, activityScreen: kHomeScreen);
  }

  getCurrentTimeToStartIos() async {
    SecureSharedPref preferences = await SecureSharedPref.getInstance();
    String Date_Time = await GailConnectServices.to.returnCurrentTime();
    preferences.putString("Date_Time", Date_Time);
  }

  Future<File> createFileOfPdfUrl(String pdf) async {
    Completer<File> completer = Completer();
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = pdf;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  getNewsCategory() async {
    // calling check connectivity method
    isConnected = await checkConnectivity();
    update([kDashboard]);
    int count = 0;
    count++;

    if (isConnected) {
      isLoading = true;

      // calling get news by category api method
      newsCategoryList = await GailConnectServices.to.getNewsByCategoryApi(
        newsCategory: "G",
      );
      // print(newsCategoryList);
      final DefaultCacheManager _defaultCacheManager = DefaultCacheManager();
      await _defaultCacheManager.emptyCache();

      isLoading = false;
      update([kDashboard]);
    }
  }

  getNewsCategoryInd() async {
    // calling check connectivity method

    isConnected = await checkConnectivity();
    update([kDashboard]);
    int count = 0;
    count++;

    if (isConnected) {
      isLoading = true;

      // calling get news by category api method
      newsCategoryListind = await GailConnectServices.to.getNewsByCategoryApi(
        newsCategory: "I",
      );
      final DefaultCacheManager _defaultCacheManager = DefaultCacheManager();
      await _defaultCacheManager.emptyCache();

      isLoading = false;
      update([kDashboard]);
    }
  }

  getSideDrawerElementsList() async {
    final SecureSharedPref prefs = await SecureSharedPref.getInstance();
    noti = await prefs.getString("noti", isEncrypted: true);
    // calling get banner api method
    sideDrawerList = await GailConnectServices.to.getSideDrawerListApi();
    update([kDashboard]);
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(TutorialOverlay());
  }

  getWhatsNewIsClicked() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    final String _cpfNumber =
        (await pref.getString("cpfNumber", isEncrypted: true))!;

    whatsNewIsClicked =
        await GailConnectServices.to.getWhatsNewIsClickedApi(cpfNo: _cpfNumber);
    if (whatsNewIsClicked!.isNotEmpty) {
      for (int i = 0; i < whatsNewIsClicked!.length; i++) {
        isclickedchecked = whatsNewIsClicked![i].is_clicked.toString();
      }
    }
    if (whatsNewIsClicked!.isEmpty) {
      isclickedchecked = "false";
    }

    // print("ISSNACKBARACTIVE2: " + isSnackbarActive.toString());
    // print("whatsNewIsClicked2: " + whatsNewIsClicked![0].is_clicked.toString());
    if (isclickedchecked.toString() == "false" ||
        isclickedchecked.toString() == "") {
      // showSnackbar();
      Future<void>.delayed(
        const Duration(milliseconds: 2000),
        () {},
      ).then(
        (value) {
          isSnackbarActive = true;
          showSnackbar();
          value;
          update([kDashboard]);
        },
      );
    } else {
      isSnackbarActive = false;
    }

    update([kDashboard]);
  }

  showSnackbar() {
    // isclickedchecked.toString() == "false" || isclickedchecked.toString() == ""
    //     ? isSnackbarActive = false
    //     :
    Future<void>.delayed(
      const Duration(milliseconds: 10000),
      () {
        isSnackbarActive = true;
      },
    ).then(
      (value) {
        isSnackbarActive = false;
        value;
      },
    );
    update([kDashboard]);
  }

  firstTime(BuildContext context) async {
    final SecureSharedPref prefs = await SecureSharedPref.getInstance();

    Future<void>.delayed(
      const Duration(milliseconds: 2500),
      () {
        return Intro.of(context).start();
      },
    ).then(
      (value) {
        // setState(() {
        //   bottomColor = value;
        // });
        value;
      },
    );
    prefs.putBool('seen', true);

    // print("Before:" + SplashController().prefs!.getBool('seen'));
    // print("After:" + SplashController().seen.toString());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      _setStatus(kOnline);
    } else {
      // offline
      _setStatus(kOffline);
    }
  }

  _setStatus(String status) async {
    // SharedPrefs.to.currentChatRoomId = '';
    // await _firestore.collection(kUsersCollection).doc(_firebaseAuth.currentUser!.uid).update({kKeyStatus: status});
  }

  syncEmpListFromServer() async {
    // calling clear cache method
    await _clearCache();

    //calling database to sync
    await DbProvider.db.database;

    // calling show progress dialog method
    await showProgressDialog(Get.context!, message: kMsgSyncingData);

    // calling get employees list api method
    await GailConnectServices.to.getEmployeesListApi();

    await GailConnectServices.to.getEmployeesSectionListApi();
    // calling get offices list api method
    await GailConnectServices.to.getOfficesListApi();

    // calling get control room list api method
    await GailConnectServices.to.getControlRoomListApi();

    // calling get guest house details api method
    await GailConnectServices.to.getGuestHouseDetailsApi();

    // calling get hospitals cities list api method
    // await GailConnectServices.to.getHospitalsCitiesListApi();
    await GailConnectServices.to.getHospitalsListApi();
    await GailConnectServices.to.getCitiesListApi();

    // delaying loading of employee data for 1.5 seconds
    await Future.delayed(const Duration(milliseconds: 1500));

    // calling get employee logged in method
    await getEmployeeLoggedIn();

    // calling get employees birthday list method
    await getEmployeesBirthdayList();

    //send player id
    // await sendPlayerIdapi();

    // calling hide progress dialog method
    await hideProgressDialog();
  }

  sendPlayerIdapi() async {
    // await GailConnectServices.to.sendPlayerId();
  }

  postwhtsnewupdateapi() async {
    // await GailConnectServices.to.insertWhatsNew();
  }

  requestPermission() async {
    await [
      Permission.notification,
      Permission.camera,
      Permission.photos,
      Permission.phone,
      Permission.storage,
      Permission.contacts,
      Permission.location,
      Permission.locationAlways,
      Permission.locationWhenInUse,
      Permission.activityRecognition
    ].request();

    // if(await Permission.activityRecognition.status.isGranted){
    //   await initializeService();
    // }else{
    //   checkPermission();
    // }
  }

  checkPermission() async {
    var statusActivityRecognition = await Permission.activityRecognition.status;
    var statusNotification = await Permission.notification.status;
    if (statusActivityRecognition.isPermanentlyDenied) {
      // Permission.activityRecognition.request();
      showConfirmationDialog(
        Get.context!,
        title: "Grant Permission",
        description:
            "In order to access the Health App, you first need to grant 'Physical Activity and Notification' permission in app settings. Click YES to go to app settings.",
        dividerColor: colorController.kPrimaryDarkColor,
        positiveBtnStyle: buttonTextStyle,
        positiveBtnColor: colorController.kPrimaryDarkColor,
        negativeBtnColor: colorController.kPrimaryColor,
        onPositivePressed: () async {
          openAppSettings();
          update([kHomeScreen]);
          Navigator.pop(Get.context!, "");
        },
      );
    }
  }

  _clearCache() async {
    final _tempDir = await getTemporaryDirectory();

    if (_tempDir.existsSync()) {
      final file = File(_tempDir.path);
      final isExists = await file.exists();
      if (isExists) {
        await file.delete(recursive: true);
      }
      //_tempDir.deleteSync(recursive: true);
    }
  }

  getSections() async {
    await await GailConnectServices.to.getEmployeesSectionListApi();
  }

  getEmployeeLoggedIn() async {
    // calling get logged in employee from db method

    loggedInEmployee = await EmployeeDb.getLoggedInEmployeeFromDb();
    update([kDashboard]);

    /// TODO : Forebase checking
    // // calling login in firebase method
    // final bool _isLoggedInInFirebase = await _loginInFirebase();
    //
    // if (!_isLoggedInInFirebase) {
    //   // calling create firebase account method
    //   await _createFirebaseAccount();
    // }
  }

  getEmployeesBirthdayList() async {
    isLoading = true;
    update([kDashboard]);
    // calling get employees list from db method
    employeesBirthDayList = await EmployeeDb.getEmployeesListFromDb(
        forBirthdayList: true, isFilterSelected: false);
    bdayConsentList1.clear();
    bdayConsentList1 = await GailConnectServices.to.getConsentBdaydetails();
    for (int j = 0; j < bdayConsentList1.length; j++) {
      for (int i = 0; i < employeesBirthDayList.length; i++) {
        // print( "employeesBirthDayList :: ${employeesBirthDayList[i].empNo.toInt}");
        if (employeesBirthDayList[i].empNo.toInt.toString() ==
            bdayConsentList1[j].cpfNo!.toInt().toString()) {
          // print("bdayConsentList index :: $i");
          employeesBirthDayList.removeAt(i);
        }
      }
    }
    // isLoading = false;
    // currentBirthdayCard = 0;
    update([kDashboard]);
  }

  getNewJoinedEmployeesList() async {
    isLoading = true;
    update([kDashboard]);

    newEmployeesJoinesList = await EmployeeDb.getNewJoinedEmployeesList();

    update([kDashboard]);
  }

  getBannersList() async {
    // calling get banner api method
    bannersList = await GailConnectServices.to.getBannerApi();
    if (bannersList.length == 1) {
      image = bannersList[0].image.toString();
    }
    update([kDashboard]);
  }

  getSuperAnnuationData() async {
    // calling get banner api method
    superannuationmodel = await GailConnectServices.to.getsuperannuationApi();

    for (int j = 0; j < superannuationConsentList.length; j++) {
      for (int i = 0; i < superannuationmodel.length; i++) {
        if (superannuationmodel[i].empNo.toInt.toString() ==
            superannuationConsentList[j].cpfNo!.round().toString()) {
          superannuationmodel.removeAt(i);
        }
      }
    }
    update([kDashboard]);
  }

  getActiveNews() async {
    // calling get banner api method
    activeNewsList.clear();
    activeNewsList = await GailConnectServices.to.getActiveNewsAPI();
    for (int i = 0; i < activeNewsList.length; i++) {
      activeNewsLength = activeNewsLength! + activeNewsList[i].title!.length;
    }
    update([kDashboard]);
  }

  getConsentData() async {
    superannuationConsentList.clear();
    superannuationConsentList =
        await GailConnectServices.to.getConsentsuperannuationdetails();
    phoneConsentList = await GailConnectServices.to.getConsentPhonedetails();

    update([kDashboard]);
  }

  getActiveNewsIND() async {
    // calling get banner api method
    activeNewsListIn.clear();
    activeNewsListIn = await GailConnectServices.to.getActiveINDNewsAPI();
    for (int i = 0; i < activeNewsListIn.length; i++) {
      activeNewsLengthIND =
          activeNewsLengthIND! + activeNewsListIn[i].title!.length;
    }
    update([kDashboard]);
  }

  openActivity(BuildContext context, String screen) async {
    SecureSharedPref prefs = await SecureSharedPref.getInstance();
    prefs.putBool('cashless', true);

    Get.toNamed(screen.toString());
  }

  getMostUsedLinks() async {
    // calling get banner api method
    mostUsedList = await GailConnectServices.to.getMostUsedAPI();
    for (int i = 0; i < mostUsedList!.length; i++) {
      if (!mostUsedList![i].activity!.contains("Screen")) {
        mostUsedListRevised!.add(mostUsedList![i]);
      }
    }
    update([kDashboard]);
  }

  onCarouselPageChanged(int _index) {
    currentBirthdayCard = _index;
    update([kDashboard]);

    if (employeesBirthDayList.length > 20 && employeesBirthDayList.isNotEmpty) {
      if (_index == 0) {
        // calling scroll to end method
        _scrollToEnd(0);
      } else {
        // calling scroll to end method
        // _scrollToEnd(scrollController.position.pixels + 10);
      }
    }
  }

  _scrollToEnd(double _index) async {
    scrollController.animateTo(_index,
        curve: Curves.easeOut, duration: const Duration(milliseconds: 400));
  }

  logout() async {
    // calling show confirmation dialog method
    showConfirmationDialog(
      Get.context!,
      title: kLogout,
      description: kMsgConfirmLogout,
      dividerColor: Colors.white,
      positiveBtnStyle: buttonTextStyle,
      negativeBtnStyle: buttonTextStyle,
      positiveBtnColor: colorController.kPrimaryDarkColor,
      negativeBtnColor: controller.kPrimaryColor,
      onPositivePressed: () async {
        // await GetStorage().erase();
        // _deleteAppDir();
        // _deleteCacheDir();
        var pref = await SecureSharedPref.getInstance();
        pref.clearAll();

        // await DbProvider.db.closeDb();
        // signing out from firebase on app log out
        // await _firebaseAuth.signOut();

        Get.offNamedUntil(kLoginRoute, (route) => false);
      },
    );
  }

  Future<void> _deleteCacheDir() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    var appDocDir = await getApplicationDocumentsDirectory();

    if (appDocDir.existsSync()) {
      appDocDir.deleteSync(recursive: true);
    }
  }

  callNumber(String _number) async {
    final _callNo = 'tel:$_number';

    if (await canLaunch(_callNo)) {
      await launch(_callNo);
    }
  }

  ///TODO :: need to woek on save contact with different library
  saveContact({required Employee employee, required String number}) async {
    try {
      if (Platform.isAndroid) {
        bool? b = await Permission.contacts.isGranted;
        if (b) {
          // Get contacts matching a string
          List<Contact> johns = await ContactsService.getContacts(
              query: employee.empName?.toTitleCase());

          if (johns.isEmpty) {
            await ContactsService.addContact(
              Contact(
                company: kGail,
                givenName: employee.empName?.toTitleCase(),
                jobTitle: employee.designation?.toTitleCase(),
                emails: [Item(label: kEmailId, value: employee.emails)],
                phones: [
                  Item(label: kMobile, value: number),
                  Item(label: "Phone", value: employee.mobileNo)
                ],
              ),
            );
            Get.snackbar(kSuccess, kMsgContactSavedSuccessfully,
                backgroundColor: colorController.kPrimaryLightColor);
          } else {
            // Get.snackbar(kSuccess, kMsgContactAlreadySaved,
            //     backgroundColor: colorController.kPrimaryLightColor);
          }
        } else {
          showConfirmationDialog(Get.context!,
              title: "Grant Permission",
              negativeBtnColor: colorController.kPrimaryColor,
              positiveBtnColor: colorController.kPrimaryColor,
              positiveBtnStyle: TextStyle(color: colorController.kBlackColor),
              negativeBtnStyle: TextStyle(color: colorController.kBlackColor),
              description:
                  "In order to access the Contact, you first need to grant 'Contact' permission in app settings. Click YES to go to app settings.",
              onPositivePressed: () async {
            openAppSettings();
            Navigator.pop(Get.context!, "");
          });
        }
      } else {
        List<Contact> johns = await ContactsService.getContacts(
            query: employee.empName?.toTitleCase());

        if (johns.isEmpty) {
          await ContactsService.addContact(
            Contact(
              company: kGail,
              givenName: employee.empName?.toTitleCase(),
              jobTitle: employee.designation?.toTitleCase(),
              emails: [Item(label: kEmailId, value: employee.emails)],
              phones: [
                Item(label: kMobile, value: number),
                Item(label: "Phone", value: employee.mobileNo)
              ],
            ),
          );
          Get.snackbar(kSuccess, kMsgContactSavedSuccessfully,
              backgroundColor: colorController.kPrimaryLightColor);
        } else {
          // Get.snackbar(kSuccess, kMsgContactAlreadySaved,
          //     backgroundColor: colorController.kPrimaryLightColor);
        }
      }
    } catch (e, s) {
      showConfirmationDialog(
        Get.context!,
        title: "Grant Permission",
        description:
            "In order to save the contact, you first need to grant 'Contacts' permission in app settings. Click YES to go to app settings.",
        dividerColor: colorController.kPrimaryDarkColor,
        positiveBtnStyle: buttonTextStyle,
        positiveBtnColor: colorController.kPrimaryDarkColor,
        negativeBtnColor: colorController.kPrimaryColor,
        onPositivePressed: () async {
          openAppSettings();
          Navigator.pop(Get.context!, "");
        },
      );
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: 'main',
        exceptionMsg: 'exception while initializing one signal sdk',
      );
    }
  }

  sendMessage({required List<String> recipients, String? message}) async {
    try {
      // calling show progress dialog method
      await showProgressDialog(Get.context!);
      await _textMe(recipients.first.toString());
      await hideProgressDialog();
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while sending sms to employee',
      );
    }
  }

  _textMe(String number) async {
    Uri uri;
    if (Platform.isAndroid) {
      uri = Uri.parse('sms:+$number?body=');
    } else {
      uri = Uri.parse('sms:$number&body=');
    }
    if (await launchUrl(uri)) {
      //app opened
    } else {
      //app is not opened
    }
  }

  sendEmail({required String emailId, String? body}) async {
    final Uri _emailLaunchUri = Uri(
      path: emailId,
      scheme: 'mailto',
      // calling encode query parameters method
      query: _encodeQueryParameters(<String, String>{'body': body ?? ''}),
    );

    launchUrl(Uri.parse(_emailLaunchUri.toString()));
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  _getLatestNews() async {
    //calling get news by category api method
    final List<NewsCategory> _newsCatList =
        await GailConnectServices.to.getNewsByCategoryApi(
      newsCategory: kNewsCategoryG,
    );
    if (_newsCatList.isNotEmpty) {
      newsLink = _newsCatList[0].body;
      update([kDashboard]);
    }
  }

  openNews() => launch('$kNewsPdfApi$newsLink');

  openSearch() => Get.toNamed(kSearchRoute);

  openScreen(var activity, BuildContext context) async {
    SecureSharedPref prefs = await SecureSharedPref.getInstance();
    if (RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(activity)) {
    } else {
      if (activity == "Guest House") {
        Get.toNamed(kGuestHouseRoute);
      }
      if (activity == "Hospitals") {
        Get.toNamed(kHospitalsRoute);
      }
      if (activity == "Profile Settings") {
        Get.toNamed(kProfileSettingsRoute);
      }
      if (activity == "Employees") {
        Get.toNamed(kEmployeesDashRoute);
      }
      if (activity == "News Dashboard") {
        Get.toNamed(kNewsRoute);
      }
      if (activity == "Cashless Medicine") {
        prefs.putBool('cashless', true);
        // print("fZSedgxchvjbkl" + prefs.get('cashless').toString());
        Get.to(DispensaryDashScreen(
          isSearch: true,
        ));

        // Get.toNamed(kDispensaryDashRoute);
      }
      if (activity == "Feedback") {
        Get.toNamed(kFeedbackRoute);
      }
      // if (activity == "Health") {
      //   Get.toNamed(kHealthMed);
      // }
      if (activity == "Health") {
        Get.toNamed(kHealthMed);
      }
      if (activity == "Super Annuation") {
        Get.toNamed(kEmployeesAnnuationRoute);
      }
      if (activity == "Profile") {
        Get.to(ProfileScreen());
      }
      if (activity == "ID View") {
        Get.to(IDViewScreen());
      }
      if (activity == "Wishes") {
        Get.to(EmpWishesScreen());
      }
      if (activity == "Consent Form") {
        Get.toNamed(kConcent);
      }
      if (activity == "Open House") {
        Get.toNamed(kcmdopenhouse);
      }
      if (activity == "Gail Voice") {
        Get.to(PdfViewer(
          pdfurl: 'https://gailvoice.com/',
          title: kGAilVoice,
          type: "sugamUrl",
        ));
      }
      if (activity == "App Store") {
        Get.toNamed(kAppStore);
      }
      if (activity == "New Employee Zone") {
        Get.toNamed(kFreshersCategoryRoute);
      }
      if (activity == "MM T Codes") {
        Get.to(PdfViewer(
          pdfurl: kMMTCodeUrl,
          title: kMMTCODE,
          type: "pdf",
        ));
      }
      if (activity == "Hindi Shabdavali") {
        Get.to(PdfViewer(
          pdfurl: kHindiShabdavaliUrl,
          title: kHindiShabdavali,
          type: "pdf",
        ));
      }
      if (activity == "Gail Prashashanik ShabadKosh") {
        Get.to(PdfViewer(
          pdfurl: kGailPrashashanikShabadKoshUrl,
          title: kGailPrashashanikShabadKosh,
          type: "pdf",
        ));
      }
      if (activity == "Dashboard") {
        Get.toNamed(kDashboardRoute);
        // Get.toNamed(kOtpRoute);
      }

      if (activity == "Useful Links") {
        Get.toNamed(kUsefulLinksRoute);
      }
      if (activity == "Useful Documents") {
        Get.toNamed(kUsefulLinksRoute);
      }
      if (activity == "My GSTIN") {
        _showGstInDetails(context);
        update([kDashboard]);
      }
      if (activity == "Vehicle Search") {
        Get.toNamed(kVehicleSearchRoute);
      }
      if (activity == "BIS Helpdesk") {
        Get.toNamed(kBISHelpdeskDashTabRoute);
      }
      if (activity == "Offices") {
        Get.toNamed(kOfficeDashRoute);
      }
      if (activity == "Employees Birthday") {
        Get.toNamed(kEmployeesBirthdayRoute);
      }
      if (activity == "Energy Calculator") {
        Get.toNamed(kCalculatorRoute);
      }
      if (activity == "Sugam") {
        openLink(title: kSugam, link: kSugamUrl);
      }
      if (activity == "In-Out Time") {
        Get.toNamed(kInOutTime);
      }
      // if (activity == "Dashboard") {
      //   Get.toNamed(kOtpRoute);
      // }

      if (activity == "Website") {
        UsefulLinksController().openGailWebsite();
      }
      if (activity == "Intranet") {
        UsefulLinksController().openGailIntranet();
      }
      if (activity == "Tenders") {
        UsefulLinksController().openGailTenders();
      }
      if (activity == "My GSTIN") {}
      if (activity == "My Library") {
        UsefulLinksController().openMyLibrary();
      }
      if (activity == "WFH") {
        UsefulLinksController().openGailWfh();
      }
      if (activity == "Holiday List") {
        UsefulLinksController().openHolidayList();
      }
    }
  }

  _showGstInDetails(BuildContext context) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    String? _baName = await pref.getString("baName", isEncrypted: true);
    String? _state = await pref.getString("gstLocation", isEncrypted: true);
    String? _gstIn = await pref.getString("gstInNumber", isEncrypted: true);

    // calling show custom general dialog box method
    showCustomGeneralDialogBox(
      context: context,
      title: kMyGst,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
            caption: kState,
            description: _state!,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
          verticalSpace12,
          RichTextWidget(
            description: _baName!,
            caption: kBusinessArea,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
          verticalSpace12,
          RichTextWidget(
            caption: kGstIn,
            description: _gstIn!,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
        ],
      ),
    );
  }

  // _createFirebaseAccount() async {
  //   try {
  //     debugPrint('calling create firebase account method');
  //
  //     final String _email = loggedInEmployee!.emails!;
  //     final String _name =
  //         loggedInEmployee!.empName!.replaceAll(RegExp(r"\s+\b|\b\s"), ' ');
  //
  //     // calling create user with email and password method
  //     final UserCredential _userCredential =
  //         await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: _email,
  //       password: _password,
  //     );
  //
  //     if (_userCredential.user != null) {
  //       // calling update display name
  //       // for updating user's display name
  //       _userCredential.user!.updateDisplayName(_name);
  //
  //       final DocumentSnapshot _document = await _firestore
  //           .collection(kUsersCollection)
  //           .doc(_firebaseAuth.currentUser!.uid)
  //           .get();
  //
  //       debugPrint('document snapshot of user is: $_document');
  //
  //       if (!_document.exists) {
  //         // calling set notification token id method
  //         ///TODO :: uncomment once after
  //         // await _setNotificationTokenId();
  //
  //         final ChatUser _chatUser = ChatUser(
  //           name: _name,
  //           email: _email,
  //           isAdmin: false,
  //           profileUrl: '',
  //           status: kOnline,
  //           lastMessage: '',
  //           lastMessageBy: '',
  //           isGroupChat: false,
  //           chatRoomOrGroupId: '',
  //           lastMessageByName: '',
  //           cpf: loggedInEmployee!.empNo!,
  //           lastMessageTime: Timestamp.now(),
  //           uid: _firebaseAuth.currentUser!.uid,
  //           notificationTokenId: SharedPrefs.to.notificationTokenId,
  //         );
  //
  //         // creating firestore users collection on cloud firestore database
  //         await _firestore
  //             .collection(kUsersCollection)
  //             .doc(_firebaseAuth.currentUser!.uid)
  //             .set(_chatUser.toMap());
  //       }
  //     }
  //
  //     // calling login in firebase method
  //     ///TODO::Check firebase later
  //     // await _loginInFirebase();
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg:
  //           'exception while creating an account on firebase for the user',
  //     );
  //   }
  // }

  // Future<bool> _loginInFirebase() async {
  //   try {

  //     // calling sign in with email and password method
  //     final UserCredential _userCredential =
  //         await _firebaseAuth.signInWithEmailAndPassword(
  //       password: _password,
  //       email: loggedInEmployee!.emails!,
  //     );

  //     // calling update notification id method
  //     ///TODO ::check later notification
  //     // await _updateNotificationId();

  //     if (_userCredential.user != null) {
  //       await _firestore
  //           .collection(kUsersCollection)
  //           .doc(_firebaseAuth.currentUser!.uid)
  //           .get()
  //           .then((value) =>
  //               _userCredential.user!.updateDisplayName(value[kKeyName]));

  //       // calling set status method
  //       _setStatus(kOnline);
  //     }
  //     return (_userCredential.user != null);
  //   } on FirebaseAuthException catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg: 'firebase auth exception while logging in firebase',
  //     );
  //     return false;
  //   } catch (e, s) {
  //     handleException(
  //       exception: e,
  //       stackTrace: s,
  //       exceptionClass: _tag,
  //       exceptionMsg: 'other exception while logging in firebase',
  //     );
  //     return false;
  //   }
  // }

  openBanner(String link) {
    openLink(title: "GAIL", link: link);

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: 'Banner Details Screen');
  }

  openLink({required String title, required String link}) async {
    // final String _link = int.parse(SharedPrefs.to.cpfNumber).toString();
    await hideProgressDialog();
    await launch(link);
  }

  // _updateNotificationId() async {
  //   // calling set notification token id method
  //   ///TODO :: uncomment after fix
  //   // await _setNotificationTokenId();
  //
  //   List<ChatUser> _conversationChatList = [];
  //   final String _notificationTokenId = SharedPrefs.to.notificationTokenId;
  //
  //   // updating current user's notification id in user's collection
  //   await _firestore
  //       .collection(kUsersCollection)
  //       .doc(_firebaseAuth.currentUser!.uid)
  //       .update({kKeyNotificationTokenId: _notificationTokenId});
  //
  //   // getting conversation list of current user
  //   final QuerySnapshot _querySnapshot = await _firestore
  //       .collection(kUsersCollection)
  //       .doc(_firebaseAuth.currentUser!.uid)
  //       .collection(kChatListCollection)
  //       .get();
  //
  //   _conversationChatList =
  //       _querySnapshot.docs.map<ChatUser>((e) => ChatUser.fromDoc(e)).toList();
  //   debugPrint(
  //       'length of conversation chat list is: ${_conversationChatList.length}');
  //
  //   for (final ChatUser _conversationChatUser in _conversationChatList) {
  //     bool _isNotificationTokenIdUpdated = true;
  //
  //     debugPrint('CHATUSER1:' + _conversationChatUser.toString());
  //
  //     if (_conversationChatUser.isGroupChat) {
  //       // getting group info from firestore
  //       final EmpGroupInfo _empGroupInfo = EmpGroupInfo.fromDoc(
  //         await _firestore
  //             .collection(kGroupsCollection)
  //             .doc(_conversationChatUser.chatRoomOrGroupId)
  //             .get(),
  //       );
  //
  //       for (final ChatUser _groupChatUser in _empGroupInfo.groupMembersList) {
  //         if (_groupChatUser.uid == _firebaseAuth.currentUser!.uid &&
  //             _groupChatUser.notificationTokenId != _notificationTokenId) {
  //           _isNotificationTokenIdUpdated = true;
  //           _groupChatUser.notificationTokenId = _notificationTokenId;
  //         }
  //       }
  //
  //       debugPrint(
  //           'is notification token id updated value is: $_isNotificationTokenIdUpdated');
  //
  //       if (!_isNotificationTokenIdUpdated) {
  //         // updating notification id for current user in group
  //         await _firestore
  //             .collection(kGroupsCollection)
  //             .doc(_conversationChatUser.chatRoomOrGroupId)
  //             .update({kKeyMembers: _empGroupInfo.groupMembersList});
  //       }
  //     } else {
  //       // updating notification id for current user in other user's chat list collection
  //       await _firestore
  //           .collection(kUsersCollection)
  //           .doc(_conversationChatUser.uid)
  //           .collection(kChatListCollection)
  //           .doc(_firebaseAuth.currentUser!.uid)
  //           .update({kKeyNotificationTokenId: _notificationTokenId});
  //     }
  //   }
  // }

  switchTheme(value) {
    if (value) {
      isLight == value;
      update([kDashboard]);
    } else {
      isLight == value;
      update([kDashboard]);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    colorController.dispose();
    sendwishController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  marquewidgert(BuildContext context) {
    // return Text("sdfghjk");
    for (int i = 0; i < activeNewsList.length; i++)
      return Row(
        children: [
          // Text("Hello" + i.toString())
          Expanded(
            child: MarqueeCustomWidget(
                text: activeNewsList[i].title.toString(),
                textStyle: textStyle12Bold),
          )
        ],
      );
  }

  void changeTab(int? pos) {
    pageIndex = pos!;
    if (pageIndex == 2) {
      getApp_Version();
    }
    update([kDashboard]);
  }

  getApp_Version() async {
    String? currentAppVersion;
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    late String _storeLink, _serverAppVersion;

    // calling get app version method
    currentAppVersion = await getAppVersion();
    // update([kAppVersion]);

    if (Platform.isAndroid) {
      _storeLink = kPlayStoreUrl;
      _serverAppVersion =
          (await pref.getString("apkVersion", isEncrypted: true))!;
    } else if (Platform.isIOS) {
      _storeLink = kAppStoreUrl;
      _serverAppVersion =
          (await pref.getString("iosVersion", isEncrypted: true))!;
    }
    print("_serverAppVersion ****:: $_serverAppVersion");

    final int _serverAppVer = int.parse(_serverAppVersion.replaceAll('.', ''));
    final int _currentAppVer = int.parse(currentAppVersion.replaceAll('.', ''));

    if (_serverAppVer > _currentAppVer) {
      print("_serverAppVersion popup ****:: $_serverAppVersion");
      // calling update app dialog method
      updateAppDialog(context: Get.context!, storeLink: _storeLink);
    }
  }

  void toggleSwitch(bool value) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    if (value == true) {
      isSwitched = true;
      await pref.putBool("isSwitch", isSwitched);

      //MyThemePreferences.setTheme(isSwitched);
      update([kDashboard]);
    } else {
      isSwitched = false;
      await pref.putBool("isSwitch", isSwitched);

      // MyThemePreferences.setTheme(isSwitched);
      update([kDashboard]);
    }

    colorController.switchTheme();
    await Future.delayed(const Duration(seconds: 5));
    update([kDashboard]);
    update(['color']);
    update([kEmpDash]);
    update([kEmployees]);
  }

  postSendWish(BuildContext context, String type, String? empNo) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String _cpfNumber =
        (await pref.getString("cpfNumber", isEncrypted: true))!;

    final Map<String, String> _body = {
      kSendFrom: _cpfNumber, //"17231",
      kSendTo: empNo.toString(),
      kSendMessage: sendwishController.text,
      kSendCategory: type,
      "sender_name": loggedInEmployee!.empName!, //"prince",
      "sender_designation":
          loggedInEmployee!.designation!, //"Executive Trainee",
      "sender_place_of_posting": loggedInEmployee!.location!, //"Noida"
    };

    final _response = await GailConnectServices.to.sendpostwishes(body: _body);

    if (_response != null) {
      if (_response.statusCode == 200) {
        Navigator.pop(context);
        // calling show custom dialog box method
        // await showCustomDialogBox(context: Get.context!, title: kSuccess, description: _response.body[kJsonMessage]);

        Get.back();
      } else {
        // calling show custom dialog box method
        // await showCustomDialogBox(context: Get.context!, title: kError, description: _response.body[kJsonMessage]);
      }
    }
  }

  // loadHtmlFromAssets(String path) async {
  //   String fileHtmlContents = await rootBundle.loadString(path);
  //
  //   webViewController?.loadRequest(Uri.dataFromString(fileHtmlContents,
  //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8')));
  // }

  void _getAppVersion() async {
    currentAppVersion = await getAppVersion();
  }

  getLiveEventUrl() async {
    update([kDashboard]);
    if (gailEventBanner.isNotEmpty) {
      List<String> s = await GailConnectServices.to.getLiveEvents();
      s.forEach((element) {
        gailEventBanner.add(element);
      });
      // return eventList;
    }
    isLoading = false;
    update([kDashboard]);
    // return eventList;
  }
}
