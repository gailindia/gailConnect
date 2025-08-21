// Created by AMIT JANGID on 17/07/20.

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:get/get.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/animations/animations.dart';
import 'package:multiutillib/widgets/default_button.dart';

import '../../styles/color_controller.dart';

/// This method will show a dialog box with custom UI and animation
showENotesDialogBox(
    BuildContext context, {
      required String userManual,
      required String FAQ,
      required VoidCallback onNegativePressed,
      required VoidCallback onPositivePressed,
      required VoidCallback onVideoPressed,
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
      return _CustomConfirmDialog(
        userManual: userManual,
        FAQ: FAQ,
        onNegativePressed: onNegativePressed,
        onPositivePressed: onPositivePressed,
        onVideoPressed: onVideoPressed,
      );
    },
  );
}

class _CustomConfirmDialog extends StatelessWidget {
  final String userManual, FAQ;
  final VoidCallback onNegativePressed, onPositivePressed,onVideoPressed;

  const _CustomConfirmDialog({
    required this.userManual,
    required this.FAQ,
    required this.onNegativePressed,
    required this.onPositivePressed,
    required this.onVideoPressed,
  });

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());//colorController.
    MainDashController mainDashController = Get.put(MainDashController());
    const double _borderRadius = 20;
    final double _width = MediaQuery.of(context).size.width;

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
              height: 200,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(
                  top: 0, left: 20, right: 20, bottom: 80),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_borderRadius)),
              child: Column(
                // mainAxisSize: MainAxisSize.st,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Please select E-Office',
                            style: textStyle14Bold, textAlign: TextAlign.left),
                        Spacer(),
                        GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0,top: 5.0),
                            child: Icon(Icons.cancel, color: Colors.black,)
                            // Text("X",style: TextStyle(
                            //     fontSize: 20,
                            //     color: Colors.black
                            // ),
                            // ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 30,
              top: 50,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: DefaultButton(
                            text: 'Videos',
                            btnColor: colorController.kPrimaryDarkColor,
                            onPressed: onVideoPressed,
                            btnTextStyle: buttonTextStyle,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: DefaultButton(
                            text: FAQ,
                            btnColor: colorController.kPrimaryDarkColor,
                            onPressed: onPositivePressed,
                            btnTextStyle: buttonTextStyle,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: DefaultButton(
                            text: userManual,
                            btnColor: colorController.kPrimaryDarkColor,
                            onPressed: onNegativePressed,
                            btnTextStyle: buttonTextStyle,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
