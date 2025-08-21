// Created by AMIT JANGID on 06/07/20.

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:multiutillib/animations/animations.dart';
import 'package:multiutillib/widgets/default_button.dart';

/// This method will show a dialog box with custom UI and animation
showCustomDialogAcknowledge(
  BuildContext context, {
  required String title,
  required String description,
  required VoidCallback onNegativePressed,
  required VoidCallback onPositivePressed,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        Animations.grow(animation, child),
    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      return _CustomDialog(
        title: title,
        description: description,
        onNegativePressed: onNegativePressed,
        onPositivePressed: onPositivePressed,
      );
    },
  );
}

class _CustomDialog extends StatelessWidget {
  final String title, description;
  final VoidCallback onNegativePressed, onPositivePressed;

  const _CustomDialog({
    required this.title,
    required this.description,
    required this.onNegativePressed,
    required this.onPositivePressed,
  });

  @override
  Widget build(BuildContext context) {
    const double _borderRadius = 20;
    final double _width = MediaQuery.of(context).size.width;

    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (colorController) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Dialog(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_borderRadius)),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: _width,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.only(
                        top: 24, left: 20, right: 20, bottom: 80),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(_borderRadius)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(title,
                            style: const TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.27,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        // Container(
                        //   height: 1.5,
                        //   margin: const EdgeInsets.symmetric(vertical: 20),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: List.generate(
                        //       12,
                        //       (index) => Container(
                        //         width: 6,
                        //         height: 1.5,
                        //         color: Colors.black,
                        //         margin: const EdgeInsets.symmetric(horizontal: 2),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(description,
                              style: const TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  color: Colors.black),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 0,
                    child: DefaultButton(
                      text: "OK",
                      btnColor: colorController.kPrimaryDarkColor,
                      btnTextStyle:   TextStyle(
                          fontSize: 18,
                          letterSpacing: 0.27,
                          color: colorController.kCircleBgColor,
                          fontWeight: FontWeight.w400),
                      onPressed: onPositivePressed,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
