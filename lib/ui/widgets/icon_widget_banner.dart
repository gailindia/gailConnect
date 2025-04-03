// // // Created By Amit Jangid 02/09/21

// // import 'package:flutter/material.dart';
// // import 'package:multiutillib/utils/ui_helpers.dart';
// // import 'package:gail_connect/ui/styles/colors.dart';
// // import 'package:gail_connect/ui/styles/text_styles.dart';
// // import 'package:multiutillib/widgets/material_card.dart';

// // class IconWidget extends StatelessWidget {
// //   final String title;
// //   final IconData icon;
// //   final Color iconColor;
// //   final Animation<double> scale;
// //   final GestureTapCallback? onTap;

// //   const IconWidget({
// //     Key? key,
// //     this.onTap,
// //     required this.icon,
// //     required this.scale,
// //     required this.title,
// //     required this.iconColor,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     const _borderRadius = BorderRadius.all(Radius.circular(12));

// //     return Expanded(
// //       child: Container(
// //         padding: const EdgeInsets.all(2),
// //         margin: const EdgeInsets.symmetric(horizontal: 5),
// //         decoration: BoxDecoration(
// //           borderRadius: _borderRadius,
// //           boxShadow: [BoxShadow(blurRadius: 12, spreadRadius: 2, color: kPrimaryLightColor.withOpacity(0.2))],
// //         ),
// //         child: AspectRatio(
// //           aspectRatio: 1,
// //           child: ScaleTransition(
// //             scale: scale,
// //             child: MaterialCard(
// //               onTap: onTap,
// //               elevation: 0,
// //               margin: const EdgeInsets.only(),
// //               padding: const EdgeInsets.all(6),
// //               borderRadiusGeometry: _borderRadius,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Container(
// //                     width: 80,
// //                     height: 80,
// //                     decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor.withOpacity(0.3)),
// //                     child: Icon(icon, size: 40, color: iconColor),
// //                   ),
// //                   verticalSpace6,
// //                   Text(title, style: textStyle16Bold, textAlign: TextAlign.center),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // Created By Amit Jangid 02/09/21

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:gail_connect/ui/styles/colors.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:multiutillib/widgets/material_card.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class IconWidgetBanner extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color iconColor;
//   final Animation<double> scale;
//   final GestureTapCallback? onTap;

//   const IconWidgetBanner({
//     Key? key,
//     this.onTap,
//     required this.icon,
//     required this.scale,
//     required this.title,
//     required this.iconColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const _borderRadius = BorderRadius.all(Radius.circular(12)); //12

//     return Expanded(
//       child: FittedBox(
//         fit: BoxFit.scaleDown,
//         child: Container(
//           padding: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
//           margin: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
//           // color: Colors.amber,
//           height: MediaQuery.of(context).size.height * 0.2,
//           width: MediaQuery.of(context).size.width * 0.35,
//           // height: MediaQuery.of(context).devicePixelRatio >= 3.0
//           //     ? 19.h
//           //     : MediaQuery.of(context).devicePixelRatio >= 2.6
//           //         ? 17.h
//           //         : 16.h,
//           // width: MediaQuery.of(context).devicePixelRatio >= 3.0
//           //     ? Adaptive.w(15)
//           //     : MediaQuery.of(context).devicePixelRatio >= 2.6
//           //         ? Adaptive.w(14)
//           //         : Adaptive.w(14),
//           // padding: const EdgeInsets.all(0),
//           // margin: const EdgeInsets.symmetric(horizontal: 5), //5
//           decoration: BoxDecoration(
//             // color: Colors.black12,
//             borderRadius: _borderRadius,

//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 300, //12
//                 spreadRadius: 0,

//                 color: iconColor
//                     .withOpacity(0.15), //kPrimaryLightColor.withOpacity(0.1),
//               ),
//               //0.2
//             ],
//           ),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               GestureDetector(
//                 onTap: onTap,
//                 child: Expanded(
//                   child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.15,
//                       width: MediaQuery.of(context).size.width * 0.3,
//                       // height: MediaQuery.of(context).devicePixelRatio >= 3.0
//                       //     ? 15.h
//                       //     : MediaQuery.of(context).devicePixelRatio >= 2.6
//                       //         ? 14.h
//                       //         : 12.h,
//                       // width: MediaQuery.of(context).devicePixelRatio >= 3.0
//                       //     ? Adaptive.w(28)
//                       //     : MediaQuery.of(context).devicePixelRatio >= 2.6
//                       //         ? Adaptive.w(22)
//                       //         : Adaptive.w(21),
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: iconColor.withOpacity(0.2)), //0.3
//                       //child: //Icon(icon, color: iconColor),
//                       child: Expanded(
//                         child: FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Icon(icon,
//                               size: MediaQuery.of(context).size.height * 0.08,
//                               // size: MediaQuery.of(context).devicePixelRatio >= 3.0
//                               //     ? 45
//                               //     : MediaQuery.of(context).devicePixelRatio >= 2.6
//                               //         ? 38
//                               //         : 36,
//                               color: iconColor),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               verticalSpace3,
//               Expanded(
//                 child: FittedBox(
//                   fit: BoxFit.scaleDown,
//                   child: Text(title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         // fontSize: Platform.isAndroid ? 0.24.dp : 0.21.dp,
//                         // fontSize: MediaQuery.of(context).devicePixelRatio >= 3.0
//                         //     ? 0.28.dp
//                         //     : MediaQuery.of(context).devicePixelRatio >= 2.6
//                         //         ? 0.24.dp
//                         //         : 0.22.dp,
//                         color: kBlackColor,
//                         letterSpacing: 0.55,
//                         fontWeight: FontWeight.w600,
//                       ).apply(fontSizeFactor: 1.2),
//                       textAlign: TextAlign.center),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
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
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class IconWidgetBanner extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Animation<double> scale;
  final GestureTapCallback? onTap;

  const IconWidgetBanner({
    Key? key,
    this.onTap,
    required this.icon,
    required this.scale,
    required this.title,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _borderRadius = BorderRadius.all(Radius.circular(12)); //12
    print(MediaQuery.of(context).devicePixelRatio);
    print(MediaQuery.of(context).size);
    ColorController colorController = Get.put(ColorController());

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        // color: Colors.green,
        height: MediaQuery.of(context).devicePixelRatio <= 3.0
            ? 17.h
            : MediaQuery.of(context).devicePixelRatio <= 2.6
                ? 15.h
                : 14.h,
        // width: MediaQuery.of(context).devicePixelRatio >= 3.0
        //     ? Adaptive.w(15)
        //     : MediaQuery.of(context).devicePixelRatio >= 2.6
        //         ? Adaptive.w(14)
        //         : Adaptive.w(14),
        // padding: const EdgeInsets.all(0),
        // margin: const EdgeInsets.symmetric(horizontal: 5), //5
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          boxShadow: [
            BoxShadow(
                blurRadius: 30, //12
                spreadRadius: 0, //2
                color: iconColor.withOpacity(0.1)) //0.2
          ],
        ),
        child: AspectRatio(
          aspectRatio: 100 / 100, //1
          child: ScaleTransition(
            scale: scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    // color: Colors.black,
                    height: MediaQuery.of(context).devicePixelRatio >= 3.0
                        ? 13.h
                        : MediaQuery.of(context).devicePixelRatio >= 2.6
                            ? 12.h
                            : 10.h,
                    width: MediaQuery.of(context).devicePixelRatio >= 3.0
                        ? Adaptive.w(28)
                        : MediaQuery.of(context).devicePixelRatio >= 2.6
                            ? Adaptive.w(22)
                            : Adaptive.w(21),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: iconColor.withOpacity(0.2)), //0.3
                    child: Icon(icon,
                        size: MediaQuery.of(context).devicePixelRatio >= 3.0
                            ? 45
                            : MediaQuery.of(context).devicePixelRatio >= 2.6
                                ? 38
                                : 36,
                        color: iconColor),
                  ),
                ),
                verticalSpace3,
                Text(title,
                    style: TextStyle(
                      // fontSize: Platform.isAndroid ? 0.24.dp : 0.21.dp,
                      fontSize: MediaQuery.of(context).devicePixelRatio >= 3.0
                          ? 0.26.dp
                          : MediaQuery.of(context).devicePixelRatio >= 2.6
                              ? 0.22.dp
                              : 0.18.dp,
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
    );
  }
}
