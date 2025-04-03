// // Created By Amit Jangid 13/07/21

// import 'package:flutter/material.dart';
// import 'package:gail_connect/ui/styles/color_controller.dart';
// import 'package:gail_connect/ui/styles/colors.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:get/get.dart';

// class HelpWidget extends StatelessWidget {
//   final String text;
//   final double? width;
//   final Color? btnColor;
//   final OutlinedBorder shape;
//   final VoidCallback onPressed;
//   final double height, elevation;

//   const HelpWidget({
//     Key? key,
//     this.width,
//     this.height = 48,
//     this.elevation = 0,
//     this.btnColor = Colors.transparent,
//     this.shape = const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(12))),
//     required this.text,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ColorController>(
//         init: ColorController(),
//         id: 'color',
//         builder: (context) {
//           return _DefaultButton(
//             text: text,
//             width: width,
//             shape: shape,
//             height: height,
//             btnColor: btnColor,
//             elevation: elevation,
//             onPressed: onPressed,
//             btnTextStyle: buttonTextStyle,
//           );
//         });
//   }
// }

// class _DefaultButton extends StatelessWidget {
//   final String? text;
//   final double? width;
//   final Color? btnColor;
//   final Function onPressed;
//   final OutlinedBorder shape;
//   final TextStyle? btnTextStyle;
//   final double height, elevation;
//   final EdgeInsetsGeometry margin;
//   final bool isEnabled, isUpperCase;

//   const _DefaultButton({
//     this.width,
//     this.btnColor,
//     this.height = 48,
//     this.elevation = 4,
//     this.isEnabled = true,
//     this.isUpperCase = false,
//     this.margin = const EdgeInsets.only(left: 12),
//     this.shape = const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(24))),
//     this.btnTextStyle = const TextStyle(
//       fontSize: 18,
//       letterSpacing: 0.27,
//       color: Colors.white,
//       fontWeight: FontWeight.w700,
//     ),
//     required this.text,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     ColorController colorController = Get.put(ColorController());
//     return Container(
//       // color: Colors.amber,
//       width: width,
//       height: height,
//       // margin: margin,
//       child: ElevatedButton(
//         clipBehavior: Clip.antiAlias,
//         // splashColor: Colors.transparent,
//         // highlightColor: Colors.transparent,
//         // enableFeedback: false,
//         // elevation: 0,
//         // focusColor: Colors.transparent,
//         // color: Colors.transparent,
//         // focusElevation: 0,
//         // highlightElevation: 0,
//         onPressed: isEnabled ? onPressed as void Function()? : null,
//         style: ElevatedButton.styleFrom(
//           shape: shape,
//           primary: Colors.transparent,
//           elevation: 0,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         child:
//             // Icon(
//             //   Icons.headphones_rounded,
//             //   color: Colors.black,
//             // ),
//             Row(
//           // crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             const Icon(
//               Icons.headphones_rounded,
//               color: Colors.black,
//             ),
//             Text(isUpperCase ? text!.toUpperCase() : text!,
//                 style: const TextStyle(color: Colors.black)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//======

// Created By Amit Jangid 13/07/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:get/get.dart';

class HelpButton extends StatelessWidget {
  final String text;
  final double? width;
  final Color? btnColor;
  final OutlinedBorder shape;
  final VoidCallback onPressed;
  final double height, elevation;

  const HelpButton({
    Key? key,
    this.width,
    this.height = 48,
    this.elevation = 4,
    this.btnColor = Colors.black,
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (context) {
          return _DefaultButton(
            text: text,
            width: width,
            shape: shape,
            height: height,
            btnColor: btnColor,
            elevation: elevation,
            onPressed: onPressed,
            btnTextStyle: buttonTextStyle,
          );
        });
  }
}

class _DefaultButton extends StatelessWidget {
  final String? text;
  final double? width;
  final Color? btnColor;
  final Function onPressed;
  final OutlinedBorder shape;
  final TextStyle? btnTextStyle;
  final double height, elevation;
  final EdgeInsetsGeometry margin;
  final bool isEnabled, isUpperCase;

  const _DefaultButton({
    this.width,
    this.btnColor,
    this.height = 48,
    this.elevation = 4,
    this.isEnabled = true,
    this.isUpperCase = false,
    this.margin = const EdgeInsets.only(top: 9),
    this.shape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    this.btnTextStyle = const TextStyle(
      fontSize: 18,
      letterSpacing: 0.27,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        enableFeedback: false,
        elevation: 0,
        focusColor: Colors.transparent,
        color: Colors.transparent,
        focusElevation: 0,
        highlightElevation: 0,
        clipBehavior: Clip.antiAlias,
        onPressed: isEnabled ? onPressed as void Function()? : null,

        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.headphones_rounded,
              color: Colors.black,
            ),
            Text(isUpperCase ? text!.toUpperCase() : text!,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: Colors.black,
                  // fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }
}
