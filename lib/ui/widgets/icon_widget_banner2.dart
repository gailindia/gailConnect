//used in Apps screen

// Created By Amit Jangid 02/09/21


import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';


class IconWidgetBanner2 extends StatelessWidget {
  final String title;
  final String icon;
  final Color iconColor;
  final Animation<double> scale;
  final GestureTapCallback? onTap;

  const IconWidgetBanner2({
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

    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    ColorController colorController = Get.put(ColorController());

    return Expanded(
      child: GestureDetector(
        // onTap: onTap,
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.all(8),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              // padding:
              //     const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 0),
              // margin:
              //     const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 0),
              // color: Colors.amber,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.35,
              // height: MediaQuery.of(context).devicePixelRatio >= 3.0
              //     ? 19.h
              //     : MediaQuery.of(context).devicePixelRatio >= 2.6
              //         ? 17.h
              //         : 16.h,
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
                    blurRadius: 300, //12
                    spreadRadius: 0,
                    color: colorController.kPrimaryLightColor.withOpacity(0.1),
                  ) //0.2
                ],
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: _width * 0.23,
                        height: _height * 0.125,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                          color: colorController.kCircleBgColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 30, //12
                              spreadRadius: 100, //2
                              color: iconColor.withOpacity(0.03),
                            ) //0.2
                          ],
                        ),
                        // decoration: BoxDecoration(
                        //   borderRadius: _borderRadius,
                        //   color: iconColor.withOpacity(0.035),
                        //   boxShadow: [
                        //     BoxShadow(
                        //       blurRadius: 0, //12
                        //       spreadRadius: 0, //2
                        //       color: iconColor.withOpacity(0.009),
                        //     ) //0.2
                        //   ],
                        // ),
                        // child: FittedBox(
                        //   fit: BoxFit.scaleDown,

                        child: Transform.scale(
                          scale: icon.toString().contains("freshman")
                              ? 0.5
                              : icon.toString().contains("cashless")
                                  ? 1.3
                                  : icon.toString().contains("vehicle")
                                      ? 1.3
                                      : 1,
                          child: Image(
                            color: iconColor,
                            image: AssetImage(icon),
                          ),
                        ),
                        // ),
                      ),
                    ),
                  ),
                  verticalSpace3,
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(title,
                          style: TextStyle(
                            fontSize: 14,
                            // fontSize: Platform.isAndroid ? 0.24.dp : 0.21.dp,
                            // fontSize: MediaQuery.of(context).devicePixelRatio >= 3.0
                            //     ? 0.28.dp
                            //     : MediaQuery.of(context).devicePixelRatio >= 2.6
                            //         ? 0.24.dp
                            //         : 0.22.dp,
                            color: colorController.kBlackColor,
                            letterSpacing: 0.55,
                            fontWeight: FontWeight.w600,
                          ).apply(fontSizeFactor: 0.95),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
