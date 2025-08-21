// // Created By Amit Jangid 02/09/21

// import 'package:flutter/material.dart';
// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:gail_connect/ui/styles/colors.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:multiutillib/widgets/material_card.dart';

// class IconWidget extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color iconColor;
//   final Animation<double> scale;
//   final GestureTapCallback? onTap;

//   const IconWidget({
//     Key? key,
//     this.onTap,
//     required this.icon,
//     required this.scale,
//     required this.title,
//     required this.iconColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const _borderRadius = BorderRadius.all(Radius.circular(12));

//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(2),
//         margin: const EdgeInsets.symmetric(horizontal: 5),
//         decoration: BoxDecoration(
//           borderRadius: _borderRadius,
//           boxShadow: [BoxShadow(blurRadius: 12, spreadRadius: 2, color: kPrimaryLightColor.withOpacity(0.2))],
//         ),
//         child: AspectRatio(
//           aspectRatio: 1,
//           child: ScaleTransition(
//             scale: scale,
//             child: MaterialCard(
//               onTap: onTap,
//               elevation: 0,
//               margin: const EdgeInsets.only(),
//               padding: const EdgeInsets.all(6),
//               borderRadiusGeometry: _borderRadius,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 80,
//                     height: 80,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor.withOpacity(0.3)),
//                     child: Icon(icon, size: 40, color: iconColor),
//                   ),
//                   verticalSpace6,
//                   Text(title, style: textStyle16Bold, textAlign: TextAlign.center),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Created By Amit Jangid 02/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../styles/color_controller.dart';

class IconWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Animation<double> scale;
  final GestureTapCallback? onTap;
  final bool? boolValue;

  const IconWidget({
    Key? key,
    this.onTap,
    required this.icon,
    required this.scale,
    required this.title,
    required this.iconColor,
    this.boolValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _borderRadius = BorderRadius.all(Radius.circular(12)); //12
    double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    ColorController colorController = Get.put(ColorController());

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: MaterialCard(
          elevation: 12,
          borderRadius: 24,
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.only(top: 0),
          child: Container(
            // margin: const EdgeInsets.only(bottom: 12),
            // color: Colors.amber,
            height: boolValue == true
                ? _pixelRatio >= 3.0
                    ? 17.h
                    : _pixelRatio >= 2.6
                        ? 16.h
                        : 15.h
                : _pixelRatio >= 3.0
                    ? 19.h
                    : _pixelRatio >= 2.6
                        ? 18.h
                        : 17.h,
            width: _pixelRatio >= 3.0
                ? Adaptive.w(15)
                : _pixelRatio >= 2.6
                    ? Adaptive.w(14)
                    : Adaptive.w(14),
            // padding: const EdgeInsets.all(0),
            // margin: const EdgeInsets.symmetric(horizontal: 5), //5
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              color: iconColor.withOpacity(0.035),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1000, //12
                  spreadRadius: 10000, //2
                  color: iconColor.withOpacity(0.009),
                ) //0.2
              ],
            ),
            child: AspectRatio(
              aspectRatio: 1, //1
              child: ScaleTransition(
                scale: scale,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.black,
                      // height: 12.h,
                      // width: Adaptive.w(20),
                      height: boolValue == true
                          ? _pixelRatio >= 3.0
                              ? 13.h
                              : _pixelRatio >= 2.6
                                  ? 11.h
                                  : 10.h
                          : _pixelRatio >= 3.0
                              ? 14.h
                              : _pixelRatio >= 2.6
                                  ? 12.h
                                  : 11.h,
                      width: _pixelRatio >= 3.0
                          ? Adaptive.w(28)
                          : _pixelRatio >= 2.6
                              ? Adaptive.w(22)
                              : Adaptive.w(21),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.51, //12
                            spreadRadius: boolValue == true ? -2 : 0, //2
                            color: iconColor.withOpacity(0.2),
                          ) //kPrimaryLightColor.withOpacity(0.07)) //0.2
                        ],
                      ),
                      // color: iconColor.withOpacity(0.2)), //0.3
                      child: Icon(icon,
                          size: boolValue == true
                              ? _pixelRatio >= 3.0
                                  ? 48
                                  : _pixelRatio >= 2.6
                                      ? 42
                                      : 40
                              : _pixelRatio >= 3.0
                                  ? 52
                                  : _pixelRatio >= 2.6
                                      ? 44
                                      : 42,
                          color: iconColor),
                    ),
                    verticalSpace3,
                    Text(title,
                        style: TextStyle(
                          // fontSize: Platform.isAndroid ? 0.24.dp : 0.21.dp,
                          fontSize: _pixelRatio >= 3.0
                              ? 0.28.dp
                              : _pixelRatio >= 2.6
                                  ? 0.24.dp
                                  : 0.22.dp,
                          color: colorController.kBlackColor,
                          letterSpacing: 0.55,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ), //Material Card
              ),
            ),
          ),
        ),
      ),
    );
  }
}
