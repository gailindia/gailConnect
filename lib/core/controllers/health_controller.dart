import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gail_connect/core/db/health.dart';
import 'package:gail_connect/core/db/health_data.dart';
import 'package:gail_connect/models/health_data_model.dart';
import 'package:gail_connect/models/healthdbModel.dart';
import 'package:gail_connect/models/ohc_screen_model.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/ui/screens/health_screens/health_screen.dart';
import 'package:gail_connect/ui/screens/wishlist_screen.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:pedometer/pedometer.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../models/week_day_db.dart';
import '../../models/weekday.dart';
import '../../ui/styles/text_styles.dart';
import '../../ui/widgets/custom_dialogs/show_message_wish_dialog.dart';

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_DELETED,
  DATA_NOT_ADDED,
  DATA_NOT_DELETED,
  STEPS_READY,
}

class HealthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  TextEditingController kmTargetAcheivedController = TextEditingController();
  TextEditingController kmTargetController = TextEditingController();
  TextEditingController timePeriodController = TextEditingController();
  Pedometer pedo_meter = Pedometer();
  String steps = '0';
  int totalcount = 0, step = 0;
  double kal = 0.0,
      distance = 0.0,
      percentage = 0.0,
      percent = 0.0,
      speed = 0.0;

  int? target = 10000;
  int previoussteps = 0;
  int recordpreSteps = 0;
  String str = "";
  int steps1 = 0;
  String steprecordset = "0";
  String toSPteps = "0";
  String stepTargetset = "0";
  String totalStepsDB = "";

  bool targetCard = false;
  bool reSetUpdateCard = false;
  final currentTime = DateTime.now();
  static var countdownDuration = const Duration(minutes: 10);

  // static var countdownDuration1 = const Duration(minutes: 10);
  Duration duration = const Duration();
  Duration duration1 = const Duration();
  Timer? timer;
  Timer? timer1;
  Timer? timerForIosStepCounter;
  bool countDown = true;
  bool countDown1 = true;
  bool startRow = true;
  bool visiblecalender = true,
      invisiblecalender = true,
      visiblecalender1 = false,
      invisiblecalender1 = true,
      visiblecalender2 = false,
      invisiblecalender2 = true;

  List<SalesData> chartDataToday = [];
  // List<WeekDay> getOnClickToday = [];

  ///From DB
  late List<SalesData> chartDataTodayDB = [];
  // List<WeekDay> getOnClickTodayDB = [];

  late List<HealthDataModel> healthdatalist = [];

  final List<SalesData> chartData = [];

  final values = [
    true,
    true,
    true,
    false,
    false,
    false,
    true,
  ];
  List<Widget> bottomNavChildren = <Widget>[
    EmpWishesScreen(),
    EmpWishesScreen(),
    EmpWishesScreen(),
  ];

  Dio dio = Dio();
  Map<String, String> body = {};

  String finalDate = '';
  String finalDate1 = '';
  String start_Date = '';
  String end_Date = '';
  DateTime? mon_day;
  DateTime? tue_day;
  DateTime? wed_day;
  DateTime? thu_day;
  DateTime? fri_day;
  DateTime? sat_day;
  DateTime? sun_day;

  // List<WeekDay> weekDayList = [];
  List<WeekDayDB> weekDayListDB = [];
  // List<WeekDay> weekDayListNew = [];
  // List<WeekDay> weekDayListForView = [];
  // List<WeekDay> getOnClick = [];
  List<staticDay> static_Day = [];
  List<DateTime> staticDateTime = [];
  List<DateTime> staticDateTimeNew = [];
  late String dayName;
  late DateTime date_param;

  late String stepsOnCard;

  DateTime? startDate;
  DateTime? endDate;

  List<OHCMODEL> ohcmodellist = [];
  OHCMODEL? ohcmodel;
  TextEditingController hospitalNameController = TextEditingController();
  TextEditingController hospitalAddressController = TextEditingController();
  TextEditingController hospitalmeasurementsController =
      TextEditingController();
  TextEditingController hospitalNameControllerU = TextEditingController();
  TextEditingController hospitalAddressControllerU = TextEditingController();
  TextEditingController hospitalmeasurementsControllerU =
      TextEditingController();
  TextEditingController dateinputupdate = TextEditingController();
  bool formvisible = false;
  String sno = '';
  bool viewFrom = false, updateForm = false;

  DailyDataOnClickModel dailyDataOnClickModel = DailyDataOnClickModel();

  int totalSteps = 0;
  int stepsTest = 0;
  int recordtotalSteps = 0;

  // Box<String> box = Hive.box<String>('testBox');
  var name;
  late String totalStepsTillDate;
  List<String> list = [];

  //ios stepup for step counter
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;
  int _nofSteps = 0;

  String getTodaysSteps = "0";
  String Date_Time = "0";
  String Date_Timeer = "0";

  static final types = [HealthDataType.STEPS];

  final permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();
  // Global Health instance
  final health = Health();
  // create a HealthFactory for use in the app
  // HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  bool showCelebration = false;
  late List<Map<String, Object?>> healthListToPost = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    // health.configure(useHealthConnectIfAvailable: true);
    super.onInit();

    await health.configure();
    if (Platform.isAndroid) {
      print("Platform is Android");
      initPlatformState();
    } else {
      timerForIosStepCounter = Timer.periodic(
          Duration(seconds: 1), (Timer t) => getTodaysStepsData());
    }
    var hours;
    var mints;
    var secs;
    hours = int.parse("00");
    mints = int.parse("00");
    secs = int.parse("00");
    getCurrentDate();

    getWeekDataFromDB();

    countdownDuration = Duration(hours: hours, minutes: mints, seconds: secs);
    stepsOnCard = '0';

    setTargetApi();
    getTimeData();
    showSumStarget();

    if (Platform.isAndroid) {
      checkPermission();
    }

    // calling hit count api method
    GailConnectServices.to
        .hitCountApi(activity: kHealth, activityScreen: "/health");
  }

  //* ios steps counter start
  getTodaysStepsData() async {
    SecureSharedPref preferences = await SecureSharedPref.getInstance();
    // preferences.reload();
    // await GailConnectServices.to.returnCurrentTime();
    print(
        "getTodaysStepsData Health kit :: ${preferences.getString("Date_Time")}");
    String? s = await preferences.getString("Date_Time");
    if (s != null) {
      authorize();
    } else {
      Date_Time = await GailConnectServices.to.returnCurrentTime();
      preferences.putString("Date_Time", Date_Time);
      authorize();
    }
  }

  checkPermission() async {
    var statusActivityRecognition = await Permission.activityRecognition.status;
    var statusNotification = await Permission.notification.status;
    print("checkPermission :: ${statusNotification}");
    if (statusActivityRecognition.isDenied ||
        statusActivityRecognition.isPermanentlyDenied ||
        statusNotification.isDenied ||
        statusNotification.isPermanentlyDenied) {
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
        negativeBtnStyle: TextStyle(color: colorController.kCircleBgColor),
        onPositivePressed: () async {
          openAppSettings();
          Navigator.pop(Get.context!, "");
        },
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timerForIosStepCounter?.cancel();
  }

  getTimerreset() async {
    SecureSharedPref preferences = await SecureSharedPref.getInstance();
    preferences.putString("TimerIsActive", "");
  }

  /// Authorize, i.e. get permissions to access relevant health data.
  Future authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    // Check if we have health permissions
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);

    print("hasPermissions :: $hasPermissions");
    hasPermissions = false;

    bool authorized = false;

    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
        authorized =
            await health.requestAuthorization(types, permissions: permissions);
      } catch (error) {
        print("Exception in authorize: $error");
      }
    }

    _state = (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED;

    print("authorized :: $authorized   $hasPermissions");

    if (authorized) {
      fetchStepData();
    }

    update([kHealth]);
  }

  /// Fetch steps from the health plugin and show them in the app.
  Future fetchStepData() async {
    int? steps;
    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool stepsPermission =
        await health.hasPermissions([HealthDataType.STEPS]) ?? false;
    if (!stepsPermission) {
      stepsPermission =
          await health.requestAuthorization([HealthDataType.STEPS]);
    }

    if (stepsPermission) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');
      // final now = DateTime.now();
      final yesterday = now.subtract(Duration(hours: 24));
      SecureSharedPref preferences = await SecureSharedPref.getInstance();
      // preferences.reload();
      final String _cpfNumber =
          (await preferences.getString("cpfNumber", isEncrypted: true))!;

      String? s = await preferences.getString("Date_Time");

      DateTime t = DateFormat("dd/MM/yyyy HH:mm:ss").parse(s!);
      var d = DateFormat("yyyy-MM-dd HH:mm:ss.000").format(t);
      print("yesterday :: $yesterday  $s $t  $d");
//yesterday :: 2024-02-07 15:47:54.979915  08/02/2024 15:47:54
      // Clear old data points
      _healthDataList.clear();

      try {
        // fetch health data
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
            types: types, startTime: t, endTime: now);
        // save all the new data points (only the first 100)

        print("healthData :: $healthData");

        _healthDataList.addAll((healthData.length < 100)
            ? healthData
            : healthData.sublist(0, 100));
      } catch (error) {
        print("Exception in getHealthDataFromTypes: $error");
      }

      // filter out duplicates
      _healthDataList = health.removeDuplicates(_healthDataList);
      _healthDataList.reversed;
      // print the results

      _healthDataList.forEach((x) async {
        HealthDataModel model = HealthDataModel();
        var dt = DateTime.fromMillisecondsSinceEpoch(
            x.dateFrom.millisecondsSinceEpoch);
        String d24 = DateFormat('MM/dd/yyyy HH:mm:ss').format(dt);
        String dateIn = DateFormat('MM/dd/yyyy').format(dt);
        String st = '${x.value}';

        model.empNo = '${_cpfNumber}';
        model.steps = '${st.replaceAll(".0", "")}';
        model.updateDate = '$d24';
        model.date = '$dateIn';
        print("model :: ${x.value}  ${model.toString()}");

        await HealthDataDb.batchInsertIntoHealthDataTable(model);
      });

      totalStepsDB = await HealthDataDb.batchGetSUMsData();
      chartDataTodayDB = await HealthDataDb.batchGetChartsData();

      kal = int.parse(totalStepsDB) / 24;
      distance = int.parse(totalStepsDB) / 1200;
      percent = (int.parse(totalStepsDB) / 10000);
      percentage = percent;
      speed = distance / 12;

      getWeekDataFromDB();

      String acheivedSteps = await HealthDataDb.getSumOfTargetAcheived();

      SetTarget setTarget = SetTarget();
      setTarget.EMP_NO = '${_cpfNumber}';
      if (targetCard == true) {
        // stepTargetset = '${int.parse(stepTargetset) + actualsteps}';
        var splitSteps = acheivedSteps.split("/");
        if (int.parse(splitSteps[0]) >= int.parse(splitSteps[1])) {
          setTarget.ISTARGETACHIEVED = "true";
        } else {
          setTarget.ISTARGETACHIEVED = "false";
        }
        setTarget.TARGETACHIEVED = splitSteps[0];

        await HealthDataDb.updateTargetAchieved(setTarget);
        kmTargetAcheivedController.text = "${acheivedSteps}";
      } else {
        kmTargetAcheivedController.text = "${acheivedSteps}";
      }

      // if(actualsteps != event.steps){

      if (timer?.isActive ?? false) {
        Date_Timeer = await GailConnectServices.to.returnCurrentTime();
        preferences.putString("TimerIsActive", Date_Timeer);
        String? st = await preferences.getString("TimerIsActive");

        DateTime tt = DateFormat("dd/MM/yyyy HH:mm:ss").parse(st!);
        int? ist = await health.getTotalStepsInInterval(tt, now);
        steprecordset = '${ist ?? 0}';
        // steprecordset = '0';
      } else {
        steprecordset = '0';
      }

      _nofSteps = (steps == null) ? 0 : steps;
      //  getTodaysStepsData();
      _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
      print("fetchData totalStepsDB  ${totalStepsDB}");
    } else {
      print("Authorization not granted - error in authorization");
      _state = AppState.DATA_NOT_FETCHED;
    }

    update([kHealth]);
  }

  setTargetApi() async {
    SecureSharedPref preferences = await SecureSharedPref.getInstance();
    // preferences.reload();
    getWeekDataFromDB();
    final String _cpfNumber =
        (await preferences.getString("cpfNumber", isEncrypted: true))!;

    await HealthDataDb.getSetTargetListFromDb();

    healthListToPost = await HealthDataDb.batchGet3MonthsDataDynamic(
        DateTime.now(), _cpfNumber);
    print("healthTableToPost :: ${healthListToPost.length}");

    String? date = await preferences.getString('startDate');
    print("startDate ===== $date");
    // await HealthDataDb.getachievedDatafromdb();
    if (date != null) {
      String? staDate = await preferences.getString('startDate');
      String? edDate = await preferences.getString('endDate');
      print("getSetTargetListFromDb :: ${staDate}");
      startDate = DateFormat("yyyy-MM-dd HH:mm:ss.s").parse('${staDate}');
      endDate = DateFormat("yyyy-MM-dd HH:mm:ss.s").parse('${edDate}');
      String sd = DateFormat("dd/MMM/yyyy").format(startDate!);
      String ed = DateFormat("dd/MMM/yyyy").format(endDate!);

      String str = await HealthDataDb.getSumOfTargetAcheived();
      print("kmTargetAcheivedController :: ${str}");
      preferences.putBool('isSet', true);
      preferences.putBool('reSetUpdateCard', false);
      targetCard = await preferences.getBool('isSet') ?? true;
      reSetUpdateCard = await preferences.getBool("reSetUpdateCard") ?? false;
      kmTargetController.text =
          await preferences.getString('setTarget', isEncrypted: true) ?? '0';
      timePeriodController.text = '${sd} - ${ed}';
      kmTargetAcheivedController.text = "${str}";
      final splitted = str.split('/');

      if (int.parse(splitted[0]) / int.parse(splitted[1]) > 1) {
        showCelebration = true;
      }
    }
    update([kHealth]);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getDataOHC();
    if (Platform.isIOS) {
      getTodaysStepsData();
    }
  }

  void onStepCount(StepCount event) async {
    totalStepsDB = await HealthDataDb.batchGetSUMsData() ?? "0";
    chartDataTodayDB = await HealthDataDb.batchGetChartsData();
    print("event ---- $event");
    // box = await Hive.openBox('testBox');
    // box.put('steps', event.steps.toString());

    SecureSharedPref pref = await SecureSharedPref.getInstance();
    // await pref.reload();
    final String _cpfNumber =
        (await pref.getString("cpfNumber", isEncrypted: true)) ?? "";

    final log = await pref.getStringList('steps_pedo');

    print("SEE THE LOG :: $log");
    // log.clear();

    log.add(totalStepsDB);
    await pref.putStringList('steps_pedo', log);

    steps = event.steps.toString();
    list.add(steps);
    pref.putStringList("listinbackground", list);
    kal = int.parse(totalStepsDB) / 24;
    distance = int.parse(totalStepsDB) / 1200;
    percent = (int.parse(totalStepsDB) / 10000);
    percentage = percent;
    speed = distance / 12;
    // totalStepsTillDate = await HealthDataDb.batchGetTodaysData();

    // previoussteps = int.parse(totalStepsTillDate)+event.steps;

    int actualsteps = event.steps - previoussteps;
    previoussteps = event.steps;
    totalSteps = totalSteps + actualsteps;

    var dt = DateTime.fromMillisecondsSinceEpoch(
        event.timeStamp.millisecondsSinceEpoch);
    String d24 = DateFormat('MM/dd/yyyy HH:mm:ss').format(dt);
    String dateIn = DateFormat('MM/dd/yyyy').format(dt);
    HealthDataModel healthModel = HealthDataModel();
    healthModel.empNo = '${_cpfNumber}';

    if (actualsteps != event.steps) {
      healthModel.steps = '${actualsteps}';
      // list.add(healthModel.steps!);
      // stepsTest = int.parse(healthModel.steps??'0')+actualsteps;
      healthModel.updateDate = d24;
      healthModel.date = dateIn;
    } else {
      healthModel.steps = '0';
      // list.add(healthModel.steps!);
      healthModel.updateDate = d24;
      healthModel.date = dateIn;
    }

    // list.add(healthModel.steps!);

    await HealthDataDb.batchInsertIntoHealthDataTable(healthModel);
    // await HealthDataDb.getHealthListFromDb();
    getWeekDataFromDB();

    String acheivedSteps = await HealthDataDb.getSumOfTargetAcheived();

    pref.getString("startDate");
    pref.getString("endDate");
    SetTarget setTarget = SetTarget();
    setTarget.EMP_NO = '${_cpfNumber}';
    if (actualsteps != event.steps && targetCard == true) {
      stepTargetset = '${int.parse(stepTargetset) + actualsteps}';
      var splitSteps = acheivedSteps.split("/");
      if (int.parse(splitSteps[0]) >= int.parse(splitSteps[1])) {
        setTarget.ISTARGETACHIEVED = "true";
      } else {
        setTarget.ISTARGETACHIEVED = "false";
      }
      setTarget.TARGETACHIEVED = splitSteps[0];

      await HealthDataDb.updateTargetAchieved(setTarget);
      kmTargetAcheivedController.text = "${acheivedSteps}";
    } else {
      kmTargetAcheivedController.text = "${acheivedSteps}";
    }

    if (actualsteps != event.steps) {
      if (timer?.isActive ?? false) {
        steprecordset = '${int.parse(steprecordset) + actualsteps}';
      }
    } else {
      steprecordset = '0';
    }

    update([kHealth]);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print("onPedestrianStatusChanged :: $event");

    update([kHealth]);
  }

  void onPedestrianStatusError(error) {
    // print('onPedestrianStatusError: $error');
    update([kHealth]);
    // print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    steps = '0';
    update([kHealth]);
  }

  void initPlatformState() {
    print("initPlatformState");
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    // sendOtp();
    update([kHealth]);
  }

  void reset() {
    if (countDown) {
      duration = countdownDuration;
      update([kHealth]);
    } else {
      duration = const Duration();
      update([kHealth]);
    }
  }

  void finishTimer() {
    print("finishTimer");
    duration = const Duration();
    timer?.cancel();
    steprecordset = '0';
    getTimerreset();
    update([kHealth]);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    print("call start timer in records.dart");
    final addSeconds = 1;
    final seconds = duration.inSeconds + addSeconds;
    if (seconds < 0) {
      timer?.cancel();
    } else {
      duration = Duration(seconds: seconds);
    }
    update([kHealth]);
  }

  cancelTimer() {
    timer?.cancel();
    timer = null;

    // update([kHealth]);
  }

  reStartTimer() {
    print("timer resume ::");
    startTimer();
    // update([kHealth]);
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HOURS'),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

  void startTargetTimer() {
    timer1 = Timer.periodic(const Duration(seconds: 1), (_) => substractTime());
  }

  void substractTime() {
    print("call start timer in records.dart");
    final addSeconds = 1;
    final seconds = duration1.inSeconds - addSeconds;
    if (seconds < 0) {
      print("buildTimer1 if :: $duration1");
      // timer1?.cancel();
    } else {
      duration1 = Duration(seconds: seconds);
      print("buildTimer1 :: $duration1");
    }
    update([kHealth]);
  }

  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HOURS'),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
          ),
          // const SizedBox(
          //   height: 24,
          // ),
          // Text(header, style: const TextStyle(color: Colors.black45)),
        ],
      );

  void setVisibility() {
    if (visiblecalender) {
      visiblecalender = false;
      invisiblecalender = true;
      invisiblecalender1 = false;
      visiblecalender1 = true;
      invisiblecalender2 = false;
      visiblecalender2 = true;
      update([kHealth]);
    } else {
      visiblecalender = true;
      invisiblecalender = false;
      invisiblecalender1 = true;
      visiblecalender1 = false;
      invisiblecalender2 = true;
      visiblecalender2 = false;
      update([kHealth]);
    }
  }

  void setVisibility1() {
    if (visiblecalender1) {
      visiblecalender1 = false;
      invisiblecalender1 = true;
      invisiblecalender = false;
      visiblecalender = true;
      invisiblecalender2 = false;
      visiblecalender2 = true;
      update([kHealth]);
    } else {
      visiblecalender1 = true;
      invisiblecalender1 = false;
      invisiblecalender = true;
      visiblecalender = false;
      invisiblecalender2 = true;
      visiblecalender2 = false;
      update([kHealth]);
    }
  }

  void setVisibility2() {
    if (visiblecalender2) {
      visiblecalender2 = false;
      invisiblecalender2 = true;
      visiblecalender1 = false;
      invisiblecalender1 = true;
      invisiblecalender = false;
      visiblecalender = true;
      update([kHealth]);
    } else {
      visiblecalender2 = true;
      invisiblecalender2 = false;
      visiblecalender1 = true;
      invisiblecalender1 = false;
      invisiblecalender = true;
      visiblecalender = false;
      update([kHealth]);
    }
  }

  /// get TODAY DATA from DB
  // getTodayDataFromDB(DateTime d, String s) async{
  //   getOnClickTodayDB.clear();
  //   chartDataTodayDB.clear();
  //   List<HealthModel> list = await HealthDb.getTodaysData();
  //   if(list.isNotEmpty) {
  //
  //     getOnClickTodayDB.add(WeekDay(
  //       dayname: s,
  //       date_name: d,
  //       STEPS: list[0].sTEPS!,
  //       CAL: list[0].cAL!,
  //       DISTANCE: list[0].dISTANCE!,
  //       TWO_STEPS: list[0].tWOSTEPS!,
  //       FOUR_STEPS: list[0].fOURSTEPS!,
  //       SIX_STEPS: list[0].sIXSTEPS!,
  //       EIGHT_STEPS: list[0].eIGHTSTEPS!,
  //       TEN_STEPS: list[0].tENSTEPS!,
  //       TWELVE_STEPS: list[0].tWELVESTEPS!,
  //       FOURTEEN_STEPS: list[0].fOURTEENSTEPS!,
  //       SIXTEEN_STEPS: list[0].sIXTEENSTEPS!,
  //       EIGHTEEN_STEPS: list[0].eIGHTEENSTEPS!,
  //       TWENTY_STEPS: list[0].tWENTYSTEPS!,
  //       TTWO_STEPS: list[0].tWOSTEPS!,
  //       TFOUR_STEPS: list[0].tFOURSTEPS!,
  //     ));
  //
  //     chartDataTodayDB
  //         .add(SalesData(2, double.parse(list[0].tWOSTEPS!)));
  //     chartDataTodayDB
  //         .add(SalesData(4, double.parse(list[0].fOURSTEPS!)));
  //     chartDataTodayDB
  //         .add(SalesData(6, double.parse(list[0].sIXSTEPS!)));
  //     chartDataTodayDB
  //         .add(SalesData(8, double.parse(list[0].eIGHTSTEPS!)));
  //     chartDataTodayDB
  //         .add(SalesData(10, double.parse(list[0].tENSTEPS!)));
  //     chartDataTodayDB.add(
  //         SalesData(12, double.parse(list[0].tWELVESTEPS!)));
  //     chartDataTodayDB.add(
  //         SalesData(14, double.parse(list[0].fOURTEENSTEPS!)));
  //     chartDataTodayDB.add(
  //         SalesData(16, double.parse(list[0].sIXTEENSTEPS!)));
  //     chartDataTodayDB.add(
  //         SalesData(18, double.parse(list[0].eIGHTEENSTEPS!)));
  //     chartDataTodayDB.add(
  //         SalesData(20, double.parse(list[0].tWENTYSTEPS!)));
  //     chartDataTodayDB
  //         .add(SalesData(22, double.parse(list[0].tTWOSTEPS!)));
  //     chartDataTodayDB
  //         .add(SalesData(24, double.parse(list[0].tFOURSTEPS!)));
  //   }
  // }

  getWeekDataFromDB() async {
    print("start_Date :: $start_Date end_Date :: $end_Date");
    if (start_Date.isNullOrEmpty && end_Date.isNullOrEmpty) {
    } else {
      List<HealthDataModel> list =
          await HealthDataDb.batchGetWeekData(start_Date, end_Date);
      print("getWeekDataFromDB :: ${list.length}");
      for (int i = 0; i < list.length; i++) {
        print("get date from static_Day[i].date :: ${list[i].date!}");
        String t = DateFormat("yyyy-MM-dd HH:mm:ss.000")
            .format(DateFormat("MM/dd/yyyy").parse(list[i].date!));
        DateTime ft = DateFormat("yyyy-MM-dd HH:mm:ss.000").parse(t);
        print("get date from static_Day[i].date :: ${ft}");
        staticDateTimeNew.add(ft);
        if (staticDateTime.contains(ft)) {
          int j = staticDateTime.indexOf(ft);
          print("get data from static_Day :: ${staticDateTime.indexOf(ft)}");
          dayName = static_Day[j].dayname;
          date_param = static_Day[j].date;
          print(
              "get data from static datetime dayName if:: ${dayName} ${list[i].stepsInt}");
        }

        weekDayListDB.add(WeekDayDB(
            dayname: dayName,
            date_name: date_param,
            STEPS: '${list[i].stepsInt}'));
      }
    }
    update([kHealth]);
  }

  /// get CurrentDate
  getCurrentDate() {
    final now = DateTime.now();

    var date = DateTime(now.year, now.month + 1, 0).toString();

    var dateParse = findFirstDateOfTheWeek(now);
    var dateParse1 = lastFirstDateOfTheWeek(now);

    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    var formattedDate1 =
        "${dateParse1.day}/${dateParse1.month}/${dateParse1.year}";
    finalDate = formattedDate.toString();
    finalDate1 = formattedDate1.toString();

    start_Date = DateFormat("dd/MMM/yyyy")
        .format(DateFormat("dd/MM/yyyy").parse(finalDate));
    // startDate = DateFormat("dd/MMM/yyyy").parse(start_Date);
    end_Date = DateFormat("dd/MMM/yyyy")
        .format(DateFormat("dd/MM/yyyy").parse(finalDate1));
    // endDate = DateFormat("dd/MMM/yyyy").parse(end_Date);

    mon_day = DateFormat("dd/MM/yyyy").parse(finalDate);
    tue_day = DateFormat("dd/MM/yyyy").parse(finalDate).add(Duration(days: 1));
    wed_day = DateFormat("dd/MM/yyyy").parse(finalDate).add(Duration(days: 2));
    thu_day = DateFormat("dd/MM/yyyy").parse(finalDate).add(Duration(days: 3));
    fri_day = DateFormat("dd/MM/yyyy").parse(finalDate).add(Duration(days: 4));
    sat_day = DateFormat("dd/MM/yyyy").parse(finalDate).add(Duration(days: 5));
    sun_day = DateFormat("dd/MM/yyyy").parse(finalDate).add(Duration(days: 6));

    static_Day.add(staticDay(dayname: 'M', date: mon_day!));
    static_Day.add(staticDay(dayname: 'T', date: tue_day!));
    static_Day.add(staticDay(dayname: 'W', date: wed_day!));
    static_Day.add(staticDay(dayname: 'T', date: thu_day!));
    static_Day.add(staticDay(dayname: 'F', date: fri_day!));
    static_Day.add(staticDay(dayname: 'S', date: sat_day!));
    static_Day.add(staticDay(dayname: 'S', date: sun_day!));

    staticDateTime.add(mon_day!);
    staticDateTime.add(tue_day!);
    staticDateTime.add(wed_day!);
    staticDateTime.add(thu_day!);
    staticDateTime.add(fri_day!);
    staticDateTime.add(sat_day!);
    staticDateTime.add(sun_day!);
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime lastFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  void changeVisibility() {
    if (formvisible) {
      formvisible = false;
      updateForm = false;
      viewFrom = false;
    } else {
      formvisible = true;
      updateForm = false;
      viewFrom = false;
    }
    update([kHealth]);
  }

  void getDataOHC() async {
    ohcmodellist = await GailConnectServices.to.getOhcScreenData();
    print("gfdxhcjvkblm;" + ohcmodellist.toString());
    update([kHealth]);
  }

  void saveOFCData(BuildContext context, String text) async {
    var inputDate = DateTime.parse(text.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String _cpfNumber =
        (await pref.getString("cpfNumber", isEncrypted: true))!;

    final Map<String, dynamic> _body = {
      "EMP_NO": _cpfNumber,
      "HOSPITAL_NAME": hospitalNameController.text,
      "HOSPITAL_ADD": hospitalAddressController.text,
      "MEASUREMENTS": hospitalmeasurementsController.text,
      "OHC_DATE": outputDate.toString()
    };
    print(_body);

    final _response =
        await GailConnectServices.to.sendOHCScreenData(body: _body);

    if (_response != null) {
      if (_response.statusCode == 200) {
        // print(_response);
        viewFrom = false;
        updateForm = false;
        formvisible = false;
        hospitalNameController.clear();
        hospitalAddressController.clear();
        hospitalmeasurementsController.clear();
        dateinputupdate.clear();
        showWishDialogBox(context,
            title: "Status",
            description: _response.body['message'].toString(),
            onNegativePressed: () {}, onPositivePressed: () {
          Navigator.pop(context);
          // Get.offNamedUntil(kMainDashRoute, (route) => false);
        });
        getDataOHC();
        // Get.back();
      } else {
        showWishDialogBox(context,
            title: "ERROR",
            description: _response.body['message'].toString(),
            onNegativePressed: () {}, onPositivePressed: () {
          Navigator.pop(context);
          // Get.offNamedUntil(kMainDashRoute, (route) => false);
        });
        // calling show custom dialog box method
        // await showCustomDialogBox(context: Get.context!, title: kError, description: _response.body[kJsonMessage]);
      }
      update([kHealth]);
    }
  }

  void UpdateOFCData(BuildContext context) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String _cpfNumber =
        (await pref.getString("cpfNumber", isEncrypted: true))!;

    final Map<String, dynamic> _body = {
      "SNO": sno,
      "EMP_NO": _cpfNumber,
      "HOSPITAL_NAME": hospitalNameControllerU.text,
      "HOSPITAL_ADD": hospitalAddressControllerU.text,
      "MEASUREMENTS": hospitalmeasurementsControllerU.text
    };
    print(_body);

    final _response =
        await GailConnectServices.to.updateOHCScreenData(body: _body);

    await showProgressDialog(Get.context!);

    if (_response != null) {
      if (_response.statusCode == 200) {
        // print(_response);
        viewFrom = false;
        updateForm = false;
        formvisible = false;
        hospitalNameController.clear();
        hospitalAddressController.clear();
        hospitalmeasurementsController.clear();
        dateinputupdate.clear();
        showWishDialogBox(context,
            title: "Status",
            description: _response.body['message'].toString(),
            onNegativePressed: () {}, onPositivePressed: () {
          Navigator.pop(context);
          hideProgressDialog();
          // Get.offNamedUntil(kMainDashRoute, (route) => false);
        });

        getDataOHC();
        // Get.back();
      } else {
        hideProgressDialog();
        showWishDialogBox(context,
            title: "ERROR",
            description: _response.body['message'].toString(),
            onNegativePressed: () {}, onPositivePressed: () {
          Navigator.pop(context);
          // Get.offNamedUntil(kMainDashRoute, (route) => false);
        });

        // calling show custom dialog box method
        // await showCustomDialogBox(context: Get.context!, title: kError, description: _response.body[kJsonMessage]);
      }

      update([kHealth]);
    }
  }

  onTypesSelected(OHCMODEL? types) {
    ohcmodel = types;
    viewFrom = true;
    updateForm = false;
    formvisible = false;

    // if(viewFrom)
    update([kHealth]);
  }

  onUpdate(OHCMODEL? types) {
    ohcmodel = types;
    updateForm = true;
    viewFrom = false;
    formvisible = false;
    dateinputupdate.text =
        ohcmodel == null ? "" : ohcmodel!.LAST_OHC_DATE.toString();
    hospitalAddressControllerU.text =
        ohcmodel == null ? "" : ohcmodel!.HOSPITAL_ADD.toString();
    hospitalNameControllerU.text =
        ohcmodel == null ? "" : ohcmodel!.HOSPITAL_NAME.toString();
    hospitalmeasurementsControllerU.text =
        ohcmodel == null ? "" : ohcmodel!.MEASUREMENTS.toString();
    sno = ohcmodel == null ? "" : ohcmodel!.SNO.toString();
    update([kHealth]);
  }

  void getTimeData() async {
    totalStepsDB = await HealthDataDb.batchGetSUMsData() ?? "0";
    update([kHealth]);
  }

  getOnClickDailyData(DateTime dateTime) async {
    List<CardData> dailyOnClickData =
        await HealthDataDb.batchGetChartsDatadynamic(dateTime);
    final List<SalesData> chartDataTodayDB = [];

    chartDataTodayDB
        .add(SalesData(2.0, double.parse("${dailyOnClickData[0].TWO_STEPS}")));
    chartDataTodayDB
        .add(SalesData(4.0, double.parse("${dailyOnClickData[0].FOUR_STEPS}")));
    chartDataTodayDB
        .add(SalesData(6.0, double.parse("${dailyOnClickData[0].SIX_STEPS}")));
    chartDataTodayDB.add(
        SalesData(8.0, double.parse("${dailyOnClickData[0].EIGHT_STEPS}")));
    chartDataTodayDB
        .add(SalesData(10.0, double.parse("${dailyOnClickData[0].TEN_STEPS}")));
    chartDataTodayDB.add(
        SalesData(12.0, double.parse("${dailyOnClickData[0].TWELVE_STEPS}")));
    chartDataTodayDB.add(
        SalesData(14.0, double.parse("${dailyOnClickData[0].FOURTEEN_STEPS}")));
    chartDataTodayDB.add(
        SalesData(16.0, double.parse("${dailyOnClickData[0].SIXTEEN_STEPS}")));
    chartDataTodayDB.add(
        SalesData(18.0, double.parse("${dailyOnClickData[0].EIGHTEEN_STEPS}")));
    chartDataTodayDB.add(
        SalesData(20.0, double.parse("${dailyOnClickData[0].TWENTY_STEPS}")));
    chartDataTodayDB.add(
        SalesData(22.0, double.parse("${dailyOnClickData[0].TTWO_STEPS}")));
    chartDataTodayDB.add(
        SalesData(24.0, double.parse("${dailyOnClickData[0].TFOUR_STEPS}")));

    dailyDataOnClickModel = DailyDataOnClickModel(
        charData: chartDataTodayDB,
        Steps: "${dailyOnClickData[0].STEPS}",
        cal: "${dailyOnClickData[0].CAL}",
        distance: "${dailyOnClickData[0].DISTANCE}");
    print(
        "month view click data :: ${dailyDataOnClickModel.Steps}   ${dailyDataOnClickModel.cal}");
    stepsOnCard = dailyDataOnClickModel.Steps!;
    update([kHealth]);
    // return dailyDataOnClickModel;
  }

  showSumStarget() async {
    // await HealthDataDb.getSetTargetListFromDb();
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    // pref.reload();
    pref.getString("startDate", isEncrypted: true);
    pref.getString("endDate", isEncrypted: true);

    // String str = await HealthDataDb.getSumOfTargetAcheived('${pref.getString("startDate")}', '${pref.getString("endDate")}');

    kmTargetAcheivedController.text = "${str}";

    update([kHealth]);
  }
}
