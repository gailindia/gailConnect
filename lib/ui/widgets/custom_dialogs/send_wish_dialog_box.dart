// Created by AMIT JANGID on 17/07/20.

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:get/get.dart';

import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/animations/animations.dart';
import 'package:multiutillib/widgets/default_button.dart';

import '../../styles/color_controller.dart';

/// This method will show a dialog box with custom UI and animation
sendWishDialogBox(
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
      return _CustomConfirmDialog(
        title: title,
        description: description,
        onNegativePressed: onNegativePressed,
        onPositivePressed: onPositivePressed,
      );
    },
  );
}

class _CustomConfirmDialog extends StatelessWidget {
  final String title, description;
  final VoidCallback onNegativePressed, onPositivePressed;

  const _CustomConfirmDialog({
    required this.title,
    required this.description,
    required this.onNegativePressed,
    required this.onPositivePressed,
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
                  // Text(title,
                  //     style: textStyle18Bold, textAlign: TextAlign.center),
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
                  //         color: kPrimaryDarkColor,
                  //         margin: const EdgeInsets.symmetric(horizontal: 2),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    child: Text(description,
                        style: textStyle12Bold, textAlign: TextAlign.left),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextField(

                      // readOnly: true,
                      // controller: TextEditingController(text: ""),
                      controller: mainDashController.sendwishController,
                      // calling show date picker method method
                      // onTap: () => _controller.showDatePickerDialog(),
                      decoration: const InputDecoration(
                          labelText: "Please type here.."),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DefaultButton(
                      text: "Cancel",
                      btnColor: colorController.kUnselectedColor,
                      onPressed: onNegativePressed,
                      btnTextStyle: buttonTextStyle,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DefaultButton(
                      text: 'Send',
                      btnColor: colorController.kPrimaryDarkColor,
                      onPressed: onPositivePressed,
                      btnTextStyle: buttonTextStyle,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
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
