// Created By Amit Jangid 21/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/constants.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/animations/animations.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';

import '../../styles/color_controller.dart';

showCustomGeneralDialogBox({
  required BuildContext context,
  required String title,
  String? description,
  Widget? content,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, animation, secondaryAnimation, child) => Animations.grow(animation, child),
    pageBuilder: (BuildContext context, animation, secondaryAnimation) =>
        _CustomDialog(title: title, description: description, content: content),
  );
}

class _CustomDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final String? description;

  const _CustomDialog({Key? key, required this.title, this.description, this.content}) : super(key: key);

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
        child: Container(
          width: _width,
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 120,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                decoration:  BoxDecoration(
                  color: colorController.kPrimaryDarkColor,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Text(title, textAlign: TextAlign.center, style: textStyle18Bold.copyWith(color: Colors.white)),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (description != null && content == null) ...[
                      Text(description!, textAlign: TextAlign.center, style: textStyle14Normal),
                    ] else if (content != null && description == null) ...[
                      content!,
                    ],
                    verticalSpace18,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 54),
                      child: PrimaryButton(text: kOK, height: 40, onPressed: () => Get.back()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
