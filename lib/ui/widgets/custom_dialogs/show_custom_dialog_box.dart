// Created by AMIT JANGID on 06/07/20.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/animations/animations.dart';
import 'package:multiutillib/widgets/default_button.dart';

import '../../styles/color_controller.dart';

/// This method will show a dialog box with custom UI and animation
showCustomDialogBox(
  BuildContext context, {
  String btnText = kOK,
  required String title,
  required Widget content,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, animation, secondaryAnimation, child) => Animations.grow(animation, child),
    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      return _CustomDialog(title: title, btnText: btnText, content: content);
    },
  );
}

class _CustomDialog extends StatelessWidget {
  final Widget content;
  final String title, btnText;

  const _CustomDialog({required this.title, required this.btnText, required this.content});

  @override
  Widget build(BuildContext context) {

    ColorController colorController = Get.put(ColorController());//colorController.
    const double _borderRadius = 20;
    final double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
        child: Stack(
          children: <Widget>[
            Container(
              width: _width,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 80),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_borderRadius)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title, style: textStyle18Bold, textAlign: TextAlign.center),
                  Container(
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        12,
                        (index) => Container(
                          width: 6,
                          height: 1.5,
                          color: colorController.kPrimaryDarkColor,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                        ),
                      ),
                    ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 10), child: content),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 0,
              child: DefaultButton(
                text: btnText,
                btnColor: colorController.kPrimaryDarkColor,
                btnTextStyle: buttonTextStyle,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
