import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gail_connect/core/db/health_data.dart';
import 'package:gail_connect/ui/screens/health_screens/health_screen.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:health/health.dart';

import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/controllers/health_controller.dart';
import '../../../main.dart';
import '../../../models/health_data_model.dart';
import '../../../models/weekday.dart';
import '../../../rest/gail_connect_services.dart';
import '../../../utils/constants/app_constants.dart';

class StatsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatsScreen();
}

class _StatsScreen extends State<StatsScreen>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  bool isWorkManagerInitialised = true;
  String finalDate = '';
  String finalDate1 = '';
  int? selectedIndex;

  bool isSelected = false;
  DateTime? mon_day;
  DateTime? tue_day;
  DateTime? wed_day;
  DateTime? thu_day;
  DateTime? fri_day;
  DateTime? sat_day;
  DateTime? sun_day;

  bool weekVisible = false;
  bool monthOneVisible = false;
  bool monthTwoVisible = false;
  bool monthThreeVisible = false;
  bool visiblecalender = false;
  bool visiblecalender1 = false;
  bool visiblecalender2 = false;
  bool isWeekDayClicked = false;

  var logStatus = '';

  // List<WeekDay> weekDayList = [];
  Map<String, String> body = {};
  Color? c;

  late List<HealthDataModel> healthdatalist = [];

  @override
  bool get wantKeepAlive => true;

  // The background
  static SendPort? uiSendPort;
  var d;
  var d1;
  var d2;

  AppState _state = AppState.DATA_NOT_FETCHED;
  int _nofSteps = 0;

  double v = 0.0;

  String getTodaysSteps = "0";
  String Date_Time = "0";

  static final types = [HealthDataType.STEPS];

  final permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();
  // create a HealthFactory for use in the app
  final health = Health();
  // HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (Platform.isAndroid) {
      if (state == AppLifecycleState.resumed) {
        checkPermissionStatus();
      }
    }
  }

  void checkPermissionStatus() async {
    print("inside isAndroid");
    var statusNoti = await Permission.notification.status;
    var statusActvity = await Permission.activityRecognition.status;
    print("statusNoti  :: $statusNoti");
    if (statusNoti != PermissionStatus.granted &&
        statusActvity != PermissionStatus.granted) {
      // await initializeService();
    } else {
      // await initializeService();
    }
  }

  //
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
  //       onStart: onStart,
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
  //       onForeground: onStart,
  //
  //       // you have to enable background fetch capability on xcode project
  //       onBackground: onIosBackground,
  //     ),
  //   );
  // }

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
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    // FlutterLocalNotificationsPlugin();

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

    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   var logs = sp.getStringList('steps_pedo');
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
    //         content: "App is active",
    //       );
    //     }
    //   }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    DateFormat formate = DateFormat("dd");
    var lastDayDateTime =
        new DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
    var lastDayDateTime1 =
        new DateTime(DateTime.now().year, DateTime.now().month, 0);
    var lastDayDateTime2 =
        new DateTime(DateTime.now().year, DateTime.now().month - 1, 0);

    d = formate.format(lastDayDateTime);
    d1 = formate.format(lastDayDateTime1);
    d2 = formate.format(lastDayDateTime2);
    conf();

    WidgetsBinding.instance.addObserver(this);

    // Health().configure(useHealthConnectIfAvailable: true);
  }

  conf() async {
    await health.configure();
  }

  void setLogsStatus({String status = '', bool append = false}) {
    setState(() {
      logStatus = status;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GetBuilder<HealthController>(
        id: kHealth,
        init: HealthController(),
        builder: (_controller) {
          return Container(
            color: colorController.kHomeBgColor,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Today",
                          style: TextStyle(
                              color: colorController.kPrimaryDarkColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // late List<Map<String, Object?>> healthlist = [];
                          // healthlist = await HealthDataDb.getHealthListFromDb();
                          if (_controller.healthListToPost.isNotEmpty) {
                            print(
                                "healthlist.isNotEmpty ${_controller.healthListToPost.length}");
                            print(
                                "healthlist.isNotEmpty ${_controller.healthListToPost}");
                            await GailConnectServices.to.stepDataInsertLive(
                                body: _controller.healthListToPost);
                          } else {
                            healthdatalist.clear();
                            print("healthdatalist.isNotEmpty");
                            healthdatalist = await GailConnectServices.to
                                .getHealthLiveData();
                            print("healthdatalist  $healthdatalist");

                            HealthDataModel healthModel = HealthDataModel();

                            for (int i = 0; i < healthdatalist.length; i++) {
                              healthModel.empNo = healthdatalist[i].empNo;
                              healthModel.steps = healthdatalist[i].steps;
                              healthModel.date = healthdatalist[i].date;
                              healthModel.updateDate =
                                  healthdatalist[i].updateDate;
                              await HealthDataDb.batchInsertIntoHealthDataTable(
                                  healthModel);
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: colorController.kPrimaryDarkColor,
                                  width: 1),
                              color: colorController.kPrimaryDarkColor),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "SAVE DATA",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colorController.kCircleBgColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 330,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: colorController.kBgPopupColor),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Activity"),
                                    const Spacer(),
                                    const Text("Move"),
                                    Text(
                                      "${_controller.totalStepsDB}/${_controller.target}",
                                      //_controller.steps +
                                      style: TextStyle(
                                          color: colorController
                                              .kPrimaryDarkColor),
                                    ),
                                    const Spacer(),
                                    const Text("CAL"),
                                    Text(
                                      _controller.kal.round().toString(),
                                      style: TextStyle(
                                          color: colorController
                                              .kPrimaryDarkColor),
                                    ),
                                    const Spacer(),
                                    const Text("Distance"),
                                    Text(
                                      "${_controller.distance.toStringAsFixed(2)} KM",
                                      style: TextStyle(
                                          color: colorController
                                              .kPrimaryDarkColor),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularPercentIndicator(
                                      radius: 50.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 15.0,
                                      percent: _controller
                                              .totalStepsDB.isNotEmpty
                                          ? (double.parse("${_controller.totalStepsDB}") /
                                                      10000) >
                                                  1
                                              ? 1
                                              : (double.parse(
                                                      "${_controller.totalStepsDB}") /
                                                  10000)
                                          : 0,
                                      center: new Text(
                                        _controller.totalStepsDB,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.butt,
                                      backgroundColor: Colors.white,
                                      progressColor:
                                          colorController.kPrimaryDarkColor,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            // color: Colors.grey,
                            child: SfCartesianChart(
                                primaryXAxis: NumericAxis(
                                  borderWidth: 0.0,
                                  majorGridLines: MajorGridLines(
                                    width: 0.5,
                                    color: Color.fromARGB(255, 197, 172, 162),
                                  ),
                                  minimum: 2,
                                  maximum: 24,
                                  interval: 2,
                                  axisLine: AxisLine(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  borderWidth: 0.0,
                                  isVisible: false,
                                  majorGridLines: MajorGridLines(
                                      width: 0.5,
                                      color: colorController.kPrimaryDarkColor),
                                  axisLine: AxisLine(width: 0),
                                ),
                                // backgroundColor:Colors.yellow,
                                isTransposed: true,
                                series: [
                                  BarSeries<SalesData, double>(
                                    dataSource: _controller.chartDataTodayDB,
                                    xValueMapper: (SalesData data, _) =>
                                        data.year,
                                    yValueMapper: (SalesData data, _) =>
                                        data.sales,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                        textStyle: TextStyle(fontSize: 10)),
                                    color: colorController.kPrimaryDarkColor,
                                    width: 1,
                                    spacing: 0.9,
                                    enableTooltip: true,
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20, bottom: 10),
                  child: Text(
                    "This Week",
                    style: TextStyle(
                        color: colorController.kPrimaryDarkColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _controller.staticDateTime.length,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime d = _controller.staticDateTime[index];
                        // print("get date from ******$d ${_controller.staticDateTimeNew[0]}");
                        if (_controller.staticDateTimeNew.contains(d)) {
                          int j = _controller.staticDateTimeNew.indexOf(d);
                          return Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 150,
                                color: selectedIndex == index
                                    ? colorController.kBgPopupColor
                                    : null,
                                child: InkWell(
                                  onTapDown: (TapUpDetails) async {
                                    weekVisible = true;
                                    monthOneVisible = false;
                                    monthTwoVisible = false;
                                    monthThreeVisible = false;
                                    visiblecalender = false;
                                    visiblecalender1 = false;
                                    visiblecalender2 = false;
                                    isWeekDayClicked = true;
                                    _controller.getOnClickDailyData(
                                        _controller.weekDayListDB[j].date_name);

                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: _controller.weekDayListDB.isNotEmpty
                                      ? Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5.0),
                                                child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70.0),
                                                      color: colorController
                                                          .kBgColor,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      _controller
                                                          .weekDayListDB[j]
                                                          .dayname,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))),
                                              ),
                                              CircularPercentIndicator(
                                                radius: 20.0,
                                                animation: true,
                                                animationDuration: 1200,
                                                lineWidth: 5.0,
                                                percent: (double.parse(_controller
                                                                .weekDayListDB[
                                                                    j]
                                                                .STEPS) /
                                                            10000) >
                                                        1
                                                    ? 1
                                                    : (double.parse(_controller
                                                            .weekDayListDB[j]
                                                            .STEPS) /
                                                        10000),
                                                circularStrokeCap:
                                                    CircularStrokeCap.butt,
                                                backgroundColor: colorController
                                                    .kPrimaryLightColor,
                                                progressColor: colorController
                                                    .kPrimaryDarkColor,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ),
                              ),
                            ],
                          );
                        } else {
                          c = Colors.blue;
                          int count = 0;
                          // print("get data from static_Day else :: $index}");
                          return Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 150,
                                color: selectedIndex == index
                                    ? colorController.kBgPopupColor
                                    : null,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 2, right: 2),
                                  child: InkWell(
                                    onTapDown: (TapUpDetails) {
                                      print(
                                          "INDEX :: $index  J :: $selectedIndex");

                                      weekVisible = true;
                                      monthOneVisible = false;
                                      monthTwoVisible = false;
                                      monthThreeVisible = false;
                                      visiblecalender = false;
                                      visiblecalender1 = false;
                                      visiblecalender2 = false;
                                      isWeekDayClicked = true;
                                      _controller.getOnClickDailyData(
                                          _controller.static_Day[index].date);
                                      // if(index != selectedIndex){
                                      //   _controller.weekViewColor = null;
                                      //   count++;
                                      // }else{
                                      //   count = 0;
                                      //   _controller.weekViewColor = colorController.kBgPopupColor;
                                      // }
                                      setState(() {
                                        selectedIndex = index;
                                      });

                                      print(count);
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          70.0),
                                                  color:
                                                      colorController.kBgColor,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  _controller.static_Day[index]
                                                      .dayname,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))),
                                          ),
                                          CircularPercentIndicator(
                                            radius: 20.0,
                                            animation: true,
                                            animationDuration: 1200,
                                            lineWidth: 5.0,
                                            percent: 0,
                                            circularStrokeCap:
                                                CircularStrokeCap.butt,
                                            backgroundColor: colorController
                                                .kPrimaryLightColor,
                                            progressColor: colorController
                                                .kPrimaryDarkColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                ),
                Visibility(
                  visible: weekVisible,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: colorController.kBgPopupColor,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Activity"),
                                      const Spacer(),
                                      const Text("Move"),
                                      Text(
                                        _controller
                                                .dailyDataOnClickModel?.Steps ??
                                            "0",
                                        //_controller.steps +
                                        style: TextStyle(
                                            color: colorController
                                                .kPrimaryDarkColor),
                                      ),
                                      const Spacer(),
                                      const Text("CAL"),
                                      textWidget(_controller
                                              .dailyDataOnClickModel?.cal ??
                                          "0.0"),
                                      // Text(
                                      //   healthController
                                      //           .dailyDataOnClickModel?.cal.round().toString() ??
                                      //       "0",
                                      //   style:
                                      //       const TextStyle(color: colorController.kPrimaryDarkColor),
                                      // ),
                                      const Spacer(),
                                      const Text("Distance"),

                                      distancewidget(_controller
                                              .dailyDataOnClickModel
                                              ?.distance ??
                                          "0"),

                                      // Text(
                                      //   '${healthController.dailyDataOnClickModel?.distance ?? "0"} KM',
                                      //   style:
                                      //       const TextStyle(color: colorController.kPrimaryDarkColor),
                                      // ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 50.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 15.0,
                                        percent: _controller
                                                    .dailyDataOnClickModel
                                                    ?.Steps !=
                                                null
                                            ? (double.parse(_controller
                                                            .dailyDataOnClickModel!
                                                            .Steps!) /
                                                        10000) >
                                                    1
                                                ? 1
                                                : (double.parse(_controller
                                                        .dailyDataOnClickModel!
                                                        .Steps!) /
                                                    10000)
                                            : 0,
                                        center: new Text(
                                          _controller.dailyDataOnClickModel
                                                      ?.Steps !=
                                                  null
                                              ? _controller
                                                  .dailyDataOnClickModel!.Steps!
                                              : "0",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.butt,
                                        backgroundColor: Colors.white,
                                        progressColor:
                                            colorController.kPrimaryDarkColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _controller.dailyDataOnClickModel?.charData != null
                              ? Expanded(
                                  child: Container(
                                    height: 100,
                                    // color: Colors.grey,
                                    child: SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          borderWidth: 0.0,
                                          majorGridLines: MajorGridLines(
                                            width: 0.5,
                                            color: Color.fromARGB(
                                                255, 197, 172, 162),
                                          ),
                                          minimum: 2,
                                          maximum: 24,
                                          interval: 2,
                                          axisLine: AxisLine(width: 0),
                                        ),
                                        primaryYAxis: NumericAxis(
                                            borderWidth: 0.0,
                                            isVisible: false,
                                            majorGridLines: MajorGridLines(
                                                width: 0.5,
                                                color: colorController
                                                    .kPrimaryDarkColor),
                                            axisLine: AxisLine(width: 0)),
                                        // backgroundColor:Colors.yellow,
                                        isTransposed: true,
                                        series: [
                                          BarSeries<SalesData, double>(
                                            dataSource: _controller
                                                .dailyDataOnClickModel!
                                                .charData!,
                                            xValueMapper: (SalesData data, _) =>
                                                data.year,
                                            yValueMapper: (SalesData data, _) =>
                                                data.sales,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true,
                                                    textStyle: TextStyle(
                                                        fontSize: 10)),
                                            color: colorController
                                                .kPrimaryDarkColor,
                                            width: 1,
                                            spacing: 0.9,
                                            enableTooltip: true,
                                          )
                                        ]),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 0),
                  child: Row(
                    children: [
                      Text(
                        "${DateFormat("MMMM").format(DateTime.now())}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            visiblecalender = !visiblecalender;
                            visiblecalender1 = false;
                            visiblecalender2 = false;

                            print(
                                "_controller.visiblecalender :: ${!visiblecalender}");
                            // _controller.setVisibility();
                            weekVisible = false;
                            monthOneVisible = false;
                            monthTwoVisible = false;
                            monthThreeVisible = false;
                            setState(() {});
                          },
                          child: visiblecalender
                              ? Icon(
                                  Icons.arrow_drop_up,
                                  size: 30,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                  color: Colors.black,
                                )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      color: colorController.kBgPopupColor,
                    ),
                    child: Visibility(
                      visible: visiblecalender,
                      child: SfCalendar(
                        selectionDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            width: 2,
                            color: colorController.kPrimaryDarkColor,
                          ),
                        ),
                        todayHighlightColor: colorController.kPrimaryDarkColor,
                        cellBorderColor: colorController.kPrimaryLightColor,
                        minDate: DateTime(
                            DateTime.now().year, DateTime.now().month, 1),
                        maxDate: DateTime.now(),
                        // maxDate: DateTime(DateTime.now().year,
                        //     DateTime.now().month, int.parse(d)),
                        initialDisplayDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day, /* 08, 45*/
                        ),
                        view: CalendarView.month,
                        monthViewSettings: MonthViewSettings(
                            showAgenda: false,
                            monthCellStyle: MonthCellStyle(
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold))),
                        onTap: (CalendarTapDetails d) {
                          var dateF = DateFormat("dd/MMM/yyyy").format(d.date!);
                          var dayinweek = DateFormat('EEE').format(d.date!);
                          _controller.getOnClickDailyData(d.date!);
                          weekVisible = false;
                          monthOneVisible = true;
                          monthTwoVisible = false;
                          monthThreeVisible = false;
                          setState(() {});
                          print(
                              "on tap on calendar :: ${d.date}   ${_controller.stepsOnCard}");
                          print(
                              "on tap on calendar :: ${DateFormat("dd/MMM/yyyy").format(d.date!)}");
                        },

                        // onSelectionChanged: (CalendarSelectionDetails d) {
                        //   var dateF = DateFormat("dd/MMM/yyyy").format(d.date!);
                        //   var dayinweek = DateFormat('EEE').format(d.date!);
                        //   // healthController.getOnClickDailyData(
                        //   //     d.date!);
                        //   // healthController.getDataOnDateClick(
                        //   //     DateFormat("dd/MMM/yyyy").parse(dateF), dayinweek);
                        //   weekVisible = false;
                        //   monthOneVisible = true;
                        //   monthTwoVisible = false;
                        //   monthThreeVisible = false;
                        //   setState(() {});
                        //   print("onSelectionChanged on calendar :: ${d.date}");
                        //   print(
                        //       "onSelectionChanged calendar :: ${DateFormat("dd/MMM/yyyy").format(d.date!)}");
                        // },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: monthOneVisible,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: colorController.kBgPopupColor,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Activity"),
                                      const Spacer(),
                                      const Text("Move"),
                                      Text(
                                        _controller.stepsOnCard,
                                        //_controller.steps +
                                        style: TextStyle(
                                            color: colorController
                                                .kPrimaryDarkColor),
                                      ),
                                      const Spacer(),
                                      const Text("CAL"),
                                      textWidget(_controller
                                              .dailyDataOnClickModel?.cal ??
                                          "0"),
                                      const Spacer(),
                                      const Text("Distance"),
                                      distancewidget(_controller
                                              .dailyDataOnClickModel
                                              ?.distance ??
                                          "0"),

                                      // Text(
                                      //   '${healthController.dailyDataOnClickModel?.distance ?? "0"} KM',
                                      //   style:
                                      //       const TextStyle(color: colorController.kPrimaryDarkColor),
                                      // ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 50.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 15.0,
                                        percent: _controller
                                                    .dailyDataOnClickModel
                                                    ?.Steps !=
                                                null
                                            ? (double.parse(_controller
                                                            .dailyDataOnClickModel!
                                                            .Steps!) /
                                                        10000) >
                                                    1
                                                ? 1
                                                : (double.parse(_controller
                                                        .dailyDataOnClickModel!
                                                        .Steps!) /
                                                    10000)
                                            : 0,
                                        center: new Text(
                                          _controller.dailyDataOnClickModel
                                                      ?.Steps !=
                                                  null
                                              ? _controller
                                                  .dailyDataOnClickModel!.Steps!
                                              : "0",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.butt,
                                        backgroundColor: Colors.white,
                                        progressColor:
                                            colorController.kPrimaryDarkColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _controller.dailyDataOnClickModel?.charData != null
                              ? Expanded(
                                  child: Container(
                                    height: 100,
                                    padding: EdgeInsets.all(8.0),
                                    // color: Colors.grey,
                                    child: SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          borderWidth: 0.0,
                                          majorGridLines: MajorGridLines(
                                            width: 0.5,
                                            color: Color.fromARGB(
                                                255, 197, 172, 162),
                                          ),
                                          minimum: 2,
                                          maximum: 24,
                                          interval: 2,
                                          axisLine: AxisLine(width: 0),
                                        ),
                                        primaryYAxis: NumericAxis(
                                            borderWidth: 0.0,
                                            isVisible: false,
                                            majorGridLines: MajorGridLines(
                                                width: 0.5,
                                                color: colorController
                                                    .kPrimaryDarkColor),
                                            axisLine: AxisLine(width: 0)),
                                        // backgroundColor:Colors.yellow,
                                        isTransposed: true,
                                        series: [
                                          BarSeries<SalesData, double>(
                                            dataSource: _controller
                                                .dailyDataOnClickModel!
                                                .charData!,
                                            xValueMapper: (SalesData data, _) =>
                                                data.year,
                                            yValueMapper: (SalesData data, _) =>
                                                data.sales,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true,
                                                    textStyle: TextStyle(
                                                        fontSize: 10)),
                                            color: colorController
                                                .kPrimaryDarkColor,
                                            width: 1,
                                            spacing: 0.9,
                                            enableTooltip: true,
                                          )
                                        ]),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "${DateFormat("MMMM").format(DateTime(DateTime.now().year, DateTime.now().month - 1, int.parse(d1)))}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            visiblecalender1 = !visiblecalender1;
                            visiblecalender2 = false;
                            visiblecalender = false;
                            weekVisible = false;
                            monthOneVisible = false;
                            monthTwoVisible = false;
                            monthThreeVisible = false;
                            setState(() {});
                          },
                          child: visiblecalender1
                              ? Icon(
                                  Icons.arrow_drop_up,
                                  size: 30,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                  color: Colors.black,
                                )),
                    ],
                  ),
                ),
                Visibility(
                  visible: visiblecalender1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        color: colorController.kBgPopupColor,
                      ),
                      child: SfCalendar(
                        selectionDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            width: 2,
                            color: colorController.kPrimaryDarkColor,
                          ),
                        ),
                        todayHighlightColor: colorController.kPrimaryDarkColor,
                        minDate: DateTime(
                            DateTime.now().year, DateTime.now().month - 1, 1),
                        maxDate: DateTime(DateTime.now().year,
                            DateTime.now().month - 1, int.parse(d1)),
                        view: CalendarView.month,
                        monthViewSettings: MonthViewSettings(
                            showAgenda: false,
                            monthCellStyle: MonthCellStyle(
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold))),
                        onTap: (CalendarTapDetails d) {
                          _controller.getOnClickDailyData(d.date!);
                          weekVisible = false;
                          monthOneVisible = false;
                          monthTwoVisible = true;
                          monthThreeVisible = false;
                          setState(() {});
                        },

                        // onSelectionChanged: (CalendarSelectionDetails d) {
                        //   var dateF = DateFormat("dd/MMM/yyyy").format(d.date!);
                        //   var dayinweek = DateFormat('EEE').format(d.date!);
                        //   healthController.getDataOnDateClick(
                        //       DateFormat("dd/MMM/yyyy").parse(dateF), dayinweek);
                        //   weekVisible = false;
                        //   monthOneVisible = false;
                        //   monthTwoVisible = true;
                        //   monthThreeVisible = false;
                        //   setState(() {});
                        // },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: monthTwoVisible,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: colorController.kBgPopupColor,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Activity"),
                                      const Spacer(),
                                      const Text("Move"),
                                      Text(
                                        _controller
                                                .dailyDataOnClickModel?.Steps ??
                                            "0",
                                        //_controller.steps +
                                        style: TextStyle(
                                            color: colorController
                                                .kPrimaryDarkColor),
                                      ),
                                      const Spacer(),
                                      const Text("CAL"),
                                      textWidget(_controller
                                              .dailyDataOnClickModel?.cal ??
                                          "0"),
                                      const Spacer(),
                                      const Text("Distance"),
                                      Text(
                                        '${_controller.dailyDataOnClickModel?.distance ?? "0"} KM',
                                        style: TextStyle(
                                            color: colorController
                                                .kPrimaryDarkColor),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 50.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 15.0,
                                        percent: _controller
                                                    .dailyDataOnClickModel
                                                    ?.Steps !=
                                                null
                                            ? (double.parse(_controller
                                                            .dailyDataOnClickModel!
                                                            .Steps!) /
                                                        10000) >
                                                    1
                                                ? 1
                                                : (double.parse(_controller
                                                        .dailyDataOnClickModel!
                                                        .Steps!) /
                                                    10000)
                                            : 0,
                                        center: new Text(
                                          _controller.dailyDataOnClickModel
                                                      ?.Steps !=
                                                  null
                                              ? _controller
                                                  .dailyDataOnClickModel!.Steps!
                                              : "0",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.butt,
                                        backgroundColor: Colors.white,
                                        progressColor:
                                            colorController.kPrimaryDarkColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _controller.dailyDataOnClickModel?.charData != null
                              ? Expanded(
                                  child: Container(
                                    height: 100,
                                    padding: EdgeInsets.all(8.0),
                                    // color: Colors.grey,
                                    child: SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          borderWidth: 0.0,
                                          majorGridLines: MajorGridLines(
                                            width: 0.5,
                                            color: Color.fromARGB(
                                                255, 197, 172, 162),
                                          ),
                                          minimum: 2,
                                          maximum: 24,
                                          interval: 2,
                                          axisLine: AxisLine(width: 0),
                                        ),
                                        primaryYAxis: NumericAxis(
                                            borderWidth: 0.0,
                                            isVisible: false,
                                            majorGridLines: MajorGridLines(
                                                width: 0.5,
                                                color: colorController
                                                    .kPrimaryDarkColor),
                                            axisLine: AxisLine(width: 0)),
                                        // backgroundColor:Colors.yellow,
                                        isTransposed: true,
                                        series: [
                                          BarSeries<SalesData, double>(
                                            dataSource: _controller
                                                .dailyDataOnClickModel!
                                                .charData!,
                                            xValueMapper: (SalesData data, _) =>
                                                data.year,
                                            yValueMapper: (SalesData data, _) =>
                                                data.sales,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true,
                                                    textStyle: TextStyle(
                                                        fontSize: 10)),
                                            color: colorController
                                                .kPrimaryDarkColor,
                                            width: 1,
                                            spacing: 0.9,
                                            enableTooltip: true,
                                          )
                                        ]),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "${DateFormat("MMMM").format(DateTime(DateTime.now().year, DateTime.now().month - 2, int.parse(d2)))}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            visiblecalender2 = !visiblecalender2;
                            visiblecalender1 = false;
                            visiblecalender = false;
                            weekVisible = false;
                            monthOneVisible = false;
                            monthTwoVisible = false;
                            monthThreeVisible = false;
                            setState(() {});
                          },
                          child: visiblecalender2
                              ? Icon(
                                  Icons.arrow_drop_up,
                                  size: 30,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                  color: Colors.black,
                                )),
                    ],
                  ),
                ),
                Visibility(
                  visible: visiblecalender2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        color: colorController.kBgPopupColor,
                      ),
                      child: SfCalendar(
                        selectionDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            width: 2,
                            color: colorController.kPrimaryDarkColor,
                          ),
                        ),
                        todayHighlightColor: colorController.kPrimaryDarkColor,
                        minDate: DateTime(
                            DateTime.now().year, DateTime.now().month - 2, 1),
                        maxDate: DateTime(DateTime.now().year,
                            DateTime.now().month - 2, int.parse(d2)),
                        view: CalendarView.month,
                        monthViewSettings: MonthViewSettings(
                            showAgenda: false,
                            monthCellStyle: MonthCellStyle(
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold))),
                        // onTap: (CalendarTapDetails d) {
                        //   var dateF = DateFormat("dd/MMM/yyyy").format(d.date!);
                        //   var dayinweek = DateFormat('EEE').format(d.date!);
                        //   healthController.getDataOnDateClick(
                        //       DateFormat("dd/MMM/yyyy").parse(dateF), dayinweek);
                        //   weekVisible = false;
                        //   monthOneVisible = false;
                        //   monthTwoVisible = false;
                        //   monthThreeVisible = true;
                        // },

                        onTap: (CalendarTapDetails d) {
                          _controller.getOnClickDailyData(d.date!);
                          weekVisible = false;
                          monthOneVisible = false;
                          monthTwoVisible = false;
                          monthThreeVisible = true;
                          setState(() {});
                        },

                        // onSelectionChanged: (CalendarSelectionDetails d) {
                        //   var dateF = DateFormat("dd/MMM/yyyy").format(d.date!);
                        //   var dayinweek = DateFormat('EEE').format(d.date!);
                        //   healthController.getDataOnDateClick(
                        //       DateFormat("dd/MMM/yyyy").parse(dateF), dayinweek);
                        //   weekVisible = false;
                        //   monthOneVisible = false;
                        //   monthTwoVisible = false;
                        //   monthThreeVisible = true;
                        // },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: monthThreeVisible,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: colorController.kBgPopupColor,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Activity"),
                                      const Spacer(),
                                      const Text("Move"),
                                      Text(
                                        _controller
                                                .dailyDataOnClickModel?.Steps ??
                                            "0",
                                        //_controller.steps +
                                        style: TextStyle(
                                            color: colorController
                                                .kPrimaryDarkColor),
                                      ),
                                      const Spacer(),
                                      const Text("CAL"),
                                      textWidget(_controller
                                              .dailyDataOnClickModel?.cal ??
                                          "0"),
                                      const Spacer(),
                                      const Text("Distance"),
                                      distancewidget(_controller
                                              .dailyDataOnClickModel
                                              ?.distance ??
                                          "0"),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 50.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 15.0,
                                        percent: _controller
                                                    .dailyDataOnClickModel
                                                    ?.Steps !=
                                                null
                                            ? (double.parse(_controller
                                                            .dailyDataOnClickModel!
                                                            .Steps!) /
                                                        10000) >
                                                    1
                                                ? 1
                                                : (double.parse(_controller
                                                        .dailyDataOnClickModel!
                                                        .Steps!) /
                                                    10000)
                                            : 0,
                                        center: new Text(
                                          _controller.dailyDataOnClickModel
                                                      ?.Steps !=
                                                  null
                                              ? _controller
                                                  .dailyDataOnClickModel!.Steps!
                                              : "0",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.butt,
                                        backgroundColor: Colors.white,
                                        progressColor:
                                            colorController.kPrimaryDarkColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _controller.dailyDataOnClickModel?.charData != null
                              ? Expanded(
                                  child: Container(
                                    height: 100,
                                    padding: EdgeInsets.all(8.0),
                                    // color: Colors.grey,
                                    child: SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          borderWidth: 0.0,
                                          majorGridLines: MajorGridLines(
                                            width: 0.5,
                                            color: Color.fromARGB(
                                                255, 197, 172, 162),
                                          ),
                                          minimum: 2,
                                          maximum: 24,
                                          interval: 2,
                                          axisLine: AxisLine(width: 0),
                                        ),
                                        primaryYAxis: NumericAxis(
                                            borderWidth: 0.0,
                                            isVisible: false,
                                            majorGridLines: MajorGridLines(
                                                width: 0.5,
                                                color: colorController
                                                    .kPrimaryDarkColor),
                                            axisLine: AxisLine(width: 0)),
                                        // backgroundColor:Colors.yellow,
                                        isTransposed: true,
                                        series: [
                                          BarSeries<SalesData, double>(
                                            dataSource: _controller
                                                .dailyDataOnClickModel!
                                                .charData!,
                                            xValueMapper: (SalesData data, _) =>
                                                data.year,
                                            yValueMapper: (SalesData data, _) =>
                                                data.sales,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true,
                                                    textStyle: TextStyle(
                                                        fontSize: 10)),
                                            color: colorController
                                                .kPrimaryDarkColor,
                                            width: 1,
                                            spacing: 0.9,
                                            enableTooltip: true,
                                          )
                                        ]),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget textWidget(String? cal) {
    double val = double.parse(cal.toString());
    return Text(
      val.round().toString(),
      style: TextStyle(color: colorController.kPrimaryDarkColor),
    );
  }

  Widget distancewidget(String s) {
    double val = double.parse(s) / 100;
    return Text(
      '${val.toStringAsFixed(2)} KM',
      style: TextStyle(color: colorController.kPrimaryDarkColor),
    );
  }
}
