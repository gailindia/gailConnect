import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';

import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:multiutillib/multiutillib.dart';

import 'package:get/get.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../styles/color_controller.dart';


class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    // calling hit count api method

    final GailConnectServices _gailConnectServices = GailConnectServices.to;
    _gailConnectServices.hitCountApi(
        activity: "Energy Calculator", activityScreen: "/calculator");
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kBgPopupColor,
        appBar: CustomAppBar(
          title: 'Energy Calculator',
        ),
        body: RawScrollbar(
          thumbColor: colorController.kPrimaryDarkColor,
          radius: const Radius.circular(20),
          // isAlwaysShown: true,
          thickness: 4,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _ItemCard(
                      title: kGasHeading,
                      title2: kGas1,
                      onTap: () => Get.toNamed(
                        kCalculatorGasARoute,
                      ),
                    ),
                    const Spacer(),
                    _ItemCard(
                      title: kGasHeading,
                      title2: kGas2,
                      onTap: () => Get.toNamed(
                        kCalculatorGasBRoute,
                      ),
                    ),
                  ],
                ),
                verticalSpace12,
                Row(
                  children: [
                    _ItemCard(
                      title: kCrudeHeading,
                      title2: kCrudeOil,
                      onTap: () => Get.toNamed(
                        kCalculatorCrudeOilRoute,
                      ),
                    ),
                    const Spacer(),
                    _ItemCard(
                      title: kCoalHeading,
                      title2: kCoalF,
                      onTap: () => Get.toNamed(
                        kCalculatorCoalFRoute,
                      ),
                    ),
                  ],
                ),
                verticalSpace12,
                Row(
                  children: [
                    _ItemCard(
                      title: kNapthaHeading,
                      title2: kNaptha,
                      onTap: () => Get.toNamed(
                        kCalculatorNapthaRoute,
                      ),
                    ),
                    const Spacer(),
                    _ItemCard(
                      title: kNaturalGasHeading,
                      title2: kNaturalGas1,
                      onTap: () => Get.toNamed(
                        kCalculatorNaturalGasARoute,
                      ),
                    ),
                  ],
                ),
                verticalSpace12,
                Row(
                  children: [
                    _ItemCard(
                      title: kNaturalGasHeading,
                      title2: kNaturalGas2,
                      onTap: () => Get.toNamed(
                        kCalculatorNaturalGasBRoute,
                      ),
                    ),
                    const Spacer(),
                    _ItemCard(
                      title: kOilHeading,
                      title2: kOil,
                      onTap: () => Get.toNamed(
                        kCalculatorOilRoute,
                      ),
                    ),
                  ],
                ),
                verticalSpace12,
                Row(
                  children: [
                    _ItemCard(
                      title: kLNGHeading,
                      title2: kLNG,
                      onTap: () => Get.toNamed(
                        kCalculatorLNGRoute,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final String title, title2;
  final GestureTapCallback? onTap;

  const _ItemCard(
      {Key? key,
      required this.title,
      required this.title2,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context1) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (context) {
          return MaterialCard(
            // padding: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 12),
            padding: const EdgeInsets.all(0),
            // margin: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 12),
            onTap: onTap,
            borderRadius: 12,
            child: Container(
              width: MediaQuery.of(context1).size.width / 2.2,
              height: 100,
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    // BoxShadow(
                    //   color: Colors.black38,
                    //   blurRadius: 3.0,
                    //   spreadRadius: 3.0,
                    //   offset: Offset(1.0, 1.0),
                    // )
                  ],
                  color: Colors.white
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color.fromARGB(255, 215, 230, 211),
                  //     Color.fromARGB(107, 205, 210, 247),
                  //     // Color.fromARGB(107, 189, 207, 252),
                  //     // Color.fromARGB(255, 224, 224, 224),
                  //     // Color.fromARGB(255, 215, 215, 215),
                  //     // Color.fromARGB(223, 141, 144, 139),
                  //   ],
                  //   begin: Alignment.bottomLeft,
                  //   end: Alignment.topRight,
                  // ),
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verticalSpace3,
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: textStyle18Bold,
                    ),
                  ),
                  verticalSpace6,
                  FittedBox(
                    child: Text(title2,
                        style: textStyle14Normal.apply(fontSizeFactor: 0.9)),
                  ),
                  verticalSpace3,
                ],
              ),
            ),
          );
        });
  }
}
