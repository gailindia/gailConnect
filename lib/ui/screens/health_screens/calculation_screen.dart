import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../core/controllers/health_controller.dart';
import '../../../utils/constants/app_constants.dart';

class CalculationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalculationScreen();
}

class _CalculationScreen extends State<CalculationScreen> {
  TextEditingController heightInFeet = TextEditingController();
  TextEditingController weightInKg = TextEditingController();
  TextEditingController waistCircumfirance = TextEditingController();
  TextEditingController hipCircumfirance = TextEditingController();
  String _dropDownValue = "";
  double bmi = 0;
  double whr = 0;
  double startVal1 = 0;
  double endVal1 = .9;
  double startVal2 = .9;
  double endVal2 = 1;
  double startVal3 = 1;
  double endVal3 = 2;

  bool resetEnable = false;
  bool resetHipEnable = false;

  String heightFeet = "1";
  String heightInches = "0";
  List<String> listHeight = <String>['1', '2', '3', '4', '5', '6', '7', '8'];
  List<String> listInches = <String>[
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("open didChangeDependencies");
    if (Platform.isAndroid) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorController colorController  = Get.put(ColorController());
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
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "BMI CALCULATOR",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorController.kPrimaryDarkColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 550,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: colorController.kBgPopupColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "HEIGHT",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Colors.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                  ),
                                  child: DropdownButton(
                                    onTap: () {
                                      print("open didChangeDependencies");
                                      if (Platform.isAndroid) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      }
                                    },
                                    // Initial Value
                                    value: heightFeet,

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: listHeight.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Container(
                                            width: 50,
                                            child: Center(child: Text(items))),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        heightFeet = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("feet"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 80,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: Colors.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                  ),
                                  child: DropdownButton(
                                    onTap: () {
                                      print("open didChangeDependencies");
                                      if (Platform.isAndroid) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      }
                                    },
                                    // Initial Value
                                    value: heightInches,

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: listInches.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Container(
                                            width: 50,
                                            child: Center(child: Text(items))),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        heightInches = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Inches"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "WEIGHT",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextFormField(
                                    onTapOutside: (PointerDownEvent event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      // if (Platform.isAndroid) {
                                      //
                                      // }
                                    },
                                    controller: weightInKg,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "In Kg",
                                      labelStyle: TextStyle(color: Colors.black),
                                      contentPadding: const EdgeInsets.all(12),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.black),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Weight in Feets';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ), // <-- Wrapped in Expanded.
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              child: ElevatedButton(
                                // focusNode:  FocusScope.of(context).requestFocus(new FocusNode()),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: colorController.kPrimaryDarkColor, // foreground
                                ),
                                onPressed: () {
                                  String s = "$heightFeet.$heightInches";
                                  double cm = s.toDouble! / 3.32;
                                  double w = weightInKg.text.toDouble!;
                                  bmi = (w / (cm * cm)).toDouble();
                                  pow(bmi, 2);
                                  print("BMI :: $bmi");
                                  if (bmi > 70) {
                                    bmi = 70;
                                  }
                                  setState(() {
                                    // FocusScope.of(context).requestFocus(new FocusNode());
                                    // resetEnable = true;
                                  });
                                },
                                child: Text('CALCULATE'),
                              )),
                          // Visibility(
                          //   visible: resetEnable,
                          //   child: Container(
                          //       margin: EdgeInsets.all(10),
                          //       width: MediaQuery.of(context).size.width,
                          //       height: 50.0,
                          //       child: ElevatedButton(
                          //         style: ElevatedButton.styleFrom(
                          //           primary: colorController.kPrimaryDarkColor,
                          //           // background
                          //           onPrimary: Colors.white, // foreground
                          //         ),
                          //         onPressed: () {
                          //           setState(() {
                          //             listHeight = <String>['1', '2', '3', '4', '5', '6', '7', '8'];
                          //
                          //             heightInches = "0";
                          //             weightInKg.text = "";
                          //             bmi = 0.0;
                          //             resetEnable = false;
                          //           });
                          //         },
                          //         child: Text('RESET'),
                          //       )),
                          // ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 200,
                            // width: 500,
                            child: SfRadialGauge(axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 70,
                                  radiusFactor: 1.5,
                                  maximumLabels: 3,
                                  labelOffset: 50,
                                  interval: 5,
                                  showLastLabel: true,
                                  // offsetUnit: GaugeSizeUnit.factor,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: 0,
                                        startWidth: 50,
                                        endWidth: 50,
                                        endValue: 18.5,
                                        label: "Underweight",
                                        labelStyle: GaugeTextStyle(fontSize: 8),
                                        color: colorController.kUnderWeight),
                                    GaugeRange(
                                        startValue: 18.5,
                                        endValue: 24.9,
                                        startWidth: 50,
                                        endWidth: 50,
                                        labelStyle: GaugeTextStyle(fontSize: 8),
                                        label: "Normal",
                                        color: colorController.kInterMediate),
                                    GaugeRange(
                                        startValue: 24.9,
                                        endValue: 30,
                                        startWidth: 50,
                                        endWidth: 50,
                                        label: "Overweight",
                                        labelStyle: GaugeTextStyle(fontSize: 8),
                                        color: colorController.kNormal),
                                    GaugeRange(
                                        startValue: 30,
                                        endValue: 70,
                                        startWidth: 50,
                                        endWidth: 50,
                                        label: "Obesity",
                                        labelStyle: GaugeTextStyle(fontSize: 8),
                                        color: colorController.kObesity)
                                  ],
                                  // pointers: <GaugePointer>[
                                  //   TextPointer()
                                  // ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: bmi,
                                      needleStartWidth: 1,
                                      needleEndWidth: 5,
                                      needleLength: 0.4,
                                    )
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                          child: Text('${bmi.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold))),
                                      angle: 90,
                                      positionFactor: 0.5,
                                    )
                                  ])
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "WHR RATIO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorController.kPrimaryDarkColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 650,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color:colorController.kBgPopupColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.black54),
                              shape: BoxShape.rectangle,
                              color: Colors.transparent,
                            ),
                            child: DropdownButton(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              hint: _dropDownValue == ""
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Choose Gender',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _dropDownValue,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.black),
                              items: ['Male', 'Female'].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValue = val.toString();
                                    if (_dropDownValue == "Male") {
                                      startVal1 = 0;
                                      endVal1 = .9;
                                      startVal2 = .9;
                                      endVal2 = 1;
                                      startVal3 = 1;
                                      endVal3 = 2;
                                    } else {
                                      startVal1 = 0;
                                      endVal1 = .8;
                                      startVal2 = .8;
                                      endVal2 = .9;
                                      startVal3 = .9;
                                      endVal3 = 2;
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "WAIST CIRCUMFERENCE",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextFormField(
                                    controller: waistCircumfirance,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "In Inches",
                                      labelStyle: TextStyle(color: Colors.black),
                                      contentPadding: const EdgeInsets.all(12),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.black),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Height in Feets';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ), // <-- Wrapped in Expanded.
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "HIP CIRCUMFERENCE",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextFormField(
                                    controller: hipCircumfirance,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "In Inches",
                                      labelStyle: TextStyle(color: Colors.black),
                                      contentPadding: const EdgeInsets.all(12),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.black),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Weight in Feets';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ), // <-- Wrapped in Expanded.
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: colorController.kPrimaryDarkColor, // foreground
                                ),
                                onPressed: () {
                                  double waistcm =
                                      waistCircumfirance.text.toDouble! / 3.32;
                                  double hipcm =
                                      hipCircumfirance.text.toDouble! / 3.32;
                                  whr = (waistcm / hipcm).toDouble();
                                  if (whr > 2) {
                                    whr = 2;
                                  }
                                  // resetHipEnable = true;
                                  print("_dropDownValue :: $_dropDownValue");

                                  setState(() {
                                    // FocusScope.of(context).requestFocus(new FocusNode());
                                  });
                                },
                                child: Text('CALCULATE'),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 200,
                            // width: 500,
                            child: SfRadialGauge(axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 2,
                                  radiusFactor: 1.5,
                                  maximumLabels: 3,
                                  labelOffset: 50,
                                  interval: .1,
                                  canScaleToFit: true,
                                  canRotateLabels: true,
                                  showLastLabel: true,
                                  // offsetUnit: GaugeSizeUnit.factor,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: startVal1,
                                        startWidth: 50,
                                        endWidth: 50,
                                        endValue: endVal1,
                                        label: "Low",
                                        labelStyle: GaugeTextStyle(fontSize: 8),
                                        color: colorController.kNormal),
                                    GaugeRange(
                                        startValue: startVal2,
                                        endValue: endVal2,
                                        startWidth: 50,
                                        endWidth: 50,
                                        labelStyle: GaugeTextStyle(fontSize: 8),
                                        label: "Moderate",
                                        color: colorController.kInterMediate),
                                    GaugeRange(
                                        startValue: startVal3,
                                        endValue: endVal3,
                                        startWidth: 50,
                                        endWidth: 50,
                                        label: "High",
                                        labelStyle: GaugeTextStyle(fontSize: 8),
                                        color: colorController.kObesity)
                                  ],
                                  // pointers: <GaugePointer>[
                                  //   TextPointer()
                                  // ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: whr,
                                      needleStartWidth: 1,
                                      needleEndWidth: 5,
                                      needleLength: 0.4,
                                    )
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                          child: Text('${whr.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold))),
                                      angle: 90,
                                      positionFactor: 0.5,
                                    )
                                  ])
                            ]),
                          ),
                          SizedBox(
                            height: 40,
                          ),
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
}
