import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:gail_connect/core/db/health_data.dart';

import 'package:gail_connect/models/health_data_model.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';


import '../../../core/controllers/health_controller.dart';
import '../../../rest/gail_connect_services.dart';
import '../../../utils/constants/app_constants.dart';
import '../../widgets/acknowledge_dialog.dart';

class RecordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecordScreen();
}

class _RecordScreen extends State<RecordScreen> {
  // TextEditingController kmTargetAcheivedController = TextEditingController();
  ColorController colorController = Get.put(ColorController());

  bool? resetval = false;
  String? settarget = "", range = "";

  // bool targetCard = false;
  // DateTime? startDate;
  // DateTime? endDate;
  Duration? _duration;
  int countResume = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getsharedvalue();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivate");
  }

  @override
  Widget build(BuildContext context) {
    ColorController colorController  = Get.put(ColorController());
    return GetBuilder<HealthController>(
        id: kHealth,
        init: HealthController(),
        builder: (_controller) {
          // kmTargetAcheivedController.text  = '${_controller.stepTargetset}';
          return Container(
            color: colorController.kHomeBgColor,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: colorController.kBgPopupColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Time",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 30),
                                child: _controller.buildTime()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Text("Distance"),
                                    Text(
                                      '${(int.parse(_controller.steprecordset) / 1200).toStringAsFixed(2)}' +
                                          " KM",
                                      style:  TextStyle(color: colorController.kPrimaryDarkColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text("Move"),
                                    Text(
                                      _controller.steprecordset,
                                      style:  TextStyle(color: colorController.kPrimaryDarkColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Visibility(
                              visible: _controller.startRow,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      // await Workmanager().registerOneOffTask(
                                      //   "fetchTimer", "fetchTimer",
                                      //   // frequency: Duration(minutes: 15),
                                      //   // initialDelay: Duration(minutes: min)
                                      // );
                                      _controller.startTimer();
                                      _controller.startRow = false;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15.0),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          border: Border.all(
                                            color: Colors.white,
                                            //                   <--- border color
                                            width: 1.0,
                                          ),
                                          color: colorController.kPrimaryColor,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "START",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10.0,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: !_controller.startRow,
                              child: Row(
                                children: [
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      countResume = countResume + 1;
                                      if (countResume == 0) {
                                        _controller.cancelTimer();
                                        print("countResume if :: ${countResume}");
                                      } else {
                                        _controller.reStartTimer();
                                        countResume = -1;
                                        print(
                                            "countResume else:: ${countResume}");
                                      }
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15.0),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          border: Border.all(
                                            color: Colors.white,
                                            //                   <--- border color
                                            width: 1.0,
                                          ),
                                          color: colorController.kPrimaryColor,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              countResume == -1
                                                  ? "PAUSE"
                                                  : "RESUME",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10.0,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      countResume = -1;
                                      _controller.finishTimer();
                                      _controller.startRow = true;
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        border: Border.all(
                                          color: Colors.white,
                                          //                   <--- border color
                                          width: 1.0,
                                        ),
                                        color:colorController.kPrimaryColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "FINISH",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.0,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: colorController.kBgPopupColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Visibility(
                            visible: _controller.showCelebration,
                              child: Image.asset('assets/birthday.gif')
                          ),

                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "SET TARGET",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Text(
                                    "Select Time Period",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: _controller.timePeriodController,
                                  decoration: InputDecoration(
                                    // labelText: "In Inches",
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                    ),
                                  ),
                                  onTap: () {
                                    if (!_controller.targetCard || _controller.reSetUpdateCard)
                                      _dialogBuilder(context, _controller);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Height in Inches';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Text(
                                    "Enter Target Steps",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  readOnly: !_controller.targetCard || _controller.reSetUpdateCard ? false : true,
                                  controller: _controller.kmTargetController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    // labelText: "In Inches",
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Target';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Text(
                                    "Target Achieved",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: _controller.kmTargetAcheivedController,
                                  decoration: InputDecoration(
                                    // labelText: "In Inches",
                                    contentPadding: const EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),

                                Visibility(
                                  visible: !_controller.targetCard,
                                  child: Container(
                                      margin: EdgeInsets.only(top: 10,bottom: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 50.0,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white, backgroundColor: colorController.kPrimaryDarkColor, // foreground
                                        ),
                                        onPressed: () async {
                                          SecureSharedPref pref =
                                          await SecureSharedPref.getInstance();
                                          // pref.reload();
                                          await pref.putString("startDate",
                                              '${_controller.startDate}');
                                          await pref.putString(
                                              "endDate", '${_controller.endDate}');
                                          await pref.putString("setTarget",
                                              '${_controller.kmTargetController.text}',isEncrypted: true);
                                          await pref.putBool("isSet", true);
                                          await pref.putBool("reSetUpdateCard", false);
                                          String? cpf = await pref.getString("cpfNumber",isEncrypted:true);
                                          setState(() {
                                            _controller.targetCard = true;
                                            _controller.reSetUpdateCard = false;
                                            SetTarget setTarget = SetTarget();
                                            setTarget.EMP_NO = '${cpf}';
                                            setTarget.START_DATE =
                                            '${_controller.startDate}';
                                            setTarget.END_DATE =
                                            '${_controller.endDate}';
                                            setTarget.TARGETSTEPS =
                                            '${_controller.kmTargetController.text}';
                                            callDataBase(setTarget, _controller);
                                          });
                                        },
                                        child: Text('SET'),
                                      )),
                                ),

                                Visibility(
                                  visible: _controller.targetCard,
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: _controller.reSetUpdateCard,
                                        child: Container(
                                            margin: EdgeInsets.only(top: 10,bottom: 10),
                                            width: MediaQuery.of(context).size.width,
                                            height: 50.0,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white, backgroundColor: colorController.kPrimaryDarkColor, // foreground
                                              ),
                                              onPressed: () async {
                                                SecureSharedPref pref =
                                                await SecureSharedPref.getInstance();
                                                // pref.reload();
                                                String? cpf = await pref.getString("cpfNumber",isEncrypted:true);
                                                await pref.putBool("reSetUpdateCard", false);
                                                await pref.putString("startDate",
                                                    '${_controller.startDate}');
                                                await pref.putString(
                                                    "endDate", '${_controller.endDate}');
                                                await pref.putString("setTarget",
                                                    '${_controller.kmTargetController.text}',isEncrypted: true);
                                                String? s  = await pref.getString('startDate');
                                                String? d  = await pref.getString('endDate');
                                                String? st  = await pref.getString('setTarget',isEncrypted: true);

                                                setState(() {
                                                  // if(timePeriodController.text.isNotEmpty && _controller.kmTargetController.text.isNotEmpty) {

                                                  _controller.reSetUpdateCard = false;
                                                  SetTarget setTarget = SetTarget();
                                                  setTarget.EMP_NO = '${cpf}';
                                                  if(_controller.startDate == "" || _controller.startDate == null){
                                                    setTarget.START_DATE =
                                                    '${s}';
                                                  }else{
                                                    setTarget.START_DATE =
                                                    '${_controller.startDate}';
                                                  }
                                                  if(_controller.endDate == "" || _controller.endDate == null){
                                                    setTarget.END_DATE =
                                                    '${d}';
                                                  }else{
                                                    setTarget.END_DATE =
                                                    '${_controller.endDate}';
                                                  }
                                                  if(_controller.kmTargetController.text == "" || _controller.kmTargetController.text == null){
                                                    setTarget.TARGETSTEPS =
                                                    '${st}';
                                                  }else{
                                                    setTarget.TARGETSTEPS =
                                                    '${_controller.kmTargetController.text}';
                                                  }
                                                  callResetData(setTarget,_controller);
                                                });
                                              },
                                              child: Text("UPDATE"),
                                            )),
                                      ),
                                      Visibility(
                                        visible: !_controller.reSetUpdateCard,
                                        child: Container(
                                            margin: EdgeInsets.only(top: 10,bottom: 10),
                                            width: MediaQuery.of(context).size.width,
                                            height: 50.0,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white, backgroundColor: colorController.kPrimaryDarkColor, // foreground
                                              ),
                                              onPressed: () async {
                                                SecureSharedPref pref =
                                                await SecureSharedPref.getInstance();
                                                // pref.reload();
                                                pref.putBool("reSetUpdateCard", true);
                                                setState(() {
                                                  _controller.reSetUpdateCard = true;

                                                });
                                              },
                                              child: Text("RESET"),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),



                              ])
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

  Future<void> _dialogBuilder(
      BuildContext context, HealthController controller) {
    int count = 0;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: colorController.kPrimaryLightColor,
          title: const Text('Select Date Range'),
          content: Container(
            height: 550,
            width: 350,
            child: Column(
              children: [
                Container(
                  height: 400,
                  width: 350,
                  child: DateRangePickerWidget(
                    doubleMonth: false,
                    initialDisplayedDate: DateTime.now(),
                    // minDate: DateTime.now().subtract(Duration(days: 1)),
                    onDateRangeChanged: (onDateRangeChanged) {
                      count++;
                      // if (count == 2) {
                        controller.startDate = onDateRangeChanged!.start;
                        print("onDateRangeChanged!.start :: ${onDateRangeChanged.start}");
                        controller.endDate = DateFormat("yyyy-MM-dd HH:mm:ss.s").parse(DateFormat("yyyy-MM-dd 23:59:59.000").format(onDateRangeChanged.end));
                        print("onDateRangeChanged!.endDate :: ${onDateRangeChanged.end}   ${controller.endDate}");
                        _duration = controller.endDate
                            ?.difference(controller.startDate!);
                        controller.timePeriodController.text =
                            "${DateFormat("dd/MMM/yyyy").format(controller.startDate!)} - ${DateFormat("dd/MMM/yyyy").format(controller.endDate!)}";
                      // } else if (count > 2) {
                      //   count = 0;
                      // }
                      print("onDateRangeChanged :: $onDateRangeChanged");
                    },
                  ),
                ),
                Center(
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration:
                        BoxDecoration(color: colorController.kPrimaryDarkColor),
                    child: TextButton(
                      onPressed: () {
                        print("value of count :: $count");
                        if (count == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please Select Range")));
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void callDataBase(SetTarget setTarget, HealthController controller) async {
    await HealthDataDb.batchInsertSetTarget(setTarget);
    // var myMap = Map<SetTarget, dynamic>.from(setTarget);
    List<Map<String,dynamic>> settargetlist = await HealthDataDb.gettargetDatafromdb();
    print("fsxrdcgtvyh  ${settargetlist[0]}");

    await GailConnectServices.to.setTargetDataInsert(body: settargetlist[0]);
    // await HealthDataDb.getSetTargetListFromDb();
    String str = await HealthDataDb.getSumOfTargetAcheived();
    controller.kmTargetAcheivedController.text = "${str}";

    showCustomDialogAcknowledge(Get.context!,
        title: "",
        description: "Target Added Successfully",
        onNegativePressed: () {}, onPositivePressed: () async {
          Navigator.pop(Get.context!);
          controller.update([kHealth]);
        });
  }

  void callResetData(SetTarget setTarget, HealthController controller) async {
    print("call update data  ${setTarget.TARGETSTEPS}");

    await HealthDataDb.updateSetTargetTable(setTarget);
    List<Map<String,dynamic>> settargetlist = await HealthDataDb.gettargetDatafromdb();
    print("fsxrdcgtvyh  ${settargetlist[0]}");

    await GailConnectServices.to.setTargetDataInsert(body: settargetlist[0]);
    String str = await HealthDataDb.getSumOfTargetAcheived();
    controller.kmTargetAcheivedController.text = "${str}";
    showCustomDialogAcknowledge(Get.context!,
        title: "",
        description: "Target Updated Successfully",
        onNegativePressed: () {}, onPositivePressed: () async {
          Navigator.pop(Get.context!);
          controller.update([kHealth]);
        });
  }

  void getsharedvalue() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    resetval = await pref.getBool('isSet',);
    range = await pref.getString('startDate',isEncrypted: true);
    settarget = await pref.getString('',isEncrypted: true);
  }



}
